; ModuleID = 'spectral.c.m2r.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [7 x i8] c"%0.9f\0A\00"

define double @eval_A(i32 %i, i32 %j) nounwind ssp {
  %1 = add nsw i32 %i, %j
  %2 = add nsw i32 %i, %j
  %3 = add nsw i32 %2, 1
  %4 = mul nsw i32 %1, %3
  %5 = sdiv i32 %4, 2
  %6 = add nsw i32 %5, %i
  %7 = add nsw i32 %6, 1
  %8 = sitofp i32 %7 to double
  %9 = fdiv double 1.000000e+00, %8
  ret double %9
}

define void @eval_A_times_u(i32 %N, double* %u, double* %Au) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %21, %0
  %i.0 = phi i32 [ 0, %0 ], [ %22, %21 ]
  %2 = icmp slt i32 %i.0, %N
  br i1 %2, label %3, label %23

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds double* %Au, i64 %4
  store double 0.000000e+00, double* %5
  br label %6

; <label>:6                                       ; preds = %18, %3
  %j.0 = phi i32 [ 0, %3 ], [ %19, %18 ]
  %7 = icmp slt i32 %j.0, %N
  br i1 %7, label %8, label %20

; <label>:8                                       ; preds = %6
  %9 = call double @eval_A(i32 %i.0, i32 %j.0)
  %10 = sext i32 %j.0 to i64
  %11 = getelementptr inbounds double* %u, i64 %10
  %12 = load double* %11
  %13 = fmul double %9, %12
  %14 = sext i32 %i.0 to i64
  %15 = getelementptr inbounds double* %Au, i64 %14
  %16 = load double* %15
  %17 = fadd double %16, %13
  store double %17, double* %15
  br label %18

; <label>:18                                      ; preds = %8
  %19 = add nsw i32 %j.0, 1
  br label %6

; <label>:20                                      ; preds = %6
  br label %21

; <label>:21                                      ; preds = %20
  %22 = add nsw i32 %i.0, 1
  br label %1

; <label>:23                                      ; preds = %1
  ret void
}

define void @eval_At_times_u(i32 %N, double* %u, double* %Au) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %21, %0
  %i.0 = phi i32 [ 0, %0 ], [ %22, %21 ]
  %2 = icmp slt i32 %i.0, %N
  br i1 %2, label %3, label %23

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds double* %Au, i64 %4
  store double 0.000000e+00, double* %5
  br label %6

; <label>:6                                       ; preds = %18, %3
  %j.0 = phi i32 [ 0, %3 ], [ %19, %18 ]
  %7 = icmp slt i32 %j.0, %N
  br i1 %7, label %8, label %20

; <label>:8                                       ; preds = %6
  %9 = call double @eval_A(i32 %j.0, i32 %i.0)
  %10 = sext i32 %j.0 to i64
  %11 = getelementptr inbounds double* %u, i64 %10
  %12 = load double* %11
  %13 = fmul double %9, %12
  %14 = sext i32 %i.0 to i64
  %15 = getelementptr inbounds double* %Au, i64 %14
  %16 = load double* %15
  %17 = fadd double %16, %13
  store double %17, double* %15
  br label %18

; <label>:18                                      ; preds = %8
  %19 = add nsw i32 %j.0, 1
  br label %6

; <label>:20                                      ; preds = %6
  br label %21

; <label>:21                                      ; preds = %20
  %22 = add nsw i32 %i.0, 1
  br label %1

; <label>:23                                      ; preds = %1
  ret void
}

define void @eval_AtA_times_u(i32 %N, double* %u, double* %AtAu) nounwind ssp {
  %1 = sext i32 %N to i64
  %2 = mul i64 %1, 8
  %3 = call i8* @malloc(i64 %2)
  %4 = bitcast i8* %3 to double*
  call void @eval_A_times_u(i32 %N, double* %u, double* %4)
  call void @eval_At_times_u(i32 %N, double* %4, double* %AtAu)
  %5 = bitcast double* %4 to i8*
  call void @free(i8* %5)
  ret void
}

declare i8* @malloc(i64)

declare void @free(i8*)

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = icmp eq i32 %argc, 2
  br i1 %1, label %2, label %6

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds i8** %argv, i64 1
  %4 = load i8** %3
  %5 = call i32 @atoi(i8* %4)
  br label %7

; <label>:6                                       ; preds = %0
  br label %7

; <label>:7                                       ; preds = %6, %2
  %8 = phi i32 [ %5, %2 ], [ 2500, %6 ]
  %9 = sext i32 %8 to i64
  %10 = mul i64 %9, 8
  %11 = call i8* @malloc(i64 %10)
  %12 = bitcast i8* %11 to double*
  %13 = sext i32 %8 to i64
  %14 = mul i64 %13, 8
  %15 = call i8* @malloc(i64 %14)
  %16 = bitcast i8* %15 to double*
  br label %17

; <label>:17                                      ; preds = %22, %7
  %i.0 = phi i32 [ 0, %7 ], [ %23, %22 ]
  %18 = icmp slt i32 %i.0, %8
  br i1 %18, label %19, label %24

; <label>:19                                      ; preds = %17
  %20 = sext i32 %i.0 to i64
  %21 = getelementptr inbounds double* %12, i64 %20
  store double 1.000000e+00, double* %21
  br label %22

; <label>:22                                      ; preds = %19
  %23 = add nsw i32 %i.0, 1
  br label %17

; <label>:24                                      ; preds = %17
  br label %25

; <label>:25                                      ; preds = %28, %24
  %i.1 = phi i32 [ 0, %24 ], [ %29, %28 ]
  %26 = icmp slt i32 %i.1, 10
  br i1 %26, label %27, label %30

; <label>:27                                      ; preds = %25
  call void @eval_AtA_times_u(i32 %8, double* %12, double* %16)
  call void @eval_AtA_times_u(i32 %8, double* %16, double* %12)
  br label %28

; <label>:28                                      ; preds = %27
  %29 = add nsw i32 %i.1, 1
  br label %25

; <label>:30                                      ; preds = %25
  br label %31

; <label>:31                                      ; preds = %50, %30
  %i.2 = phi i32 [ 0, %30 ], [ %51, %50 ]
  %vBv.0 = phi double [ 0.000000e+00, %30 ], [ %41, %50 ]
  %vv.0 = phi double [ 0.000000e+00, %30 ], [ %49, %50 ]
  %32 = icmp slt i32 %i.2, %8
  br i1 %32, label %33, label %52

; <label>:33                                      ; preds = %31
  %34 = sext i32 %i.2 to i64
  %35 = getelementptr inbounds double* %12, i64 %34
  %36 = load double* %35
  %37 = sext i32 %i.2 to i64
  %38 = getelementptr inbounds double* %16, i64 %37
  %39 = load double* %38
  %40 = fmul double %36, %39
  %41 = fadd double %vBv.0, %40
  %42 = sext i32 %i.2 to i64
  %43 = getelementptr inbounds double* %16, i64 %42
  %44 = load double* %43
  %45 = sext i32 %i.2 to i64
  %46 = getelementptr inbounds double* %16, i64 %45
  %47 = load double* %46
  %48 = fmul double %44, %47
  %49 = fadd double %vv.0, %48
  br label %50

; <label>:50                                      ; preds = %33
  %51 = add nsw i32 %i.2, 1
  br label %31

; <label>:52                                      ; preds = %31
  %53 = fdiv double %vBv.0, %vv.0
  %54 = call double @sqrt(double %53)
  %55 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i32 0, i32 0), double %54)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)

declare double @sqrt(double) readnone
