; ModuleID = 'integr.c.m2r.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [35 x i8] c"integr(square, 0.0, 1.0, %d) = %g\0A\00"

define double @test(i32 %n) nounwind ssp {
  %1 = call double @integr(double (double)* @square, double 0.000000e+00, double 1.000000e+00, i32 %n)
  ret double %1
}

define internal double @integr(double (double)* %f, double %low, double %high, i32 %n) nounwind ssp {
; <label>:0
  %1 = fsub double %high, %low
  %2 = sitofp i32 %n to double
  %3 = fdiv double %1, %2
  br label %4

; <label>:4                                       ; preds = %9, %0
  %x.0 = phi double [ %low, %0 ], [ %11, %9 ]
  %s.0 = phi double [ 0.000000e+00, %0 ], [ %8, %9 ]
  %i.0 = phi i32 [ %n, %0 ], [ %10, %9 ]
  %5 = icmp sgt i32 %i.0, 0
  br i1 %5, label %6, label %12

; <label>:6                                       ; preds = %4
  %7 = call double %f(double %x.0)
  %8 = fadd double %s.0, %7
  br label %9

; <label>:9                                       ; preds = %6
  %10 = add nsw i32 %i.0, -1
  %11 = fadd double %x.0, %3
  br label %4

; <label>:12                                      ; preds = %4
  %13 = fmul double %s.0, %3
  ret double %13
}

define internal double @square(double %x) nounwind ssp {
  %1 = fmul double %x, %x
  ret double %1
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
  %n.0 = phi i32 [ %5, %2 ], [ 100000000, %6 ]
  %8 = call double @test(i32 %n.0)
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str, i32 0, i32 0), i32 %n.0, double %8)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)
