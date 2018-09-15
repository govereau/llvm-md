; ModuleID = 'fib.c.m2r.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [14 x i8] c"fib(%d) = %d\0A\00"

define i32 @fib(i32 %n) nounwind ssp {
  %1 = icmp slt i32 %n, 2
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  br label %9

; <label>:3                                       ; preds = %0
  %4 = sub nsw i32 %n, 1
  %5 = call i32 @fib(i32 %4)
  %6 = sub nsw i32 %n, 2
  %7 = call i32 @fib(i32 %6)
  %8 = add nsw i32 %5, %7
  br label %9

; <label>:9                                       ; preds = %3, %2
  %.0 = phi i32 [ 1, %2 ], [ %8, %3 ]
  ret i32 %.0
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = icmp sge i32 %argc, 2
  br i1 %1, label %2, label %6

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds i8** %argv, i64 1
  %4 = load i8** %3
  %5 = call i32 @atoi(i8* %4)
  br label %7

; <label>:6                                       ; preds = %0
  br label %7

; <label>:7                                       ; preds = %6, %2
  %n.0 = phi i32 [ %5, %2 ], [ 36, %6 ]
  %8 = call i32 @fib(i32 %n.0)
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i32 0, i32 0), i32 %n.0, i32 %8)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)
