; ModuleID = 'nsieve.c.pipeline.o'
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

; <label>:9                                       ; preds = %11, %7
  %i.0 = phi i32 [ 0, %7 ], [ %14, %11 ]
  %10 = icmp slt i32 %i.0, 3
  br i1 %10, label %11, label %15

; <label>:11                                      ; preds = %9
  %12 = sub nsw i32 %8, %i.0
  %13 = shl i32 10000, %12
  call void @nsieve(i32 %13)
  %14 = add nsw i32 %i.0, 1
  br label %9

; <label>:15                                      ; preds = %9
  ret i32 0
}

declare i32 @atoi(i8*)

define internal void @nsieve(i32 %m) nounwind ssp {
  %1 = sext i32 %m to i64
  %2 = mul i64 %1, 1
  %3 = call i8* @malloc(i64 %2)
  %4 = call i64 @llvm.objectsize.i64(i8* %3, i1 false)
  %5 = icmp ne i64 %4, -1
  br i1 %5, label %6, label %8

; <label>:6                                       ; preds = %0
  %7 = call i8* @__memset_chk(i8* %3, i32 1, i64 %1, i64 %4)
  br label %10

; <label>:8                                       ; preds = %0
  %9 = call i8* @__inline_memset_chk(i8* %3, i32 1, i64 %1)
  br label %10

; <label>:10                                      ; preds = %8, %6
  br label %11

; <label>:11                                      ; preds = %32, %10
  %i.0 = phi i32 [ 2, %10 ], [ %33, %32 ]
  %count.1 = phi i32 [ 0, %10 ], [ %count.0, %32 ]
  %12 = icmp ult i32 %i.0, %m
  br i1 %12, label %13, label %34

; <label>:13                                      ; preds = %11
  %14 = zext i32 %i.0 to i64
  %15 = getelementptr inbounds i8* %3, i64 %14
  %16 = load i8* %15
  %17 = icmp ne i8 %16, 0
  br i1 %17, label %18, label %32

; <label>:18                                      ; preds = %13
  %19 = add i32 %count.1, 1
  %20 = shl i32 %i.0, 1
  br label %21

; <label>:21                                      ; preds = %29, %18
  %j.0 = phi i32 [ %20, %18 ], [ %30, %29 ]
  %22 = icmp ult i32 %j.0, %m
  br i1 %22, label %23, label %31

; <label>:23                                      ; preds = %21
  %24 = zext i32 %j.0 to i64
  %25 = getelementptr inbounds i8* %3, i64 %24
  %26 = load i8* %25
  %27 = icmp ne i8 %26, 0
  br i1 %27, label %28, label %29

; <label>:28                                      ; preds = %23
  store i8 0, i8* %25
  br label %29

; <label>:29                                      ; preds = %28, %23
  %30 = add i32 %j.0, %i.0
  br label %21

; <label>:31                                      ; preds = %21
  br label %32

; <label>:32                                      ; preds = %31, %13
  %count.0 = phi i32 [ %19, %31 ], [ %count.1, %13 ]
  %33 = add i32 %i.0, 1
  br label %11

; <label>:34                                      ; preds = %11
  %count.1.lcssa = phi i32 [ %count.1, %11 ]
  call void @free(i8* %3)
  %35 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str, i32 0, i32 0), i32 %m, i32 %count.1.lcssa)
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
