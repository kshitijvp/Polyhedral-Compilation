; ModuleID = 'prog.c'
source_filename = "prog.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@A = dso_local global [200 x [200 x i32]] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 !dbg !16 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, ptr %retval, align 4
    #dbg_declare(ptr %i, !20, !DIExpression(), !21)
    #dbg_declare(ptr %j, !22, !DIExpression(), !23)
  store i32 0, ptr %i, align 4, !dbg !24
  br label %for.cond, !dbg !26

for.cond:                                         ; preds = %for.inc6, %entry
  %0 = load i32, ptr %i, align 4, !dbg !27
  %cmp = icmp slt i32 %0, 200, !dbg !29
  br i1 %cmp, label %for.body, label %for.end8, !dbg !30

for.body:                                         ; preds = %for.cond
  store i32 0, ptr %j, align 4, !dbg !31
  br label %for.cond1, !dbg !34

for.cond1:                                        ; preds = %for.inc, %for.body
  %1 = load i32, ptr %j, align 4, !dbg !35
  %cmp2 = icmp slt i32 %1, 200, !dbg !37
  br i1 %cmp2, label %for.body3, label %for.end, !dbg !38

for.body3:                                        ; preds = %for.cond1
  %2 = load i32, ptr %i, align 4, !dbg !39
  %idxprom = sext i32 %2 to i64, !dbg !41
  %arrayidx = getelementptr inbounds [200 x [200 x i32]], ptr @A, i64 0, i64 %idxprom, !dbg !41
  %3 = load i32, ptr %j, align 4, !dbg !42
  %idxprom4 = sext i32 %3 to i64, !dbg !41
  %arrayidx5 = getelementptr inbounds [200 x i32], ptr %arrayidx, i64 0, i64 %idxprom4, !dbg !41
  store i32 0, ptr %arrayidx5, align 4, !dbg !43
  br label %for.inc, !dbg !44

for.inc:                                          ; preds = %for.body3
  %4 = load i32, ptr %j, align 4, !dbg !45
  %inc = add nsw i32 %4, 1, !dbg !45
  store i32 %inc, ptr %j, align 4, !dbg !45
  br label %for.cond1, !dbg !46, !llvm.loop !47

for.end:                                          ; preds = %for.cond1
  br label %for.inc6, !dbg !50

for.inc6:                                         ; preds = %for.end
  %5 = load i32, ptr %i, align 4, !dbg !51
  %inc7 = add nsw i32 %5, 1, !dbg !51
  store i32 %inc7, ptr %i, align 4, !dbg !51
  br label %for.cond, !dbg !52, !llvm.loop !53

for.end8:                                         ; preds = %for.cond
  store i32 1, ptr %i, align 4, !dbg !55
  br label %for.cond9, !dbg !57

for.cond9:                                        ; preds = %for.inc27, %for.end8
  %6 = load i32, ptr %i, align 4, !dbg !58
  %cmp10 = icmp slt i32 %6, 200, !dbg !60
  br i1 %cmp10, label %for.body11, label %for.end29, !dbg !61

for.body11:                                       ; preds = %for.cond9
  store i32 1, ptr %j, align 4, !dbg !62
  br label %for.cond12, !dbg !65

for.cond12:                                       ; preds = %for.inc24, %for.body11
  %7 = load i32, ptr %j, align 4, !dbg !66
  %cmp13 = icmp slt i32 %7, 200, !dbg !68
  br i1 %cmp13, label %for.body14, label %for.end26, !dbg !69

for.body14:                                       ; preds = %for.cond12
  %8 = load i32, ptr %i, align 4, !dbg !70
  %sub = sub nsw i32 %8, 1, !dbg !72
  %idxprom15 = sext i32 %sub to i64, !dbg !73
  %arrayidx16 = getelementptr inbounds [200 x [200 x i32]], ptr @A, i64 0, i64 %idxprom15, !dbg !73
  %9 = load i32, ptr %j, align 4, !dbg !74
  %sub17 = sub nsw i32 %9, 1, !dbg !75
  %idxprom18 = sext i32 %sub17 to i64, !dbg !73
  %arrayidx19 = getelementptr inbounds [200 x i32], ptr %arrayidx16, i64 0, i64 %idxprom18, !dbg !73
  %10 = load i32, ptr %arrayidx19, align 4, !dbg !73
  %11 = load i32, ptr %i, align 4, !dbg !76
  %12 = load i32, ptr %j, align 4, !dbg !77
  %mul = mul nsw i32 %11, %12, !dbg !78
  %add = add nsw i32 %10, %mul, !dbg !79
  %13 = load i32, ptr %i, align 4, !dbg !80
  %idxprom20 = sext i32 %13 to i64, !dbg !81
  %arrayidx21 = getelementptr inbounds [200 x [200 x i32]], ptr @A, i64 0, i64 %idxprom20, !dbg !81
  %14 = load i32, ptr %j, align 4, !dbg !82
  %idxprom22 = sext i32 %14 to i64, !dbg !81
  %arrayidx23 = getelementptr inbounds [200 x i32], ptr %arrayidx21, i64 0, i64 %idxprom22, !dbg !81
  store i32 %add, ptr %arrayidx23, align 4, !dbg !83
  br label %for.inc24, !dbg !84

for.inc24:                                        ; preds = %for.body14
  %15 = load i32, ptr %j, align 4, !dbg !85
  %inc25 = add nsw i32 %15, 1, !dbg !85
  store i32 %inc25, ptr %j, align 4, !dbg !85
  br label %for.cond12, !dbg !86, !llvm.loop !87

for.end26:                                        ; preds = %for.cond12
  br label %for.inc27, !dbg !89

for.inc27:                                        ; preds = %for.end26
  %16 = load i32, ptr %i, align 4, !dbg !90
  %inc28 = add nsw i32 %16, 1, !dbg !90
  store i32 %inc28, ptr %i, align 4, !dbg !90
  br label %for.cond9, !dbg !91, !llvm.loop !92

for.end29:                                        ; preds = %for.cond9
  ret i32 0, !dbg !94
}

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!9, !10, !11, !12, !13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "A", scope: !2, file: !3, line: 2, type: !5, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "clang version 24.0.0git (https://github.com/llvm/llvm-project.git 454a66a65c66012004b2e1e711247f5ebf729957)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "prog.c", directory: "/home/kshitijvp/llvm-project", checksumkind: CSK_MD5, checksum: "bdf02fc95b36e5ace2ec663e0bdc7335")
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
!14 = !{i32 7, !"frame-pointer", i32 2}
!15 = !{!"clang version 24.0.0git (https://github.com/llvm/llvm-project.git 454a66a65c66012004b2e1e711247f5ebf729957)"}
!16 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 4, type: !17, scopeLine: 4, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !19)
!17 = !DISubroutineType(types: !18)
!18 = !{!6}
!19 = !{}
!20 = !DILocalVariable(name: "i", scope: !16, file: !3, line: 5, type: !6)
!21 = !DILocation(line: 5, column: 13, scope: !16)
!22 = !DILocalVariable(name: "j", scope: !16, file: !3, line: 5, type: !6)
!23 = !DILocation(line: 5, column: 16, scope: !16)
!24 = !DILocation(line: 6, column: 16, scope: !25)
!25 = distinct !DILexicalBlock(scope: !16, file: !3, line: 6, column: 9)
!26 = !DILocation(line: 6, column: 14, scope: !25)
!27 = !DILocation(line: 6, column: 21, scope: !28)
!28 = distinct !DILexicalBlock(scope: !25, file: !3, line: 6, column: 9)
!29 = !DILocation(line: 6, column: 23, scope: !28)
!30 = !DILocation(line: 6, column: 9, scope: !25)
!31 = !DILocation(line: 7, column: 18, scope: !32)
!32 = distinct !DILexicalBlock(scope: !33, file: !3, line: 7, column: 11)
!33 = distinct !DILexicalBlock(scope: !28, file: !3, line: 6, column: 35)
!34 = !DILocation(line: 7, column: 16, scope: !32)
!35 = !DILocation(line: 7, column: 23, scope: !36)
!36 = distinct !DILexicalBlock(scope: !32, file: !3, line: 7, column: 11)
!37 = !DILocation(line: 7, column: 25, scope: !36)
!38 = !DILocation(line: 7, column: 11, scope: !32)
!39 = !DILocation(line: 8, column: 19, scope: !40)
!40 = distinct !DILexicalBlock(scope: !36, file: !3, line: 7, column: 37)
!41 = !DILocation(line: 8, column: 17, scope: !40)
!42 = !DILocation(line: 8, column: 22, scope: !40)
!43 = !DILocation(line: 8, column: 25, scope: !40)
!44 = !DILocation(line: 9, column: 11, scope: !40)
!45 = !DILocation(line: 7, column: 33, scope: !36)
!46 = !DILocation(line: 7, column: 11, scope: !36)
!47 = distinct !{!47, !38, !48, !49}
!48 = !DILocation(line: 9, column: 11, scope: !32)
!49 = !{!"llvm.loop.mustprogress"}
!50 = !DILocation(line: 10, column: 9, scope: !33)
!51 = !DILocation(line: 6, column: 31, scope: !28)
!52 = !DILocation(line: 6, column: 9, scope: !28)
!53 = distinct !{!53, !30, !54, !49}
!54 = !DILocation(line: 10, column: 9, scope: !25)
!55 = !DILocation(line: 11, column: 16, scope: !56)
!56 = distinct !DILexicalBlock(scope: !16, file: !3, line: 11, column: 9)
!57 = !DILocation(line: 11, column: 14, scope: !56)
!58 = !DILocation(line: 11, column: 21, scope: !59)
!59 = distinct !DILexicalBlock(scope: !56, file: !3, line: 11, column: 9)
!60 = !DILocation(line: 11, column: 23, scope: !59)
!61 = !DILocation(line: 11, column: 9, scope: !56)
!62 = !DILocation(line: 12, column: 24, scope: !63)
!63 = distinct !DILexicalBlock(scope: !64, file: !3, line: 12, column: 17)
!64 = distinct !DILexicalBlock(scope: !59, file: !3, line: 11, column: 35)
!65 = !DILocation(line: 12, column: 22, scope: !63)
!66 = !DILocation(line: 12, column: 29, scope: !67)
!67 = distinct !DILexicalBlock(scope: !63, file: !3, line: 12, column: 17)
!68 = !DILocation(line: 12, column: 31, scope: !67)
!69 = !DILocation(line: 12, column: 17, scope: !63)
!70 = !DILocation(line: 13, column: 37, scope: !71)
!71 = distinct !DILexicalBlock(scope: !67, file: !3, line: 12, column: 43)
!72 = !DILocation(line: 13, column: 39, scope: !71)
!73 = !DILocation(line: 13, column: 35, scope: !71)
!74 = !DILocation(line: 13, column: 44, scope: !71)
!75 = !DILocation(line: 13, column: 46, scope: !71)
!76 = !DILocation(line: 13, column: 53, scope: !71)
!77 = !DILocation(line: 13, column: 55, scope: !71)
!78 = !DILocation(line: 13, column: 54, scope: !71)
!79 = !DILocation(line: 13, column: 51, scope: !71)
!80 = !DILocation(line: 13, column: 27, scope: !71)
!81 = !DILocation(line: 13, column: 25, scope: !71)
!82 = !DILocation(line: 13, column: 30, scope: !71)
!83 = !DILocation(line: 13, column: 33, scope: !71)
!84 = !DILocation(line: 14, column: 17, scope: !71)
!85 = !DILocation(line: 12, column: 39, scope: !67)
!86 = !DILocation(line: 12, column: 17, scope: !67)
!87 = distinct !{!87, !69, !88, !49}
!88 = !DILocation(line: 14, column: 17, scope: !63)
!89 = !DILocation(line: 15, column: 9, scope: !64)
!90 = !DILocation(line: 11, column: 31, scope: !59)
!91 = !DILocation(line: 11, column: 9, scope: !59)
!92 = distinct !{!92, !61, !93, !49}
!93 = !DILocation(line: 15, column: 9, scope: !56)
!94 = !DILocation(line: 16, column: 9, scope: !16)
