; ModuleID = 'nbody.c.pipeline.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.planet = type { double, double, double, double, double, double, double }

@bodies = global [5 x %struct.planet] [%struct.planet { double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 0.000000e+00, double 1.000000e+00 }, %struct.planet { double 0x40135DA0343CD92C, double 0xBFF290ABC01FDB7C, double 0xBFBA86F96C25EBF0, double 0x3F5B32DDB8EC9209, double 0x3F7F88FF93F670B6, double 0xBF12199946DEBD80, double 0x3F4F49601333C135 }, %struct.planet { double 0x4020AFCDC332CA67, double 0x40107FCB31DE01B0, double 0xBFD9D353E1EB467C, double 0xBF66ABB60A8E1D76, double 0x3F747956257578B8, double 0x3EF829379CAD4AC0, double 0x3F32BC5EEFF5E6F8 }, %struct.planet { double 0x4029C9EACEA7D9CF, double 0xC02E38E8D626667E, double 0xBFCC9557BE257DA0, double 0x3F6849383E87D954, double 0x3F637C044AC0ACE1, double 0xBEFF1983FEDBFAA0, double 0x3F06E44607A13BD6 }, %struct.planet { double 0x402EC267A905572A, double 0xC039EB5833C8A220, double 0x3FC6F1F393ABE540, double 0x3F65F5C9E51B4320, double 0x3F5AAD5736999D88, double 0xBF18F2070B7F9750, double 0x3F0B0213CA2D0EEC }], align 16
@.str = private constant [6 x i8] c"%.9f\0A\00"

define void @advance(i32 %nbodies, %struct.planet* %bodies, double %dt) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %71, %0
  %i.0 = phi i32 [ 0, %0 ], [ %6, %71 ]
  %2 = icmp slt i32 %i.0, %nbodies
  br i1 %2, label %3, label %72

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds %struct.planet* %bodies, i64 %4
  %6 = add nsw i32 %i.0, 1
  %7 = getelementptr inbounds %struct.planet* %5, i32 0, i32 0
  %8 = getelementptr inbounds %struct.planet* %5, i32 0, i32 1
  %9 = getelementptr inbounds %struct.planet* %5, i32 0, i32 2
  %10 = getelementptr inbounds %struct.planet* %5, i32 0, i32 3
  %11 = getelementptr inbounds %struct.planet* %5, i32 0, i32 4
  %12 = getelementptr inbounds %struct.planet* %5, i32 0, i32 5
  %13 = getelementptr inbounds %struct.planet* %5, i32 0, i32 6
  br label %14

; <label>:14                                      ; preds = %16, %3
  %j.0 = phi i32 [ %6, %3 ], [ %70, %16 ]
  %15 = icmp slt i32 %j.0, %nbodies
  br i1 %15, label %16, label %71

; <label>:16                                      ; preds = %14
  %17 = sext i32 %j.0 to i64
  %18 = getelementptr inbounds %struct.planet* %bodies, i64 %17
  %19 = load double* %7, align 8
  %20 = getelementptr inbounds %struct.planet* %18, i32 0, i32 0
  %21 = load double* %20, align 8
  %22 = fsub double %19, %21
  %23 = load double* %8, align 8
  %24 = getelementptr inbounds %struct.planet* %18, i32 0, i32 1
  %25 = load double* %24, align 8
  %26 = fsub double %23, %25
  %27 = load double* %9, align 8
  %28 = getelementptr inbounds %struct.planet* %18, i32 0, i32 2
  %29 = load double* %28, align 8
  %30 = fsub double %27, %29
  %31 = fmul double %22, %22
  %32 = fmul double %26, %26
  %33 = fadd double %31, %32
  %34 = fmul double %30, %30
  %35 = fadd double %33, %34
  %36 = call double @sqrt(double %35)
  %37 = fmul double %36, %36
  %38 = fmul double %37, %36
  %39 = fdiv double %dt, %38
  %40 = getelementptr inbounds %struct.planet* %18, i32 0, i32 6
  %41 = load double* %40, align 8
  %42 = fmul double %22, %41
  %43 = fmul double %42, %39
  %44 = load double* %10, align 8
  %45 = fsub double %44, %43
  store double %45, double* %10, align 8
  %46 = fmul double %26, %41
  %47 = fmul double %46, %39
  %48 = load double* %11, align 8
  %49 = fsub double %48, %47
  store double %49, double* %11, align 8
  %50 = fmul double %30, %41
  %51 = fmul double %50, %39
  %52 = load double* %12, align 8
  %53 = fsub double %52, %51
  store double %53, double* %12, align 8
  %54 = load double* %13, align 8
  %55 = fmul double %22, %54
  %56 = fmul double %55, %39
  %57 = getelementptr inbounds %struct.planet* %18, i32 0, i32 3
  %58 = load double* %57, align 8
  %59 = fadd double %58, %56
  store double %59, double* %57, align 8
  %60 = fmul double %26, %54
  %61 = fmul double %60, %39
  %62 = getelementptr inbounds %struct.planet* %18, i32 0, i32 4
  %63 = load double* %62, align 8
  %64 = fadd double %63, %61
  store double %64, double* %62, align 8
  %65 = fmul double %30, %54
  %66 = fmul double %65, %39
  %67 = getelementptr inbounds %struct.planet* %18, i32 0, i32 5
  %68 = load double* %67, align 8
  %69 = fadd double %68, %66
  store double %69, double* %67, align 8
  %70 = add nsw i32 %j.0, 1
  br label %14

; <label>:71                                      ; preds = %14
  br label %1

; <label>:72                                      ; preds = %1
  br label %73

; <label>:73                                      ; preds = %75, %72
  %i.1 = phi i32 [ 0, %72 ], [ %96, %75 ]
  %74 = icmp slt i32 %i.1, %nbodies
  br i1 %74, label %75, label %97

; <label>:75                                      ; preds = %73
  %76 = sext i32 %i.1 to i64
  %77 = getelementptr inbounds %struct.planet* %bodies, i64 %76
  %78 = getelementptr inbounds %struct.planet* %77, i32 0, i32 3
  %79 = load double* %78, align 8
  %80 = fmul double %dt, %79
  %81 = getelementptr inbounds %struct.planet* %77, i32 0, i32 0
  %82 = load double* %81, align 8
  %83 = fadd double %82, %80
  store double %83, double* %81, align 8
  %84 = getelementptr inbounds %struct.planet* %77, i32 0, i32 4
  %85 = load double* %84, align 8
  %86 = fmul double %dt, %85
  %87 = getelementptr inbounds %struct.planet* %77, i32 0, i32 1
  %88 = load double* %87, align 8
  %89 = fadd double %88, %86
  store double %89, double* %87, align 8
  %90 = getelementptr inbounds %struct.planet* %77, i32 0, i32 5
  %91 = load double* %90, align 8
  %92 = fmul double %dt, %91
  %93 = getelementptr inbounds %struct.planet* %77, i32 0, i32 2
  %94 = load double* %93, align 8
  %95 = fadd double %94, %92
  store double %95, double* %93, align 8
  %96 = add nsw i32 %i.1, 1
  br label %73

; <label>:97                                      ; preds = %73
  ret void
}

declare double @sqrt(double) readnone

define double @energy(i32 %nbodies, %struct.planet* %bodies) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %55, %0
  %e.0 = phi double [ 0.000000e+00, %0 ], [ %e.1.lcssa, %55 ]
  %i.0 = phi i32 [ 0, %0 ], [ %22, %55 ]
  %2 = icmp slt i32 %i.0, %nbodies
  br i1 %2, label %3, label %56

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds %struct.planet* %bodies, i64 %4
  %6 = getelementptr inbounds %struct.planet* %5, i32 0, i32 6
  %7 = load double* %6, align 8
  %8 = fmul double 5.000000e-01, %7
  %9 = getelementptr inbounds %struct.planet* %5, i32 0, i32 3
  %10 = load double* %9, align 8
  %11 = fmul double %10, %10
  %12 = getelementptr inbounds %struct.planet* %5, i32 0, i32 4
  %13 = load double* %12, align 8
  %14 = fmul double %13, %13
  %15 = fadd double %11, %14
  %16 = getelementptr inbounds %struct.planet* %5, i32 0, i32 5
  %17 = load double* %16, align 8
  %18 = fmul double %17, %17
  %19 = fadd double %15, %18
  %20 = fmul double %8, %19
  %21 = fadd double %e.0, %20
  %22 = add nsw i32 %i.0, 1
  %23 = getelementptr inbounds %struct.planet* %5, i32 0, i32 0
  %24 = getelementptr inbounds %struct.planet* %5, i32 0, i32 1
  %25 = getelementptr inbounds %struct.planet* %5, i32 0, i32 2
  br label %26

; <label>:26                                      ; preds = %28, %3
  %e.1 = phi double [ %21, %3 ], [ %53, %28 ]
  %j.0 = phi i32 [ %22, %3 ], [ %54, %28 ]
  %27 = icmp slt i32 %j.0, %nbodies
  br i1 %27, label %28, label %55

; <label>:28                                      ; preds = %26
  %29 = sext i32 %j.0 to i64
  %30 = getelementptr inbounds %struct.planet* %bodies, i64 %29
  %31 = load double* %23, align 8
  %32 = getelementptr inbounds %struct.planet* %30, i32 0, i32 0
  %33 = load double* %32, align 8
  %34 = fsub double %31, %33
  %35 = load double* %24, align 8
  %36 = getelementptr inbounds %struct.planet* %30, i32 0, i32 1
  %37 = load double* %36, align 8
  %38 = fsub double %35, %37
  %39 = load double* %25, align 8
  %40 = getelementptr inbounds %struct.planet* %30, i32 0, i32 2
  %41 = load double* %40, align 8
  %42 = fsub double %39, %41
  %43 = fmul double %34, %34
  %44 = fmul double %38, %38
  %45 = fadd double %43, %44
  %46 = fmul double %42, %42
  %47 = fadd double %45, %46
  %48 = call double @sqrt(double %47)
  %49 = getelementptr inbounds %struct.planet* %30, i32 0, i32 6
  %50 = load double* %49, align 8
  %51 = fmul double %7, %50
  %52 = fdiv double %51, %48
  %53 = fsub double %e.1, %52
  %54 = add nsw i32 %j.0, 1
  br label %26

; <label>:55                                      ; preds = %26
  %e.1.lcssa = phi double [ %e.1, %26 ]
  br label %1

; <label>:56                                      ; preds = %1
  %e.0.lcssa = phi double [ %e.0, %1 ]
  ret double %e.0.lcssa
}

define void @offset_momentum(i32 %nbodies, %struct.planet* %bodies) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %3, %0
  %py.0 = phi double [ 0.000000e+00, %0 ], [ %15, %3 ]
  %px.0 = phi double [ 0.000000e+00, %0 ], [ %11, %3 ]
  %pz.0 = phi double [ 0.000000e+00, %0 ], [ %19, %3 ]
  %i.0 = phi i32 [ 0, %0 ], [ %20, %3 ]
  %2 = icmp slt i32 %i.0, %nbodies
  br i1 %2, label %3, label %21

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds %struct.planet* %bodies, i64 %4
  %6 = getelementptr inbounds %struct.planet* %5, i32 0, i32 3
  %7 = load double* %6, align 8
  %8 = getelementptr inbounds %struct.planet* %5, i32 0, i32 6
  %9 = load double* %8, align 8
  %10 = fmul double %7, %9
  %11 = fadd double %px.0, %10
  %12 = getelementptr inbounds %struct.planet* %5, i32 0, i32 4
  %13 = load double* %12, align 8
  %14 = fmul double %13, %9
  %15 = fadd double %py.0, %14
  %16 = getelementptr inbounds %struct.planet* %5, i32 0, i32 5
  %17 = load double* %16, align 8
  %18 = fmul double %17, %9
  %19 = fadd double %pz.0, %18
  %20 = add nsw i32 %i.0, 1
  br label %1

; <label>:21                                      ; preds = %1
  %pz.0.lcssa = phi double [ %pz.0, %1 ]
  %px.0.lcssa = phi double [ %px.0, %1 ]
  %py.0.lcssa = phi double [ %py.0, %1 ]
  %22 = fsub double -0.000000e+00, %px.0.lcssa
  %23 = fdiv double %22, 0x4043BD3CC9BE45DE
  %24 = getelementptr inbounds %struct.planet* %bodies, i64 0
  %25 = getelementptr inbounds %struct.planet* %24, i32 0, i32 3
  store double %23, double* %25, align 8
  %26 = fsub double -0.000000e+00, %py.0.lcssa
  %27 = fdiv double %26, 0x4043BD3CC9BE45DE
  %28 = getelementptr inbounds %struct.planet* %24, i32 0, i32 4
  store double %27, double* %28, align 8
  %29 = fsub double -0.000000e+00, %pz.0.lcssa
  %30 = fdiv double %29, 0x4043BD3CC9BE45DE
  %31 = getelementptr inbounds %struct.planet* %24, i32 0, i32 5
  store double %30, double* %31, align 8
  ret void
}

define void @setup_bodies() nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %3, %0
  %i.0 = phi i32 [ 0, %0 ], [ %18, %3 ]
  %2 = icmp slt i32 %i.0, 5
  br i1 %2, label %3, label %19

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds [5 x %struct.planet]* @bodies, i32 0, i64 %4
  %6 = getelementptr inbounds %struct.planet* %5, i32 0, i32 3
  %7 = load double* %6, align 8
  %8 = fmul double %7, 3.652400e+02
  store double %8, double* %6, align 8
  %9 = getelementptr inbounds %struct.planet* %5, i32 0, i32 4
  %10 = load double* %9, align 8
  %11 = fmul double %10, 3.652400e+02
  store double %11, double* %9, align 8
  %12 = getelementptr inbounds %struct.planet* %5, i32 0, i32 5
  %13 = load double* %12, align 8
  %14 = fmul double %13, 3.652400e+02
  store double %14, double* %12, align 8
  %15 = getelementptr inbounds %struct.planet* %5, i32 0, i32 6
  %16 = load double* %15, align 8
  %17 = fmul double %16, 0x4043BD3CC9BE45DE
  store double %17, double* %15, align 8
  %18 = add nsw i32 %i.0, 1
  br label %1

; <label>:19                                      ; preds = %1
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

; <label>:11                                      ; preds = %13, %7
  %i.0 = phi i32 [ 1, %7 ], [ %14, %13 ]
  %12 = icmp sle i32 %i.0, %8
  br i1 %12, label %13, label %15

; <label>:13                                      ; preds = %11
  call void @advance(i32 5, %struct.planet* getelementptr inbounds ([5 x %struct.planet]* @bodies, i32 0, i32 0), double 1.000000e-02)
  %14 = add nsw i32 %i.0, 1
  br label %11

; <label>:15                                      ; preds = %11
  %16 = call double @energy(i32 5, %struct.planet* getelementptr inbounds ([5 x %struct.planet]* @bodies, i32 0, i32 0))
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0), double %16)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)
