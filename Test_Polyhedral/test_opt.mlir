module {
  memref.global "private" @A : memref<200x200xi32> = dense<0>
  func.func @main() -> i32 {
    %0 = memref.get_global @A : memref<200x200xi32>
    %c1_i32 = arith.constant 1 : i32
    %c0_i32 = arith.constant 0 : i32
    affine.parallel (%arg0) = (0) to (200) {
      affine.store %c1_i32, %0[0, %arg0] : memref<200x200xi32>
    }
    affine.parallel (%arg0) = (0) to (200) {
      affine.store %c1_i32, %0[%arg0, 0] : memref<200x200xi32>
    }
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
    return %c0_i32 : i32
  }
}

