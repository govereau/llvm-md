; ModuleID = 'fib.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [14 x i8] c"fib(%d) = %d\0A\00"

define i32 @fib(i32 %n) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %n, i32* %2, align 4
  %3 = load i32* %2, align 4
  %4 = icmp slt i32 %3, 2
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  store i32 1, i32* %1
  br label %14

; <label>:6                                       ; preds = %0
  %7 = load i32* %2, align 4
  %8 = sub nsw i32 %7, 1
  %9 = call i32 @fib(i32 %8)
  %10 = load i32* %2, align 4
  %11 = sub nsw i32 %10, 2
  %12 = call i32 @fib(i32 %11)
  %13 = add nsw i32 %9, %12
  store i32 %13, i32* %1
  br label %14

; <label>:14                                      ; preds = %6, %5
  %15 = load i32* %1
  ret i32 %15
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %n = alloca i32, align 4
  %r = alloca i32, align 4
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = load i32* %2, align 4
  %5 = icmp sge i32 %4, 2
  br i1 %5, label %6, label %11

; <label>:6                                       ; preds = %0
  %7 = load i8*** %3, align 8
  %8 = getelementptr inbounds i8** %7, i64 1
  %9 = load i8** %8
  %10 = call i32 @atoi(i8* %9)
  store i32 %10, i32* %n, align 4
  br label %12

; <label>:11                                      ; preds = %0
  store i32 36, i32* %n, align 4
  br label %12

; <label>:12                                      ; preds = %11, %6
  %13 = load i32* %n, align 4
  %14 = call i32 @fib(i32 %13)
  store i32 %14, i32* %r, align 4
  %15 = load i32* %n, align 4
  %16 = load i32* %r, align 4
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i32 0, i32 0), i32 %15, i32 %16)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)
