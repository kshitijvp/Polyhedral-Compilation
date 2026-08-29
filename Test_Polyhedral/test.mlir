module {
  // Global 200x200 integer array initialized to zero
  memref.global "private" @A : memref<200x200xi32> = dense<0>

  func.func @main() -> i32 {
    %A = memref.get_global @A : memref<200x200xi32>
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32

    // for (j = 0; j < 200; j++) A[0][j] = 1;
    affine.for %j = 0 to 200 {
      affine.store %c1_i32, %A[0, %j] : memref<200x200xi32>
    }

    // for (i = 0; i < 200; i++) A[i][0] = 1;
    affine.for %i = 0 to 200 {
      affine.store %c1_i32, %A[%i, 0] : memref<200x200xi32>
    }

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

    return %c0_i32 : i32
  }
}