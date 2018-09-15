; ModuleID = 'fft.c.pipeline.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@xr = common global double* null, align 8
@xi = common global double* null, align 8
@.str = private constant [15 x i8] c"%d points, %s\0A\00"
@.str1 = private constant [10 x i8] c"result OK\00"
@.str2 = private constant [13 x i8] c"WRONG result\00"

define i32 @dfft(double* %x, double* %y, i32 %np) nounwind ssp {
; <label>:0
  %1 = getelementptr inbounds double* %x, i64 -1
  %2 = getelementptr inbounds double* %y, i64 -1
  br label %3

; <label>:3                                       ; preds = %5, %0
  %m.0 = phi i32 [ 1, %0 ], [ %7, %5 ]
  %i.0 = phi i32 [ 2, %0 ], [ %6, %5 ]
  %4 = icmp slt i32 %i.0, %np
  br i1 %4, label %5, label %8

; <label>:5                                       ; preds = %3
  %6 = add nsw i32 %i.0, %i.0
  %7 = add nsw i32 %m.0, 1
  br label %3

; <label>:8                                       ; preds = %3
  %i.0.lcssa = phi i32 [ %i.0, %3 ]
  %m.0.lcssa = phi i32 [ %m.0, %3 ]
  %9 = icmp ne i32 %i.0.lcssa, %np
  br i1 %9, label %10, label %20

; <label>:10                                      ; preds = %8
  %11 = add nsw i32 %np, 1
  br label %12

; <label>:12                                      ; preds = %14, %10
  %i.1 = phi i32 [ %11, %10 ], [ %18, %14 ]
  %13 = icmp sle i32 %i.1, %i.0.lcssa
  br i1 %13, label %14, label %19

; <label>:14                                      ; preds = %12
  %15 = sext i32 %i.1 to i64
  %16 = getelementptr inbounds double* %1, i64 %15
  store double 0.000000e+00, double* %16
  %17 = getelementptr inbounds double* %2, i64 %15
  store double 0.000000e+00, double* %17
  %18 = add nsw i32 %i.1, 1
  br label %12

; <label>:19                                      ; preds = %12
  br label %20

; <label>:20                                      ; preds = %19, %8
  %21 = add nsw i32 %i.0.lcssa, %i.0.lcssa
  %22 = sub nsw i32 %m.0.lcssa, 1
  %23 = sub nsw i32 %i.0.lcssa, 1
  br label %24

; <label>:24                                      ; preds = %104, %20
  %k.0 = phi i32 [ 1, %20 ], [ %105, %104 ]
  %n2.0 = phi i32 [ %21, %20 ], [ %27, %104 ]
  %25 = icmp sle i32 %k.0, %22
  br i1 %25, label %26, label %106

; <label>:26                                      ; preds = %24
  %27 = sdiv i32 %n2.0, 2
  %28 = sdiv i32 %27, 4
  %29 = sitofp i32 %27 to double
  %30 = fdiv double 0x401921FB54442D18, %29
  %31 = mul nsw i32 2, %27
  br label %32

; <label>:32                                      ; preds = %102, %26
  %j.0 = phi i32 [ 1, %26 ], [ %103, %102 ]
  %a.0 = phi double [ 0.000000e+00, %26 ], [ %41, %102 ]
  %33 = icmp sle i32 %j.0, %28
  br i1 %33, label %34, label %104

; <label>:34                                      ; preds = %32
  %35 = fmul double 3.000000e+00, %a.0
  %36 = call double @cos(double %a.0)
  %37 = call double @sin(double %a.0)
  %38 = call double @cos(double %35)
  %39 = call double @sin(double %35)
  %40 = sitofp i32 %j.0 to double
  %41 = fmul double %30, %40
  br label %42

; <label>:42                                      ; preds = %97, %34
  %is.0 = phi i32 [ %j.0, %34 ], [ %100, %97 ]
  %id.0 = phi i32 [ %31, %34 ], [ %101, %97 ]
  %43 = icmp slt i32 %is.0, %i.0.lcssa
  br i1 %43, label %44, label %102

; <label>:44                                      ; preds = %42
  br label %45

; <label>:45                                      ; preds = %47, %44
  %i0.0 = phi i32 [ %is.0, %44 ], [ %96, %47 ]
  %46 = icmp sle i32 %i0.0, %23
  br i1 %46, label %47, label %97

; <label>:47                                      ; preds = %45
  %48 = add nsw i32 %i0.0, %28
  %49 = add nsw i32 %48, %28
  %50 = add nsw i32 %49, %28
  %51 = sext i32 %i0.0 to i64
  %52 = getelementptr inbounds double* %1, i64 %51
  %53 = load double* %52
  %54 = sext i32 %49 to i64
  %55 = getelementptr inbounds double* %1, i64 %54
  %56 = load double* %55
  %57 = fsub double %53, %56
  %58 = fadd double %53, %56
  store double %58, double* %52
  %59 = sext i32 %48 to i64
  %60 = getelementptr inbounds double* %1, i64 %59
  %61 = load double* %60
  %62 = sext i32 %50 to i64
  %63 = getelementptr inbounds double* %1, i64 %62
  %64 = load double* %63
  %65 = fsub double %61, %64
  %66 = fadd double %61, %64
  store double %66, double* %60
  %67 = getelementptr inbounds double* %2, i64 %51
  %68 = load double* %67
  %69 = getelementptr inbounds double* %2, i64 %54
  %70 = load double* %69
  %71 = fsub double %68, %70
  %72 = fadd double %68, %70
  store double %72, double* %67
  %73 = getelementptr inbounds double* %2, i64 %59
  %74 = load double* %73
  %75 = getelementptr inbounds double* %2, i64 %62
  %76 = load double* %75
  %77 = fsub double %74, %76
  %78 = fadd double %74, %76
  store double %78, double* %73
  %79 = fsub double %57, %77
  %80 = fadd double %57, %77
  %81 = fsub double %65, %71
  %82 = fadd double %65, %71
  %83 = fmul double %80, %36
  %84 = fmul double %81, %37
  %85 = fsub double %83, %84
  store double %85, double* %55
  %86 = fsub double -0.000000e+00, %81
  %87 = fmul double %86, %36
  %88 = fmul double %80, %37
  %89 = fsub double %87, %88
  store double %89, double* %69
  %90 = fmul double %79, %38
  %91 = fmul double %82, %39
  %92 = fadd double %90, %91
  store double %92, double* %63
  %93 = fmul double %82, %38
  %94 = fmul double %79, %39
  %95 = fsub double %93, %94
  store double %95, double* %75
  %96 = add nsw i32 %i0.0, %id.0
  br label %45

; <label>:97                                      ; preds = %45
  %98 = mul nsw i32 2, %id.0
  %99 = sub nsw i32 %98, %27
  %100 = add nsw i32 %99, %j.0
  %101 = mul nsw i32 4, %id.0
  br label %42

; <label>:102                                     ; preds = %42
  %103 = add nsw i32 %j.0, 1
  br label %32

; <label>:104                                     ; preds = %32
  %105 = add nsw i32 %k.0, 1
  br label %24

; <label>:106                                     ; preds = %24
  br label %107

; <label>:107                                     ; preds = %129, %106
  %is.1 = phi i32 [ 1, %106 ], [ %131, %129 ]
  %id.1 = phi i32 [ 4, %106 ], [ %132, %129 ]
  %108 = icmp slt i32 %is.1, %i.0.lcssa
  br i1 %108, label %109, label %133

; <label>:109                                     ; preds = %107
  br label %110

; <label>:110                                     ; preds = %112, %109
  %i0.1 = phi i32 [ %is.1, %109 ], [ %128, %112 ]
  %111 = icmp sle i32 %i0.1, %i.0.lcssa
  br i1 %111, label %112, label %129

; <label>:112                                     ; preds = %110
  %113 = add nsw i32 %i0.1, 1
  %114 = sext i32 %i0.1 to i64
  %115 = getelementptr inbounds double* %1, i64 %114
  %116 = load double* %115
  %117 = sext i32 %113 to i64
  %118 = getelementptr inbounds double* %1, i64 %117
  %119 = load double* %118
  %120 = fadd double %116, %119
  store double %120, double* %115
  %121 = fsub double %116, %119
  store double %121, double* %118
  %122 = getelementptr inbounds double* %2, i64 %114
  %123 = load double* %122
  %124 = getelementptr inbounds double* %2, i64 %117
  %125 = load double* %124
  %126 = fadd double %123, %125
  store double %126, double* %122
  %127 = fsub double %123, %125
  store double %127, double* %124
  %128 = add nsw i32 %i0.1, %id.1
  br label %110

; <label>:129                                     ; preds = %110
  %130 = mul nsw i32 2, %id.1
  %131 = sub nsw i32 %130, 1
  %132 = mul nsw i32 4, %id.1
  br label %107

; <label>:133                                     ; preds = %107
  %134 = sub nsw i32 %i.0.lcssa, 1
  %135 = sdiv i32 %i.0.lcssa, 2
  br label %136

; <label>:136                                     ; preds = %157, %133
  %j.2 = phi i32 [ 1, %133 ], [ %158, %157 ]
  %i.2 = phi i32 [ 1, %133 ], [ %159, %157 ]
  %137 = icmp sle i32 %i.2, %134
  br i1 %137, label %138, label %160

; <label>:138                                     ; preds = %136
  %139 = icmp slt i32 %i.2, %j.2
  br i1 %139, label %140, label %151

; <label>:140                                     ; preds = %138
  %141 = sext i32 %j.2 to i64
  %142 = getelementptr inbounds double* %1, i64 %141
  %143 = load double* %142
  %144 = sext i32 %i.2 to i64
  %145 = getelementptr inbounds double* %1, i64 %144
  %146 = load double* %145
  store double %146, double* %142
  store double %143, double* %145
  %147 = getelementptr inbounds double* %2, i64 %141
  %148 = load double* %147
  %149 = getelementptr inbounds double* %2, i64 %144
  %150 = load double* %149
  store double %150, double* %147
  store double %148, double* %149
  br label %151

; <label>:151                                     ; preds = %140, %138
  br label %152

; <label>:152                                     ; preds = %154, %151
  %k.1 = phi i32 [ %135, %151 ], [ %156, %154 ]
  %j.1 = phi i32 [ %j.2, %151 ], [ %155, %154 ]
  %153 = icmp slt i32 %k.1, %j.1
  br i1 %153, label %154, label %157

; <label>:154                                     ; preds = %152
  %155 = sub nsw i32 %j.1, %k.1
  %156 = sdiv i32 %k.1, 2
  br label %152

; <label>:157                                     ; preds = %152
  %j.1.lcssa = phi i32 [ %j.1, %152 ]
  %k.1.lcssa = phi i32 [ %k.1, %152 ]
  %158 = add nsw i32 %j.1.lcssa, %k.1.lcssa
  %159 = add nsw i32 %i.2, 1
  br label %136

; <label>:160                                     ; preds = %136
  ret i32 %i.0.lcssa
}

declare double @cos(double) readnone

declare double @sin(double) readnone

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
  %n.0 = phi i32 [ %5, %2 ], [ 18, %6 ]
  %8 = shl i32 1, %n.0
  %9 = sitofp i32 %8 to double
  %10 = sdiv i32 %8, 2
  %11 = sub nsw i32 %10, 1
  %12 = fdiv double 0x400921FB54442D18, %9
  %13 = sext i32 %8 to i64
  %14 = call i8* @calloc(i64 %13, i64 8)
  %15 = bitcast i8* %14 to double*
  store double* %15, double** @xr, align 8
  %16 = call i8* @calloc(i64 %13, i64 8)
  %17 = bitcast i8* %16 to double*
  store double* %17, double** @xi, align 8
  %18 = load double** @xr, align 8
  %19 = fsub double %9, 1.000000e+00
  %20 = fmul double %19, 5.000000e-01
  store double %20, double* %18
  store double 0.000000e+00, double* %17
  %21 = sext i32 %10 to i64
  %22 = getelementptr inbounds double* %18, i64 %21
  store double -5.000000e-01, double* %22
  %23 = getelementptr inbounds double* %17, i64 %21
  store double 0.000000e+00, double* %23
  br label %24

; <label>:24                                      ; preds = %26, %7
  %i.0 = phi i32 [ 1, %7 ], [ %41, %26 ]
  %25 = icmp sle i32 %i.0, %11
  br i1 %25, label %26, label %42

; <label>:26                                      ; preds = %24
  %27 = sub nsw i32 %8, %i.0
  %28 = sext i32 %i.0 to i64
  %29 = getelementptr inbounds double* %18, i64 %28
  store double -5.000000e-01, double* %29
  %30 = sext i32 %27 to i64
  %31 = getelementptr inbounds double* %18, i64 %30
  store double -5.000000e-01, double* %31
  %32 = sitofp i32 %i.0 to double
  %33 = fmul double %12, %32
  %34 = call double @cos(double %33)
  %35 = call double @sin(double %33)
  %36 = fdiv double %34, %35
  %37 = fmul double -5.000000e-01, %36
  %38 = getelementptr inbounds double* %17, i64 %28
  store double %37, double* %38
  %39 = fsub double -0.000000e+00, %37
  %40 = getelementptr inbounds double* %17, i64 %30
  store double %39, double* %40
  %41 = add nsw i32 %i.0, 1
  br label %24

; <label>:42                                      ; preds = %24
  %43 = load double** @xr, align 8
  %44 = load double** @xi, align 8
  %45 = call i32 @dfft(double* %43, double* %44, i32 %8)
  %46 = sub nsw i32 %8, 1
  br label %47

; <label>:47                                      ; preds = %64, %42
  %i.1 = phi i32 [ 0, %42 ], [ %65, %64 ]
  %zr.1 = phi double [ 0.000000e+00, %42 ], [ %zr.0, %64 ]
  %zi.1 = phi double [ 0.000000e+00, %42 ], [ %zi.0, %64 ]
  %48 = icmp sle i32 %i.1, %46
  br i1 %48, label %49, label %66

; <label>:49                                      ; preds = %47
  %50 = sext i32 %i.1 to i64
  %51 = getelementptr inbounds double* %18, i64 %50
  %52 = load double* %51
  %53 = sitofp i32 %i.1 to double
  %54 = fsub double %52, %53
  %55 = call double @fabs(double %54)
  %56 = fcmp olt double %zr.1, %55
  br i1 %56, label %57, label %58

; <label>:57                                      ; preds = %49
  br label %58

; <label>:58                                      ; preds = %57, %49
  %zr.0 = phi double [ %55, %57 ], [ %zr.1, %49 ]
  %59 = getelementptr inbounds double* %17, i64 %50
  %60 = load double* %59
  %61 = call double @fabs(double %60)
  %62 = fcmp olt double %zi.1, %61
  br i1 %62, label %63, label %64

; <label>:63                                      ; preds = %58
  br label %64

; <label>:64                                      ; preds = %63, %58
  %zi.0 = phi double [ %61, %63 ], [ %zi.1, %58 ]
  %65 = add nsw i32 %i.1, 1
  br label %47

; <label>:66                                      ; preds = %47
  %zi.1.lcssa = phi double [ %zi.1, %47 ]
  %zr.1.lcssa = phi double [ %zr.1, %47 ]
  %67 = fcmp olt double %zr.1.lcssa, %zi.1.lcssa
  br i1 %67, label %68, label %69

; <label>:68                                      ; preds = %66
  br label %69

; <label>:69                                      ; preds = %68, %66
  %zm.0 = phi double [ %zi.1.lcssa, %68 ], [ %zr.1.lcssa, %66 ]
  %70 = fcmp olt double %zm.0, 1.000000e-09
  br i1 %70, label %71, label %72

; <label>:71                                      ; preds = %69
  br label %73

; <label>:72                                      ; preds = %69
  br label %73

; <label>:73                                      ; preds = %72, %71
  %74 = phi i8* [ getelementptr inbounds ([10 x i8]* @.str1, i32 0, i32 0), %71 ], [ getelementptr inbounds ([13 x i8]* @.str2, i32 0, i32 0), %72 ]
  %75 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str, i32 0, i32 0), i32 %8, i8* %74)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i8* @calloc(i64, i64)

declare double @fabs(double)

declare i32 @printf(i8*, ...)
