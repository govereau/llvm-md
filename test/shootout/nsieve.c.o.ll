; ModuleID = 'nsieve.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [22 x i8] c"Primes up to %8u %8u\0A\00"

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %m = alloca i32, align 4
  %i = alloca i32, align 4
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
  %11 = call i32 @atoi(i8* %10)
  br label %12

; <label>:12                                      ; preds = %7, %6
  %13 = phi i32 [ 9, %6 ], [ %11, %7 ]
  store i32 %13, i32* %m, align 4
  store i32 0, i32* %i, align 4
  br label %14

; <label>:14                                      ; preds = %22, %12
  %15 = load i32* %i, align 4
  %16 = icmp slt i32 %15, 3
  br i1 %16, label %17, label %25

; <label>:17                                      ; preds = %14
  %18 = load i32* %m, align 4
  %19 = load i32* %i, align 4
  %20 = sub nsw i32 %18, %19
  %21 = shl i32 10000, %20
  call void @nsieve(i32 %21)
  br label %22

; <label>:22                                      ; preds = %17
  %23 = load i32* %i, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, i32* %i, align 4
  br label %14

; <label>:25                                      ; preds = %14
  ret i32 0
}

declare i32 @atoi(i8*)

define internal void @nsieve(i32 %m) nounwind ssp {
  %1 = alloca i32, align 4
  %count = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %flags = alloca i8*, align 8
  store i32 %m, i32* %1, align 4
  store i32 0, i32* %count, align 4
  %2 = load i32* %1, align 4
  %3 = sext i32 %2 to i64
  %4 = mul i64 %3, 1
  %5 = call i8* @malloc(i64 %4)
  store i8* %5, i8** %flags, align 8
  %6 = load i8** %flags, align 8
  %7 = call i64 @llvm.objectsize.i64(i8* %6, i1 false)
  %8 = icmp ne i64 %7, -1
  br i1 %8, label %9, label %16

; <label>:9                                       ; preds = %0
  %10 = load i8** %flags, align 8
  %11 = load i32* %1, align 4
  %12 = sext i32 %11 to i64
  %13 = load i8** %flags, align 8
  %14 = call i64 @llvm.objectsize.i64(i8* %13, i1 false)
  %15 = call i8* @__memset_chk(i8* %10, i32 1, i64 %12, i64 %14)
  br label %21

; <label>:16                                      ; preds = %0
  %17 = load i8** %flags, align 8
  %18 = load i32* %1, align 4
  %19 = sext i32 %18 to i64
  %20 = call i8* @__inline_memset_chk(i8* %17, i32 1, i64 %19)
  br label %21

; <label>:21                                      ; preds = %16, %9
  %22 = phi i8* [ %15, %9 ], [ %20, %16 ]
  store i32 2, i32* %i, align 4
  br label %23

; <label>:23                                      ; preds = %62, %21
  %24 = load i32* %i, align 4
  %25 = load i32* %1, align 4
  %26 = icmp ult i32 %24, %25
  br i1 %26, label %27, label %65

; <label>:27                                      ; preds = %23
  %28 = load i32* %i, align 4
  %29 = zext i32 %28 to i64
  %30 = load i8** %flags, align 8
  %31 = getelementptr inbounds i8* %30, i64 %29
  %32 = load i8* %31
  %33 = icmp ne i8 %32, 0
  br i1 %33, label %34, label %61

; <label>:34                                      ; preds = %27
  %35 = load i32* %count, align 4
  %36 = add i32 %35, 1
  store i32 %36, i32* %count, align 4
  %37 = load i32* %i, align 4
  %38 = shl i32 %37, 1
  store i32 %38, i32* %j, align 4
  br label %39

; <label>:39                                      ; preds = %56, %34
  %40 = load i32* %j, align 4
  %41 = load i32* %1, align 4
  %42 = icmp ult i32 %40, %41
  br i1 %42, label %43, label %60

; <label>:43                                      ; preds = %39
  %44 = load i32* %j, align 4
  %45 = zext i32 %44 to i64
  %46 = load i8** %flags, align 8
  %47 = getelementptr inbounds i8* %46, i64 %45
  %48 = load i8* %47
  %49 = icmp ne i8 %48, 0
  br i1 %49, label %50, label %55

; <label>:50                                      ; preds = %43
  %51 = load i32* %j, align 4
  %52 = zext i32 %51 to i64
  %53 = load i8** %flags, align 8
  %54 = getelementptr inbounds i8* %53, i64 %52
  store i8 0, i8* %54
  br label %55

; <label>:55                                      ; preds = %50, %43
  br label %56

; <label>:56                                      ; preds = %55
  %57 = load i32* %i, align 4
  %58 = load i32* %j, align 4
  %59 = add i32 %58, %57
  store i32 %59, i32* %j, align 4
  br label %39

; <label>:60                                      ; preds = %39
  br label %61

; <label>:61                                      ; preds = %60, %27
  br label %62

; <label>:62                                      ; preds = %61
  %63 = load i32* %i, align 4
  %64 = add i32 %63, 1
  store i32 %64, i32* %i, align 4
  br label %23

; <label>:65                                      ; preds = %23
  %66 = load i8** %flags, align 8
  call void @free(i8* %66)
  %67 = load i32* %1, align 4
  %68 = load i32* %count, align 4
  %69 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str, i32 0, i32 0), i32 %67, i32 %68)
  ret void
}

declare i8* @malloc(i64)

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

declare i8* @__memset_chk(i8*, i32, i64, i64) nounwind

define internal i8* @__inline_memset_chk(i8* %__dest, i32 %__val, i64 %__len) nounwind inlinehint ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  store i8* %__dest, i8** %1, align 8
  store i32 %__val, i32* %2, align 4
  store i64 %__len, i64* %3, align 8
  %4 = load i8** %1, align 8
  %5 = load i32* %2, align 4
  %6 = load i64* %3, align 8
  %7 = load i8** %1, align 8
  %8 = call i64 @llvm.objectsize.i64(i8* %7, i1 false)
  %9 = call i8* @__memset_chk(i8* %4, i32 %5, i64 %6, i64 %8)
  ret i8* %9
}

declare void @free(i8*)

declare i32 @printf(i8*, ...)
