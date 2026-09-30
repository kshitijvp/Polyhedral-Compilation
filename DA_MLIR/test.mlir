module {
  func.func @main() -> i32 {
    // 1. Allocate the 2D array (representing int A[200][200])
    %A = memref.alloc() : memref<200x200xi32>

    // Constant 0 for initialization
    %c0_i32 = arith.constant 0 : i32

    // 2. First loop nest: Initialize the array to 0
    affine.for %i = 0 to 200 {
      affine.for %j = 0 to 200 {
        affine.store %c0_i32, %A[%i, %j] : memref<200x200xi32>
      }
    }

    // 3. Second loop nest: Compute A[i][j] = A[i-1][j] + A[i][j-1]
    affine.for %i = 1 to 200 {
      affine.for %j = 1 to 200 {
        // Load A[i - 1][j]
        %top = affine.load %A[%i - 1, %j] : memref<200x200xi32>
  
        // Load A[i][j - 1]
        %left = affine.load %A[%i, %j - 1] : memref<200x200xi32>

        // Add the two values
        %sum = arith.addi %top, %left : i32
        
        // Store the result in A[i][j]
        affine.store %sum, %A[%i, %j] : memref<200x200xi32>
      }
    }

    // 4. Free the memory (Standard MLIR practice)
    memref.dealloc %A : memref<200x200xi32>

    // 5. Return 0
    %ret = arith.constant 0 : i32
    return %ret : i32
  }
}
