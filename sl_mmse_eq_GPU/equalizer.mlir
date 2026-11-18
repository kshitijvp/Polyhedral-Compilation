module {
	func.func private @cmatmul(memref<?x?xcomplex<f32>>, memref<?x?xcomplex<f32>>) -> (memref<?x?xcomplex<f32>>) attributes {llvm.emit_c_interface}
	func.func private @dslran_clange2D(memref<?x?xcomplex<f32>> ) -> (complex<f32>) attributes {llvm.emit_c_interface}
	func.func private @dslran_inittensor_3D_complex_float(memref<3xi64>, i64 ) -> (memref<?x?x?xcomplex<f32>>) attributes {llvm.emit_c_interface}
	func.func private @dslran_inittensor_3D_real_float(memref<3xi64>, i64 ) -> (memref<?x?x?xf32>) attributes {llvm.emit_c_interface}
	func.func private @dslran_max_real_float(memref<?x?xf32> ) -> (memref<1xf32>) attributes {llvm.emit_c_interface}
	func.func private @dslran_readfile_complex_float(memref<?xi8>) -> (memref<?xcomplex<f32>>) attributes {llvm.emit_c_interface}
	func.func private @dslran_readfile_f32(memref<?xi8>) -> (memref<?xf32>) attributes {llvm.emit_c_interface}
	func.func private @dslran_slange2D(memref<?x?xf32> ) -> (f32) attributes {llvm.emit_c_interface}
 	func.func private @dslran_print_complex_f32(complex<f32>) -> () attributes {llvm.emit_c_interface}
 	func.func private @dslran_print_f32(f32) -> () attributes {llvm.emit_c_interface}
 	func.func @sl_mmse_equ(%rx_data : memref<?xcomplex<f32>>,%H : memref<?xcomplex<f32>>,%noise_var : memref<?xf32>,%params : memref<?xi64>)-> (memref<?xf32>,memref<?xcomplex<f32>>) {
 		%135= arith.constant 0 : i64


 		%136 = index.casts %135 : i64 to index

 		%137 = memref.load %params[%136] : memref<?xi64>
 		%138= arith.constant 1 : i64


 		%139 = index.casts %138 : i64 to index

 		%140 = memref.load %params[%139] : memref<?xi64>
 		%141= arith.constant 2 : i64


 		%142 = index.casts %141 : i64 to index

 		%143 = memref.load %params[%142] : memref<?xi64>
 		%144= arith.constant 3 : i64


 		%145 = index.casts %144 : i64 to index

 		%146 = memref.load %params[%145] : memref<?xi64>
 		%147= arith.constant 4 : i64


 		%148 = index.casts %147 : i64 to index

 		%149 = memref.load %params[%148] : memref<?xi64>
 		%150= arith.constant 5 : i64


 		%151 = index.casts %150 : i64 to index

 		%152 = memref.load %params[%151] : memref<?xi64>
 		%153= arith.constant 6 : i64


 		%154 = index.casts %153 : i64 to index
 		%155= arith.constant 7 : i64


 		%156 = index.casts %155 : i64 to index
 		%157= arith.constant 8 : i64


 		%158 = index.casts %157 : i64 to index
 		%159= arith.constant 9 : i64


 		%160 = index.casts %159 : i64 to index
 		%161= arith.constant 10 : i64


 		%162 = index.casts %161 : i64 to index
 		%163= arith.constant 11 : i64


 		%164 = index.casts %163 : i64 to index
 		%165= arith.constant 12 : i64


 		%166 = index.casts %165 : i64 to index
 		%167= arith.constant 13 : i64


 		%168 = index.casts %167 : i64 to index
 		%169= arith.constant 14 : i64


 		%170 = index.casts %169 : i64 to index
 		%171= arith.constant 15 : i64


 		%172 = index.casts %171 : i64 to index
 		%173= arith.constant 16 : i64


 		%174 = index.casts %173 : i64 to index
 		%175= arith.constant 17 : i64


 		%176 = index.casts %175 : i64 to index
 		%177= arith.constant 18 : i64


 		%178 = index.casts %177 : i64 to index
 		%179= arith.constant 19 : i64


 		%180 = index.casts %179 : i64 to index
 		%181 = memref.alloc() : memref<14xi64>
 		%182 = affine.load %params[%154] : memref<?xi64>
 		affine.store %182, %181[0] : memref<14xi64>
 		%183 = affine.load %params[%156] : memref<?xi64>
 		affine.store %183, %181[1] : memref<14xi64>
 		%184 = affine.load %params[%158] : memref<?xi64>
 		affine.store %184, %181[2] : memref<14xi64>
 		%185 = affine.load %params[%160] : memref<?xi64>
 		affine.store %185, %181[3] : memref<14xi64>
 		%186 = affine.load %params[%162] : memref<?xi64>
 		affine.store %186, %181[4] : memref<14xi64>
 		%187 = affine.load %params[%164] : memref<?xi64>
 		affine.store %187, %181[5] : memref<14xi64>
 		%188 = affine.load %params[%166] : memref<?xi64>
 		affine.store %188, %181[6] : memref<14xi64>
 		%189 = affine.load %params[%168] : memref<?xi64>
 		affine.store %189, %181[7] : memref<14xi64>
 		%190 = affine.load %params[%170] : memref<?xi64>
 		affine.store %190, %181[8] : memref<14xi64>
 		%191 = affine.load %params[%172] : memref<?xi64>
 		affine.store %191, %181[9] : memref<14xi64>
 		%192 = affine.load %params[%174] : memref<?xi64>
 		affine.store %192, %181[10] : memref<14xi64>
 		%193 = affine.load %params[%176] : memref<?xi64>
 		affine.store %193, %181[11] : memref<14xi64>
 		%194 = affine.load %params[%178] : memref<?xi64>
 		affine.store %194, %181[12] : memref<14xi64>
 		%195 = affine.load %params[%180] : memref<?xi64>
 		affine.store %195, %181[13] : memref<14xi64>

 		%197= index.casts %137 : i64 to index
 		%196 = memref.alloc (%197) : memref<?xmemref<?xf32>>

 		%199= index.casts %137 : i64 to index
 		%198 = memref.alloc (%199) : memref<?xmemref<?xcomplex<f32>>>

 		%200 = arith.muli %149, %140 : i64
 		%201 = arith.muli %200, %143 : i64
 		%202 = arith.muli %201, %146 : i64

 		%203 = arith.muli %149, %143 : i64
 		%204 = arith.muli %203, %146 : i64

 		%205= arith.constant 2 : i64
 		%206 = arith.muli %140, %205 : i64

 		
 		%473 = arith.constant 0 : i64
 		%474 = arith.constant 1 : i64
 		scf.for %224 = %473 to %137 step %474 : i64 {
 			%225 = arith.muli %224, %202 : i64

 			%226= arith.constant 1 : i64
 			%227 = arith.addi %224, %226 : i64
 			%228 = arith.muli %227, %202 : i64

 			%230 = index.casts %225 : i64 to index
 			%231 = arith.constant 1 : index
 			%232 = index.casts %228 : i64 to index
 			%233 = arith.subi %232, %230 : index
 			%234 = arith.ceildivsi %233, %231 : index
 			%229 = memref.subview %H[%230][%234][%231] : memref<?xcomplex<f32>> to memref<?xcomplex<f32>, strided<[?], offset: ?>>

 			%235 = memref.alloc() : memref<4xi64>
 			affine.store %149, %235[0] : memref<4xi64>
 			affine.store %140, %235[1] : memref<4xi64>
 			affine.store %143, %235[2] : memref<4xi64>
 			affine.store %146, %235[3] : memref<4xi64>
 			%236 = arith.constant 0 : index
 			%237 = memref.load %235[%236] : memref<4xi64>
 			%238 = index.casts %237 : i64 to index
 			%239 = memref.load %235[%231] : memref<4xi64>
 			%240 = index.casts %239 : i64 to index
 			%241 = arith.constant 2 : index
 			%242 = memref.load %235[%241] : memref<4xi64>
 			%243 = index.casts %242 : i64 to index
 			%244 = arith.constant 3 : index
 			%245 = memref.load %235[%244] : memref<4xi64>
 			%246 = index.casts %245 : i64 to index
 			%247, %248, %249, %250 = memref.extract_strided_metadata %229 : memref<?xcomplex<f32>, strided<[?], offset: ?>> -> memref<complex<f32>>, index, index, index
 			%251 = arith.muli %246, %250 : index
 			%252 = arith.muli %243, %251 : index
 			%253 = arith.muli %240, %252 : index
 			%254 = memref.reinterpret_cast %229 to 
 			    offset: [%248],
 			    sizes: [%238,%240,%243,%246],
 			    strides: [%253,%252,%251,%250]
 			: memref<?xcomplex<f32>, strided<[?], offset: ?>> to memref<?x?x?x?xcomplex<f32>, strided<[?,?,?,?], offset: ?>>

 			%255 = arith.muli %224, %204 : i64

 			%256= arith.constant 1 : i64
 			%257 = arith.addi %224, %256 : i64
 			%258 = arith.muli %257, %204 : i64

 			%260 = index.casts %255 : i64 to index
 			%261 = index.casts %258 : i64 to index
 			%262 = arith.subi %261, %260 : index
 			%263 = arith.ceildivsi %262, %231 : index
 			%259 = memref.subview %rx_data[%260][%263][%231] : memref<?xcomplex<f32>> to memref<?xcomplex<f32>, strided<[?], offset: ?>>

 			%264 = memref.alloc() : memref<3xi64>
 			affine.store %149, %264[0] : memref<3xi64>
 			affine.store %143, %264[1] : memref<3xi64>
 			affine.store %146, %264[2] : memref<3xi64>
 			%265 = memref.load %264[%236] : memref<3xi64>
 			%266 = index.casts %265 : i64 to index
 			%267 = memref.load %264[%231] : memref<3xi64>
 			%268 = index.casts %267 : i64 to index
 			%269 = memref.load %264[%241] : memref<3xi64>
 			%270 = index.casts %269 : i64 to index
 			%271, %272, %273, %274 = memref.extract_strided_metadata %259 : memref<?xcomplex<f32>, strided<[?], offset: ?>> -> memref<complex<f32>>, index, index, index
 			%275 = arith.muli %270, %274 : index
 			%276 = arith.muli %268, %275 : index
 			%277 = memref.reinterpret_cast %259 to 
 			    offset: [%272],
 			    sizes: [%266,%268,%270],
 			    strides: [%276,%275,%274]
 			: memref<?xcomplex<f32>, strided<[?], offset: ?>> to memref<?x?x?xcomplex<f32>, strided<[?,?,?], offset: ?>>

 			%278 = arith.muli %224, %206 : i64

 			%279= arith.constant 1 : i64
 			%280 = arith.addi %224, %279 : i64
 			%281 = arith.muli %280, %206 : i64

 			%283 = index.casts %278 : i64 to index
 			%284 = index.casts %281 : i64 to index
 			%285 = arith.subi %284, %283 : index
 			%286 = arith.ceildivsi %285, %231 : index
 			%282 = memref.subview %noise_var[%283][%286][%231] : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>

 			%287= arith.constant 2 : i64
 			%288 = memref.alloc() : memref<2xi64>
 			affine.store %140, %288[0] : memref<2xi64>
 			affine.store %287, %288[1] : memref<2xi64>
 			%289 = memref.load %288[%236] : memref<2xi64>
 			%290 = index.casts %289 : i64 to index
 			%291 = memref.load %288[%231] : memref<2xi64>
 			%292 = index.casts %291 : i64 to index
 			%293, %294, %295, %296 = memref.extract_strided_metadata %282 : memref<?xf32, strided<[?], offset: ?>> -> memref<f32>, index, index, index
 			%297 = arith.muli %292, %296 : index
 			%298 = memref.reinterpret_cast %282 to 
 			    offset: [%294],
 			    sizes: [%290,%292],
 			    strides: [%297,%296]
 			: memref<?xf32, strided<[?], offset: ?>> to memref<?x?xf32, strided<[?,?], offset: ?>>

 			%299= arith.constant 0 : i64


 			%300= arith.constant 1 : i64


 			%301 = index.casts %299 : i64 to index
 			%302 = index.casts %300 : i64 to index
 			%304 = memref.load %298[%301, %302] : memref<?x?xf32, strided<[?,?], offset: ?>>


 			%303= ran.eye %140 : memref<?x?xcomplex<f32>>
 			%306 = arith.constant 0 : index
 			%307 = arith.constant 1 : index
 			%308 = memref.dim %303, %306 : memref<?x?xcomplex<f32>>
 			%309 = memref.dim %303, %307 : memref<?x?xcomplex<f32>>
 			%305 = memref.alloc(%308, %309) : memref<?x?xcomplex<f32>>
 			%311 = arith.constant 0. : f32
 			%312= complex.create %304, %311 : complex<f32>
 			linalg.fill ins(%312 : complex<f32>) outs(%305 : memref<?x?xcomplex<f32>>)
 			%314 = arith.constant 0 : index
 			%315 = arith.constant 1 : index
 			%316 = memref.dim %305, %314 : memref<?x?xcomplex<f32>>
 			%317 = memref.dim %305, %315 : memref<?x?xcomplex<f32>>
 			%313 = memref.alloc(%316, %317) : memref<?x?xcomplex<f32>>
 			scf.for %318 = %314 to %316 step %315 {
 			scf.for %319 = %314 to %317 step %315 {
	 			%320 = memref.load %305[%318, %319] : memref<?x?xcomplex<f32>>
	 			%321 = memref.load %303[%318, %319] : memref<?x?xcomplex<f32>>
	 			%322 = complex.mul %320, %321 : complex<f32>
	 			memref.store %322, %313[%318, %319] : memref<?x?xcomplex<f32>>
	 			}
 			}

 			%323 = memref.alloc() : memref<3xi64>
 			affine.store %149, %323[0] : memref<3xi64>
 			affine.store %140, %323[1] : memref<3xi64>
 			affine.store %146, %323[2] : memref<3xi64>

 			%324= arith.constant 0 : i64

 			%325= func.call @dslran_inittensor_3D_real_float(%323, %324) : (memref<3xi64>, i64) ->  memref<?x?x?xf32>

 			%326 = memref.alloc() : memref<3xi64>
 			affine.store %149, %326[0] : memref<3xi64>
 			affine.store %140, %326[1] : memref<3xi64>
 			affine.store %146, %326[2] : memref<3xi64>

 			%327= arith.constant 0 : i64

 			%328= func.call @dslran_inittensor_3D_complex_float(%326, %327) : (memref<3xi64>, i64) ->  memref<?x?x?xcomplex<f32>>

 			
 			%454 = arith.constant 0 : i64
 			%455 = arith.constant 1 : i64
 			affine.for %357 = %454 to %149 step %455 : i64 {


 				%358 = index.casts %357 : i64 to index
 				%451 = memref.load %181[%358] : memref<14xi64>
 				%452 = arith.constant 0 : i64
 				%453 = arith.cmpi sgt, %451, %452 : i64
 				scf.if %453 { 
 					
 					%448 = arith.constant 0 : i64
 					%449 = arith.constant 1 : i64
 					scf.for %386 = %448 to %152 step %449 : i64 {








 						%388 = index.casts %357 : i64 to index
 						%389 = memref.dim %254, %231 : memref<?x?x?x?xcomplex<f32>, strided<[?,?,?,?], offset: ?>>
 						%390 = arith.subi %389, %236 : index
 						%391 = arith.ceildivsi %390, %231 : index
 						%392 = memref.dim %254, %241 : memref<?x?x?x?xcomplex<f32>, strided<[?,?,?,?], offset: ?>>
 						%393 = arith.subi %392, %236 : index
 						%394 = arith.ceildivsi %393, %231 : index
 						%395 = index.casts %386 : i64 to index
 						%387 = memref.subview %254[%388, %236, %236, %395][1, %391, %394, 1][%231, %231, %231, %231] : memref<?x?x?x?xcomplex<f32>, strided<[?,?,?,?], offset: ?>> to memref<?x?xcomplex<f32>, strided<[?,?], offset: ?>>

 						%396= ran.conjugate %387 : memref<?x?xcomplex<f32>, strided<[?,?], offset: ?>> to memref<?x?xcomplex<f32>>


 						%c397 = arith.constant 0 : index
 						%c398 = arith.constant 1 : index
 						%m399 = memref.dim %387, %c397 : memref<?x?xcomplex<f32>, strided<[?,?], offset: ?>>
 						%n400 = memref.dim %387, %c398 : memref<?x?xcomplex<f32>, strided<[?,?], offset: ?>>
 						%401= memref.alloc(%n400, %m399) : memref<?x?xcomplex<f32>>
 						linalg.transpose ins(%387 : memref<?x?xcomplex<f32>, strided<[?,?], offset: ?>>) outs(%401 : memref<?x?xcomplex<f32>>) permutation = [1, 0]
 						%402= ran.cmatmul %396, %401 : (memref<?x?xcomplex<f32>>,memref<?x?xcomplex<f32>>) -> memref<?x?xcomplex<f32>>


 						%404 = memref.dim %402, %236 : memref<?x?xcomplex<f32>>
 						%405 = memref.dim %402, %231 : memref<?x?xcomplex<f32>>
 						%403= memref.alloc(%404, %405) : memref<?x?xcomplex<f32>>
 						linalg.add ins(%402,%313 : memref<?x?xcomplex<f32>>,memref<?x?xcomplex<f32>>) outs(%403 : memref<?x?xcomplex<f32>>)

 						%406 = memref.cast %403 : memref<?x?xcomplex<f32>> to memref<?x?xcomplex<f32>>
 						%407= ran.cgetri %406 : (memref<?x?xcomplex<f32>>) -> memref<?x?xcomplex<f32>>


 						%408= ran.cmatmul %407, %402 : (memref<?x?xcomplex<f32>>,memref<?x?xcomplex<f32>>) -> memref<?x?xcomplex<f32>>
 						%409= ran.diag %408 : (memref<?x?xcomplex<f32>>) ->  memref<?xcomplex<f32>>
 						%410= ran.real %409 : (memref<?xcomplex<f32>>) ->  memref<?xf32>

 						%411= arith.constant 1000. : f64
 						%412= arith.negf %411 : f64

 						%413= arith.constant 0.9999 : f64
 						%414= ran.clip %410, %412, %413 : (memref<?xf32>, f64, f64) ->  memref<?xf32>







 						%416 = index.casts %357 : i64 to index
 						%417 = memref.dim %325, %231 : memref<?x?x?xf32>
 						%418 = arith.subi %417, %236 : index
 						%419 = arith.ceildivsi %418, %231 : index
 						%420 = index.casts %386 : i64 to index
 						%415 = memref.subview %325[%416, %236, %420][1, %419, 1][%231, %231, %231] : memref<?x?x?xf32> to memref<?xf32, strided<[?], offset: ?>>
 						%422 = memref.dim %414, %236 : memref<?xf32>
 						%421= memref.alloc(%422) : memref<?xf32>
 						memref.copy %414, %421 : memref<?xf32> to memref<?xf32>

 						memref.copy %421, %415 : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>

 						%423= ran.conjugate %387 : memref<?x?xcomplex<f32>, strided<[?,?], offset: ?>> to memref<?x?xcomplex<f32>>
 						%424= ran.cmatmul %407, %423 : (memref<?x?xcomplex<f32>>,memref<?x?xcomplex<f32>>) -> memref<?x?xcomplex<f32>>







 						%426 = index.casts %357 : i64 to index
 						%427 = memref.dim %277, %231 : memref<?x?x?xcomplex<f32>, strided<[?,?,?], offset: ?>>
 						%428 = arith.subi %427, %236 : index
 						%429 = arith.ceildivsi %428, %231 : index
 						%430 = index.casts %386 : i64 to index
 						%425 = memref.subview %277[%426, %236, %430][1, %429, 1][%231, %231, %231] : memref<?x?x?xcomplex<f32>, strided<[?,?,?], offset: ?>> to memref<?xcomplex<f32>, strided<[?], offset: ?>>


 						%432 = memref.dim %425, %236 : memref<?xcomplex<f32>, strided<[?], offset: ?>>
 						%431= memref.alloc(%432) : memref<?xcomplex<f32>>
 						memref.copy %425, %431 : memref<?xcomplex<f32>, strided<[?], offset: ?>> to memref<?xcomplex<f32>>

 						%433 = memref.dim %431, %236 : memref<?xcomplex<f32>>
 						%434 = memref.alloc() : memref<2xindex>
 						memref.store %433, %434[%236] : memref<2xindex>
 						memref.store %231, %434[%231] : memref<2xindex>
 						%435 = memref.reshape %431(%434) : (memref<?xcomplex<f32>>, memref<2xindex>) -> memref<?x?xcomplex<f32>>
 						%436= ran.cmatmul %424, %435 : (memref<?x?xcomplex<f32>>,memref<?x?xcomplex<f32>>) -> memref<?x?xcomplex<f32>>







 						%438 = index.casts %357 : i64 to index
 						%439 = memref.dim %328, %231 : memref<?x?x?xcomplex<f32>>
 						%440 = arith.subi %439, %236 : index
 						%441 = arith.ceildivsi %440, %231 : index
 						%442 = index.casts %386 : i64 to index
 						%437 = memref.subview %328[%438, %236, %442][1, %441, 1][%231, %231, %231] : memref<?x?x?xcomplex<f32>> to memref<?xcomplex<f32>, strided<[?], offset: ?>>

 						%443 = memref.dim %436, %236 : memref<?x?xcomplex<f32>>
 						%444 = memref.dim %436, %231 : memref<?x?xcomplex<f32>>
 						%445 = arith.muli %443, %444 : index
 						%446 = memref.alloc() : memref<1xindex>
 						memref.store %445, %446[%236] : memref<1xindex>
 						%447 = memref.reshape %436(%446) : (memref<?x?xcomplex<f32>>, memref<1xindex>) -> memref<?xcomplex<f32>>
 						memref.copy %447, %437 : memref<?xcomplex<f32>> to memref<?xcomplex<f32>, strided<[?], offset: ?>>


 					}
 				}


 			}


 			%457 = index.casts %224 : i64 to index

 			%458 = memref.dim %325, %236 : memref<?x?x?xf32>
 			%459 = memref.dim %325, %231 : memref<?x?x?xf32>
 			%460 = arith.muli %458, %459 : index
 			%461 = memref.dim %325, %241 : memref<?x?x?xf32>
 			%462 = arith.muli %460, %461 : index
 			%463 = memref.alloc() : memref<1xindex>
 			memref.store %462, %463[%236] : memref<1xindex>
 			%464 = memref.reshape %325(%463) : (memref<?x?x?xf32>, memref<1xindex>) -> memref<?xf32>
 			memref.store %464, %196[%457] : memref<?xmemref<?xf32>>


 			%465 = index.casts %224 : i64 to index

 			%466 = memref.dim %328, %236 : memref<?x?x?xcomplex<f32>>
 			%467 = memref.dim %328, %231 : memref<?x?x?xcomplex<f32>>
 			%468 = arith.muli %466, %467 : index
 			%469 = memref.dim %328, %241 : memref<?x?x?xcomplex<f32>>
 			%470 = arith.muli %468, %469 : index
 			%471 = memref.alloc() : memref<1xindex>
 			memref.store %470, %471[%236] : memref<1xindex>
 			%472 = memref.reshape %328(%471) : (memref<?x?x?xcomplex<f32>>, memref<1xindex>) -> memref<?xcomplex<f32>>
 			memref.store %472, %198[%465] : memref<?xmemref<?xcomplex<f32>>>


 		} {ran.parallel}
 		%476= arith.constant 0 : i64

 		%477 = index.casts %476 : i64 to index
 		%478 = memref.alloc (%477) : memref<?xf32>

 		%479= arith.constant 0 : i64

 		%480 = index.casts %479 : i64 to index
 		%481 = memref.alloc (%480) : memref<?xcomplex<f32>>

 		
 		%507, %508 = scf.for %224 = %473 to %137 step %474 iter_args(%iter_arg488 = %481, %iter_arg487 = %478) -> (memref<?xcomplex<f32>>, memref<?xf32>) : i64 {



 			%489 = index.casts %224 : i64 to index
 			%490 = memref.load %196[%489] : memref<?xmemref<?xf32>>
 			%492 = arith.constant 0 : index
 			%491 = memref.dim %iter_arg487, %492 : memref<?xf32>
 			%494 = arith.constant 1 : index
 			%495 = memref.dim %490, %492 : memref<?xf32>
 			%496 = index.add %491, %495
 			%493 = memref.alloc(%496) : memref<?xf32>
 			%497 = memref.subview %493[0][%491][%494] : memref<?xf32> to memref<?xf32, strided<[?], offset: 0>>
 			memref.copy %iter_arg487, %497 : memref<?xf32> to memref<?xf32, strided<[?], offset: 0>>
 			%498 = memref.subview %493[%491][%495][%494] : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>
 			memref.copy %490, %498 : memref<?xf32> to memref<?xf32, strided<[?], offset: ?>>




 			%499 = index.casts %224 : i64 to index
 			%500 = memref.load %198[%499] : memref<?xmemref<?xcomplex<f32>>>
 			%501 = memref.dim %iter_arg488, %492 : memref<?xcomplex<f32>>
 			%503 = memref.dim %500, %492 : memref<?xcomplex<f32>>
 			%504 = index.add %501, %503
 			%502 = memref.alloc(%504) : memref<?xcomplex<f32>>
 			%505 = memref.subview %502[0][%501][%494] : memref<?xcomplex<f32>> to memref<?xcomplex<f32>, strided<[?], offset: 0>>
 			memref.copy %iter_arg488, %505 : memref<?xcomplex<f32>> to memref<?xcomplex<f32>, strided<[?], offset: 0>>
 			%506 = memref.subview %502[%501][%503][%494] : memref<?xcomplex<f32>> to memref<?xcomplex<f32>, strided<[?], offset: ?>>
 			memref.copy %500, %506 : memref<?xcomplex<f32>> to memref<?xcomplex<f32>, strided<[?], offset: ?>>


 			scf.yield %502, %493 : memref<?xcomplex<f32>>, memref<?xf32>
 		}

 	 		
 			memref.dealloc %181 : memref<14xi64>
 		func.return %508,%507 : memref<?xf32>,memref<?xcomplex<f32>>

 	}
 	func.func @check_mmse_eq(%val : memref<?x?xcomplex<f32>>,%ref : memref<?x?xcomplex<f32>>) {
 		%602 = arith.constant 0 : index
 		%601 = memref.dim %ref, %602 : memref<?x?xcomplex<f32>>
 		%604 = arith.constant 1 : index
 		%603 = memref.dim %ref, %604 : memref<?x?xcomplex<f32>>
 		%600= memref.alloc(%601, %603) : memref<?x?xcomplex<f32>>
 		linalg.sub ins(%ref,%val : memref<?x?xcomplex<f32>>,memref<?x?xcomplex<f32>>) outs(%600 : memref<?x?xcomplex<f32>>)
 		%606 = memref.dim %600, %602 : memref<?x?xcomplex<f32>>
 		%607 = memref.dim %600, %604 : memref<?x?xcomplex<f32>>
 		%605= memref.alloc(%606, %607) : memref<?x?xf32>
 		linalg.map {complex.abs} ins(%600 : memref<?x?xcomplex<f32>>) outs(%605 : memref<?x?xf32>)

 		%609 = memref.dim %ref, %602 : memref<?x?xcomplex<f32>>
 		%610 = memref.dim %ref, %604 : memref<?x?xcomplex<f32>>
 		%608= memref.alloc(%609, %610) : memref<?x?xf32>
 		linalg.map {complex.abs} ins(%ref : memref<?x?xcomplex<f32>>) outs(%608 : memref<?x?xf32>)

 		%611= func.call @dslran_max_real_float(%605) : (memref<?x?xf32>) ->  memref<1xf32>

 		%613 = memref.cast %605 : memref<?x?xf32> to memref<?x?xf32>
 		%612 = memref.collapse_shape %613 [[0,1]] : memref<?x?xf32> into memref<?xf32>
 		%616 = memref.dim %612, %602 : memref<?xf32>
 		%617 = memref.load %612[%602] : memref<?xf32>
 		%614, %615 = scf.for %iv0=%602 to %616 step %604 iter_args(%max = %617, %maxIndx = %602) -> (f32, index) {
 			%t0 = memref.load %612[%iv0] : memref<?xf32>
 			%cond = arith.cmpf ugt, %max, %t0 : f32
 			%tmpmax = arith.select %cond, %max, %t0 : f32
 			%tmpmaxIndx = arith.select %cond, %maxIndx, %iv0 : index
 			scf.yield %tmpmax, %tmpmaxIndx : f32, index
 		}

 		%618 = memref.cast %ref : memref<?x?xcomplex<f32>> to memref<?x?xcomplex<f32>>
 		%619= func.call @dslran_clange2D(%618) : (memref<?x?xcomplex<f32>>) -> (complex<f32>)

 		%620 = memref.cast %605 : memref<?x?xf32> to memref<?x?xf32>
 		%621= func.call @dslran_slange2D(%620) : (memref<?x?xf32>) -> (f32)

 		func.call @dslran_print_complex_f32(%619) : (complex<f32>)-> ()
 		func.call @dslran_print_f32(%621) : (f32)-> ()
 		%622= arith.constant 10. : f64
 		%624 = arith.constant 0. : f32
 		%625= complex.create %621, %624 : complex<f32>
 		%626 = complex.div %619, %625: complex<f32>
 		%628 = complex.log %626 : complex<f32>
 		%629 = arith.constant 2.30258509299 : f32
 		%631 = arith.constant 0. : f32
 		%632= complex.create %629, %631 : complex<f32>
 		%627 = complex.div %628, %632: complex<f32>
 		%634 = arith.constant 0. : f32
 		%633 = arith.truncf %622: f64 to f32
 		%635= complex.create %633, %634 : complex<f32>
 		%636 = complex.mul %635, %627: complex<f32>

 		func.call @dslran_print_complex_f32(%636) : (complex<f32>)-> ()

 	func.return
 	}

 	func.func @main() {
 	%0= memref.alloc() : memref<35xi8>
 	%1 = arith.constant 39 : i8
 	affine.store %1, %0[0] :memref<35xi8>
 	%2 = arith.constant 46 : i8
 	affine.store %2, %0[1] :memref<35xi8>
 	%3 = arith.constant 46 : i8
 	affine.store %3, %0[2] :memref<35xi8>
 	%4 = arith.constant 47 : i8
 	affine.store %4, %0[3] :memref<35xi8>
 	%5 = arith.constant 116 : i8
 	affine.store %5, %0[4] :memref<35xi8>
 	%6 = arith.constant 101 : i8
 	affine.store %6, %0[5] :memref<35xi8>
 	%7 = arith.constant 115 : i8
 	affine.store %7, %0[6] :memref<35xi8>
 	%8 = arith.constant 116 : i8
 	affine.store %8, %0[7] :memref<35xi8>
 	%9 = arith.constant 102 : i8
 	affine.store %9, %0[8] :memref<35xi8>
 	%10 = arith.constant 105 : i8
 	affine.store %10, %0[9] :memref<35xi8>
 	%11 = arith.constant 108 : i8
 	affine.store %11, %0[10] :memref<35xi8>
 	%12 = arith.constant 101 : i8
 	affine.store %12, %0[11] :memref<35xi8>
 	%13 = arith.constant 115 : i8
 	affine.store %13, %0[12] :memref<35xi8>
 	%14 = arith.constant 47 : i8
 	affine.store %14, %0[13] :memref<35xi8>
 	%15 = arith.constant 114 : i8
 	affine.store %15, %0[14] :memref<35xi8>
 	%16 = arith.constant 101 : i8
 	affine.store %16, %0[15] :memref<35xi8>
 	%17 = arith.constant 97 : i8
 	affine.store %17, %0[16] :memref<35xi8>
 	%18 = arith.constant 100 : i8
 	affine.store %18, %0[17] :memref<35xi8>
 	%19 = arith.constant 102 : i8
 	affine.store %19, %0[18] :memref<35xi8>
 	%20 = arith.constant 105 : i8
 	affine.store %20, %0[19] :memref<35xi8>
 	%21 = arith.constant 108 : i8
 	affine.store %21, %0[20] :memref<35xi8>
 	%22 = arith.constant 101 : i8
 	affine.store %22, %0[21] :memref<35xi8>
 	%23 = arith.constant 47 : i8
 	affine.store %23, %0[22] :memref<35xi8>
 	%24 = arith.constant 68 : i8
 	affine.store %24, %0[23] :memref<35xi8>
 	%25 = arith.constant 109 : i8
 	affine.store %25, %0[24] :memref<35xi8>
 	%26 = arith.constant 112 : i8
 	affine.store %26, %0[25] :memref<35xi8>
 	%27 = arith.constant 95 : i8
 	affine.store %27, %0[26] :memref<35xi8>
 	%28 = arith.constant 48 : i8
 	affine.store %28, %0[27] :memref<35xi8>
 	%29 = arith.constant 49 : i8
 	affine.store %29, %0[28] :memref<35xi8>
 	%30 = arith.constant 46 : i8
 	affine.store %30, %0[29] :memref<35xi8>
 	%31 = arith.constant 98 : i8
 	affine.store %31, %0[30] :memref<35xi8>
 	%32 = arith.constant 105 : i8
 	affine.store %32, %0[31] :memref<35xi8>
 	%33 = arith.constant 110 : i8
 	affine.store %33, %0[32] :memref<35xi8>
 	%34 = arith.constant 39 : i8
 	affine.store %34, %0[33] :memref<35xi8>
 	%35 = arith.constant 0 : i8
 	affine.store %35, %0[34] :memref<35xi8>
 	%36 = memref.cast %0 : memref<35xi8> to memref<?xi8>

 	%37= func.call @dslran_readfile_complex_float(%36) : (memref<?xi8>) ->  memref<?xcomplex<f32>>

 	%38= memref.alloc() : memref<35xi8>
 	%39 = arith.constant 39 : i8
 	affine.store %39, %38[0] :memref<35xi8>
 	%40 = arith.constant 46 : i8
 	affine.store %40, %38[1] :memref<35xi8>
 	%41 = arith.constant 46 : i8
 	affine.store %41, %38[2] :memref<35xi8>
 	%42 = arith.constant 47 : i8
 	affine.store %42, %38[3] :memref<35xi8>
 	%43 = arith.constant 116 : i8
 	affine.store %43, %38[4] :memref<35xi8>
 	%44 = arith.constant 101 : i8
 	affine.store %44, %38[5] :memref<35xi8>
 	%45 = arith.constant 115 : i8
 	affine.store %45, %38[6] :memref<35xi8>
 	%46 = arith.constant 116 : i8
 	affine.store %46, %38[7] :memref<35xi8>
 	%47 = arith.constant 102 : i8
 	affine.store %47, %38[8] :memref<35xi8>
 	%48 = arith.constant 105 : i8
 	affine.store %48, %38[9] :memref<35xi8>
 	%49 = arith.constant 108 : i8
 	affine.store %49, %38[10] :memref<35xi8>
 	%50 = arith.constant 101 : i8
 	affine.store %50, %38[11] :memref<35xi8>
 	%51 = arith.constant 115 : i8
 	affine.store %51, %38[12] :memref<35xi8>
 	%52 = arith.constant 47 : i8
 	affine.store %52, %38[13] :memref<35xi8>
 	%53 = arith.constant 114 : i8
 	affine.store %53, %38[14] :memref<35xi8>
 	%54 = arith.constant 101 : i8
 	affine.store %54, %38[15] :memref<35xi8>
 	%55 = arith.constant 97 : i8
 	affine.store %55, %38[16] :memref<35xi8>
 	%56 = arith.constant 100 : i8
 	affine.store %56, %38[17] :memref<35xi8>
 	%57 = arith.constant 102 : i8
 	affine.store %57, %38[18] :memref<35xi8>
 	%58 = arith.constant 105 : i8
 	affine.store %58, %38[19] :memref<35xi8>
 	%59 = arith.constant 108 : i8
 	affine.store %59, %38[20] :memref<35xi8>
 	%60 = arith.constant 101 : i8
 	affine.store %60, %38[21] :memref<35xi8>
 	%61 = arith.constant 47 : i8
 	affine.store %61, %38[22] :memref<35xi8>
 	%62 = arith.constant 68 : i8
 	affine.store %62, %38[23] :memref<35xi8>
 	%63 = arith.constant 109 : i8
 	affine.store %63, %38[24] :memref<35xi8>
 	%64 = arith.constant 112 : i8
 	affine.store %64, %38[25] :memref<35xi8>
 	%65 = arith.constant 95 : i8
 	affine.store %65, %38[26] :memref<35xi8>
 	%66 = arith.constant 48 : i8
 	affine.store %66, %38[27] :memref<35xi8>
 	%67 = arith.constant 50 : i8
 	affine.store %67, %38[28] :memref<35xi8>
 	%68 = arith.constant 46 : i8
 	affine.store %68, %38[29] :memref<35xi8>
 	%69 = arith.constant 98 : i8
 	affine.store %69, %38[30] :memref<35xi8>
 	%70 = arith.constant 105 : i8
 	affine.store %70, %38[31] :memref<35xi8>
 	%71 = arith.constant 110 : i8
 	affine.store %71, %38[32] :memref<35xi8>
 	%72 = arith.constant 39 : i8
 	affine.store %72, %38[33] :memref<35xi8>
 	%73 = arith.constant 0 : i8
 	affine.store %73, %38[34] :memref<35xi8>
 	%74 = memref.cast %38 : memref<35xi8> to memref<?xi8>

 	%75= func.call @dslran_readfile_complex_float(%74) : (memref<?xi8>) ->  memref<?xcomplex<f32>>

 	%76= memref.alloc() : memref<35xi8>
 	%77 = arith.constant 39 : i8
 	affine.store %77, %76[0] :memref<35xi8>
 	%78 = arith.constant 46 : i8
 	affine.store %78, %76[1] :memref<35xi8>
 	%79 = arith.constant 46 : i8
 	affine.store %79, %76[2] :memref<35xi8>
 	%80 = arith.constant 47 : i8
 	affine.store %80, %76[3] :memref<35xi8>
 	%81 = arith.constant 116 : i8
 	affine.store %81, %76[4] :memref<35xi8>
 	%82 = arith.constant 101 : i8
 	affine.store %82, %76[5] :memref<35xi8>
 	%83 = arith.constant 115 : i8
 	affine.store %83, %76[6] :memref<35xi8>
 	%84 = arith.constant 116 : i8
 	affine.store %84, %76[7] :memref<35xi8>
 	%85 = arith.constant 102 : i8
 	affine.store %85, %76[8] :memref<35xi8>
 	%86 = arith.constant 105 : i8
 	affine.store %86, %76[9] :memref<35xi8>
 	%87 = arith.constant 108 : i8
 	affine.store %87, %76[10] :memref<35xi8>
 	%88 = arith.constant 101 : i8
 	affine.store %88, %76[11] :memref<35xi8>
 	%89 = arith.constant 115 : i8
 	affine.store %89, %76[12] :memref<35xi8>
 	%90 = arith.constant 47 : i8
 	affine.store %90, %76[13] :memref<35xi8>
 	%91 = arith.constant 114 : i8
 	affine.store %91, %76[14] :memref<35xi8>
 	%92 = arith.constant 101 : i8
 	affine.store %92, %76[15] :memref<35xi8>
 	%93 = arith.constant 97 : i8
 	affine.store %93, %76[16] :memref<35xi8>
 	%94 = arith.constant 100 : i8
 	affine.store %94, %76[17] :memref<35xi8>
 	%95 = arith.constant 102 : i8
 	affine.store %95, %76[18] :memref<35xi8>
 	%96 = arith.constant 105 : i8
 	affine.store %96, %76[19] :memref<35xi8>
 	%97 = arith.constant 108 : i8
 	affine.store %97, %76[20] :memref<35xi8>
 	%98 = arith.constant 101 : i8
 	affine.store %98, %76[21] :memref<35xi8>
 	%99 = arith.constant 47 : i8
 	affine.store %99, %76[22] :memref<35xi8>
 	%100 = arith.constant 68 : i8
 	affine.store %100, %76[23] :memref<35xi8>
 	%101 = arith.constant 109 : i8
 	affine.store %101, %76[24] :memref<35xi8>
 	%102 = arith.constant 112 : i8
 	affine.store %102, %76[25] :memref<35xi8>
 	%103 = arith.constant 95 : i8
 	affine.store %103, %76[26] :memref<35xi8>
 	%104 = arith.constant 48 : i8
 	affine.store %104, %76[27] :memref<35xi8>
 	%105 = arith.constant 51 : i8
 	affine.store %105, %76[28] :memref<35xi8>
 	%106 = arith.constant 46 : i8
 	affine.store %106, %76[29] :memref<35xi8>
 	%107 = arith.constant 98 : i8
 	affine.store %107, %76[30] :memref<35xi8>
 	%108 = arith.constant 105 : i8
 	affine.store %108, %76[31] :memref<35xi8>
 	%109 = arith.constant 110 : i8
 	affine.store %109, %76[32] :memref<35xi8>
 	%110 = arith.constant 39 : i8
 	affine.store %110, %76[33] :memref<35xi8>
 	%111 = arith.constant 0 : i8
 	affine.store %111, %76[34] :memref<35xi8>
 	%112 = memref.cast %76 : memref<35xi8> to memref<?xi8>

 	%113= func.call @dslran_readfile_f32(%112) : (memref<?xi8>) ->  memref<?xf32>

 	%114= arith.constant 4 : i64
 	%115= arith.constant 8 : i64
 	%116= arith.constant 8 : i64
 	%117= arith.constant 3280 : i64
 	%118= arith.constant 14 : i64
 	%119= arith.constant 3264 : i64
 	%120= arith.constant 1 : i64
 	%121= arith.constant 1 : i64
 	%122= arith.constant 0 : i64
 	%123= arith.constant 0 : i64
 	%124= arith.constant 1 : i64
 	%125= arith.constant 1 : i64
 	%126= arith.constant 1 : i64
 	%127= arith.constant 1 : i64
 	%128= arith.constant 0 : i64
 	%129= arith.constant 0 : i64
 	%130= arith.constant 1 : i64
 	%131= arith.constant 1 : i64
 	%132= arith.constant 1 : i64
 	%133= arith.constant 1 : i64
 	%134 = memref.alloc() : memref<20xi64>
 	affine.store %114, %134[0] : memref<20xi64>
 	affine.store %115, %134[1] : memref<20xi64>
 	affine.store %116, %134[2] : memref<20xi64>
 	affine.store %117, %134[3] : memref<20xi64>
 	affine.store %118, %134[4] : memref<20xi64>
 	affine.store %119, %134[5] : memref<20xi64>
 	affine.store %120, %134[6] : memref<20xi64>
 	affine.store %121, %134[7] : memref<20xi64>
 	affine.store %122, %134[8] : memref<20xi64>
 	affine.store %123, %134[9] : memref<20xi64>
 	affine.store %124, %134[10] : memref<20xi64>
 	affine.store %125, %134[11] : memref<20xi64>
 	affine.store %126, %134[12] : memref<20xi64>
 	affine.store %127, %134[13] : memref<20xi64>
 	affine.store %128, %134[14] : memref<20xi64>
 	affine.store %129, %134[15] : memref<20xi64>
 	affine.store %130, %134[16] : memref<20xi64>
 	affine.store %131, %134[17] : memref<20xi64>
 	affine.store %132, %134[18] : memref<20xi64>
 	affine.store %133, %134[19] : memref<20xi64>

 	%510 = memref.cast %134 : memref<20xi64> to memref<?xi64>



 	%511,%512 = func.call @sl_mmse_equ(%37, %75, %113, %510) : (memref<?xcomplex<f32>>, memref<?xcomplex<f32>>, memref<?xf32>, memref<?xi64>)-> (memref<?xf32>,memref<?xcomplex<f32>>)

 	%513= memref.alloc() : memref<35xi8>
 	%514 = arith.constant 39 : i8
 	affine.store %514, %513[0] :memref<35xi8>
 	%515 = arith.constant 46 : i8
 	affine.store %515, %513[1] :memref<35xi8>
 	%516 = arith.constant 46 : i8
 	affine.store %516, %513[2] :memref<35xi8>
 	%517 = arith.constant 47 : i8
 	affine.store %517, %513[3] :memref<35xi8>
 	%518 = arith.constant 116 : i8
 	affine.store %518, %513[4] :memref<35xi8>
 	%519 = arith.constant 101 : i8
 	affine.store %519, %513[5] :memref<35xi8>
 	%520 = arith.constant 115 : i8
 	affine.store %520, %513[6] :memref<35xi8>
 	%521 = arith.constant 116 : i8
 	affine.store %521, %513[7] :memref<35xi8>
 	%522 = arith.constant 102 : i8
 	affine.store %522, %513[8] :memref<35xi8>
 	%523 = arith.constant 105 : i8
 	affine.store %523, %513[9] :memref<35xi8>
 	%524 = arith.constant 108 : i8
 	affine.store %524, %513[10] :memref<35xi8>
 	%525 = arith.constant 101 : i8
 	affine.store %525, %513[11] :memref<35xi8>
 	%526 = arith.constant 115 : i8
 	affine.store %526, %513[12] :memref<35xi8>
 	%527 = arith.constant 47 : i8
 	affine.store %527, %513[13] :memref<35xi8>
 	%528 = arith.constant 114 : i8
 	affine.store %528, %513[14] :memref<35xi8>
 	%529 = arith.constant 101 : i8
 	affine.store %529, %513[15] :memref<35xi8>
 	%530 = arith.constant 97 : i8
 	affine.store %530, %513[16] :memref<35xi8>
 	%531 = arith.constant 100 : i8
 	affine.store %531, %513[17] :memref<35xi8>
 	%532 = arith.constant 102 : i8
 	affine.store %532, %513[18] :memref<35xi8>
 	%533 = arith.constant 105 : i8
 	affine.store %533, %513[19] :memref<35xi8>
 	%534 = arith.constant 108 : i8
 	affine.store %534, %513[20] :memref<35xi8>
 	%535 = arith.constant 101 : i8
 	affine.store %535, %513[21] :memref<35xi8>
 	%536 = arith.constant 47 : i8
 	affine.store %536, %513[22] :memref<35xi8>
 	%537 = arith.constant 68 : i8
 	affine.store %537, %513[23] :memref<35xi8>
 	%538 = arith.constant 109 : i8
 	affine.store %538, %513[24] :memref<35xi8>
 	%539 = arith.constant 112 : i8
 	affine.store %539, %513[25] :memref<35xi8>
 	%540 = arith.constant 95 : i8
 	affine.store %540, %513[26] :memref<35xi8>
 	%541 = arith.constant 48 : i8
 	affine.store %541, %513[27] :memref<35xi8>
 	%542 = arith.constant 56 : i8
 	affine.store %542, %513[28] :memref<35xi8>
 	%543 = arith.constant 46 : i8
 	affine.store %543, %513[29] :memref<35xi8>
 	%544 = arith.constant 111 : i8
 	affine.store %544, %513[30] :memref<35xi8>
 	%545 = arith.constant 117 : i8
 	affine.store %545, %513[31] :memref<35xi8>
 	%546 = arith.constant 116 : i8
 	affine.store %546, %513[32] :memref<35xi8>
 	%547 = arith.constant 39 : i8
 	affine.store %547, %513[33] :memref<35xi8>
 	%548 = arith.constant 0 : i8
 	affine.store %548, %513[34] :memref<35xi8>
 	%549 = memref.cast %513 : memref<35xi8> to memref<?xi8>

 	%550= func.call @dslran_readfile_complex_float(%549) : (memref<?xi8>) ->  memref<?xcomplex<f32>>

 	%551= arith.constant 1 : i64
 	%553 = arith.constant 0 : i64
 	%552 = arith.subi %553, %551 : i64
 	%554= arith.constant 3 : i64


 	%555 = index.casts %554 : i64 to index
 	%556 = memref.alloc() : memref<2xi64>
 	affine.store %552, %556[0] : memref<2xi64>
 	%557 = affine.load %134[%555] : memref<20xi64>
 	affine.store %557, %556[1] : memref<2xi64>
 	%558 = arith.constant 0 : index
 	%559 = memref.load %556[%558] : memref<2xi64>
 	%560 = index.casts %559 : i64 to index
 	%561 = arith.constant 1 : index
 	%562 = memref.load %556[%561] : memref<2xi64>
 	%563 = index.casts %562 : i64 to index
 	%564 = memref.alloc() : memref<2xindex>
 	%565 = arith.constant 0 : index
 	memref.store %560, %564[%565] : memref<2xindex>
 	memref.store %563, %564[%561] : memref<2xindex>
 	%566 = arith.constant -1 : index
 	%567 = index.cmp eq(%566, %560)
 	scf.if %567 { 
 		%568 = arith.constant 0 : index
 		%569 = memref.dim %550, %568 : memref<?xcomplex<f32>>
 		%570 = index.divs %569, %563
 		memref.store %570, %564[%568] : memref<2xindex>
 	}
 	%571 = memref.reshape %550(%564) : (memref<?xcomplex<f32>>, memref<2xindex>) ->memref<?x?xcomplex<f32>>

 	%c572 = arith.constant 0 : index
 	%c573 = arith.constant 1 : index
 	%m574 = memref.dim %571, %c572 : memref<?x?xcomplex<f32>>
 	%n575 = memref.dim %571, %c573 : memref<?x?xcomplex<f32>>
 	%576= memref.alloc(%n575, %m574) : memref<?x?xcomplex<f32>>
 	linalg.transpose ins(%571 : memref<?x?xcomplex<f32>>) outs(%576 : memref<?x?xcomplex<f32>>) permutation = [1, 0]


 	%577= arith.constant 1 : i64
 	%578 = arith.subi %553, %577 : i64
 	%579= arith.constant 3 : i64


 	%580 = index.casts %579 : i64 to index
 	%581 = memref.alloc() : memref<2xi64>
 	affine.store %578, %581[0] : memref<2xi64>
 	%582 = affine.load %134[%580] : memref<20xi64>
 	affine.store %582, %581[1] : memref<2xi64>
 	%583 = arith.constant 0 : index
 	%584 = memref.load %581[%583] : memref<2xi64>
 	%585 = index.casts %584 : i64 to index
 	%586 = memref.load %581[%561] : memref<2xi64>
 	%587 = index.casts %586 : i64 to index
 	%588 = memref.alloc() : memref<2xindex>
 	%589 = arith.constant 0 : index
 	memref.store %585, %588[%589] : memref<2xindex>
 	memref.store %587, %588[%561] : memref<2xindex>
 	%590 = index.cmp eq(%566, %585)
 	scf.if %590 { 
 		%591 = arith.constant 0 : index
 		%592 = memref.dim %512, %591 : memref<?xcomplex<f32>>
 		%593 = index.divs %592, %587
 		memref.store %593, %588[%591] : memref<2xindex>
 	}
 	%594 = memref.reshape %512(%588) : (memref<?xcomplex<f32>>, memref<2xindex>) ->memref<?x?xcomplex<f32>>

 	%c595 = arith.constant 0 : index
 	%c596 = arith.constant 1 : index
 	%m597 = memref.dim %594, %c595 : memref<?x?xcomplex<f32>>
 	%n598 = memref.dim %594, %c596 : memref<?x?xcomplex<f32>>
 	%599= memref.alloc(%n598, %m597) : memref<?x?xcomplex<f32>>
 	linalg.transpose ins(%594 : memref<?x?xcomplex<f32>>) outs(%599 : memref<?x?xcomplex<f32>>) permutation = [1, 0]

 	func.call @check_mmse_eq(%599,%576) : (memref<?x?xcomplex<f32>>, memref<?x?xcomplex<f32>>)-> ()
 	memref.dealloc %0 : memref<35xi8>
 	memref.dealloc %38 : memref<35xi8>
 	memref.dealloc %76 : memref<35xi8>
 	memref.dealloc %134 : memref<20xi64>
 	memref.dealloc %513 : memref<35xi8>
 	memref.dealloc %556 : memref<2xi64>
 	memref.dealloc %564 : memref<2xindex>
 	memref.dealloc %576 : memref<?x?xcomplex<f32>>
 	memref.dealloc %581 : memref<2xi64>
 	memref.dealloc %588 : memref<2xindex>
 	memref.dealloc %599 : memref<?x?xcomplex<f32>>
 	func.return 
 	}

}
