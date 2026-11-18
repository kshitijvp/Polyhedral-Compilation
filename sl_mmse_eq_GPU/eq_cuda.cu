#include <cublas_v2.h>
#include <cuda_runtime.h>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

typedef cuComplex cf;
struct Memref1D { void *alloc, *aligned; int64_t offset, size, stride; };
template <class T> static T* ptr(const Memref1D* m) { return (T*)m->aligned + m->offset; }

#define CK(x) do { cudaError_t e_ = (x); if (e_ != cudaSuccess) { \
  fprintf(stderr, "CUDA error: %s (line %d)\n", cudaGetErrorString(e_), __LINE__); exit(1); } } while (0)
#define CB(x) do { if ((x) != CUBLAS_STATUS_SUCCESS) { \
  fprintf(stderr, "cuBLAS error (line %d)\n", __LINE__); exit(1); } } while (0)
#define GRID(n) (unsigned)(((n) + 127) / 128), 128

// ---- gather: one thread per problem p --------------------------------------
// X holds H^T as a column-major matrix: writing H(i,j) at i*8+j means cuBLAS
// reads X(j,i) = H(i,j), i.e. X = H^T.  Then op_C(X) = conj(H), op_N(X) = H^T.
__global__ void pack(const cf* H, const cf* y, const float* sig, const int* act,
                     int NA, int B, int S, int K, int LD,
                     cf* X, cf* yv, float* s2) {
  long p = blockIdx.x * (long)blockDim.x + threadIdx.x;
  if (p >= (long)B * NA * K) return;
  int k = p % K; long t = p / K; int si = t % NA; int b = t / NA; int s = act[si];
  const cf* Hb = H + ((long)b * S + s) * 64 * LD;      // H[b][s][i][j][k]
  const cf* yb = y + ((long)b * S + s) * 8 * LD;       // y[b][s][j][k]
  for (int i = 0; i < 8; i++)
    for (int j = 0; j < 8; j++)
      X[p * 64 + i * 8 + j] = Hb[(long)(i * 8 + j) * LD + k];
  for (int j = 0; j < 8; j++) yv[p * 8 + j] = yb[(long)j * LD + k];
  s2[p] = sig[b * 16 + 1];
}

// A = T + sigma2 * I
__global__ void make_A(const cf* T, const float* s2, cf* A, long Pn) {
  long p = blockIdx.x * (long)blockDim.x + threadIdx.x;
  if (p >= Pn) return;
  for (int e = 0; e < 64; e++) A[p * 64 + e] = T[p * 64 + e];
  for (int d = 0; d < 8; d++) A[p * 64 + d * 9].x += s2[p];
}

__global__ void make_ptrs(cf* A, cf* Ai, cf** pA, cf** pAi, long Pn) {
  long p = blockIdx.x * (long)blockDim.x + threadIdx.x;
  if (p < Pn) { pA[p] = A + p * 64; pAi[p] = Ai + p * 64; }
}

// mu[i] = clip(Re(sum_k Ai(i,k) * T(k,i)))   (= diag(Ai*T), no GEMM needed)
// then scatter mu and xhat to [B][S][8][LD]
__global__ void scatter(const cf* Ai, const cf* T, const cf* xv, const int* act,
                        int NA, int B, int S, int K, int LD, float* mu, cf* xo) {
  long p = blockIdx.x * (long)blockDim.x + threadIdx.x;
  if (p >= (long)B * NA * K) return;
  int k = p % K; long t = p / K; int si = t % NA; int b = t / NA; int s = act[si];
  for (int i = 0; i < 8; i++) {
    float acc = 0.f;
    for (int kk = 0; kk < 8; kk++) {
      cf a = Ai[p * 64 + kk * 8 + i];     // Ai(i,kk)  (column-major)
      cf tt = T [p * 64 + i * 8 + kk];    // T(kk,i)
      acc += a.x * tt.x - a.y * tt.y;
    }
    long o = (((long)b * S + s) * 8 + i) * LD + k;
    mu[o] = fminf(fmaxf(acc, -1000.f), 0.9999f);
    xo[o] = xv[p * 8 + i];
  }
}

extern "C" void _mlir_ciface_eq_cuda(Memref1D* y, Memref1D* H, Memref1D* sig,
                                     Memref1D* meta, Memref1D* mu, Memref1D* xo) {
  int64_t* m = ptr<int64_t>(meta);
  const int B = m[0], N = m[1], LD = m[3], S = m[4], K = m[5];
  if (N != 8 || m[2] != 8) { fprintf(stderr, "eq_cuda: only 8x8 supported\n"); exit(1); }

  std::vector<int> act;
  for (int s = 0; s < S; s++) if (m[6 + s] > 0) act.push_back(s);
  const int NA = (int)act.size();
  const long Pn = (long)B * NA * K;

  const size_t nH = (size_t)B * S * 64 * LD, ny = (size_t)B * S * 8 * LD;

  static cublasHandle_t h = nullptr;
  if (!h) CB(cublasCreate(&h));

  cf *dH, *dy, *dxo, *X, *yv, *T, *A, *Ai, *v;
  float *dsig, *dmu, *s2; int *dact, *info; cf **pA, **pAi;
  CK(cudaMalloc(&dH, nH * sizeof(cf)));   CK(cudaMalloc(&dy, ny * sizeof(cf)));
  CK(cudaMalloc(&dsig, (size_t)B * 16 * sizeof(float)));
  CK(cudaMalloc(&dmu, ny * sizeof(float))); CK(cudaMalloc(&dxo, ny * sizeof(cf)));
  CK(cudaMemcpy(dH, ptr<cf>(H), nH * sizeof(cf), cudaMemcpyHostToDevice));
  CK(cudaMemcpy(dy, ptr<cf>(y), ny * sizeof(cf), cudaMemcpyHostToDevice));
  CK(cudaMemcpy(dsig, ptr<float>(sig), (size_t)B * 16 * sizeof(float), cudaMemcpyHostToDevice));
  CK(cudaMemset(dmu, 0, ny * sizeof(float)));       // masked symbols and k >= K stay 0
  CK(cudaMemset(dxo, 0, ny * sizeof(cf)));

  if (NA > 0) {
    CK(cudaMalloc(&dact, NA * sizeof(int)));
    CK(cudaMemcpy(dact, act.data(), NA * sizeof(int), cudaMemcpyHostToDevice));
    CK(cudaMalloc(&X,  Pn * 64 * sizeof(cf))); CK(cudaMalloc(&T,  Pn * 64 * sizeof(cf)));
    CK(cudaMalloc(&A,  Pn * 64 * sizeof(cf))); CK(cudaMalloc(&Ai, Pn * 64 * sizeof(cf)));
    CK(cudaMalloc(&yv, Pn * 8 * sizeof(cf)));  CK(cudaMalloc(&v,  Pn * 8 * sizeof(cf)));
    CK(cudaMalloc(&s2, Pn * sizeof(float)));   CK(cudaMalloc(&info, Pn * sizeof(int)));
    CK(cudaMalloc(&pA, Pn * sizeof(cf*)));     CK(cudaMalloc(&pAi, Pn * sizeof(cf*)));

    cf one = {1.f, 0.f}, zero = {0.f, 0.f};

    pack<<<GRID(Pn)>>>(dH, dy, dsig, dact, NA, B, S, K, LD, X, yv, s2);

    // T = conj(H) * H^T  =  op_C(X) * op_N(X)
    CB(cublasCgemmStridedBatched(h, CUBLAS_OP_C, CUBLAS_OP_N, 8, 8, 8, &one,
                                 X, 8, 64, X, 8, 64, &zero, T, 8, 64, (int)Pn));
    // v = conj(H) * y
    CB(cublasCgemmStridedBatched(h, CUBLAS_OP_C, CUBLAS_OP_N, 8, 1, 8, &one,
                                 X, 8, 64, yv, 8, 8, &zero, v, 8, 8, (int)Pn));
    // A = T + sigma2*I ; Ai = inv(A)
    make_A<<<GRID(Pn)>>>(T, s2, A, Pn);
    make_ptrs<<<GRID(Pn)>>>(A, Ai, pA, pAi, Pn);
    CB(cublasCmatinvBatched(h, 8, pA, 8, pAi, 8, info, (int)Pn));
    // x = Ai * v   (reuse yv as the output buffer)
    CB(cublasCgemmStridedBatched(h, CUBLAS_OP_N, CUBLAS_OP_N, 8, 1, 8, &one,
                                 Ai, 8, 64, v, 8, 8, &zero, yv, 8, 8, (int)Pn));
    // mu from diag(Ai*T), then scatter both outputs
    scatter<<<GRID(Pn)>>>(Ai, T, yv, dact, NA, B, S, K, LD, dmu, dxo);

    std::vector<int> hinfo(Pn);
    CK(cudaMemcpy(hinfo.data(), info, Pn * sizeof(int), cudaMemcpyDeviceToHost));
    long bad = 0; for (int i : hinfo) bad += (i != 0);
    if (bad) fprintf(stderr, "eq_cuda: %ld singular matrices\n", bad);

    cudaFree(dact); cudaFree(X); cudaFree(T); cudaFree(A); cudaFree(Ai); cudaFree(yv);
    cudaFree(v); cudaFree(s2); cudaFree(info); cudaFree(pA); cudaFree(pAi);
  }

  CK(cudaMemcpy(ptr<float>(mu), dmu, ny * sizeof(float), cudaMemcpyDeviceToHost));
  CK(cudaMemcpy(ptr<cf>(xo),  dxo, ny * sizeof(cf),    cudaMemcpyDeviceToHost));
  cudaFree(dH); cudaFree(dy); cudaFree(dsig); cudaFree(dmu); cudaFree(dxo);
}