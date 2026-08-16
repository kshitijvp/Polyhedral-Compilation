; ModuleID = 'prog.c'
source_filename = "prog.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = dso_local local_unnamed_addr global [200 x [200 x i32]] zeroinitializer, align 16, !dbg !0

; Function Attrs: nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none, target_mem: none) uwtable
define dso_local noundef i32 @main() local_unnamed_addr #0 !dbg !21 {
polly.loop_preheader:
    #dbg_value(i32 0, !26, !DIExpression(), !27)
  store <4 x i32> splat (i32 1), ptr @A, align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 16), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 32), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 48), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 64), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 80), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 96), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 112), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 128), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 144), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 160), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 176), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 192), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 208), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 224), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 240), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 256), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 272), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 288), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 304), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 320), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 336), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 352), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 368), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 384), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 400), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 416), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 432), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 448), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 464), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 480), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 496), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 512), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 528), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 544), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 560), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 576), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 592), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 608), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 624), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 640), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 656), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 672), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 688), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 704), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 720), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 736), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 752), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 768), align 16, !alias.scope !28, !noalias !31
  store <4 x i32> splat (i32 1), ptr getelementptr inbounds nuw (i8, ptr @A, i64 784), align 16, !alias.scope !28, !noalias !31
  br label %polly.stmt.for.body3

for.end30:                                        ; preds = %polly.loop_exit78
  ret i32 0, !dbg !32

polly.stmt.for.body3:                             ; preds = %polly.stmt.for.body3, %polly.loop_preheader
  %polly.indvar66 = phi i64 [ 0, %polly.loop_preheader ], [ %polly.indvar_next67.4, %polly.stmt.for.body3 ]
  %0 = mul nuw nsw i64 %polly.indvar66, 800
  %scevgep69 = getelementptr i8, ptr @A, i64 %0
  store i32 1, ptr %scevgep69, align 16, !alias.scope !28, !noalias !31
  %1 = mul nuw i64 %polly.indvar66, 800
  %2 = getelementptr i8, ptr @A, i64 %1
  %scevgep69.1 = getelementptr i8, ptr %2, i64 800
  store i32 1, ptr %scevgep69.1, align 16, !alias.scope !28, !noalias !31
  %3 = mul nuw i64 %polly.indvar66, 800
  %4 = getelementptr i8, ptr @A, i64 %3
  %scevgep69.2 = getelementptr i8, ptr %4, i64 1600
  store i32 1, ptr %scevgep69.2, align 16, !alias.scope !28, !noalias !31
  %5 = mul nuw i64 %polly.indvar66, 800
  %6 = getelementptr i8, ptr @A, i64 %5
  %scevgep69.3 = getelementptr i8, ptr %6, i64 2400
  store i32 1, ptr %scevgep69.3, align 16, !alias.scope !28, !noalias !31
  %7 = mul nuw i64 %polly.indvar66, 800
  %8 = getelementptr i8, ptr @A, i64 %7
  %scevgep69.4 = getelementptr i8, ptr %8, i64 3200
  store i32 1, ptr %scevgep69.4, align 16, !alias.scope !28, !noalias !31
  %polly.indvar_next67.4 = add nuw nsw i64 %polly.indvar66, 5
  %exitcond100.not.4 = icmp eq i64 %polly.indvar_next67.4, 200
  br i1 %exitcond100.not.4, label %polly.loop_if, label %polly.stmt.for.body3

polly.loop_exit78:                                ; preds = %polly.loop_exit85, %polly.loop_if
  %polly.indvar_next74 = add nsw i64 %polly.indvar73, 1
  %exitcond101.not = icmp eq i64 %polly.indvar_next74, 7
  br i1 %exitcond101.not, label %for.end30, label %polly.loop_if

polly.loop_if:                                    ; preds = %polly.stmt.for.body3, %polly.loop_exit78
  %polly.indvar73 = phi i64 [ %polly.indvar_next74, %polly.loop_exit78 ], [ -7, %polly.stmt.for.body3 ]
  %9 = tail call i64 @llvm.smax.i64(i64 %polly.indvar73, i64 0)
  %10 = tail call i64 @llvm.smin.i64(i64 %polly.indvar73, i64 -1)
  %11 = add nsw i64 %10, 7
  %polly.loop_guard.not = icmp sgt i64 %9, %11
  br i1 %polly.loop_guard.not, label %polly.loop_exit78, label %polly.loop_if82.preheader

polly.loop_if82.preheader:                        ; preds = %polly.loop_if
  %12 = mul nsw i64 %polly.indvar73, -32
  %13 = tail call i64 @llvm.smin.i64(i64 %12, i64 -167)
  %14 = add nsw i64 %13, 198
  br label %polly.loop_if82

polly.loop_exit85:                                ; preds = %polly.loop_exit93, %polly.loop_if82
  %polly.indvar_next80 = add nuw nsw i64 %polly.indvar79, 1
  %polly.loop_cond81.not.not = icmp samesign ult i64 %polly.indvar79, %11
  br i1 %polly.loop_cond81.not.not, label %polly.loop_if82, label %polly.loop_exit78

polly.loop_if82:                                  ; preds = %polly.loop_if82.preheader, %polly.loop_exit85
  %polly.indvar79 = phi i64 [ %polly.indvar_next80, %polly.loop_exit85 ], [ %9, %polly.loop_if82.preheader ]
  %15 = shl i64 %polly.indvar79, 5
  %16 = add nsw i64 %15, %12
  %17 = tail call i64 @llvm.smax.i64(i64 %16, i64 198)
  %18 = add nsw i64 %17, -198
  %polly.loop_guard86.not = icmp sgt i64 %18, %14
  br i1 %polly.loop_guard86.not, label %polly.loop_exit85, label %polly.loop_if90.preheader

polly.loop_if90.preheader:                        ; preds = %polly.loop_if82
  %19 = sub nsw i64 %polly.indvar73, %polly.indvar79
  %20 = shl nsw i64 %19, 5
  %21 = sub i64 198, %15
  br label %polly.loop_if90

polly.loop_exit93:                                ; preds = %polly.stmt.for.body15, %polly.loop_if90
  %polly.indvar_next88 = add nuw nsw i64 %polly.indvar87, 1
  %polly.loop_cond89.not.not = icmp samesign ult i64 %polly.indvar87, %14
  br i1 %polly.loop_cond89.not.not, label %polly.loop_if90, label %polly.loop_exit85

polly.loop_if90:                                  ; preds = %polly.loop_if90.preheader, %polly.loop_exit93
  %polly.indvar87 = phi i64 [ %polly.indvar_next88, %polly.loop_exit93 ], [ %18, %polly.loop_if90.preheader ]
  %22 = add nsw i64 %polly.indvar87, %20
  %23 = tail call i64 @llvm.smax.i64(i64 %22, i64 0)
  %24 = add nsw i64 %22, 198
  %25 = tail call i64 @llvm.smin.i64(i64 %21, i64 %24)
  %26 = tail call i64 @llvm.smin.i64(i64 %25, i64 31)
  %polly.loop_guard94.not = icmp sgt i64 %23, %26
  br i1 %polly.loop_guard94.not, label %polly.loop_exit93, label %polly.stmt.for.body15.preheader

polly.stmt.for.body15.preheader:                  ; preds = %polly.loop_if90
  %27 = sub nsw i64 %16, %polly.indvar87
  br label %polly.stmt.for.body15

polly.stmt.for.body15:                            ; preds = %polly.stmt.for.body15.preheader, %polly.stmt.for.body15
  %polly.indvar95 = phi i64 [ %polly.indvar_next96, %polly.stmt.for.body15 ], [ %23, %polly.stmt.for.body15.preheader ]
  %28 = add nuw nsw i64 %polly.indvar95, %15
  %29 = add nsw i64 %polly.indvar95, %27
  %30 = mul nuw nsw i64 %28, 800
  %31 = shl i64 %29, 2
  %32 = add i64 %30, %31
  %scevgep98 = getelementptr i8, ptr @A, i64 %32
  %_p_scalar_ = load i32, ptr %scevgep98, align 4, !alias.scope !28, !noalias !31
  %33 = trunc i64 %28 to i32
  %34 = add i32 %33, 1
  %35 = trunc i64 %29 to i32
  %36 = mul i32 %34, %35
  %37 = add i32 %34, %_p_scalar_
  %p_add = add i32 %37, %36, !dbg !33
  %scevgep99 = getelementptr i8, ptr getelementptr inbounds nuw (i8, ptr @A, i64 804), i64 %32
  store i32 %p_add, ptr %scevgep99, align 4, !alias.scope !28, !noalias !31
  %polly.indvar_next96 = add nuw nsw i64 %polly.indvar95, 1
  %polly.loop_cond97.not.not = icmp slt i64 %polly.indvar95, %26
  br i1 %polly.loop_cond97.not.not, label %polly.stmt.for.body15, label %polly.loop_exit93
}

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smax.i64(i64, i64) #1

; Function Attrs: nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.smin.i64(i64, i64) #1

attributes #0 = { nofree norecurse nosync nounwind memory(readwrite, argmem: none, inaccessiblemem: none, target_mem: none) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "polly-optimized" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nocreateundeforpoison nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!9, !10, !11, !12, !13, !14}
!llvm.ident = !{!15}
!llvm.errno.tbaa = !{!16}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "A", scope: !2, file: !3, line: 2, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "clang version 24.0.0git (https://github.com/llvm/llvm-project.git 454a66a65c66012004b2e1e711247f5ebf729957)", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "prog.c", directory: "/home/kshitijvp/llvm-project", checksumkind: CSK_MD5, checksum: "abe7a9bfc38a9fd1de9b4ebc53f879f9")
!4 = !{!0}
!5 = !DICompositeType(tag: DW_TAG_array_type, baseType: !6, size: 1280000, elements: !7)
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{!8, !8}
!8 = !DISubrange(count: 200)
!9 = !{i32 7, !"Dwarf Version", i32 5}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 8, !"PIC Level", i32 2}
!12 = !{i32 7, !"PIE Level", i32 2}
!13 = !{i32 7, !"uwtable", i32 2}
!14 = !{i32 7, !"debug-info-assignment-tracking", i1 true}
!15 = !{!"clang version 24.0.0git (https://github.com/llvm/llvm-project.git 454a66a65c66012004b2e1e711247f5ebf729957)"}
!16 = !{!17, !18, i64 0}
!17 = !{!"__libc_errno", !18, i64 0}
!18 = !{!"int", !19, i64 0}
!19 = !{!"omnipotent char", !20, i64 0}
!20 = !{!"Simple C/C++ TBAA"}
!21 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 4, type: !22, scopeLine: 4, flags: DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !24, keyInstructions: true)
!22 = !DISubroutineType(types: !23)
!23 = !{!6}
!24 = !{!25, !26}
!25 = !DILocalVariable(name: "i", scope: !21, file: !3, line: 5, type: !6)
!26 = !DILocalVariable(name: "j", scope: !21, file: !3, line: 5, type: !6)
!27 = !DILocation(line: 0, scope: !21)
!28 = !{!29}
!29 = distinct !{!29, !30, !"polly.alias.scope.MemRef0"}
!30 = distinct !{!30, !"polly.alias.scope.domain"}
!31 = !{}
!32 = !DILocation(line: 19, column: 9, scope: !21, atomGroup: 25, atomRank: 1)
!33 = !DILocation(line: 15, column: 51, scope: !34, atomGroup: 19, atomRank: 2)
!34 = distinct !DILexicalBlock(scope: !35, file: !3, line: 14, column: 43)
!35 = distinct !DILexicalBlock(scope: !36, file: !3, line: 14, column: 17)
!36 = distinct !DILexicalBlock(scope: !37, file: !3, line: 14, column: 17)
!37 = distinct !DILexicalBlock(scope: !38, file: !3, line: 13, column: 35)
!38 = distinct !DILexicalBlock(scope: !39, file: !3, line: 13, column: 9)
!39 = distinct !DILexicalBlock(scope: !21, file: !3, line: 13, column: 9)
