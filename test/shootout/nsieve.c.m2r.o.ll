; ModuleID = 'nsieve.c.m2r.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [22 x i8] c"Primes up to %8u %8u\0A\00"

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = icmp slt i32 %argc, 2
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  br label %7

; <label>:3                                       ; preds = %0
  %4 = getelementptr inbounds i8** %argv, i64 1
  %5 = load i8** %4
  %6 = call i32 @atoi(i8* %5)
  br label %7

; <label>:7                                       ; preds = %3, %2
  %8 = phi i32 [ 9, %2 ], [ %6, %3 ]
  br label %9

; <label>:9                                       ; preds = %14, %7
  %i.0 = phi i32 [ 0, %7 ], [ %15, %14 ]
  %10 = icmp slt i32 %i.0, 3
  br i1 %10, label %11, label %16

; <label>:11                                      ; preds = %9
  %12 = sub nsw i32 %8, %i.0
  %13 = shl i32 10000, %12
  call void @nsieve(i32 %13)
  br label %14

; <label>:14                                      ; preds = %11
  %15 = add nsw i32 %i.0, 1
  br label %9

; <label>:16                                      ; preds = %9
  ret i32 0
}

declare i32 @atoi(i8*)

define internal void @nsieve(i32 %m) nounwind ssp {
  %1 = sext i32 %m to i64
  %2 = mul i64 %1, 1
  %3 = call i8* @malloc(i64 %2)
  %4 = call i64 @llvm.objectsize.i64(i8* %3, i1 false)
  %5 = icmp ne i64 %4, -1
  br i1 %5, label %6, label %10

; <label>:6                                       ; preds = %0
  %7 = sext i32 %m to i64
  %8 = call i64 @llvm.objectsize.i64(i8* %3, i1 false)
  %9 = call i8* @__memset_chk(i8* %3, i32 1, i64 %7, i64 %8)
  br label %13

; <label>:10                                      ; preds = %0
  %11 = sext i32 %m to i64
  %12 = call i8* @__inline_memset_chk(i8* %3, i32 1, i64 %11)
  br label %13

; <label>:13                                      ; preds = %10, %6
  %14 = phi i8* [ %9, %6 ], [ %12, %10 ]
  br label %15

; <label>:15                                      ; preds = %40, %13
  %i.0 = phi i32 [ 2, %13 ], [ %41, %40 ]
  %count.1 = phi i32 [ 0, %13 ], [ %count.0, %40 ]
  %16 = icmp ult i32 %i.0, %m
  br i1 %16, label %17, label %42

; <label>:17                                      ; preds = %15
  %18 = zext i32 %i.0 to i64
  %19 = getelementptr inbounds i8* %3, i64 %18
  %20 = load i8* %19
  %21 = icmp ne i8 %20, 0
  br i1 %21, label %22, label %39

; <label>:22                                      ; preds = %17
  %23 = add i32 %count.1, 1
  %24 = shl i32 %i.0, 1
  br label %25

; <label>:25                                      ; preds = %36, %22
  %j.0 = phi i32 [ %24, %22 ], [ %37, %36 ]
  %26 = icmp ult i32 %j.0, %m
  br i1 %26, label %27, label %38

; <label>:27                                      ; preds = %25
  %28 = zext i32 %j.0 to i64
  %29 = getelementptr inbounds i8* %3, i64 %28
  %30 = load i8* %29
  %31 = icmp ne i8 %30, 0
  br i1 %31, label %32, label %35

; <label>:32                                      ; preds = %27
  %33 = zext i32 %j.0 to i64
  %34 = getelementptr inbounds i8* %3, i64 %33
  store i8 0, i8* %34
  br label %35

; <label>:35                                      ; preds = %32, %27
  br label %36

; <label>:36                                      ; preds = %35
  %37 = add i32 %j.0, %i.0
  br label %25

; <label>:38                                      ; preds = %25
  br label %39

; <label>:39                                      ; preds = %38, %17
  %count.0 = phi i32 [ %23, %38 ], [ %count.1, %17 ]
  br label %40

; <label>:40                                      ; preds = %39
  %41 = add i32 %i.0, 1
  br label %15

; <label>:42                                      ; preds = %15
  call void @free(i8* %3)
  %43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str, i32 0, i32 0), i32 %m, i32 %count.1)
  ret void
}

declare i8* @malloc(i64)

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

declare i8* @__memset_chk(i8*, i32, i64, i64) nounwind

define internal i8* @__inline_memset_chk(i8* %__dest, i32 %__val, i64 %__len) nounwind inlinehint ssp {
  %1 = call i64 @llvm.objectsize.i64(i8* %__dest, i1 false)
  %2 = call i8* @__memset_chk(i8* %__dest, i32 %__val, i64 %__len, i64 %1)
  ret i8* %2
}

declare void @free(i8*)

declare i32 @printf(i8*, ...)
