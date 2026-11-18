#include <iostream>
#include <algorithm>
#include <cublas_v2.h>
#include <cuda_runtime.h>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>
#include <stdint.h>

typedef cuComplex cf;

template <typename T>
struct MemRefDescriptor1D {
    T* basePtr;
    T* data;
    intptr_t offset;
    intptr_t size;
    intptr_t stride;
};

template <typename T>
struct MemRefDescriptor2D {
    T* basePtr;
    T* data;
    intptr_t offset;
    intptr_t sizes[2];
    intptr_t strides[2];
};

static cublasHandle_t getHandle() {
  static cublasHandle_t h = nullptr;
  if (!h) cublasCreate(&h);
  return h;
}

__global__ void conjugate(const cf *in, cf *out, long width, long height) {
    long col = blockIdx.x * blockDim.x + threadIdx.x;
    long row = blockIdx.y * blockDim.y + threadIdx.y;

    if (col < width && row < height) {
        long i = row * width + col;
        out[i] = make_cuComplex(in[i].x, -in[i].y);
    }
}

__global__ void diagonal(const cf *in, cf *out, long n, int row_stride, int col_stride) {
    long idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n)    out[idx] = in[idx * (row_stride + col_stride)];
}

__global__ void complextoreal(const cf *in, float *out, long n) {
    long idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n)    out[idx] = in[idx].x; 
}

__global__ void clip_k(const float *in, float *out, long n, double lo, double high) {
    long idx = blockIdx.x * blockDim.x + threadIdx.x;
    if (idx < n) {
        float temp = in[idx] < lo ? lo : in[idx];
        out[idx] = temp < high ? temp : high;
    }
}

extern "C" void _mlir_ciface_cmatmul_gpu(MemRefDescriptor2D<cf> *out , MemRefDescriptor2D<cf> *A, MemRefDescriptor2D<cf>* B) {
    const int64_t m = A->sizes[0], k = A->sizes[1], n = B->sizes[1];
    const int M = static_cast<int>(m);
    const int K = static_cast<int>(k);
    const int N = static_cast<int>(n);
    if (B->sizes[0] != K) {
        fprintf(stderr, "cmatmul: shape mismatch\n");
        abort();
    }
    cf alpha;
    cf beta;
    alpha.x = 1.0f;
    alpha.y = 0.0f;
    beta.x = 0.0f;
    beta.y = 0.0f;
    cf* dA, *dB, *dC;
    cf* srcA = A->data + A->offset;
    cf* srcB = B->data + B->offset;
    cf* hA = (cf*)malloc((size_t)M * K * sizeof(cf));
    cf* hB = (cf*)malloc((size_t)K * N * sizeof(cf));

    for (int i = 0; i < M; i++)
        for (int j = 0; j < K; j++)
            hA[i * K + j] = srcA[i * A->strides[0] + j * A->strides[1]];
    for (int i = 0; i < K; i++)
        for (int j = 0; j < N; j++)
            hB[i * N + j] = srcB[i * B->strides[0] + j * B->strides[1]];

    cf* hC = (cf *)malloc((size_t)M * N * sizeof(cf));
    cudaMalloc((void**)&dA, M * K * sizeof(cf));
    cudaMalloc((void**)&dB, K * N * sizeof(cf));
    cudaMalloc((void**)&dC, M * N * sizeof(cf));
    cudaMemcpy(dA, hA, M * K * sizeof(cf), cudaMemcpyHostToDevice);
    cudaMemcpy(dB, hB, K * N * sizeof(cf), cudaMemcpyHostToDevice);

    cublasCgemm(getHandle(), CUBLAS_OP_N, CUBLAS_OP_N, N, M, K, &alpha,
                dB, N, dA, K, &beta, dC, N);
    cudaMemcpy(hC, dC, (size_t)M * N * sizeof(cf), cudaMemcpyDeviceToHost);
    cudaFree(dC);
    cudaFree(dA);
    cudaFree(dB);
    free(hA);
    free(hB);
    out->basePtr = hC;
    out->data = hC;
    out->offset = 0;
    out->sizes[0] = M, out->sizes[1] = N;
    out->strides[0] = N, out->strides[1] = 1;
}

extern "C" void _mlir_ciface_cgetri_gpu(MemRefDescriptor2D<cf> *out, MemRefDescriptor2D<cf> *A) {
    const int64_t n = A->sizes[0];
    const int N = static_cast<int>(n);
    const int lda = N;
    if (A->sizes[1] != N) {
        fprintf(stderr, "Invalid Operation: Not a Square Matrix \n");
        abort();
    }
    cf *dA, *dInv;
    int *dPiv, *dInfo;
    cf **dAarray, **dCarray; 
    cf *srcA = A->data + A->offset;
    cf *hInv = (cf*)malloc((size_t)N * N * sizeof(cf));
    cf* hA = (cf*)malloc((size_t)N * N * sizeof(cf));

    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            hA[i * N + j] = srcA[i * A->strides[0] + j * A->strides[1]];
        }
    }

    cudaMalloc((void**)&dA, N * N * sizeof(cf));
    cudaMalloc((void**)&dInv, N * N * sizeof(cf));
    cudaMemcpy(dA, hA, N * N * sizeof(cf), cudaMemcpyHostToDevice);
    cudaMalloc((void**)&dPiv, N * sizeof(int));
    cudaMalloc((void**)&dInfo, sizeof(int));
    cudaMalloc((void**)&dAarray, sizeof(cf*));
    cudaMalloc((void**)&dCarray, sizeof(cf*));
    cf* aPtr = dA;   
    cf* cPtr = dInv;
    cudaMemcpy(dAarray, &aPtr, sizeof(aPtr), cudaMemcpyHostToDevice);
    cudaMemcpy(dCarray, &cPtr, sizeof(cPtr), cudaMemcpyHostToDevice);

    cublasCgetrfBatched(getHandle(), N, dAarray, lda, dPiv, dInfo, 1);
    int info = 0;
    cudaMemcpy(&info, dInfo, sizeof(int), cudaMemcpyDeviceToHost);
    if (info != 0) {
        fprintf(stderr, "cgetri: matrix is singular (info=%d)\n", info);
        abort();
    }

    cublasCgetriBatched(getHandle(), N, dAarray, lda, dPiv, dCarray, lda, dInfo, 1);
    
    cudaMemcpy(&info, dInfo, sizeof(int), cudaMemcpyDeviceToHost);
    if (info != 0) {
        fprintf(stderr, "cgetri: inversion failed (info=%d)\n", info);
        abort();
    }
    cudaMemcpy(hInv, dInv, (size_t)N * N * sizeof(cf), cudaMemcpyDeviceToHost);

    cudaFree(dAarray);
    cudaFree(dCarray);
    cudaFree(dA);
    cudaFree(dInv);
    cudaFree(dPiv);
    cudaFree(dInfo);
    free(hA);

    out->basePtr = hInv;
    out->data = hInv;
    out->offset = 0;
    out->sizes[0] = N;
    out->sizes[1] = N;
    out->strides[0] = N;
    out->strides[1] = 1;
}

extern "C" void _mlir_ciface_clacgm_gpu(MemRefDescriptor2D<cf> *out, MemRefDescriptor2D<cf> *A) {
    int64_t m = A->sizes[0];
    int64_t n = A->sizes[1];
    int M = static_cast<int>(m);
    int N = static_cast<int>(n);
    const cf *src = A->data + A->offset;
    cf *h = (cf*)malloc(M * N * sizeof(cf));

    // Doing a Deep Copy of the Matrix. Final Result will be stored here too
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            h[i * N + j] = src[i * A->strides[0] + j * A->strides[1]];
        }
    }
    cf *dIn, *dOut;
    cudaMalloc((void**)&dIn,  M * N * sizeof(cf));
    cudaMalloc((void**)&dOut, M * N * sizeof(cf));
    cudaMemcpy(dIn, h, M * N * sizeof(cf), cudaMemcpyHostToDevice);

    dim3 block(16, 16);
    dim3 grid((N + 15) / 16, (M + 15) / 16);
    conjugate<<<grid, block>>>(dIn, dOut, N, M);
    cudaMemcpy(h, dOut, M * N * sizeof(cf), cudaMemcpyDeviceToHost);
    cudaFree(dIn);
    cudaFree(dOut);
    out->basePtr = h;
    out->data = h;
    out->offset = 0;
    out->sizes[0] = M, out->sizes[1] = N;
    out->strides[0] = N, out->strides[1] = 1;
}

extern "C" void _mlir_ciface_diag(MemRefDescriptor1D<cf> *out, MemRefDescriptor2D<cf> *A) {
    const int64_t m = A->sizes[0];
    const int64_t n = A->sizes[1];
    const int M = static_cast<int>(m);
    const int N = static_cast<int>(n);
    const cf *src = A->data + A->offset;
    cf *h = (cf*)malloc(M * N * sizeof(cf));

    // Doing a Deep Copy of the Matrix. Final Result will be stored here too
    for (int i = 0; i < M; i++) {
        for (int j = 0; j < N; j++) {
            h[i * N + j] = src[i * A->strides[0] + j * A->strides[1]];
        }
    }
    cf *dIn, *dOut;
    int mn = std::min(M, N);
    cudaMalloc((void**)&dIn,  M * N * sizeof(cf));
    cudaMalloc((void**)&dOut, mn * sizeof(cf));
    cudaMemcpy(dIn, h, M * N * sizeof(cf), cudaMemcpyHostToDevice);
    diagonal<<<(mn + 127) / 128, 128>>>(dIn, dOut, mn, N, 1);
    cf *hOut = (cf*)malloc(mn * sizeof(cf));
    free(h);

    cudaMemcpy(hOut, dOut, mn * sizeof(cf), cudaMemcpyDeviceToHost);
    cudaFree(dIn);
    cudaFree(dOut);
    out->basePtr = hOut;
    out->data = hOut;
    out->offset = 0;
    out->size = mn;
    out->stride = 1;
}

extern "C" void _mlir_ciface_complex_to_real(MemRefDescriptor1D<float> *out, MemRefDescriptor1D<cf> *A) {
    const int64_t n = A->size;
    const int N = static_cast<int>(n);
    const cf *src = A->data + A->offset;
    cf *h = (cf*)malloc(N * sizeof(cf));

    for (int i = 0; i < N; i++) {
        h[i] = src[i * A->stride];
    }

    cf *dIn;
    float *dOut;
    cudaMalloc((void**)&dIn, N * sizeof(cf));
    cudaMalloc((void**)&dOut, N * sizeof(float));
    cudaMemcpy(dIn, h, N * sizeof(cf), cudaMemcpyHostToDevice);
    complextoreal<<<(N + 127) / 128, 128>>>(dIn, dOut, N);
    float *hOut = (float*)malloc(N * sizeof(float));
    free(h);

    cudaMemcpy(hOut, dOut, N * sizeof(float), cudaMemcpyDeviceToHost);
    cudaFree(dOut);
    cudaFree(dIn);

    out->basePtr = hOut;
    out->data = hOut;
    out->offset = 0;
    out->size = N;
    out->stride = 1;
}

extern "C" void _mlir_ciface_clip(MemRefDescriptor1D<float> *out, MemRefDescriptor1D<float> *A, double lo, double high) {
    const int64_t n = A->size;
    const int N = static_cast<int>(n);
    const float *src = A->data + A->offset;
    float *h = (float*)malloc(N * sizeof(float));

    for (int i = 0; i < N; i++) {
        h[i] = src[i * A->stride];
    }

    float *dIn, *dOut;
    cudaMalloc((void**)&dIn, N * sizeof(float));
    cudaMalloc((void**)&dOut, N * sizeof(float));
    cudaMemcpy(dIn, h, N * sizeof(float), cudaMemcpyHostToDevice);
    clip_k<<<(N + 127) / 128, 128>>>(dIn, dOut, N, lo, high);
    float *hOut = (float*)malloc(N * sizeof(float));
    free(h);

    cudaMemcpy(hOut, dOut, N * sizeof(float), cudaMemcpyDeviceToHost);
    cudaFree(dOut);
    cudaFree(dIn);

    out->basePtr = hOut;
    out->data = hOut;
    out->offset = 0;
    out->size = N;
    out->stride = 1;  
}