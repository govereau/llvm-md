; ModuleID = 'binarytrees.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.tn = type { %struct.tn*, %struct.tn*, i64 }

@.str = private constant [38 x i8] c"stretch tree of depth %u\09 check: %li\0A\00"
@.str1 = private constant [36 x i8] c"%li\09 trees of depth %u\09 check: %li\0A\00"
@.str2 = private constant [41 x i8] c"long lived tree of depth %u\09 check: %li\0A\00"

define %struct.tn* @NewTreeNode(%struct.tn* %left, %struct.tn* %right, i64 %item) nounwind ssp {
  %1 = alloca %struct.tn*, align 8
  %2 = alloca %struct.tn*, align 8
  %3 = alloca i64, align 8
  %new = alloca %struct.tn*, align 8
  store %struct.tn* %left, %struct.tn** %1, align 8
  store %struct.tn* %right, %struct.tn** %2, align 8
  store i64 %item, i64* %3, align 8
  %4 = call i8* @malloc(i64 24)
  %5 = bitcast i8* %4 to %struct.tn*
  store %struct.tn* %5, %struct.tn** %new, align 8
  %6 = load %struct.tn** %1, align 8
  %7 = load %struct.tn** %new, align 8
  %8 = getelementptr inbounds %struct.tn* %7, i32 0, i32 0
  store %struct.tn* %6, %struct.tn** %8, align 8
  %9 = load %struct.tn** %2, align 8
  %10 = load %struct.tn** %new, align 8
  %11 = getelementptr inbounds %struct.tn* %10, i32 0, i32 1
  store %struct.tn* %9, %struct.tn** %11, align 8
  %12 = load i64* %3, align 8
  %13 = load %struct.tn** %new, align 8
  %14 = getelementptr inbounds %struct.tn* %13, i32 0, i32 2
  store i64 %12, i64* %14, align 8
  %15 = load %struct.tn** %new, align 8
  ret %struct.tn* %15
}

declare i8* @malloc(i64)

define i64 @ItemCheck(%struct.tn* %tree) nounwind ssp {
  %1 = alloca i64, align 8
  %2 = alloca %struct.tn*, align 8
  store %struct.tn* %tree, %struct.tn** %2, align 8
  %3 = load %struct.tn** %2, align 8
  %4 = getelementptr inbounds %struct.tn* %3, i32 0, i32 0
  %5 = load %struct.tn** %4, align 8
  %6 = icmp eq %struct.tn* %5, null
  br i1 %6, label %7, label %11

; <label>:7                                       ; preds = %0
  %8 = load %struct.tn** %2, align 8
  %9 = getelementptr inbounds %struct.tn* %8, i32 0, i32 2
  %10 = load i64* %9, align 8
  store i64 %10, i64* %1
  br label %25

; <label>:11                                      ; preds = %0
  %12 = load %struct.tn** %2, align 8
  %13 = getelementptr inbounds %struct.tn* %12, i32 0, i32 2
  %14 = load i64* %13, align 8
  %15 = load %struct.tn** %2, align 8
  %16 = getelementptr inbounds %struct.tn* %15, i32 0, i32 0
  %17 = load %struct.tn** %16, align 8
  %18 = call i64 @ItemCheck(%struct.tn* %17)
  %19 = add nsw i64 %14, %18
  %20 = load %struct.tn** %2, align 8
  %21 = getelementptr inbounds %struct.tn* %20, i32 0, i32 1
  %22 = load %struct.tn** %21, align 8
  %23 = call i64 @ItemCheck(%struct.tn* %22)
  %24 = sub nsw i64 %19, %23
  store i64 %24, i64* %1
  br label %25

; <label>:25                                      ; preds = %11, %7
  %26 = load i64* %1
  ret i64 %26
}

define %struct.tn* @BottomUpTree(i64 %item, i32 %depth) nounwind ssp {
  %1 = alloca %struct.tn*, align 8
  %2 = alloca i64, align 8
  %3 = alloca i32, align 4
  store i64 %item, i64* %2, align 8
  store i32 %depth, i32* %3, align 4
  %4 = load i32* %3, align 4
  %5 = icmp ugt i32 %4, 0
  br i1 %5, label %6, label %20

; <label>:6                                       ; preds = %0
  %7 = load i64* %2, align 8
  %8 = mul nsw i64 2, %7
  %9 = sub nsw i64 %8, 1
  %10 = load i32* %3, align 4
  %11 = sub i32 %10, 1
  %12 = call %struct.tn* @BottomUpTree(i64 %9, i32 %11)
  %13 = load i64* %2, align 8
  %14 = mul nsw i64 2, %13
  %15 = load i32* %3, align 4
  %16 = sub i32 %15, 1
  %17 = call %struct.tn* @BottomUpTree(i64 %14, i32 %16)
  %18 = load i64* %2, align 8
  %19 = call %struct.tn* @NewTreeNode(%struct.tn* %12, %struct.tn* %17, i64 %18)
  store %struct.tn* %19, %struct.tn** %1
  br label %23

; <label>:20                                      ; preds = %0
  %21 = load i64* %2, align 8
  %22 = call %struct.tn* @NewTreeNode(%struct.tn* null, %struct.tn* null, i64 %21)
  store %struct.tn* %22, %struct.tn** %1
  br label %23

; <label>:23                                      ; preds = %20, %6
  %24 = load %struct.tn** %1
  ret %struct.tn* %24
}

define void @DeleteTree(%struct.tn* %tree) nounwind ssp {
  %1 = alloca %struct.tn*, align 8
  store %struct.tn* %tree, %struct.tn** %1, align 8
  %2 = load %struct.tn** %1, align 8
  %3 = getelementptr inbounds %struct.tn* %2, i32 0, i32 0
  %4 = load %struct.tn** %3, align 8
  %5 = icmp ne %struct.tn* %4, null
  br i1 %5, label %6, label %13

; <label>:6                                       ; preds = %0
  %7 = load %struct.tn** %1, align 8
  %8 = getelementptr inbounds %struct.tn* %7, i32 0, i32 0
  %9 = load %struct.tn** %8, align 8
  call void @DeleteTree(%struct.tn* %9)
  %10 = load %struct.tn** %1, align 8
  %11 = getelementptr inbounds %struct.tn* %10, i32 0, i32 1
  %12 = load %struct.tn** %11, align 8
  call void @DeleteTree(%struct.tn* %12)
  br label %13

; <label>:13                                      ; preds = %6, %0
  %14 = load %struct.tn** %1, align 8
  %15 = bitcast %struct.tn* %14 to i8*
  call void @free(i8* %15)
  ret void
}

declare void @free(i8*)

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %N = alloca i32, align 4
  %depth = alloca i32, align 4
  %minDepth = alloca i32, align 4
  %maxDepth = alloca i32, align 4
  %stretchDepth = alloca i32, align 4
  %stretchTree = alloca %struct.tn*, align 8
  %longLivedTree = alloca %struct.tn*, align 8
  %tempTree = alloca %struct.tn*, align 8
  %i = alloca i64, align 8
  %iterations = alloca i64, align 8
  %check = alloca i64, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = load i32* %2, align 4
  %5 = icmp slt i32 %4, 2
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %0
  br label %12

; <label>:7                                       ; preds = %0
  %8 = load i8*** %3, align 8
  %9 = getelementptr inbounds i8** %8, i64 1
  %10 = load i8** %9
  %11 = call i64 @atol(i8* %10)
  br label %12

; <label>:12                                      ; preds = %7, %6
  %13 = phi i64 [ 16, %6 ], [ %11, %7 ]
  %14 = trunc i64 %13 to i32
  store i32 %14, i32* %N, align 4
  store i32 4, i32* %minDepth, align 4
  %15 = load i32* %minDepth, align 4
  %16 = add i32 %15, 2
  %17 = load i32* %N, align 4
  %18 = icmp ugt i32 %16, %17
  br i1 %18, label %19, label %22

; <label>:19                                      ; preds = %12
  %20 = load i32* %minDepth, align 4
  %21 = add i32 %20, 2
  store i32 %21, i32* %maxDepth, align 4
  br label %24

; <label>:22                                      ; preds = %12
  %23 = load i32* %N, align 4
  store i32 %23, i32* %maxDepth, align 4
  br label %24

; <label>:24                                      ; preds = %22, %19
  %25 = load i32* %maxDepth, align 4
  %26 = add i32 %25, 1
  store i32 %26, i32* %stretchDepth, align 4
  %27 = load i32* %stretchDepth, align 4
  %28 = call %struct.tn* @BottomUpTree(i64 0, i32 %27)
  store %struct.tn* %28, %struct.tn** %stretchTree, align 8
  %29 = load i32* %stretchDepth, align 4
  %30 = load %struct.tn** %stretchTree, align 8
  %31 = call i64 @ItemCheck(%struct.tn* %30)
  %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([38 x i8]* @.str, i32 0, i32 0), i32 %29, i64 %31)
  %33 = load %struct.tn** %stretchTree, align 8
  call void @DeleteTree(%struct.tn* %33)
  %34 = load i32* %maxDepth, align 4
  %35 = call %struct.tn* @BottomUpTree(i64 0, i32 %34)
  store %struct.tn* %35, %struct.tn** %longLivedTree, align 8
  %36 = load i32* %minDepth, align 4
  store i32 %36, i32* %depth, align 4
  br label %37

; <label>:37                                      ; preds = %81, %24
  %38 = load i32* %depth, align 4
  %39 = load i32* %maxDepth, align 4
  %40 = icmp ule i32 %38, %39
  br i1 %40, label %41, label %84

; <label>:41                                      ; preds = %37
  %42 = load i32* %maxDepth, align 4
  %43 = load i32* %depth, align 4
  %44 = sub i32 %42, %43
  %45 = load i32* %minDepth, align 4
  %46 = add i32 %44, %45
  %47 = uitofp i32 %46 to double
  %48 = call double @llvm.pow.f64(double 2.000000e+00, double %47)
  %49 = fptosi double %48 to i64
  store i64 %49, i64* %iterations, align 8
  store i64 0, i64* %check, align 8
  store i64 1, i64* %i, align 8
  br label %50

; <label>:50                                      ; preds = %72, %41
  %51 = load i64* %i, align 8
  %52 = load i64* %iterations, align 8
  %53 = icmp sle i64 %51, %52
  br i1 %53, label %54, label %75

; <label>:54                                      ; preds = %50
  %55 = load i64* %i, align 8
  %56 = load i32* %depth, align 4
  %57 = call %struct.tn* @BottomUpTree(i64 %55, i32 %56)
  store %struct.tn* %57, %struct.tn** %tempTree, align 8
  %58 = load %struct.tn** %tempTree, align 8
  %59 = call i64 @ItemCheck(%struct.tn* %58)
  %60 = load i64* %check, align 8
  %61 = add nsw i64 %60, %59
  store i64 %61, i64* %check, align 8
  %62 = load %struct.tn** %tempTree, align 8
  call void @DeleteTree(%struct.tn* %62)
  %63 = load i64* %i, align 8
  %64 = sub nsw i64 0, %63
  %65 = load i32* %depth, align 4
  %66 = call %struct.tn* @BottomUpTree(i64 %64, i32 %65)
  store %struct.tn* %66, %struct.tn** %tempTree, align 8
  %67 = load %struct.tn** %tempTree, align 8
  %68 = call i64 @ItemCheck(%struct.tn* %67)
  %69 = load i64* %check, align 8
  %70 = add nsw i64 %69, %68
  store i64 %70, i64* %check, align 8
  %71 = load %struct.tn** %tempTree, align 8
  call void @DeleteTree(%struct.tn* %71)
  br label %72

; <label>:72                                      ; preds = %54
  %73 = load i64* %i, align 8
  %74 = add nsw i64 %73, 1
  store i64 %74, i64* %i, align 8
  br label %50

; <label>:75                                      ; preds = %50
  %76 = load i64* %iterations, align 8
  %77 = mul nsw i64 %76, 2
  %78 = load i32* %depth, align 4
  %79 = load i64* %check, align 8
  %80 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str1, i32 0, i32 0), i64 %77, i32 %78, i64 %79)
  br label %81

; <label>:81                                      ; preds = %75
  %82 = load i32* %depth, align 4
  %83 = add i32 %82, 2
  store i32 %83, i32* %depth, align 4
  br label %37

; <label>:84                                      ; preds = %37
  %85 = load i32* %maxDepth, align 4
  %86 = load %struct.tn** %longLivedTree, align 8
  %87 = call i64 @ItemCheck(%struct.tn* %86)
  %88 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([41 x i8]* @.str2, i32 0, i32 0), i32 %85, i64 %87)
  ret i32 0
}

declare i64 @atol(i8*)

declare i32 @printf(i8*, ...)

declare double @llvm.pow.f64(double, double) nounwind readonly
