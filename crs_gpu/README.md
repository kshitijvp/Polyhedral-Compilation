Convert to .o file
```
 ./build_mlir/bin/mlir-translate --mlir-to-llvmir stage2_llvm.mlir -o main.ll
./build_mlir/bin/llc -filetype=obj -relocation-model=pic main.ll -o main.o
```

Compile using nvcc
```
nvcc main.o -o crs ./helpers.so ./mlirifacetoblas.so ./mlirifacetomisc.so   -L. -lmlir_cuda_runtime -lmlir_c_runner_utils -lmlir_float16_utils -lopenblas   -lcuda -lcublas -lcusolver   -Xlinker -rpath=$PWD -Xlinker -rpath-link=$PWD
```
