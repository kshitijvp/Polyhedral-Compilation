
```
nvcc -O2 -arch=sm_89 -Xcompiler -Wall,-fPIC -c equalizer.cu -o equalizer.o
```

Compile using nvcc:
```
nvcc simple.o equalizer.o -o equalizer_exec   ./helpers.so ./mlirifacetoblas.so ./mlirifacetomisc.so   -L. -lopenblas -lmlir_c_runner_utils -lmlir_float16_utils   -lcublas -lcusolver   -Xlinker -rpath=$PWD -Xlinker -rpath-link=$PWD
```
