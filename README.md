# Polyhedral-Compilation
The commands given on Polly Documentation are outdated and work for the Old Pass Manager, the new instructions for NPM are as follows: 

## Downloading Polly
```
cmake -B build_polly -G Ninja -DLLVM_ENABLE_ASSERTIONS=On -DLLVM_ENABLE_PROJECTS="clang;polly" -DCMAKE_BUILD_TYPE=Release
sudo ninja -C build_polly install
```
If your Machine fails to build this consider using lower cores using the -j option with ninja command (Ex sudo ninja -C build_polly install -j6)

## Features in Polly for Parallelization

```
./build_polly/bin/clang prog.c -O3 -g -mllvm -polly     -mllvm -polly-parallel     -fno-inline-functions -mllvm -polly-use-llvm-names     -mllvm -polly-print-deps     -mllvm -polly-print-ast -mllvm -polly-print-instructions -mllvm -polly-print-opt-isl
```
For using polly with Clang give the `-mllvm` option along with further commands:
`-polly` : Enable the polly optimizer (with -O1, -O2 or -O3)
`-polly-parallel` : Generate thread parallel code (isl codegen only)
`-polly-dot` : Generates dot files of SCoPs
`-polly-print-ast` : Print the ISL abstract syntax tree
`-polly-print-deps` : Print Dependencies
`-polly-print-scops` : Print Polyhedral Description of all regions
`-polly-report` : Print information about the activities of Polly
`-polly-use-llvm-names` : Uses Names similar to LLVM IR for easy identification of Statements.
`-polly-print-opt-isl` : Prints the Optimize Schedule of SCoPs

For OpenMP Code Generation:
`clang -O3 -mllvm -polly -mllvm -polly-parallel -lgomp file.c`

## Analysis Generated using Polly

Polly automatically generates RAW, WAR, WAW Dependencies as well as the Optimize Schedules.
The file `prog.c` contains a RAW Dependency {i, j} -> {i - 1, j - 1}
However dependencies are only across a Diagonal. The Diagonals are independent of each other.
Polly generates the Schedule accordingly and tracks the dependencies:
`schedule: "[{ Stmt_for_body15[i0, i1] -> [(floor((i0 - i1)/32))] }, { Stmt_for_body15[i0, i1] -> [(floor((i0)/32))] }]"`

```
	RAW dependences:
		{ Stmt_for_body[i0] -> Stmt_for_body15[0, i0] : 0 < i0 <= 198; Stmt_for_body15[i0, i1] -> Stmt_for_body15[1 + i0, 1 + i1] : 0 <= i0 <= 197 and 0 <= i1 <= 197; Stmt_for_body3[i0] -> Stmt_for_body15[i0, 0] : 0 <= i0 <= 198 }
	WAR dependences:
		{  }
	WAW dependences:
		{ Stmt_for_body[0] -> Stmt_for_body3[0] }
	Reduction dependences:
		{  }
	Transitive closure of reduction dependences:
		{  }
```

## Passes in MLIR Affine Dialect
```
./build_mlir/bin/mlir-opt conv2d.mlir --affine-parallelize -o conv2d_opt.mlir
```

`-affine-parallelize` - Parallelize Loops

Input Program (Check `test.mlir` for complete program):
```
// for (i = 1; i < 200; i++)
//   for (j = 1; j < 200; j++)
//     A[i][j] = A[i - 1][j - 1] + (i * j);
affine.for %i = 1 to 200 {
  affine.for %j = 1 to 200 {
	// Load A[i - 1][j - 1] using affine map arithmetic
	%prev = affine.load %A[%i - 1, %j - 1] : memref<200x200xi32>

	// Convert index induction variables to i32 for arithmetic multiplication
	%i_i32 = arith.index_cast %i : index to i32
	%j_i32 = arith.index_cast %j : index to i32
	%prod = arith.muli %i_i32, %j_i32 : i32

	// Compute A[i - 1][j - 1] + (i * j)
	%res = arith.addi %prev, %prod : i32

	affine.store %res, %A[%i, %j] : memref<200x200xi32>
  }
}
```

Transformed Program (Check `test_opt.mlir` for complete program):
```
affine.for %arg0 = 1 to 200 {
  affine.parallel (%arg1) = (1) to (200) {
	%1 = affine.load %0[%arg0 - 1, %arg1 - 1] : memref<200x200xi32>
	%2 = arith.index_cast %arg0 : index to i32
	%3 = arith.index_cast %arg1 : index to i32
	%4 = arith.muli %2, %3 : i32
	%5 = arith.addi %1, %4 : i32
	affine.store %5, %0[%arg0, %arg1] : memref<200x200xi32>
  }
}

```

`-test-memref-dependence-check` : Find Data Dependencies

Sample Output
```
test.mlir:12:7: remark: dependence from 0 to 0 at depth 1 = false
      affine.store %c1_i32, %A[0, %j] : memref<200x200xi32>
      ^
test.mlir:12:7: note: see current operation: affine.store %c1_i32, %0[0, %arg0] : memref<200x200xi32>
test.mlir:12:7: remark: dependence from 0 to 0 at depth 2 = false
      affine.store %c1_i32, %A[0, %j] : memref<200x200xi32>
      ^
test.mlir:12:7: note: see current operation: affine.store %c1_i32, %0[0, %arg0] : memref<200x200xi32>
test.mlir:12:7: remark: dependence from 0 to 1 at depth 1 = true
      affine.store %c1_i32, %A[0, %j] : memref<200x200xi32>
      ^
test.mlir:12:7: note: see current operation: affine.store %c1_i32, %0[0, %arg0] : memref<200x200xi32>
test.mlir:12:7: remark: dependence from 0 to 2 at depth 1 = true
      affine.store %c1_i32, %A[0, %j] : memref<200x200xi32>
      ^
test.mlir:12:7: note: see current operation: affine.store %c1_i32, %0[0, %arg0] : memref<200x200xi32>
test.mlir:12:7: remark: dependence from 0 to 3 at depth 1 = false
      affine.store %c1_i32, %A[0, %j] : memref<200x200xi32>

```

## Checking Functional Correctness

We use the `-DPOLYBENCH_DUMP_ARRAYS` flag of PolyBenchC-4.2.1 for checking functional correctness of parallelization.
It prints the final Live-out Arrays after the computation.
```
cd PolyBenchC-4.2.1

your_llvm_installation/build_polly/bin/clang -O0 -g -I utilities -I linear-algebra/blas/gemm utilities/polybench.c linear-algebra/blas/gemm/gemm.c -DPOLYBENCH_DUMP_ARRAYS -lm -o gemm_ref

./gemm_ref 2>gemm_ref.out

/home/kshitijvp/llvm-project/build_polly/bin/clang -O0 -g -I utilities -I linear-algebra/blas/gemm utilities/polybench.c linear-algebra/blas/gemm/gemm.c -mllvm -polly -mllvm -polly-parallel -lgomp -DPOLYBENCH_DUMP_ARRAYS -lm -o gemm_parallel_ref

./gemm_parallel_ref 2>gemm_parallel_ref.out
```

`gemm_ref.out`, `gemm_parallel_ref.out` must contain the same data.
