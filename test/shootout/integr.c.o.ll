; ModuleID = 'integr.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [35 x i8] c"integr(square, 0.0, 1.0, %d) = %g\0A\00"

define double @test(i32 %n) nounwind ssp {
  %1 = alloca i32, align 4
  store i32 %n, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call double @integr(double (double)* @square, double 0.000000e+00, double 1.000000e+00, i32 %2)
  ret double %3
}

define internal double @integr(double (double)* %f, double %low, double %high, i32 %n) nounwind ssp {
  %1 = alloca double (double)*, align 8
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  %4 = alloca i32, align 4
  %h = alloca double, align 8
  %x = alloca double, align 8
  %s = alloca double, align 8
  %i = alloca i32, align 4
  store double (double)* %f, double (double)** %1, align 8
  store double %low, double* %2, align 8
  store double %high, double* %3, align 8
  store i32 %n, i32* %4, align 4
  %5 = load double* %3, align 8
  %6 = load double* %2, align 8
  %7 = fsub double %5, %6
  %8 = load i32* %4, align 4
  %9 = sitofp i32 %8 to double
  %10 = fdiv double %7, %9
  store double %10, double* %h, align 8
  store double 0.000000e+00, double* %s, align 8
  %11 = load i32* %4, align 4
  store i32 %11, i32* %i, align 4
  %12 = load double* %2, align 8
  store double %12, double* %x, align 8
  br label %13

; <label>:13                                      ; preds = %22, %0
  %14 = load i32* %i, align 4
  %15 = icmp sgt i32 %14, 0
  br i1 %15, label %16, label %28

; <label>:16                                      ; preds = %13
  %17 = load double (double)** %1, align 8
  %18 = load double* %x, align 8
  %19 = call double %17(double %18)
  %20 = load double* %s, align 8
  %21 = fadd double %20, %19
  store double %21, double* %s, align 8
  br label %22

; <label>:22                                      ; preds = %16
  %23 = load i32* %i, align 4
  %24 = add nsw i32 %23, -1
  store i32 %24, i32* %i, align 4
  %25 = load double* %h, align 8
  %26 = load double* %x, align 8
  %27 = fadd double %26, %25
  store double %27, double* %x, align 8
  br label %13

; <label>:28                                      ; preds = %13
  %29 = load double* %s, align 8
  %30 = load double* %h, align 8
  %31 = fmul double %29, %30
  ret double %31
}

define internal double @square(double %x) nounwind ssp {
  %1 = alloca double, align 8
  store double %x, double* %1, align 8
  %2 = load double* %1, align 8
  %3 = load double* %1, align 8
  %4 = fmul double %2, %3
  ret double %4
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %n = alloca i32, align 4
  %r = alloca double, align 8
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
  store i32 100000000, i32* %n, align 4
  br label %12

; <label>:12                                      ; preds = %11, %6
  %13 = load i32* %n, align 4
  %14 = call double @test(i32 %13)
  store double %14, double* %r, align 8
  %15 = load i32* %n, align 4
  %16 = load double* %r, align 8
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([35 x i8]* @.str, i32 0, i32 0), i32 %15, double %16)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)
