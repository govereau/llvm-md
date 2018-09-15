; ModuleID = 'bisect.c.pipeline.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }

@__stderrp = external global %struct.__sFILE*
@.str = private constant [44 x i8] c"Error: couldn't allocate V in allocvector.\0A\00"
@.str1 = private constant [40 x i8] c"bisect: Couldn't allocate memory for wu\00"
@.str2 = private constant [10 x i8] c"%5d %.5e\0A\00"
@.str3 = private constant [22 x i8] c"eps2 = %.5e,  k = %d\0A\00"

define i8* @allocvector(i64 %size) nounwind ssp {
  %1 = call i8* @malloc(i64 %size)
  %2 = icmp eq i8* %1, null
  br i1 %2, label %3, label %6

; <label>:3                                       ; preds = %0
  %4 = load %struct.__sFILE** @__stderrp, align 8
  %5 = call i32 (%struct.__sFILE*, i8*, ...)* @fprintf(%struct.__sFILE* %4, i8* getelementptr inbounds ([44 x i8]* @.str, i32 0, i32 0))
  call void @exit(i32 2) noreturn
  unreachable

; <label>:6                                       ; preds = %0
  %7 = call i64 @llvm.objectsize.i64(i8* %1, i1 false)
  %8 = icmp ne i64 %7, -1
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %6
  %10 = call i8* @__memset_chk(i8* %1, i32 0, i64 %size, i64 %7)
  br label %13

; <label>:11                                      ; preds = %6
  %12 = call i8* @__inline_memset_chk(i8* %1, i32 0, i64 %size)
  br label %13

; <label>:13                                      ; preds = %11, %9
  ret i8* %1
}

declare i8* @malloc(i64)

declare i32 @fprintf(%struct.__sFILE*, i8*, ...)

declare void @exit(i32) noreturn

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

declare i8* @__memset_chk(i8*, i32, i64, i64) nounwind

define internal i8* @__inline_memset_chk(i8* %__dest, i32 %__val, i64 %__len) nounwind inlinehint ssp {
  %1 = call i64 @llvm.objectsize.i64(i8* %__dest, i1 false)
  %2 = call i8* @__memset_chk(i8* %__dest, i32 %__val, i64 %__len, i64 %1)
  ret i8* %2
}

define void @dallocvector(i32 %n, double** %V) nounwind ssp {
  %1 = sext i32 %n to i64
  %2 = mul i64 %1, 8
  %3 = call i8* @allocvector(i64 %2)
  %4 = bitcast i8* %3 to double*
  store double* %4, double** %V
  ret void
}

define i32 @sturm(i32 %n, double* %c, double* %b, double* %beta, double %x) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %28, %0
  %i.0 = phi i32 [ 0, %0 ], [ %29, %28 ]
  %a.1 = phi i32 [ 0, %0 ], [ %a.0, %28 ]
  %q.1 = phi double [ 1.000000e+00, %0 ], [ %q.0, %28 ]
  %2 = icmp slt i32 %i.0, %n
  br i1 %2, label %3, label %30

; <label>:3                                       ; preds = %1
  %4 = fcmp une double %q.1, 0.000000e+00
  br i1 %4, label %5, label %14

; <label>:5                                       ; preds = %3
  %6 = sext i32 %i.0 to i64
  %7 = getelementptr inbounds double* %c, i64 %6
  %8 = load double* %7
  %9 = fsub double %8, %x
  %10 = getelementptr inbounds double* %beta, i64 %6
  %11 = load double* %10
  %12 = fdiv double %11, %q.1
  %13 = fsub double %9, %12
  br label %24

; <label>:14                                      ; preds = %3
  %15 = sext i32 %i.0 to i64
  %16 = getelementptr inbounds double* %c, i64 %15
  %17 = load double* %16
  %18 = fsub double %17, %x
  %19 = getelementptr inbounds double* %b, i64 %15
  %20 = load double* %19
  %21 = call double @fabs(double %20)
  %22 = fdiv double %21, 0x3CB0000000000000
  %23 = fsub double %18, %22
  br label %24

; <label>:24                                      ; preds = %14, %5
  %q.0 = phi double [ %13, %5 ], [ %23, %14 ]
  %25 = fcmp olt double %q.0, 0.000000e+00
  br i1 %25, label %26, label %28

; <label>:26                                      ; preds = %24
  %27 = add nsw i32 %a.1, 1
  br label %28

; <label>:28                                      ; preds = %26, %24
  %a.0 = phi i32 [ %27, %26 ], [ %a.1, %24 ]
  %29 = add nsw i32 %i.0, 1
  br label %1

; <label>:30                                      ; preds = %1
  %a.1.lcssa = phi i32 [ %a.1, %1 ]
  ret i32 %a.1.lcssa
}

declare double @fabs(double)

define void @dbisect(double* %c, double* %b, double* %beta, i32 %n, i32 %m1, i32 %m2, double %eps1, double* %eps2, i32* %z, double* %x) nounwind ssp {
; <label>:0
  %1 = getelementptr inbounds double* %b, i64 0
  store double 0.000000e+00, double* %1
  %2 = getelementptr inbounds double* %beta, i64 0
  store double 0.000000e+00, double* %2
  %3 = sub nsw i32 %n, 1
  %4 = sext i32 %3 to i64
  %5 = getelementptr inbounds double* %c, i64 %4
  %6 = load double* %5
  %7 = getelementptr inbounds double* %b, i64 %4
  %8 = load double* %7
  %9 = call double @fabs(double %8)
  %10 = fmul double 1.010000e+00, %9
  %11 = fsub double %6, %10
  %12 = load double* %5
  %13 = load double* %7
  %14 = call double @fabs(double %13)
  %15 = fmul double 1.010000e+00, %14
  %16 = fadd double %12, %15
  %17 = sub nsw i32 %n, 2
  br label %18

; <label>:18                                      ; preds = %41, %0
  %i.0 = phi i32 [ %17, %0 ], [ %42, %41 ]
  %xmin.1 = phi double [ %11, %0 ], [ %xmin.0, %41 ]
  %xmax.1 = phi double [ %16, %0 ], [ %xmax.0, %41 ]
  %19 = icmp sge i32 %i.0, 0
  br i1 %19, label %20, label %43

; <label>:20                                      ; preds = %18
  %21 = sext i32 %i.0 to i64
  %22 = getelementptr inbounds double* %b, i64 %21
  %23 = load double* %22
  %24 = call double @fabs(double %23)
  %25 = add nsw i32 %i.0, 1
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds double* %b, i64 %26
  %28 = load double* %27
  %29 = call double @fabs(double %28)
  %30 = fadd double %24, %29
  %31 = fmul double 1.010000e+00, %30
  %32 = getelementptr inbounds double* %c, i64 %21
  %33 = load double* %32
  %34 = fadd double %33, %31
  %35 = fcmp ogt double %34, %xmax.1
  br i1 %35, label %36, label %37

; <label>:36                                      ; preds = %20
  br label %37

; <label>:37                                      ; preds = %36, %20
  %xmax.0 = phi double [ %34, %36 ], [ %xmax.1, %20 ]
  %38 = fsub double %33, %31
  %39 = fcmp olt double %38, %xmin.1
  br i1 %39, label %40, label %41

; <label>:40                                      ; preds = %37
  br label %41

; <label>:41                                      ; preds = %40, %37
  %xmin.0 = phi double [ %38, %40 ], [ %xmin.1, %37 ]
  %42 = add nsw i32 %i.0, -1
  br label %18

; <label>:43                                      ; preds = %18
  %xmax.1.lcssa = phi double [ %xmax.1, %18 ]
  %xmin.1.lcssa = phi double [ %xmin.1, %18 ]
  %44 = fadd double %xmin.1.lcssa, %xmax.1.lcssa
  %45 = fcmp ogt double %44, 0.000000e+00
  br i1 %45, label %46, label %47

; <label>:46                                      ; preds = %43
  br label %49

; <label>:47                                      ; preds = %43
  %48 = fsub double -0.000000e+00, %xmin.1.lcssa
  br label %49

; <label>:49                                      ; preds = %47, %46
  %50 = phi double [ %xmax.1.lcssa, %46 ], [ %48, %47 ]
  %51 = fmul double 0x3CB0000000000000, %50
  store double %51, double* %eps2
  %52 = fcmp ole double %eps1, 0.000000e+00
  br i1 %52, label %53, label %54

; <label>:53                                      ; preds = %49
  br label %54

; <label>:54                                      ; preds = %53, %49
  %.0 = phi double [ %51, %53 ], [ %eps1, %49 ]
  %55 = fmul double 5.000000e-01, %.0
  %56 = fmul double 7.000000e+00, %51
  %57 = fadd double %55, %56
  store double %57, double* %eps2
  %58 = add nsw i32 %n, 1
  %59 = sext i32 %58 to i64
  %60 = call i8* @calloc(i64 %59, i64 8)
  %61 = bitcast i8* %60 to double*
  %62 = icmp eq double* %61, null
  br i1 %62, label %63, label %66

; <label>:63                                      ; preds = %54
  %64 = load %struct.__sFILE** @__stderrp, align 8
  %65 = call i32 @"\01_fputs"(i8* getelementptr inbounds ([40 x i8]* @.str1, i32 0, i32 0), %struct.__sFILE* %64)
  call void @exit(i32 1) noreturn
  unreachable

; <label>:66                                      ; preds = %54
  br label %67

; <label>:67                                      ; preds = %69, %66
  %i.1 = phi i32 [ %m2, %66 ], [ %73, %69 ]
  %68 = icmp sge i32 %i.1, %m1
  br i1 %68, label %69, label %74

; <label>:69                                      ; preds = %67
  %70 = sext i32 %i.1 to i64
  %71 = getelementptr inbounds double* %x, i64 %70
  store double %xmax.1.lcssa, double* %71
  %72 = getelementptr inbounds double* %61, i64 %70
  store double %xmin.1.lcssa, double* %72
  %73 = add nsw i32 %i.1, -1
  br label %67

; <label>:74                                      ; preds = %67
  store i32 0, i32* %z
  %75 = sext i32 %m1 to i64
  %76 = getelementptr inbounds double* %61, i64 %75
  br label %77

; <label>:77                                      ; preds = %130, %74
  %k.0 = phi i32 [ %m2, %74 ], [ %133, %130 ]
  %x0.1 = phi double [ %xmax.1.lcssa, %74 ], [ %x0.3.lcssa, %130 ]
  %78 = icmp sge i32 %k.0, %m1
  br i1 %78, label %79, label %134

; <label>:79                                      ; preds = %77
  br label %80

; <label>:80                                      ; preds = %88, %79
  %i.2 = phi i32 [ %k.0, %79 ], [ %89, %88 ]
  %81 = icmp sge i32 %i.2, %m1
  br i1 %81, label %82, label %.loopexit

; <label>:82                                      ; preds = %80
  %83 = sext i32 %i.2 to i64
  %84 = getelementptr inbounds double* %61, i64 %83
  %85 = load double* %84
  %86 = fcmp olt double %xmin.1.lcssa, %85
  br i1 %86, label %87, label %88

; <label>:87                                      ; preds = %82
  %.lcssa = phi double [ %85, %82 ]
  br label %90

; <label>:88                                      ; preds = %82
  %89 = add nsw i32 %i.2, -1
  br label %80

.loopexit:                                        ; preds = %80
  br label %90

; <label>:90                                      ; preds = %.loopexit, %87
  %xu.0 = phi double [ %.lcssa, %87 ], [ %xmin.1.lcssa, %.loopexit ]
  %91 = sext i32 %k.0 to i64
  %92 = getelementptr inbounds double* %x, i64 %91
  %93 = load double* %92
  %94 = fcmp ogt double %x0.1, %93
  br i1 %94, label %95, label %96

; <label>:95                                      ; preds = %90
  br label %96

; <label>:96                                      ; preds = %95, %90
  %x0.0 = phi double [ %93, %95 ], [ %x0.1, %90 ]
  %97 = fadd double %xu.0, %x0.0
  %98 = fdiv double %97, 2.000000e+00
  br label %99

; <label>:99                                      ; preds = %127, %96
  %x1.0 = phi double [ %98, %96 ], [ %129, %127 ]
  %xu.3 = phi double [ %xu.0, %96 ], [ %xu.2, %127 ]
  %x0.3 = phi double [ %x0.0, %96 ], [ %x0.2, %127 ]
  %100 = fsub double %x0.3, %xu.3
  %101 = call double @fabs(double %xu.3)
  %102 = call double @fabs(double %x0.3)
  %103 = fadd double %101, %102
  %104 = fmul double 0x3CC0000000000000, %103
  %105 = fadd double %104, %.0
  %106 = fcmp ogt double %100, %105
  br i1 %106, label %107, label %130

; <label>:107                                     ; preds = %99
  %108 = load i32* %z
  %109 = add nsw i32 %108, 1
  store i32 %109, i32* %z
  %110 = call i32 @sturm(i32 %n, double* %c, double* %b, double* %beta, double %x1.0)
  %111 = icmp slt i32 %110, %k.0
  br i1 %111, label %112, label %126

; <label>:112                                     ; preds = %107
  %113 = icmp slt i32 %110, %m1
  br i1 %113, label %114, label %115

; <label>:114                                     ; preds = %112
  store double %x1.0, double* %76
  br label %125

; <label>:115                                     ; preds = %112
  %116 = add nsw i32 %110, 1
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds double* %61, i64 %117
  store double %x1.0, double* %118
  %119 = sext i32 %110 to i64
  %120 = getelementptr inbounds double* %x, i64 %119
  %121 = load double* %120
  %122 = fcmp ogt double %121, %x1.0
  br i1 %122, label %123, label %124

; <label>:123                                     ; preds = %115
  store double %x1.0, double* %120
  br label %124

; <label>:124                                     ; preds = %123, %115
  br label %125

; <label>:125                                     ; preds = %124, %114
  br label %127

; <label>:126                                     ; preds = %107
  br label %127

; <label>:127                                     ; preds = %126, %125
  %xu.2 = phi double [ %x1.0, %125 ], [ %xu.3, %126 ]
  %x0.2 = phi double [ %x0.3, %125 ], [ %x1.0, %126 ]
  %128 = fadd double %xu.2, %x0.2
  %129 = fdiv double %128, 2.000000e+00
  br label %99

; <label>:130                                     ; preds = %99
  %x0.3.lcssa = phi double [ %x0.3, %99 ]
  %xu.3.lcssa = phi double [ %xu.3, %99 ]
  %131 = fadd double %xu.3.lcssa, %x0.3.lcssa
  %132 = fdiv double %131, 2.000000e+00
  store double %132, double* %92
  %133 = add nsw i32 %k.0, -1
  br label %77

; <label>:134                                     ; preds = %77
  %135 = bitcast double* %61 to i8*
  call void @free(i8* %135)
  ret void
}

declare i8* @calloc(i64, i64)

declare i32 @"\01_fputs"(i8*, %struct.__sFILE*)

declare void @free(i8*)

define void @test_matrix(i32 %n, double* %C, double* %B) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %3, %0
  %i.0 = phi i32 [ 0, %0 ], [ %7, %3 ]
  %2 = icmp slt i32 %i.0, %n
  br i1 %2, label %3, label %12

; <label>:3                                       ; preds = %1
  %4 = sitofp i32 %i.0 to double
  %5 = sext i32 %i.0 to i64
  %6 = getelementptr inbounds double* %B, i64 %5
  store double %4, double* %6
  %7 = add nsw i32 %i.0, 1
  %8 = sitofp i32 %7 to double
  %9 = fmul double %8, %8
  %10 = getelementptr inbounds double* %C, i64 %5
  %11 = fmul double %9, %9
  store double %11, double* %10
  br label %1

; <label>:12                                      ; preds = %1
  ret void
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
; <label>:0
  %k = alloca i32, align 4
  %eps2 = alloca double, align 8
  %D = alloca double*, align 8
  %E = alloca double*, align 8
  %beta = alloca double*, align 8
  %S = alloca double*, align 8
  call void @dallocvector(i32 500, double** %D)
  call void @dallocvector(i32 500, double** %E)
  call void @dallocvector(i32 500, double** %beta)
  call void @dallocvector(i32 500, double** %S)
  br label %1

; <label>:1                                       ; preds = %19, %0
  %j.0 = phi i32 [ 0, %0 ], [ %29, %19 ]
  %2 = icmp slt i32 %j.0, 50
  br i1 %2, label %3, label %30

; <label>:3                                       ; preds = %1
  %4 = load double** %D, align 8
  %5 = load double** %E, align 8
  call void @test_matrix(i32 500, double* %4, double* %5)
  br label %6

; <label>:6                                       ; preds = %8, %3
  %i.0 = phi i32 [ 0, %3 ], [ %18, %8 ]
  %7 = icmp slt i32 %i.0, 500
  br i1 %7, label %8, label %19

; <label>:8                                       ; preds = %6
  %9 = sext i32 %i.0 to i64
  %10 = load double** %E, align 8
  %11 = getelementptr inbounds double* %10, i64 %9
  %12 = load double* %11
  %13 = fmul double %12, %12
  %14 = load double** %beta, align 8
  %15 = getelementptr inbounds double* %14, i64 %9
  store double %13, double* %15
  %16 = load double** %S, align 8
  %17 = getelementptr inbounds double* %16, i64 %9
  store double 0.000000e+00, double* %17
  %18 = add nsw i32 %i.0, 1
  br label %6

; <label>:19                                      ; preds = %6
  %20 = load double** %beta, align 8
  %21 = getelementptr inbounds double* %20, i64 0
  store double 0.000000e+00, double* %21
  %22 = load double** %E, align 8
  %23 = getelementptr inbounds double* %22, i64 0
  store double 0.000000e+00, double* %23
  %24 = load double** %D, align 8
  %25 = load double** %E, align 8
  %26 = load double** %beta, align 8
  %27 = load double** %S, align 8
  %28 = getelementptr inbounds double* %27, i64 -1
  call void @dbisect(double* %24, double* %25, double* %26, i32 500, i32 1, i32 500, double 0x3CB0000000000000, double* %eps2, i32* %k, double* %28)
  %29 = add nsw i32 %j.0, 1
  br label %1

; <label>:30                                      ; preds = %1
  br label %31

; <label>:31                                      ; preds = %33, %30
  %i.1 = phi i32 [ 1, %30 ], [ %34, %33 ]
  %32 = icmp slt i32 %i.1, 20
  br i1 %32, label %33, label %40

; <label>:33                                      ; preds = %31
  %34 = add nsw i32 %i.1, 1
  %35 = sext i32 %i.1 to i64
  %36 = load double** %S, align 8
  %37 = getelementptr inbounds double* %36, i64 %35
  %38 = load double* %37
  %39 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i32 0, i32 0), i32 %34, double %38)
  br label %31

; <label>:40                                      ; preds = %31
  %41 = load double* %eps2, align 8
  %42 = load i32* %k, align 4
  %43 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str3, i32 0, i32 0), double %41, i32 %42)
  ret i32 0
}

declare i32 @printf(i8*, ...)
