; ModuleID = 'binarytrees.c.pipeline.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.tn = type { %struct.tn*, %struct.tn*, i64 }

@.str = private constant [38 x i8] c"stretch tree of depth %u\09 check: %li\0A\00"
@.str1 = private constant [36 x i8] c"%li\09 trees of depth %u\09 check: %li\0A\00"
@.str2 = private constant [41 x i8] c"long lived tree of depth %u\09 check: %li\0A\00"

define %struct.tn* @NewTreeNode(%struct.tn* %left, %struct.tn* %right, i64 %item) nounwind ssp {
  %1 = call i8* @malloc(i64 24)
  %2 = bitcast i8* %1 to %struct.tn*
  %3 = getelementptr inbounds %struct.tn* %2, i32 0, i32 0
  store %struct.tn* %left, %struct.tn** %3, align 8
  %4 = getelementptr inbounds %struct.tn* %2, i32 0, i32 1
  store %struct.tn* %right, %struct.tn** %4, align 8
  %5 = getelementptr inbounds %struct.tn* %2, i32 0, i32 2
  store i64 %item, i64* %5, align 8
  ret %struct.tn* %2
}

declare i8* @malloc(i64)

define i64 @ItemCheck(%struct.tn* %tree) nounwind ssp {
  %1 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 0
  %2 = load %struct.tn** %1, align 8
  %3 = icmp eq %struct.tn* %2, null
  br i1 %3, label %4, label %7

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 2
  %6 = load i64* %5, align 8
  br label %16

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 2
  %9 = load i64* %8, align 8
  %10 = call i64 @ItemCheck(%struct.tn* %2)
  %11 = add nsw i64 %9, %10
  %12 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 1
  %13 = load %struct.tn** %12, align 8
  %14 = call i64 @ItemCheck(%struct.tn* %13)
  %15 = sub nsw i64 %11, %14
  br label %16

; <label>:16                                      ; preds = %7, %4
  %.0 = phi i64 [ %6, %4 ], [ %15, %7 ]
  ret i64 %.0
}

define %struct.tn* @BottomUpTree(i64 %item, i32 %depth) nounwind ssp {
  %1 = icmp ugt i32 %depth, 0
  br i1 %1, label %2, label %9

; <label>:2                                       ; preds = %0
  %3 = mul nsw i64 2, %item
  %4 = sub nsw i64 %3, 1
  %5 = sub i32 %depth, 1
  %6 = call %struct.tn* @BottomUpTree(i64 %4, i32 %5)
  %7 = call %struct.tn* @BottomUpTree(i64 %3, i32 %5)
  %8 = call %struct.tn* @NewTreeNode(%struct.tn* %6, %struct.tn* %7, i64 %item)
  br label %11

; <label>:9                                       ; preds = %0
  %10 = call %struct.tn* @NewTreeNode(%struct.tn* null, %struct.tn* null, i64 %item)
  br label %11

; <label>:11                                      ; preds = %9, %2
  %.0 = phi %struct.tn* [ %8, %2 ], [ %10, %9 ]
  ret %struct.tn* %.0
}

define void @DeleteTree(%struct.tn* %tree) nounwind ssp {
  %1 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 0
  %2 = load %struct.tn** %1, align 8
  %3 = icmp ne %struct.tn* %2, null
  br i1 %3, label %4, label %7

; <label>:4                                       ; preds = %0
  call void @DeleteTree(%struct.tn* %2)
  %5 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 1
  %6 = load %struct.tn** %5, align 8
  call void @DeleteTree(%struct.tn* %6)
  br label %7

; <label>:7                                       ; preds = %4, %0
  %8 = bitcast %struct.tn* %tree to i8*
  call void @free(i8* %8)
  ret void
}

declare void @free(i8*)

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = icmp slt i32 %argc, 2
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  br label %7

; <label>:3                                       ; preds = %0
  %4 = getelementptr inbounds i8** %argv, i64 1
  %5 = load i8** %4
  %6 = call i64 @atol(i8* %5)
  br label %7

; <label>:7                                       ; preds = %3, %2
  %8 = phi i64 [ 16, %2 ], [ %6, %3 ]
  %9 = trunc i64 %8 to i32
  %10 = icmp ugt i32 6, %9
  br i1 %10, label %11, label %12

; <label>:11                                      ; preds = %7
  br label %13

; <label>:12                                      ; preds = %7
  br label %13

; <label>:13                                      ; preds = %12, %11
  %maxDepth.0 = phi i32 [ 6, %11 ], [ %9, %12 ]
  %14 = add i32 %maxDepth.0, 1
  %15 = call %struct.tn* @BottomUpTree(i64 0, i32 %14)
  %16 = call i64 @ItemCheck(%struct.tn* %15)
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([38 x i8]* @.str, i32 0, i32 0), i32 %14, i64 %16)
  call void @DeleteTree(%struct.tn* %15)
  %18 = call %struct.tn* @BottomUpTree(i64 0, i32 %maxDepth.0)
  br label %19

; <label>:19                                      ; preds = %38, %13
  %depth.0 = phi i32 [ 4, %13 ], [ %41, %38 ]
  %20 = icmp ule i32 %depth.0, %maxDepth.0
  br i1 %20, label %21, label %42

; <label>:21                                      ; preds = %19
  %22 = sub i32 %maxDepth.0, %depth.0
  %23 = add i32 %22, 4
  %24 = uitofp i32 %23 to double
  %25 = call double @llvm.pow.f64(double 2.000000e+00, double %24)
  %26 = fptosi double %25 to i64
  br label %27

; <label>:27                                      ; preds = %29, %21
  %i.0 = phi i64 [ 1, %21 ], [ %37, %29 ]
  %check.0 = phi i64 [ 0, %21 ], [ %36, %29 ]
  %28 = icmp sle i64 %i.0, %26
  br i1 %28, label %29, label %38

; <label>:29                                      ; preds = %27
  %30 = call %struct.tn* @BottomUpTree(i64 %i.0, i32 %depth.0)
  %31 = call i64 @ItemCheck(%struct.tn* %30)
  %32 = add nsw i64 %check.0, %31
  call void @DeleteTree(%struct.tn* %30)
  %33 = sub nsw i64 0, %i.0
  %34 = call %struct.tn* @BottomUpTree(i64 %33, i32 %depth.0)
  %35 = call i64 @ItemCheck(%struct.tn* %34)
  %36 = add nsw i64 %32, %35
  call void @DeleteTree(%struct.tn* %34)
  %37 = add nsw i64 %i.0, 1
  br label %27

; <label>:38                                      ; preds = %27
  %check.0.lcssa = phi i64 [ %check.0, %27 ]
  %39 = mul nsw i64 %26, 2
  %40 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str1, i32 0, i32 0), i64 %39, i32 %depth.0, i64 %check.0.lcssa)
  %41 = add i32 %depth.0, 2
  br label %19

; <label>:42                                      ; preds = %19
  %43 = call i64 @ItemCheck(%struct.tn* %18)
  %44 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([41 x i8]* @.str2, i32 0, i32 0), i32 %maxDepth.0, i64 %43)
  ret i32 0
}

declare i64 @atol(i8*)

declare i32 @printf(i8*, ...)

declare double @llvm.pow.f64(double, double) nounwind readonly
