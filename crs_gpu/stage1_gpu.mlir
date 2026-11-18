#map = affine_map<(d0)[s0, s1] -> ((d0 - s0) ceildiv s1)>
#map1 = affine_map<(d0)[s0, s1] -> (d0 * s0 + s1)>
module attributes {gpu.container_module} {
  func.func private @dslran_print_memref_2D_complex_f32(memref<?x?xcomplex<f32>>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %c4 = arith.constant 4 : index
    %c5 = arith.constant 5 : index
    %c10 = arith.constant 10 : index
    %c31 = arith.constant 31 : index
    %c40 = arith.constant 40 : index
    %c440 = arith.constant 440 : index
    %c1600 = arith.constant 1600 : index
    %c2009 = arith.constant 2009 : index
    %c2040 = arith.constant 2040 : index
    %c0_i64 = arith.constant 0 : i64
    %c1_i64 = arith.constant 1 : i64
    %c2_i64 = arith.constant 2 : i64
    %c3_i64 = arith.constant 3 : i64
    %c4_i64 = arith.constant 4 : i64
    %c7_i64 = arith.constant 7 : i64
    %c9_i64 = arith.constant 9 : i64
    %c31_i64 = arith.constant 31 : i64
    %c105_i64 = arith.constant 105 : i64
    %c9216_i64 = arith.constant 9216 : i64
    %c0_i32 = arith.constant 0 : i32
    %c2_i32 = arith.constant 2 : i32
    %cst = arith.constant 0.000000e+00 : f64
    %cst_0 = arith.constant 1.000000e+00 : f64
    %cst_1 = arith.constant 1.000000e+00 : f32
    %cst_2 = arith.constant 0.70710678118654746 : f64
    %cst_3 = arith.constant 0.000000e+00 : f32
    %memref = gpu.alloc  (%c4, %c10) : memref<?x?xcomplex<f32>>
    %c1_4 = arith.constant 1 : index
    %0 = affine.apply #map(%c2)[%c0, %c1]
    %1 = affine.apply #map(%c2)[%c0, %c1]
    gpu.launch_func  @main_kernel::@main_kernel blocks in (%0, %1, %c1_4) threads in (%c1_4, %c1_4, %c1_4)  args(%c1 : index, %c0 : index, %c4_i64 : i64, %c2 : index, %c1_i64 : i64, %c7_i64 : i64, %c9216_i64 : i64, %c9_i64 : i64, %cst : f64, %c31 : index, %cst_0 : f64, %c0_i64 : i64, %c3_i64 : i64, %c0_i32 : i32, %c2040 : index, %c2009 : index, %c31_i64 : i64, %c2_i32 : i32, %c2_i64 : i64, %c3 : index, %c4 : index, %c1600 : index, %c440 : index, %c10 : index, %c105_i64 : i64, %cst_2 : f64, %cst_3 : f32, %cst_1 : f32, %memref : memref<?x?xcomplex<f32>>)
    %memref_5 = gpu.alloc  host_shared (%c40, %c5) : memref<?x?xcomplex<f32>>
    %c1_6 = arith.constant 1 : index
    %2 = affine.apply #map(%c40)[%c0, %c1]
    %3 = affine.apply #map(%c5)[%c0, %c1]
    gpu.launch_func  @main_kernel_0::@main_kernel blocks in (%2, %3, %c1_6) threads in (%c1_6, %c1_6, %c1_6)  args(%c1 : index, %c0 : index, %c10 : index, %memref : memref<?x?xcomplex<f32>>, %memref_5 : memref<?x?xcomplex<f32>>)
    call @dslran_print_memref_2D_complex_f32(%memref_5) : (memref<?x?xcomplex<f32>>) -> ()
    gpu.dealloc  %memref_5 : memref<?x?xcomplex<f32>>
    gpu.dealloc  %memref : memref<?x?xcomplex<f32>>
    return
  }
  gpu.module @main_kernel {
    gpu.func @main_kernel(%arg0: index, %arg1: index, %arg2: i64, %arg3: index, %arg4: i64, %arg5: i64, %arg6: i64, %arg7: i64, %arg8: f64, %arg9: index, %arg10: f64, %arg11: i64, %arg12: i64, %arg13: i32, %arg14: index, %arg15: index, %arg16: i64, %arg17: i32, %arg18: i64, %arg19: index, %arg20: index, %arg21: index, %arg22: index, %arg23: index, %arg24: i64, %arg25: f64, %arg26: f32, %arg27: f32, %arg28: memref<?x?xcomplex<f32>>) kernel attributes {known_block_size = array<i32: 1, 1, 1>} {
      %block_id_x = gpu.block_id x
      %block_id_y = gpu.block_id y
      %block_id_z = gpu.block_id z
      %thread_id_x = gpu.thread_id x
      %thread_id_y = gpu.thread_id y
      %thread_id_z = gpu.thread_id z
      %grid_dim_x = gpu.grid_dim x
      %grid_dim_y = gpu.grid_dim y
      %grid_dim_z = gpu.grid_dim z
      %block_dim_x = gpu.block_dim x
      %block_dim_y = gpu.block_dim y
      %block_dim_z = gpu.block_dim z
      %0 = affine.apply #map1(%block_id_x)[%arg0, %arg1]
      %1 = affine.apply #map1(%block_id_y)[%arg0, %arg1]
      %2 = arith.index_cast %0 : index to i64
      %3 = arith.index_cast %1 : index to i64
      %4 = arith.muli %3, %arg2 : i64
      %5 = arith.muli %0, %arg3 : index
      %6 = arith.addi %2, %arg4 : i64
      %7 = arith.muli %6, %arg5 : i64
      %8 = arith.addi %7, %4 : i64
      %9 = arith.addi %8, %arg4 : i64
      %10 = arith.muli %9, %arg6 : i64
      %11 = arith.addi %10, %arg7 : i64
      %alloca = memref.alloca() : memref<31xf64>
      scf.for %arg29 = %arg1 to %arg9 step %arg0 {
        memref.store %arg8, %alloca[%arg29] : memref<31xf64>
      }
      memref.store %arg10, %alloca[%arg1] : memref<31xf64>
      %alloca_0 = memref.alloca() : memref<2xi64>
      memref.store %arg11, %alloca_0[%arg1] : memref<2xi64>
      memref.store %arg12, %alloca_0[%arg0] : memref<2xi64>
      %alloca_1 = memref.alloca() : memref<2040xi32>
      scf.for %arg29 = %arg1 to %arg14 step %arg0 {
        memref.store %arg13, %alloca_1[%arg29] : memref<2040xi32>
      }
      scf.for %arg29 = %arg1 to %arg9 step %arg0 {
        %17 = memref.load %alloca[%arg29] : memref<31xf64>
        %18 = arith.fptosi %17 : f64 to i32
        memref.store %18, %alloca_1[%arg29] : memref<2040xi32>
      }
      %alloca_2 = memref.alloca() : memref<2009xi64>
      scf.for %arg29 = %arg1 to %arg15 step %arg0 {
        %17 = arith.index_cast %arg29 : index to i64
        memref.store %17, %alloca_2[%arg29] : memref<2009xi64>
      }
      %alloca_3 = memref.alloca() : memref<2xi64>
      %alloca_4 = memref.alloca() : memref<2xi64>
      %alloca_5 = memref.alloca() : memref<2xi32>
      scf.for %arg29 = %arg1 to %arg15 step %arg0 {
        %17 = memref.load %alloca_2[%arg29] : memref<2009xi64>
        %18 = arith.addi %17, %arg16 : i64
        %19 = arith.index_cast %18 : i64 to index
        scf.for %arg30 = %arg1 to %arg3 step %arg0 {
          memref.store %17, %alloca_3[%arg30] : memref<2xi64>
        }
        scf.for %arg30 = %arg1 to %arg3 step %arg0 {
          %22 = memref.load %alloca_3[%arg30] : memref<2xi64>
          %23 = memref.load %alloca_0[%arg30] : memref<2xi64>
          %24 = arith.addi %22, %23 : i64
          memref.store %24, %alloca_4[%arg30] : memref<2xi64>
        }
        scf.for %arg30 = %arg1 to %arg3 step %arg0 {
          %22 = memref.load %alloca_4[%arg30] : memref<2xi64>
          %23 = arith.index_cast %22 : i64 to index
          %24 = memref.load %alloca_1[%23] : memref<2040xi32>
          memref.store %24, %alloca_5[%arg30] : memref<2xi32>
        }
        %20 = scf.for %arg30 = %arg1 to %arg3 step %arg0 iter_args(%arg31 = %arg13) -> (i32) {
          %22 = memref.load %alloca_5[%arg30] : memref<2xi32>
          %23 = arith.addi %arg31, %22 : i32
          scf.yield %23 : i32
        }
        %21 = arith.remsi %20, %arg17 : i32
        memref.store %21, %alloca_1[%19] : memref<2040xi32>
      }
      %alloca_6 = memref.alloca() : memref<31xf64>
      scf.for %arg29 = %arg1 to %arg9 step %arg0 {
        %17 = arith.index_cast %arg29 : index to i64
        %18 = arith.shrui %11, %17 : i64
        %19 = arith.andi %18, %arg4 : i64
        %20 = arith.sitofp %19 : i64 to f64
        memref.store %20, %alloca_6[%arg29] : memref<31xf64>
      }
      %alloca_7 = memref.alloca() : memref<4xi64>
      memref.store %arg11, %alloca_7[%arg1] : memref<4xi64>
      memref.store %arg4, %alloca_7[%arg0] : memref<4xi64>
      memref.store %arg18, %alloca_7[%arg3] : memref<4xi64>
      memref.store %arg12, %alloca_7[%arg19] : memref<4xi64>
      %alloca_8 = memref.alloca() : memref<2040xi32>
      scf.for %arg29 = %arg1 to %arg14 step %arg0 {
        memref.store %arg13, %alloca_8[%arg29] : memref<2040xi32>
      }
      scf.for %arg29 = %arg1 to %arg9 step %arg0 {
        %17 = memref.load %alloca_6[%arg29] : memref<31xf64>
        %18 = arith.fptosi %17 : f64 to i32
        memref.store %18, %alloca_8[%arg29] : memref<2040xi32>
      }
      %alloca_9 = memref.alloca() : memref<2009xi64>
      scf.for %arg29 = %arg1 to %arg15 step %arg0 {
        %17 = arith.index_cast %arg29 : index to i64
        memref.store %17, %alloca_9[%arg29] : memref<2009xi64>
      }
      %alloca_10 = memref.alloca() : memref<4xi64>
      %alloca_11 = memref.alloca() : memref<4xi64>
      %alloca_12 = memref.alloca() : memref<4xi32>
      scf.for %arg29 = %arg1 to %arg15 step %arg0 {
        %17 = memref.load %alloca_9[%arg29] : memref<2009xi64>
        %18 = arith.addi %17, %arg16 : i64
        %19 = arith.index_cast %18 : i64 to index
        scf.for %arg30 = %arg1 to %arg20 step %arg0 {
          memref.store %17, %alloca_10[%arg30] : memref<4xi64>
        }
        scf.for %arg30 = %arg1 to %arg20 step %arg0 {
          %22 = memref.load %alloca_10[%arg30] : memref<4xi64>
          %23 = memref.load %alloca_7[%arg30] : memref<4xi64>
          %24 = arith.addi %22, %23 : i64
          memref.store %24, %alloca_11[%arg30] : memref<4xi64>
        }
        scf.for %arg30 = %arg1 to %arg20 step %arg0 {
          %22 = memref.load %alloca_11[%arg30] : memref<4xi64>
          %23 = arith.index_cast %22 : i64 to index
          %24 = memref.load %alloca_8[%23] : memref<2040xi32>
          memref.store %24, %alloca_12[%arg30] : memref<4xi32>
        }
        %20 = scf.for %arg30 = %arg1 to %arg20 step %arg0 iter_args(%arg31 = %arg13) -> (i32) {
          %22 = memref.load %alloca_12[%arg30] : memref<4xi32>
          %23 = arith.addi %arg31, %22 : i32
          scf.yield %23 : i32
        }
        %21 = arith.remsi %20, %arg17 : i32
        memref.store %21, %alloca_8[%19] : memref<2040xi32>
      }
      %alloca_13 = memref.alloca() : memref<2040xi32>
      scf.for %arg29 = %arg1 to %arg14 step %arg0 {
        %17 = memref.load %alloca_1[%arg29] : memref<2040xi32>
        %18 = memref.load %alloca_8[%arg29] : memref<2040xi32>
        %19 = arith.addi %17, %18 : i32
        memref.store %19, %alloca_13[%arg29] : memref<2040xi32>
      }
      %alloca_14 = memref.alloca() : memref<2040xi32>
      scf.for %arg29 = %arg1 to %arg14 step %arg0 {
        memref.store %arg17, %alloca_14[%arg29] : memref<2040xi32>
      }
      %alloca_15 = memref.alloca() : memref<2040xi32>
      scf.for %arg29 = %arg1 to %arg14 step %arg0 {
        %17 = memref.load %alloca_13[%arg29] : memref<2040xi32>
        %18 = memref.load %alloca_14[%arg29] : memref<2040xi32>
        %19 = arith.remsi %17, %18 : i32
        memref.store %19, %alloca_15[%arg29] : memref<2040xi32>
      }
      %alloca_16 = memref.alloca() : memref<440xi64>
      scf.for %arg29 = %arg1 to %arg22 step %arg0 {
        %17 = arith.addi %arg29, %arg21 : index
        %18 = memref.load %alloca_15[%17] : memref<2040xi32>
        %19 = arith.extsi %18 : i32 to i64
        memref.store %19, %alloca_16[%arg29] : memref<440xi64>
      }
      %alloca_17 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = arith.index_cast %arg29 : index to i64
        memref.store %17, %alloca_17[%arg29] : memref<10xi64>
      }
      %alloca_18 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %arg24, %alloca_18[%arg29] : memref<10xi64>
      }
      %alloca_19 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_17[%arg29] : memref<10xi64>
        %18 = memref.load %alloca_18[%arg29] : memref<10xi64>
        %19 = arith.addi %17, %18 : i64
        memref.store %19, %alloca_19[%arg29] : memref<10xi64>
      }
      %alloca_20 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %arg18, %alloca_20[%arg29] : memref<10xi64>
      }
      %alloca_21 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_20[%arg29] : memref<10xi64>
        %18 = memref.load %alloca_19[%arg29] : memref<10xi64>
        %19 = arith.muli %17, %18 : i64
        memref.store %19, %alloca_21[%arg29] : memref<10xi64>
      }
      %alloca_22 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_21[%arg29] : memref<10xi64>
        %18 = arith.index_cast %17 : i64 to index
        %19 = memref.load %alloca_16[%18] : memref<440xi64>
        memref.store %19, %alloca_22[%arg29] : memref<10xi64>
      }
      %alloca_23 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %arg18, %alloca_23[%arg29] : memref<10xi64>
      }
      %alloca_24 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_23[%arg29] : memref<10xi64>
        %18 = memref.load %alloca_19[%arg29] : memref<10xi64>
        %19 = arith.muli %17, %18 : i64
        memref.store %19, %alloca_24[%arg29] : memref<10xi64>
      }
      %alloca_25 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %arg4, %alloca_25[%arg29] : memref<10xi64>
      }
      %alloca_26 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_24[%arg29] : memref<10xi64>
        %18 = memref.load %alloca_25[%arg29] : memref<10xi64>
        %19 = arith.addi %17, %18 : i64
        memref.store %19, %alloca_26[%arg29] : memref<10xi64>
      }
      %alloca_27 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_26[%arg29] : memref<10xi64>
        %18 = arith.index_cast %17 : i64 to index
        %19 = memref.load %alloca_16[%18] : memref<440xi64>
        memref.store %19, %alloca_27[%arg29] : memref<10xi64>
      }
      %alloca_28 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %arg18, %alloca_28[%arg29] : memref<10xi64>
      }
      %alloca_29 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_28[%arg29] : memref<10xi64>
        %18 = memref.load %alloca_22[%arg29] : memref<10xi64>
        %19 = arith.muli %17, %18 : i64
        memref.store %19, %alloca_29[%arg29] : memref<10xi64>
      }
      %alloca_30 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %arg4, %alloca_30[%arg29] : memref<10xi64>
      }
      %alloca_31 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_30[%arg29] : memref<10xi64>
        %18 = memref.load %alloca_29[%arg29] : memref<10xi64>
        %19 = arith.subi %17, %18 : i64
        memref.store %19, %alloca_31[%arg29] : memref<10xi64>
      }
      %alloca_32 = memref.alloca() : memref<10xf64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_31[%arg29] : memref<10xi64>
        %18 = arith.sitofp %17 : i64 to f64
        memref.store %18, %alloca_32[%arg29] : memref<10xf64>
      }
      %alloca_33 = memref.alloca() : memref<10xf64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %arg25, %alloca_33[%arg29] : memref<10xf64>
      }
      %alloca_34 = memref.alloca() : memref<10xf64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_33[%arg29] : memref<10xf64>
        %18 = memref.load %alloca_32[%arg29] : memref<10xf64>
        %19 = arith.mulf %17, %18 : f64
        memref.store %19, %alloca_34[%arg29] : memref<10xf64>
      }
      %12 = complex.create %arg26, %arg27 : complex<f32>
      %13 = arith.truncf %arg25 : f64 to f32
      %14 = complex.create %13, %arg26 : complex<f32>
      %15 = complex.mul %12, %14 : complex<f32>
      %alloca_35 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %arg18, %alloca_35[%arg29] : memref<10xi64>
      }
      %alloca_36 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_35[%arg29] : memref<10xi64>
        %18 = memref.load %alloca_27[%arg29] : memref<10xi64>
        %19 = arith.muli %17, %18 : i64
        memref.store %19, %alloca_36[%arg29] : memref<10xi64>
      }
      %alloca_37 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %arg4, %alloca_37[%arg29] : memref<10xi64>
      }
      %alloca_38 = memref.alloca() : memref<10xi64>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_37[%arg29] : memref<10xi64>
        %18 = memref.load %alloca_36[%arg29] : memref<10xi64>
        %19 = arith.subi %17, %18 : i64
        memref.store %19, %alloca_38[%arg29] : memref<10xi64>
      }
      %alloca_39 = memref.alloca() : memref<10xcomplex<f32>>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_38[%arg29] : memref<10xi64>
        %18 = arith.sitofp %17 : i64 to f32
        %19 = complex.create %18, %arg26 : complex<f32>
        memref.store %19, %alloca_39[%arg29] : memref<10xcomplex<f32>>
      }
      %alloca_40 = memref.alloca() : memref<10xcomplex<f32>>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        memref.store %15, %alloca_40[%arg29] : memref<10xcomplex<f32>>
      }
      %alloca_41 = memref.alloca() : memref<10xcomplex<f32>>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_40[%arg29] : memref<10xcomplex<f32>>
        %18 = memref.load %alloca_39[%arg29] : memref<10xcomplex<f32>>
        %19 = complex.mul %17, %18 : complex<f32>
        memref.store %19, %alloca_41[%arg29] : memref<10xcomplex<f32>>
      }
      %alloca_42 = memref.alloca() : memref<10xcomplex<f32>>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_34[%arg29] : memref<10xf64>
        %18 = arith.truncf %17 : f64 to f32
        %19 = complex.create %18, %arg26 : complex<f32>
        memref.store %19, %alloca_42[%arg29] : memref<10xcomplex<f32>>
      }
      %alloca_43 = memref.alloca() : memref<10xcomplex<f32>>
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_42[%arg29] : memref<10xcomplex<f32>>
        %18 = memref.load %alloca_41[%arg29] : memref<10xcomplex<f32>>
        %19 = complex.add %17, %18 : complex<f32>
        memref.store %19, %alloca_43[%arg29] : memref<10xcomplex<f32>>
      }
      %16 = arith.addi %5, %1 : index
      scf.for %arg29 = %arg1 to %arg23 step %arg0 {
        %17 = memref.load %alloca_43[%arg29] : memref<10xcomplex<f32>>
        memref.store %17, %arg28[%16, %arg29] : memref<?x?xcomplex<f32>>
      }
      gpu.return
    }
  }
  gpu.module @main_kernel_0 {
    gpu.func @main_kernel(%arg0: index, %arg1: index, %arg2: index, %arg3: memref<?x?xcomplex<f32>>, %arg4: memref<?x?xcomplex<f32>>) kernel attributes {known_block_size = array<i32: 1, 1, 1>} {
      %block_id_x = gpu.block_id x
      %block_id_y = gpu.block_id y
      %block_id_z = gpu.block_id z
      %thread_id_x = gpu.thread_id x
      %thread_id_y = gpu.thread_id y
      %thread_id_z = gpu.thread_id z
      %grid_dim_x = gpu.grid_dim x
      %grid_dim_y = gpu.grid_dim y
      %grid_dim_z = gpu.grid_dim z
      %block_dim_x = gpu.block_dim x
      %block_dim_y = gpu.block_dim y
      %block_dim_z = gpu.block_dim z
      %0 = affine.apply #map1(%block_id_x)[%arg0, %arg1]
      %1 = affine.apply #map1(%block_id_y)[%arg0, %arg1]
      %2 = arith.divui %0, %arg2 : index
      %3 = arith.remui %0, %arg2 : index
      %4 = memref.load %arg3[%2, %3] : memref<?x?xcomplex<f32>>
      memref.store %4, %arg4[%0, %1] : memref<?x?xcomplex<f32>>
      gpu.return
    }
  }
}

