; ModuleID = 'C:/Users/seanr/vitis_projects/fpp_project/singleStep_baseline/equalStep_baseline/hls/.autopilot/db/a.g.ld.5.gdce.bc'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-i128:128-i256:256-i512:512-i1024:1024-i2048:2048-i4096:4096-n8:16:32:64-S128-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024"
target triple = "fpga64-xilinx-none"

; Function Attrs: noinline
define void @apatb_equalStep_baseline_ir([64 x [64 x i16]]* noalias nocapture nonnull readonly "fpga.decayed.dim.hint"="5" %imStack, [64 x double]* noalias nocapture nonnull "fpga.decayed.dim.hint"="64" %wrappedPhase, [64 x double]* noalias nocapture nonnull "fpga.decayed.dim.hint"="64" %mod) local_unnamed_addr #0 {
entry:
  %0 = bitcast [64 x [64 x i16]]* %imStack to [5 x [64 x [64 x i16]]]*
  %1 = call i8* @malloc(i64 40960)
  %imStack_copy = bitcast i8* %1 to [5 x [64 x [64 x i16]]]*
  %2 = bitcast [64 x double]* %wrappedPhase to [64 x [64 x double]]*
  %3 = call i8* @malloc(i64 32768)
  %wrappedPhase_copy = bitcast i8* %3 to [64 x [64 x double]]*
  %4 = bitcast [64 x double]* %mod to [64 x [64 x double]]*
  %5 = call i8* @malloc(i64 32768)
  %mod_copy = bitcast i8* %5 to [64 x [64 x double]]*
  call fastcc void @copy_in([5 x [64 x [64 x i16]]]* nonnull %0, [5 x [64 x [64 x i16]]]* %imStack_copy, [64 x [64 x double]]* nonnull %2, [64 x [64 x double]]* %wrappedPhase_copy, [64 x [64 x double]]* nonnull %4, [64 x [64 x double]]* %mod_copy)
  call void @apatb_equalStep_baseline_hw([5 x [64 x [64 x i16]]]* %imStack_copy, [64 x [64 x double]]* %wrappedPhase_copy, [64 x [64 x double]]* %mod_copy)
  call void @copy_back([5 x [64 x [64 x i16]]]* %0, [5 x [64 x [64 x i16]]]* %imStack_copy, [64 x [64 x double]]* %2, [64 x [64 x double]]* %wrappedPhase_copy, [64 x [64 x double]]* %4, [64 x [64 x double]]* %mod_copy)
  tail call void @free(i8* %1)
  tail call void @free(i8* %3)
  tail call void @free(i8* %5)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_in([5 x [64 x [64 x i16]]]* readonly, [5 x [64 x [64 x i16]]]*, [64 x [64 x double]]* readonly, [64 x [64 x double]]*, [64 x [64 x double]]* readonly, [64 x [64 x double]]*) unnamed_addr #1 {
entry:
  call fastcc void @onebyonecpy_hls.p0a5a64a64i16([5 x [64 x [64 x i16]]]* %1, [5 x [64 x [64 x i16]]]* %0)
  call fastcc void @onebyonecpy_hls.p0a64a64f64([64 x [64 x double]]* %3, [64 x [64 x double]]* %2)
  call fastcc void @onebyonecpy_hls.p0a64a64f64([64 x [64 x double]]* %5, [64 x [64 x double]]* %4)
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a5a64a64i16([5 x [64 x [64 x i16]]]* %dst, [5 x [64 x [64 x i16]]]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [5 x [64 x [64 x i16]]]* %dst, null
  %1 = icmp eq [5 x [64 x [64 x i16]]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a5a64a64i16([5 x [64 x [64 x i16]]]* nonnull %dst, [5 x [64 x [64 x i16]]]* nonnull %src, i64 5)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a5a64a64i16([5 x [64 x [64 x i16]]]* %dst, [5 x [64 x [64 x i16]]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [5 x [64 x [64 x i16]]]* %src, null
  %1 = icmp eq [5 x [64 x [64 x i16]]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [5 x [64 x [64 x i16]]], [5 x [64 x [64 x i16]]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [5 x [64 x [64 x i16]]], [5 x [64 x [64 x i16]]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a64a64i16([64 x [64 x i16]]* %dst.addr, [64 x [64 x i16]]* %src.addr, i64 64)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a64a64i16([64 x [64 x i16]]* %dst, [64 x [64 x i16]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [64 x [64 x i16]]* %src, null
  %1 = icmp eq [64 x [64 x i16]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [64 x [64 x i16]], [64 x [64 x i16]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [64 x [64 x i16]], [64 x [64 x i16]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a64i16([64 x i16]* %dst.addr, [64 x i16]* %src.addr, i64 64)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a64i16([64 x i16]* %dst, [64 x i16]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [64 x i16]* %src, null
  %1 = icmp eq [64 x i16]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [64 x i16], [64 x i16]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [64 x i16], [64 x i16]* %src, i64 0, i64 %for.loop.idx2
  %3 = load i16, i16* %src.addr, align 2
  store i16 %3, i16* %dst.addr, align 2
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @onebyonecpy_hls.p0a64a64f64([64 x [64 x double]]* %dst, [64 x [64 x double]]* readonly %src) unnamed_addr #2 {
entry:
  %0 = icmp eq [64 x [64 x double]]* %dst, null
  %1 = icmp eq [64 x [64 x double]]* %src, null
  %2 = or i1 %0, %1
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  call void @arraycpy_hls.p0a64a64f64([64 x [64 x double]]* nonnull %dst, [64 x [64 x double]]* nonnull %src, i64 64)
  br label %ret

ret:                                              ; preds = %copy, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a64a64f64([64 x [64 x double]]* %dst, [64 x [64 x double]]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [64 x [64 x double]]* %src, null
  %1 = icmp eq [64 x [64 x double]]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [64 x [64 x double]], [64 x [64 x double]]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [64 x [64 x double]], [64 x [64 x double]]* %src, i64 0, i64 %for.loop.idx2
  call void @arraycpy_hls.p0a64f64([64 x double]* %dst.addr, [64 x double]* %src.addr, i64 64)
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define void @arraycpy_hls.p0a64f64([64 x double]* %dst, [64 x double]* readonly %src, i64 %num) local_unnamed_addr #3 {
entry:
  %0 = icmp eq [64 x double]* %src, null
  %1 = icmp eq [64 x double]* %dst, null
  %2 = or i1 %1, %0
  br i1 %2, label %ret, label %copy

copy:                                             ; preds = %entry
  %for.loop.cond1 = icmp sgt i64 %num, 0
  br i1 %for.loop.cond1, label %for.loop.lr.ph, label %copy.split

for.loop.lr.ph:                                   ; preds = %copy
  br label %for.loop

for.loop:                                         ; preds = %for.loop, %for.loop.lr.ph
  %for.loop.idx2 = phi i64 [ 0, %for.loop.lr.ph ], [ %for.loop.idx.next, %for.loop ]
  %dst.addr = getelementptr [64 x double], [64 x double]* %dst, i64 0, i64 %for.loop.idx2
  %src.addr = getelementptr [64 x double], [64 x double]* %src, i64 0, i64 %for.loop.idx2
  %3 = load double, double* %src.addr, align 8
  store double %3, double* %dst.addr, align 8
  %for.loop.idx.next = add nuw nsw i64 %for.loop.idx2, 1
  %exitcond = icmp ne i64 %for.loop.idx.next, %num
  br i1 %exitcond, label %for.loop, label %copy.split

copy.split:                                       ; preds = %for.loop, %copy
  br label %ret

ret:                                              ; preds = %copy.split, %entry
  ret void
}

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_out([5 x [64 x [64 x i16]]]*, [5 x [64 x [64 x i16]]]* readonly, [64 x [64 x double]]*, [64 x [64 x double]]* readonly, [64 x [64 x double]]*, [64 x [64 x double]]* readonly) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a5a64a64i16([5 x [64 x [64 x i16]]]* %0, [5 x [64 x [64 x i16]]]* %1)
  call fastcc void @onebyonecpy_hls.p0a64a64f64([64 x [64 x double]]* %2, [64 x [64 x double]]* %3)
  call fastcc void @onebyonecpy_hls.p0a64a64f64([64 x [64 x double]]* %4, [64 x [64 x double]]* %5)
  ret void
}

declare i8* @malloc(i64) local_unnamed_addr

declare void @free(i8*) local_unnamed_addr

declare void @apatb_equalStep_baseline_hw([5 x [64 x [64 x i16]]]*, [64 x [64 x double]]*, [64 x [64 x double]]*)

; Function Attrs: argmemonly noinline norecurse willreturn
define internal fastcc void @copy_back([5 x [64 x [64 x i16]]]*, [5 x [64 x [64 x i16]]]* readonly, [64 x [64 x double]]*, [64 x [64 x double]]* readonly, [64 x [64 x double]]*, [64 x [64 x double]]* readonly) unnamed_addr #4 {
entry:
  call fastcc void @onebyonecpy_hls.p0a64a64f64([64 x [64 x double]]* %2, [64 x [64 x double]]* %3)
  call fastcc void @onebyonecpy_hls.p0a64a64f64([64 x [64 x double]]* %4, [64 x [64 x double]]* %5)
  ret void
}

declare void @equalStep_baseline_hw_stub([64 x [64 x i16]]* noalias nocapture nonnull readonly, [64 x double]* noalias nocapture nonnull, [64 x double]* noalias nocapture nonnull)

define void @equalStep_baseline_hw_stub_wrapper([5 x [64 x [64 x i16]]]*, [64 x [64 x double]]*, [64 x [64 x double]]*) #5 {
entry:
  call void @copy_out([5 x [64 x [64 x i16]]]* null, [5 x [64 x [64 x i16]]]* %0, [64 x [64 x double]]* null, [64 x [64 x double]]* %1, [64 x [64 x double]]* null, [64 x [64 x double]]* %2)
  %3 = bitcast [5 x [64 x [64 x i16]]]* %0 to [64 x [64 x i16]]*
  %4 = bitcast [64 x [64 x double]]* %1 to [64 x double]*
  %5 = bitcast [64 x [64 x double]]* %2 to [64 x double]*
  call void @equalStep_baseline_hw_stub([64 x [64 x i16]]* %3, [64 x double]* %4, [64 x double]* %5)
  call void @copy_in([5 x [64 x [64 x i16]]]* null, [5 x [64 x [64 x i16]]]* %0, [64 x [64 x double]]* null, [64 x [64 x double]]* %1, [64 x [64 x double]]* null, [64 x [64 x double]]* %2)
  ret void
}

attributes #0 = { noinline "fpga.wrapper.func"="wrapper" }
attributes #1 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyin" }
attributes #2 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="onebyonecpy_hls" }
attributes #3 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="arraycpy_hls" }
attributes #4 = { argmemonly noinline norecurse willreturn "fpga.wrapper.func"="copyout" }
attributes #5 = { "fpga.wrapper.func"="stub" }

!llvm.dbg.cu = !{}
!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3}
!blackbox_cfg = !{!4}

!0 = !{!"clang version 7.0.0 "}
!1 = !{i32 2, !"Dwarf Version", i32 4}
!2 = !{i32 2, !"Debug Info Version", i32 3}
!3 = !{i32 1, !"wchar_size", i32 4}
!4 = !{}
