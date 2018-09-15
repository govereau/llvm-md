; ModuleID = 'nbody.c.m2r.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.planet = type { double, double, double, double, double, double, double }

@bodies = global [5 x %struct.planet] [%struct.planet { double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 1.000000e+00 }, %struct.planet { double 0x40135DA0343CD92C, double 0xBFF290ABC01FDB7C, double 0xBFBA86F96C25EBF0, double 0x3F5B32DDB8EC9209, double 0x3F7F88FF93F670B6, double 0xBF12199946DEBD80, double 0x3F4F49601333C135 }, %struct.planet { double 0x4020AFCDC332CA67, double 0x40107FCB31DE01B0, double 0xBFD9D353E1EB467C, double 0xBF66ABB60A8E1D76, double 0x3F747956257578B8, double 0x3EF829379CAD4AC0, double 0x3F32BC5EEFF5E6F8 }, %struct.planet { double 0x4029C9EACEA7D9CF, double 0xC02E38E8D626667E, double 0xBFCC9557BE257DA0, double 0x3F6849383E87D954, double 0x3F637C044AC0ACE1, double 0xBEFF1983FEDBFAA0, double 0x3F06E44607A13BD6 }, %struct.planet { double 0x402EC267A905572A, double 0xC039EB5833C8A220, double 0x3FC6F1F393ABE540, double 0x3F65F5C9E51B4320, double 0x3F5AAD5736999D88, double 0xBF18F2070B7F9750, double 0x3F0B0213CA2D0EEC }], align 16
@.str = private constant [6 x i8] c"%.9f\0A\00"

define void @advance(i32 %nbodies, %struct.planet* %bodies, double %dt) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %81, %0
  %i.0 = phi i32 [ 0, %0 ], [ %82, %81 ]
  %2 = icmp slt i32 %i.0, %nbodies
  br i1 %2, label %3, label %83

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds %struct.planet* %bodies, i64 %4
  %6 = add nsw i32 %i.0, 1
  br label %7

; <label>:7                                       ; preds = %78, %3
  %j.0 = phi i32 [ %6, %3 ], [ %79, %78 ]
  %8 = icmp slt i32 %j.0, %nbodies
  br i1 %8, label %9, label %80

; <label>:9                                       ; preds = %7
  %10 = sext i32 %j.0 to i64
  %11 = getelementptr inbounds %struct.planet* %bodies, i64 %10
  %12 = getelementptr inbounds %struct.planet* %5, i32 0, i32 0
  %13 = load double* %12, align 8
  %14 = getelementptr inbounds %struct.planet* %11, i32 0, i32 0
  %15 = load double* %14, align 8
  %16 = fsub double %13, %15
  %17 = getelementptr inbounds %struct.planet* %5, i32 0, i32 1
  %18 = load double* %17, align 8
  %19 = getelementptr inbounds %struct.planet* %11, i32 0, i32 1
  %20 = load double* %19, align 8
  %21 = fsub double %18, %20
  %22 = getelementptr inbounds %struct.planet* %5, i32 0, i32 2
  %23 = load double* %22, align 8
  %24 = getelementptr inbounds %struct.planet* %11, i32 0, i32 2
  %25 = load double* %24, align 8
  %26 = fsub double %23, %25
  %27 = fmul double %16, %16
  %28 = fmul double %21, %21
  %29 = fadd double %27, %28
  %30 = fmul double %26, %26
  %31 = fadd double %29, %30
  %32 = call double @sqrt(double %31)
  %33 = fmul double %32, %32
  %34 = fmul double %33, %32
  %35 = fdiv double %dt, %34
  %36 = getelementptr inbounds %struct.planet* %11, i32 0, i32 6
  %37 = load double* %36, align 8
  %38 = fmul double %16, %37
  %39 = fmul double %38, %35
  %40 = getelementptr inbounds %struct.planet* %5, i32 0, i32 3
  %41 = load double* %40, align 8
  %42 = fsub double %41, %39
  store double %42, double* %40, align 8
  %43 = getelementptr inbounds %struct.planet* %11, i32 0, i32 6
  %44 = load double* %43, align 8
  %45 = fmul double %21, %44
  %46 = fmul double %45, %35
  %47 = getelementptr inbounds %struct.planet* %5, i32 0, i32 4
  %48 = load double* %47, align 8
  %49 = fsub double %48, %46
  store double %49, double* %47, align 8
  %50 = getelementptr inbounds %struct.planet* %11, i32 0, i32 6
  %51 = load double* %50, align 8
  %52 = fmul double %26, %51
  %53 = fmul double %52, %35
  %54 = getelementptr inbounds %struct.planet* %5, i32 0, i32 5
  %55 = load double* %54, align 8
  %56 = fsub double %55, %53
  store double %56, double* %54, align 8
  %57 = getelementptr inbounds %struct.planet* %5, i32 0, i32 6
  %58 = load double* %57, align 8
  %59 = fmul double %16, %58
  %60 = fmul double %59, %35
  %61 = getelementptr inbounds %struct.planet* %11, i32 0, i32 3
  %62 = load double* %61, align 8
  %63 = fadd double %62, %60
  store double %63, double* %61, align 8
  %64 = getelementptr inbounds %struct.planet* %5, i32 0, i32 6
  %65 = load double* %64, align 8
  %66 = fmul double %21, %65
  %67 = fmul double %66, %35
  %68 = getelementptr inbounds %struct.planet* %11, i32 0, i32 4
  %69 = load double* %68, align 8
  %70 = fadd double %69, %67
  store double %70, double* %68, align 8
  %71 = getelementptr inbounds %struct.planet* %5, i32 0, i32 6
  %72 = load double* %71, align 8
  %73 = fmul double %26, %72
  %74 = fmul double %73, %35
  %75 = getelementptr inbounds %struct.planet* %11, i32 0, i32 5
  %76 = load double* %75, align 8
  %77 = fadd double %76, %74
  store double %77, double* %75, align 8
  br label %78

; <label>:78                                      ; preds = %9
  %79 = add nsw i32 %j.0, 1
  br label %7

; <label>:80                                      ; preds = %7
  br label %81

; <label>:81                                      ; preds = %80
  %82 = add nsw i32 %i.0, 1
  br label %1

; <label>:83                                      ; preds = %1
  br label %84

; <label>:84                                      ; preds = %107, %83
  %i.1 = phi i32 [ 0, %83 ], [ %108, %107 ]
  %85 = icmp slt i32 %i.1, %nbodies
  br i1 %85, label %86, label %109

; <label>:86                                      ; preds = %84
  %87 = sext i32 %i.1 to i64
  %88 = getelementptr inbounds %struct.planet* %bodies, i64 %87
  %89 = getelementptr inbounds %struct.planet* %88, i32 0, i32 3
  %90 = load double* %89, align 8
  %91 = fmul double %dt, %90
  %92 = getelementptr inbounds %struct.planet* %88, i32 0, i32 0
  %93 = load double* %92, align 8
  %94 = fadd double %93, %91
  store double %94, double* %92, align 8
  %95 = getelementptr inbounds %struct.planet* %88, i32 0, i32 4
  %96 = load double* %95, align 8
  %97 = fmul double %dt, %96
  %98 = getelementptr inbounds %struct.planet* %88, i32 0, i32 1
  %99 = load double* %98, align 8
  %100 = fadd double %99, %97
  store double %100, double* %98, align 8
  %101 = getelementptr inbounds %struct.planet* %88, i32 0, i32 5
  %102 = load double* %101, align 8
  %103 = fmul double %dt, %102
  %104 = getelementptr inbounds %struct.planet* %88, i32 0, i32 2
  %105 = load double* %104, align 8
  %106 = fadd double %105, %103
  store double %106, double* %104, align 8
  br label %107

; <label>:107                                     ; preds = %86
  %108 = add nsw i32 %i.1, 1
  br label %84

; <label>:109                                     ; preds = %84
  ret void
}

declare double @sqrt(double) readnone

define double @energy(i32 %nbodies, %struct.planet* %bodies) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %65, %0
  %e.0 = phi double [ 0.000000e+00, %0 ], [ %e.1, %65 ]
  %i.0 = phi i32 [ 0, %0 ], [ %66, %65 ]
  %2 = icmp slt i32 %i.0, %nbodies
  br i1 %2, label %3, label %67

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds %struct.planet* %bodies, i64 %4
  %6 = getelementptr inbounds %struct.planet* %5, i32 0, i32 6
  %7 = load double* %6, align 8
  %8 = fmul double 5.000000e-01, %7
  %9 = getelementptr inbounds %struct.planet* %5, i32 0, i32 3
  %10 = load double* %9, align 8
  %11 = getelementptr inbounds %struct.planet* %5, i32 0, i32 3
  %12 = load double* %11, align 8
  %13 = fmul double %10, %12
  %14 = getelementptr inbounds %struct.planet* %5, i32 0, i32 4
  %15 = load double* %14, align 8
  %16 = getelementptr inbounds %struct.planet* %5, i32 0, i32 4
  %17 = load double* %16, align 8
  %18 = fmul double %15, %17
  %19 = fadd double %13, %18
  %20 = getelementptr inbounds %struct.planet* %5, i32 0, i32 5
  %21 = load double* %20, align 8
  %22 = getelementptr inbounds %struct.planet* %5, i32 0, i32 5
  %23 = load double* %22, align 8
  %24 = fmul double %21, %23
  %25 = fadd double %19, %24
  %26 = fmul double %8, %25
  %27 = fadd double %e.0, %26
  %28 = add nsw i32 %i.0, 1
  br label %29

; <label>:29                                      ; preds = %62, %3
  %e.1 = phi double [ %27, %3 ], [ %61, %62 ]
  %j.0 = phi i32 [ %28, %3 ], [ %63, %62 ]
  %30 = icmp slt i32 %j.0, %nbodies
  br i1 %30, label %31, label %64

; <label>:31                                      ; preds = %29
  %32 = sext i32 %j.0 to i64
  %33 = getelementptr inbounds %struct.planet* %bodies, i64 %32
  %34 = getelementptr inbounds %struct.planet* %5, i32 0, i32 0
  %35 = load double* %34, align 8
  %36 = getelementptr inbounds %struct.planet* %33, i32 0, i32 0
  %37 = load double* %36, align 8
  %38 = fsub double %35, %37
  %39 = getelementptr inbounds %struct.planet* %5, i32 0, i32 1
  %40 = load double* %39, align 8
  %41 = getelementptr inbounds %struct.planet* %33, i32 0, i32 1
  %42 = load double* %41, align 8
  %43 = fsub double %40, %42
  %44 = getelementptr inbounds %struct.planet* %5, i32 0, i32 2
  %45 = load double* %44, align 8
  %46 = getelementptr inbounds %struct.planet* %33, i32 0, i32 2
  %47 = load double* %46, align 8
  %48 = fsub double %45, %47
  %49 = fmul double %38, %38
  %50 = fmul double %43, %43
  %51 = fadd double %49, %50
  %52 = fmul double %48, %48
  %53 = fadd double %51, %52
  %54 = call double @sqrt(double %53)
  %55 = getelementptr inbounds %struct.planet* %5, i32 0, i32 6
  %56 = load double* %55, align 8
  %57 = getelementptr inbounds %struct.planet* %33, i32 0, i32 6
  %58 = load double* %57, align 8
  %59 = fmul double %56, %58
  %60 = fdiv double %59, %54
  %61 = fsub double %e.1, %60
  br label %62

; <label>:62                                      ; preds = %31
  %63 = add nsw i32 %j.0, 1
  br label %29

; <label>:64                                      ; preds = %29
  br label %65

; <label>:65                                      ; preds = %64
  %66 = add nsw i32 %i.0, 1
  br label %1

; <label>:67                                      ; preds = %1
  ret double %e.0
}

define void @offset_momentum(i32 %nbodies, %struct.planet* %bodies) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %34, %0
  %py.0 = phi double [ 0.000000e+00, %0 ], [ %23, %34 ]
  %px.0 = phi double [ 0.000000e+00, %0 ], [ %13, %34 ]
  %pz.0 = phi double [ 0.000000e+00, %0 ], [ %33, %34 ]
  %i.0 = phi i32 [ 0, %0 ], [ %35, %34 ]
  %2 = icmp slt i32 %i.0, %nbodies
  br i1 %2, label %3, label %36

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds %struct.planet* %bodies, i64 %4
  %6 = getelementptr inbounds %struct.planet* %5, i32 0, i32 3
  %7 = load double* %6, align 8
  %8 = sext i32 %i.0 to i64
  %9 = getelementptr inbounds %struct.planet* %bodies, i64 %8
  %10 = getelementptr inbounds %struct.planet* %9, i32 0, i32 6
  %11 = load double* %10, align 8
  %12 = fmul double %7, %11
  %13 = fadd double %px.0, %12
  %14 = sext i32 %i.0 to i64
  %15 = getelementptr inbounds %struct.planet* %bodies, i64 %14
  %16 = getelementptr inbounds %struct.planet* %15, i32 0, i32 4
  %17 = load double* %16, align 8
  %18 = sext i32 %i.0 to i64
  %19 = getelementptr inbounds %struct.planet* %bodies, i64 %18
  %20 = getelementptr inbounds %struct.planet* %19, i32 0, i32 6
  %21 = load double* %20, align 8
  %22 = fmul double %17, %21
  %23 = fadd double %py.0, %22
  %24 = sext i32 %i.0 to i64
  %25 = getelementptr inbounds %struct.planet* %bodies, i64 %24
  %26 = getelementptr inbounds %struct.planet* %25, i32 0, i32 5
  %27 = load double* %26, align 8
  %28 = sext i32 %i.0 to i64
  %29 = getelementptr inbounds %struct.planet* %bodies, i64 %28
  %30 = getelementptr inbounds %struct.planet* %29, i32 0, i32 6
  %31 = load double* %30, align 8
  %32 = fmul double %27, %31
  %33 = fadd double %pz.0, %32
  br label %34

; <label>:34                                      ; preds = %3
  %35 = add nsw i32 %i.0, 1
  br label %1

; <label>:36                                      ; preds = %1
  %37 = fsub double -0.000000e+00, %px.0
  %38 = fdiv double %37, 0x4043BD3CC9BE45DE
  %39 = getelementptr inbounds %struct.planet* %bodies, i64 0
  %40 = getelementptr inbounds %struct.planet* %39, i32 0, i32 3
  store double %38, double* %40, align 8
  %41 = fsub double -0.000000e+00, %py.0
  %42 = fdiv double %41, 0x4043BD3CC9BE45DE
  %43 = getelementptr inbounds %struct.planet* %bodies, i64 0
  %44 = getelementptr inbounds %struct.planet* %43, i32 0, i32 4
  store double %42, double* %44, align 8
  %45 = fsub double -0.000000e+00, %pz.0
  %46 = fdiv double %45, 0x4043BD3CC9BE45DE
  %47 = getelementptr inbounds %struct.planet* %bodies, i64 0
  %48 = getelementptr inbounds %struct.planet* %47, i32 0, i32 5
  store double %46, double* %48, align 8
  ret void
}

define void @setup_bodies() nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %24, %0
  %i.0 = phi i32 [ 0, %0 ], [ %25, %24 ]
  %2 = icmp slt i32 %i.0, 5
  br i1 %2, label %3, label %26

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds [5 x %struct.planet]* @bodies, i32 0, i64 %4
  %6 = getelementptr inbounds %struct.planet* %5, i32 0, i32 3
  %7 = load double* %6, align 8
  %8 = fmul double %7, 3.652400e+02
  store double %8, double* %6, align 8
  %9 = sext i32 %i.0 to i64
  %10 = getelementptr inbounds [5 x %struct.planet]* @bodies, i32 0, i64 %9
  %11 = getelementptr inbounds %struct.planet* %10, i32 0, i32 4
  %12 = load double* %11, align 8
  %13 = fmul double %12, 3.652400e+02
  store double %13, double* %11, align 8
  %14 = sext i32 %i.0 to i64
  %15 = getelementptr inbounds [5 x %struct.planet]* @bodies, i32 0, i64 %14
  %16 = getelementptr inbounds %struct.planet* %15, i32 0, i32 5
  %17 = load double* %16, align 8
  %18 = fmul double %17, 3.652400e+02
  store double %18, double* %16, align 8
  %19 = sext i32 %i.0 to i64
  %20 = getelementptr inbounds [5 x %struct.planet]* @bodies, i32 0, i64 %19
  %21 = getelementptr inbounds %struct.planet* %20, i32 0, i32 6
  %22 = load double* %21, align 8
  %23 = fmul double %22, 0x4043BD3CC9BE45DE
  store double %23, double* %21, align 8
  br label %24

; <label>:24                                      ; preds = %3
  %25 = add nsw i32 %i.0, 1
  br label %1

; <label>:26                                      ; preds = %1
  ret void
}

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
  %8 = phi i32 [ 20000000, %2 ], [ %6, %3 ]
  call void @setup_bodies()
  call void @offset_momentum(i32 5, %struct.planet* getelementptr inbounds ([5 x %struct.planet]* @bodies, i32 0, i32 0))
  %9 = call double @energy(i32 5, %struct.planet* getelementptr inbounds ([5 x %struct.planet]* @bodies, i32 0, i32 0))
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0), double %9)
  br label %11

; <label>:11                                      ; preds = %14, %7
  %i.0 = phi i32 [ 1, %7 ], [ %15, %14 ]
  %12 = icmp sle i32 %i.0, %8
  br i1 %12, label %13, label %16

; <label>:13                                      ; preds = %11
  call void @advance(i32 5, %struct.planet* getelementptr inbounds ([5 x %struct.planet]* @bodies, i32 0, i32 0), double 1.000000e-02)
  br label %14

; <label>:14                                      ; preds = %13
  %15 = add nsw i32 %i.0, 1
  br label %11

; <label>:16                                      ; preds = %11
  %17 = call double @energy(i32 5, %struct.planet* getelementptr inbounds ([5 x %struct.planet]* @bodies, i32 0, i32 0))
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0), double %17)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)
