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
./build_polly/bin/clang prog.c -O3 -g -mllvm -polly     -mllvm -polly-parallel     -fno-inline-functions -mllvm -polly-use-llvm-names     -mllvm -polly-print-deps     -mllvm -polly-print-ast -mllvm -polly-print-instructions
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

