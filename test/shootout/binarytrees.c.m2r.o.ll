; ModuleID = 'binarytrees.c.m2r.o'
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
  br label %18

; <label>:7                                       ; preds = %0
  %8 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 2
  %9 = load i64* %8, align 8
  %10 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 0
  %11 = load %struct.tn** %10, align 8
  %12 = call i64 @ItemCheck(%struct.tn* %11)
  %13 = add nsw i64 %9, %12
  %14 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 1
  %15 = load %struct.tn** %14, align 8
  %16 = call i64 @ItemCheck(%struct.tn* %15)
  %17 = sub nsw i64 %13, %16
  br label %18

; <label>:18                                      ; preds = %7, %4
  %.0 = phi i64 [ %6, %4 ], [ %17, %7 ]
  ret i64 %.0
}

define %struct.tn* @BottomUpTree(i64 %item, i32 %depth) nounwind ssp {
  %1 = icmp ugt i32 %depth, 0
  br i1 %1, label %2, label %11

; <label>:2                                       ; preds = %0
  %3 = mul nsw i64 2, %item
  %4 = sub nsw i64 %3, 1
  %5 = sub i32 %depth, 1
  %6 = call %struct.tn* @BottomUpTree(i64 %4, i32 %5)
  %7 = mul nsw i64 2, %item
  %8 = sub i32 %depth, 1
  %9 = call %struct.tn* @BottomUpTree(i64 %7, i32 %8)
  %10 = call %struct.tn* @NewTreeNode(%struct.tn* %6, %struct.tn* %9, i64 %item)
  br label %13

; <label>:11                                      ; preds = %0
  %12 = call %struct.tn* @NewTreeNode(%struct.tn* null, %struct.tn* null, i64 %item)
  br label %13

; <label>:13                                      ; preds = %11, %2
  %.0 = phi %struct.tn* [ %10, %2 ], [ %12, %11 ]
  ret %struct.tn* %.0
}

define void @DeleteTree(%struct.tn* %tree) nounwind ssp {
  %1 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 0
  %2 = load %struct.tn** %1, align 8
  %3 = icmp ne %struct.tn* %2, null
  br i1 %3, label %4, label %9

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 0
  %6 = load %struct.tn** %5, align 8
  call void @DeleteTree(%struct.tn* %6)
  %7 = getelementptr inbounds %struct.tn* %tree, i32 0, i32 1
  %8 = load %struct.tn** %7, align 8
  call void @DeleteTree(%struct.tn* %8)
  br label %9

; <label>:9                                       ; preds = %4, %0
  %10 = bitcast %struct.tn* %tree to i8*
  call void @free(i8* %10)
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
  %10 = add i32 4, 2
  %11 = icmp ugt i32 %10, %9
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %7
  %13 = add i32 4, 2
  br label %15

; <label>:14                                      ; preds = %7
  br label %15

; <label>:15                                      ; preds = %14, %12
  %maxDepth.0 = phi i32 [ %13, %12 ], [ %9, %14 ]
  %16 = add i32 %maxDepth.0, 1
  %17 = call %struct.tn* @BottomUpTree(i64 0, i32 %16)
  %18 = call i64 @ItemCheck(%struct.tn* %17)
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([38 x i8]* @.str, i32 0, i32 0), i32 %16, i64 %18)
  call void @DeleteTree(%struct.tn* %17)
  %20 = call %struct.tn* @BottomUpTree(i64 0, i32 %maxDepth.0)
  br label %21

; <label>:21                                      ; preds = %44, %15
  %depth.0 = phi i32 [ 4, %15 ], [ %45, %44 ]
  %22 = icmp ule i32 %depth.0, %maxDepth.0
  br i1 %22, label %23, label %46

; <label>:23                                      ; preds = %21
  %24 = sub i32 %maxDepth.0, %depth.0
  %25 = add i32 %24, 4
  %26 = uitofp i32 %25 to double
  %27 = call double @llvm.pow.f64(double 2.000000e+00, double %26)
  %28 = fptosi double %27 to i64
  br label %29

; <label>:29                                      ; preds = %39, %23
  %i.0 = phi i64 [ 1, %23 ], [ %40, %39 ]
  %check.0 = phi i64 [ 0, %23 ], [ %38, %39 ]
  %30 = icmp sle i64 %i.0, %28
  br i1 %30, label %31, label %41

; <label>:31                                      ; preds = %29
  %32 = call %struct.tn* @BottomUpTree(i64 %i.0, i32 %depth.0)
  %33 = call i64 @ItemCheck(%struct.tn* %32)
  %34 = add nsw i64 %check.0, %33
  call void @DeleteTree(%struct.tn* %32)
  %35 = sub nsw i64 0, %i.0
  %36 = call %struct.tn* @BottomUpTree(i64 %35, i32 %depth.0)
  %37 = call i64 @ItemCheck(%struct.tn* %36)
  %38 = add nsw i64 %34, %37
  call void @DeleteTree(%struct.tn* %36)
  br label %39

; <label>:39                                      ; preds = %31
  %40 = add nsw i64 %i.0, 1
  br label %29

; <label>:41                                      ; preds = %29
  %42 = mul nsw i64 %28, 2
  %43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str1, i32 0, i32 0), i64 %42, i32 %depth.0, i64 %check.0)
  br label %44

; <label>:44                                      ; preds = %41
  %45 = add i32 %depth.0, 2
  br label %21

; <label>:46                                      ; preds = %21
  %47 = call i64 @ItemCheck(%struct.tn* %20)
  %48 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([41 x i8]* @.str2, i32 0, i32 0), i32 %maxDepth.0, i64 %47)
  ret i32 0
}

declare i64 @atol(i8*)

declare i32 @printf(i8*, ...)

declare double @llvm.pow.f64(double, double) nounwind readonly
