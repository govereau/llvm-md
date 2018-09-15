; ModuleID = 'spectral.c.pipeline.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [7 x i8] c"%0.9f\0A\00"

define double @eval_A(i32 %i, i32 %j) nounwind ssp {
  %1 = add nsw i32 %i, %j
  %2 = add nsw i32 %1, 1
  %3 = mul nsw i32 %1, %2
  %4 = sdiv i32 %3, 2
  %5 = add nsw i32 %4, %i
  %6 = add nsw i32 %5, 1
  %7 = sitofp i32 %6 to double
  %8 = fdiv double 1.000000e+00, %7
  ret double %8
}

define void @eval_A_times_u(i32 %N, double* %u, double* %Au) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %17, %0
  %i.0 = phi i32 [ 0, %0 ], [ %18, %17 ]
  %2 = icmp slt i32 %i.0, %N
  br i1 %2, label %3, label %19

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds double* %Au, i64 %4
  store double 0.000000e+00, double* %5
  br label %6

; <label>:6                                       ; preds = %8, %3
  %j.0 = phi i32 [ 0, %3 ], [ %16, %8 ]
  %7 = icmp slt i32 %j.0, %N
  br i1 %7, label %8, label %17

; <label>:8                                       ; preds = %6
  %9 = call double @eval_A(i32 %i.0, i32 %j.0)
  %10 = sext i32 %j.0 to i64
  %11 = getelementptr inbounds double* %u, i64 %10
  %12 = load double* %11
  %13 = fmul double %9, %12
  %14 = load double* %5
  %15 = fadd double %14, %13
  store double %15, double* %5
  %16 = add nsw i32 %j.0, 1
  br label %6

; <label>:17                                      ; preds = %6
  %18 = add nsw i32 %i.0, 1
  br label %1

; <label>:19                                      ; preds = %1
  ret void
}

define void @eval_At_times_u(i32 %N, double* %u, double* %Au) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %17, %0
  %i.0 = phi i32 [ 0, %0 ], [ %18, %17 ]
  %2 = icmp slt i32 %i.0, %N
  br i1 %2, label %3, label %19

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds double* %Au, i64 %4
  store double 0.000000e+00, double* %5
  br label %6

; <label>:6                                       ; preds = %8, %3
  %j.0 = phi i32 [ 0, %3 ], [ %16, %8 ]
  %7 = icmp slt i32 %j.0, %N
  br i1 %7, label %8, label %17

; <label>:8                                       ; preds = %6
  %9 = call double @eval_A(i32 %j.0, i32 %i.0)
  %10 = sext i32 %j.0 to i64
  %11 = getelementptr inbounds double* %u, i64 %10
  %12 = load double* %11
  %13 = fmul double %9, %12
  %14 = load double* %5
  %15 = fadd double %14, %13
  store double %15, double* %5
  %16 = add nsw i32 %j.0, 1
  br label %6

; <label>:17                                      ; preds = %6
  %18 = add nsw i32 %i.0, 1
  br label %1

; <label>:19                                      ; preds = %1
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
  %13 = call i8* @malloc(i64 %10)
  %14 = bitcast i8* %13 to double*
  br label %15

; <label>:15                                      ; preds = %17, %7
  %i.0 = phi i32 [ 0, %7 ], [ %20, %17 ]
  %16 = icmp slt i32 %i.0, %8
  br i1 %16, label %17, label %21

; <label>:17                                      ; preds = %15
  %18 = sext i32 %i.0 to i64
  %19 = getelementptr inbounds double* %12, i64 %18
  store double 1.000000e+00, double* %19
  %20 = add nsw i32 %i.0, 1
  br label %15

; <label>:21                                      ; preds = %15
  br label %22

; <label>:22                                      ; preds = %24, %21
  %i.1 = phi i32 [ 0, %21 ], [ %25, %24 ]
  %23 = icmp slt i32 %i.1, 10
  br i1 %23, label %24, label %26

; <label>:24                                      ; preds = %22
  call void @eval_AtA_times_u(i32 %8, double* %12, double* %14)
  call void @eval_AtA_times_u(i32 %8, double* %14, double* %12)
  %25 = add nsw i32 %i.1, 1
  br label %22

; <label>:26                                      ; preds = %22
  br label %27

; <label>:27                                      ; preds = %29, %26
  %i.2 = phi i32 [ 0, %26 ], [ %39, %29 ]
  %vBv.0 = phi double [ 0.000000e+00, %26 ], [ %36, %29 ]
  %vv.0 = phi double [ 0.000000e+00, %26 ], [ %38, %29 ]
  %28 = icmp slt i32 %i.2, %8
  br i1 %28, label %29, label %40

; <label>:29                                      ; preds = %27
  %30 = sext i32 %i.2 to i64
  %31 = getelementptr inbounds double* %12, i64 %30
  %32 = load double* %31
  %33 = getelementptr inbounds double* %14, i64 %30
  %34 = load double* %33
  %35 = fmul double %32, %34
  %36 = fadd double %vBv.0, %35
  %37 = fmul double %34, %34
  %38 = fadd double %vv.0, %37
  %39 = add nsw i32 %i.2, 1
  br label %27

; <label>:40                                      ; preds = %27
  %vv.0.lcssa = phi double [ %vv.0, %27 ]
  %vBv.0.lcssa = phi double [ %vBv.0, %27 ]
  %41 = fdiv double %vBv.0.lcssa, %vv.0.lcssa
  %42 = call double @sqrt(double %41)
  %43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i32 0, i32 0), double %42)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)

declare double @sqrt(double) readnone
