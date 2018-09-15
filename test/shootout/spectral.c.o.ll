; ModuleID = 'spectral.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [7 x i8] c"%0.9f\0A\00"

define double @eval_A(i32 %i, i32 %j) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  store i32 %i, i32* %1, align 4
  store i32 %j, i32* %2, align 4
  %3 = load i32* %1, align 4
  %4 = load i32* %2, align 4
  %5 = add nsw i32 %3, %4
  %6 = load i32* %1, align 4
  %7 = load i32* %2, align 4
  %8 = add nsw i32 %6, %7
  %9 = add nsw i32 %8, 1
  %10 = mul nsw i32 %5, %9
  %11 = sdiv i32 %10, 2
  %12 = load i32* %1, align 4
  %13 = add nsw i32 %11, %12
  %14 = add nsw i32 %13, 1
  %15 = sitofp i32 %14 to double
  %16 = fdiv double 1.000000e+00, %15
  ret double %16
}

define void @eval_A_times_u(i32 %N, double* %u, double* %Au) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca double*, align 8
  %3 = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %N, i32* %1, align 4
  store double* %u, double** %2, align 8
  store double* %Au, double** %3, align 8
  store i32 0, i32* %i, align 4
  br label %4

; <label>:4                                       ; preds = %37, %0
  %5 = load i32* %i, align 4
  %6 = load i32* %1, align 4
  %7 = icmp slt i32 %5, %6
  br i1 %7, label %8, label %40

; <label>:8                                       ; preds = %4
  %9 = load i32* %i, align 4
  %10 = sext i32 %9 to i64
  %11 = load double** %3, align 8
  %12 = getelementptr inbounds double* %11, i64 %10
  store double 0.000000e+00, double* %12
  store i32 0, i32* %j, align 4
  br label %13

; <label>:13                                      ; preds = %33, %8
  %14 = load i32* %j, align 4
  %15 = load i32* %1, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %36

; <label>:17                                      ; preds = %13
  %18 = load i32* %i, align 4
  %19 = load i32* %j, align 4
  %20 = call double @eval_A(i32 %18, i32 %19)
  %21 = load i32* %j, align 4
  %22 = sext i32 %21 to i64
  %23 = load double** %2, align 8
  %24 = getelementptr inbounds double* %23, i64 %22
  %25 = load double* %24
  %26 = fmul double %20, %25
  %27 = load i32* %i, align 4
  %28 = sext i32 %27 to i64
  %29 = load double** %3, align 8
  %30 = getelementptr inbounds double* %29, i64 %28
  %31 = load double* %30
  %32 = fadd double %31, %26
  store double %32, double* %30
  br label %33

; <label>:33                                      ; preds = %17
  %34 = load i32* %j, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, i32* %j, align 4
  br label %13

; <label>:36                                      ; preds = %13
  br label %37

; <label>:37                                      ; preds = %36
  %38 = load i32* %i, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, i32* %i, align 4
  br label %4

; <label>:40                                      ; preds = %4
  ret void
}

define void @eval_At_times_u(i32 %N, double* %u, double* %Au) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca double*, align 8
  %3 = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %N, i32* %1, align 4
  store double* %u, double** %2, align 8
  store double* %Au, double** %3, align 8
  store i32 0, i32* %i, align 4
  br label %4

; <label>:4                                       ; preds = %37, %0
  %5 = load i32* %i, align 4
  %6 = load i32* %1, align 4
  %7 = icmp slt i32 %5, %6
  br i1 %7, label %8, label %40

; <label>:8                                       ; preds = %4
  %9 = load i32* %i, align 4
  %10 = sext i32 %9 to i64
  %11 = load double** %3, align 8
  %12 = getelementptr inbounds double* %11, i64 %10
  store double 0.000000e+00, double* %12
  store i32 0, i32* %j, align 4
  br label %13

; <label>:13                                      ; preds = %33, %8
  %14 = load i32* %j, align 4
  %15 = load i32* %1, align 4
  %16 = icmp slt i32 %14, %15
  br i1 %16, label %17, label %36

; <label>:17                                      ; preds = %13
  %18 = load i32* %j, align 4
  %19 = load i32* %i, align 4
  %20 = call double @eval_A(i32 %18, i32 %19)
  %21 = load i32* %j, align 4
  %22 = sext i32 %21 to i64
  %23 = load double** %2, align 8
  %24 = getelementptr inbounds double* %23, i64 %22
  %25 = load double* %24
  %26 = fmul double %20, %25
  %27 = load i32* %i, align 4
  %28 = sext i32 %27 to i64
  %29 = load double** %3, align 8
  %30 = getelementptr inbounds double* %29, i64 %28
  %31 = load double* %30
  %32 = fadd double %31, %26
  store double %32, double* %30
  br label %33

; <label>:33                                      ; preds = %17
  %34 = load i32* %j, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, i32* %j, align 4
  br label %13

; <label>:36                                      ; preds = %13
  br label %37

; <label>:37                                      ; preds = %36
  %38 = load i32* %i, align 4
  %39 = add nsw i32 %38, 1
  store i32 %39, i32* %i, align 4
  br label %4

; <label>:40                                      ; preds = %4
  ret void
}

define void @eval_AtA_times_u(i32 %N, double* %u, double* %AtAu) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca double*, align 8
  %3 = alloca double*, align 8
  %v = alloca double*, align 8
  store i32 %N, i32* %1, align 4
  store double* %u, double** %2, align 8
  store double* %AtAu, double** %3, align 8
  %4 = load i32* %1, align 4
  %5 = sext i32 %4 to i64
  %6 = mul i64 %5, 8
  %7 = call i8* @malloc(i64 %6)
  %8 = bitcast i8* %7 to double*
  store double* %8, double** %v, align 8
  %9 = load i32* %1, align 4
  %10 = load double** %2, align 8
  %11 = load double** %v, align 8
  call void @eval_A_times_u(i32 %9, double* %10, double* %11)
  %12 = load i32* %1, align 4
  %13 = load double** %v, align 8
  %14 = load double** %3, align 8
  call void @eval_At_times_u(i32 %12, double* %13, double* %14)
  %15 = load double** %v, align 8
  %16 = bitcast double* %15 to i8*
  call void @free(i8* %16)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %i = alloca i32, align 4
  %N = alloca i32, align 4
  %u = alloca double*, align 8
  %v = alloca double*, align 8
  %vBv = alloca double, align 8
  %vv = alloca double, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = load i32* %2, align 4
  %5 = icmp eq i32 %4, 2
  br i1 %5, label %6, label %11

; <label>:6                                       ; preds = %0
  %7 = load i8*** %3, align 8
  %8 = getelementptr inbounds i8** %7, i64 1
  %9 = load i8** %8
  %10 = call i32 @atoi(i8* %9)
  br label %12

; <label>:11                                      ; preds = %0
  br label %12

; <label>:12                                      ; preds = %11, %6
  %13 = phi i32 [ %10, %6 ], [ 2500, %11 ]
  store i32 %13, i32* %N, align 4
  %14 = load i32* %N, align 4
  %15 = sext i32 %14 to i64
  %16 = mul i64 %15, 8
  %17 = call i8* @malloc(i64 %16)
  %18 = bitcast i8* %17 to double*
  store double* %18, double** %u, align 8
  %19 = load i32* %N, align 4
  %20 = sext i32 %19 to i64
  %21 = mul i64 %20, 8
  %22 = call i8* @malloc(i64 %21)
  %23 = bitcast i8* %22 to double*
  store double* %23, double** %v, align 8
  store i32 0, i32* %i, align 4
  br label %24

; <label>:24                                      ; preds = %33, %12
  %25 = load i32* %i, align 4
  %26 = load i32* %N, align 4
  %27 = icmp slt i32 %25, %26
  br i1 %27, label %28, label %36

; <label>:28                                      ; preds = %24
  %29 = load i32* %i, align 4
  %30 = sext i32 %29 to i64
  %31 = load double** %u, align 8
  %32 = getelementptr inbounds double* %31, i64 %30
  store double 1.000000e+00, double* %32
  br label %33

; <label>:33                                      ; preds = %28
  %34 = load i32* %i, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, i32* %i, align 4
  br label %24

; <label>:36                                      ; preds = %24
  store i32 0, i32* %i, align 4
  br label %37

; <label>:37                                      ; preds = %47, %36
  %38 = load i32* %i, align 4
  %39 = icmp slt i32 %38, 10
  br i1 %39, label %40, label %50

; <label>:40                                      ; preds = %37
  %41 = load i32* %N, align 4
  %42 = load double** %u, align 8
  %43 = load double** %v, align 8
  call void @eval_AtA_times_u(i32 %41, double* %42, double* %43)
  %44 = load i32* %N, align 4
  %45 = load double** %v, align 8
  %46 = load double** %u, align 8
  call void @eval_AtA_times_u(i32 %44, double* %45, double* %46)
  br label %47

; <label>:47                                      ; preds = %40
  %48 = load i32* %i, align 4
  %49 = add nsw i32 %48, 1
  store i32 %49, i32* %i, align 4
  br label %37

; <label>:50                                      ; preds = %37
  store double 0.000000e+00, double* %vv, align 8
  store double 0.000000e+00, double* %vBv, align 8
  store i32 0, i32* %i, align 4
  br label %51

; <label>:51                                      ; preds = %82, %50
  %52 = load i32* %i, align 4
  %53 = load i32* %N, align 4
  %54 = icmp slt i32 %52, %53
  br i1 %54, label %55, label %85

; <label>:55                                      ; preds = %51
  %56 = load i32* %i, align 4
  %57 = sext i32 %56 to i64
  %58 = load double** %u, align 8
  %59 = getelementptr inbounds double* %58, i64 %57
  %60 = load double* %59
  %61 = load i32* %i, align 4
  %62 = sext i32 %61 to i64
  %63 = load double** %v, align 8
  %64 = getelementptr inbounds double* %63, i64 %62
  %65 = load double* %64
  %66 = fmul double %60, %65
  %67 = load double* %vBv, align 8
  %68 = fadd double %67, %66
  store double %68, double* %vBv, align 8
  %69 = load i32* %i, align 4
  %70 = sext i32 %69 to i64
  %71 = load double** %v, align 8
  %72 = getelementptr inbounds double* %71, i64 %70
  %73 = load double* %72
  %74 = load i32* %i, align 4
  %75 = sext i32 %74 to i64
  %76 = load double** %v, align 8
  %77 = getelementptr inbounds double* %76, i64 %75
  %78 = load double* %77
  %79 = fmul double %73, %78
  %80 = load double* %vv, align 8
  %81 = fadd double %80, %79
  store double %81, double* %vv, align 8
  br label %82

; <label>:82                                      ; preds = %55
  %83 = load i32* %i, align 4
  %84 = add nsw i32 %83, 1
  store i32 %84, i32* %i, align 4
  br label %51

; <label>:85                                      ; preds = %51
  %86 = load double* %vBv, align 8
  %87 = load double* %vv, align 8
  %88 = fdiv double %86, %87
  %89 = call double @sqrt(double %88)
  %90 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i32 0, i32 0), double %89)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)

declare double @sqrt(double) readnone
