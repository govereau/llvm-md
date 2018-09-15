; ModuleID = 'bisect.c.m2r.o'
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
  br i1 %8, label %9, label %12

; <label>:9                                       ; preds = %6
  %10 = call i64 @llvm.objectsize.i64(i8* %1, i1 false)
  %11 = call i8* @__memset_chk(i8* %1, i32 0, i64 %size, i64 %10)
  br label %14

; <label>:12                                      ; preds = %6
  %13 = call i8* @__inline_memset_chk(i8* %1, i32 0, i64 %size)
  br label %14

; <label>:14                                      ; preds = %12, %9
  %15 = phi i8* [ %11, %9 ], [ %13, %12 ]
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

; <label>:1                                       ; preds = %31, %0
  %i.0 = phi i32 [ 0, %0 ], [ %32, %31 ]
  %a.1 = phi i32 [ 0, %0 ], [ %a.0, %31 ]
  %q.1 = phi double [ 1.000000e+00, %0 ], [ %q.0, %31 ]
  %2 = icmp slt i32 %i.0, %n
  br i1 %2, label %3, label %33

; <label>:3                                       ; preds = %1
  %4 = fcmp une double %q.1, 0.000000e+00
  br i1 %4, label %5, label %15

; <label>:5                                       ; preds = %3
  %6 = sext i32 %i.0 to i64
  %7 = getelementptr inbounds double* %c, i64 %6
  %8 = load double* %7
  %9 = fsub double %8, %x
  %10 = sext i32 %i.0 to i64
  %11 = getelementptr inbounds double* %beta, i64 %10
  %12 = load double* %11
  %13 = fdiv double %12, %q.1
  %14 = fsub double %9, %13
  br label %26

; <label>:15                                      ; preds = %3
  %16 = sext i32 %i.0 to i64
  %17 = getelementptr inbounds double* %c, i64 %16
  %18 = load double* %17
  %19 = fsub double %18, %x
  %20 = sext i32 %i.0 to i64
  %21 = getelementptr inbounds double* %b, i64 %20
  %22 = load double* %21
  %23 = call double @fabs(double %22)
  %24 = fdiv double %23, 0x3CB0000000000000
  %25 = fsub double %19, %24
  br label %26

; <label>:26                                      ; preds = %15, %5
  %q.0 = phi double [ %14, %5 ], [ %25, %15 ]
  %27 = fcmp olt double %q.0, 0.000000e+00
  br i1 %27, label %28, label %30

; <label>:28                                      ; preds = %26
  %29 = add nsw i32 %a.1, 1
  br label %30

; <label>:30                                      ; preds = %28, %26
  %a.0 = phi i32 [ %29, %28 ], [ %a.1, %26 ]
  br label %31

; <label>:31                                      ; preds = %30
  %32 = add nsw i32 %i.0, 1
  br label %1

; <label>:33                                      ; preds = %1
  ret i32 %a.1
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
  %7 = sub nsw i32 %n, 1
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds double* %b, i64 %8
  %10 = load double* %9
  %11 = call double @fabs(double %10)
  %12 = fmul double 1.010000e+00, %11
  %13 = fsub double %6, %12
  %14 = sub nsw i32 %n, 1
  %15 = sext i32 %14 to i64
  %16 = getelementptr inbounds double* %c, i64 %15
  %17 = load double* %16
  %18 = sub nsw i32 %n, 1
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds double* %b, i64 %19
  %21 = load double* %20
  %22 = call double @fabs(double %21)
  %23 = fmul double 1.010000e+00, %22
  %24 = fadd double %17, %23
  %25 = sub nsw i32 %n, 2
  br label %26

; <label>:26                                      ; preds = %62, %0
  %i.0 = phi i32 [ %25, %0 ], [ %63, %62 ]
  %xmin.1 = phi double [ %13, %0 ], [ %xmin.0, %62 ]
  %xmax.1 = phi double [ %24, %0 ], [ %xmax.0, %62 ]
  %27 = icmp sge i32 %i.0, 0
  br i1 %27, label %28, label %64

; <label>:28                                      ; preds = %26
  %29 = sext i32 %i.0 to i64
  %30 = getelementptr inbounds double* %b, i64 %29
  %31 = load double* %30
  %32 = call double @fabs(double %31)
  %33 = add nsw i32 %i.0, 1
  %34 = sext i32 %33 to i64
  %35 = getelementptr inbounds double* %b, i64 %34
  %36 = load double* %35
  %37 = call double @fabs(double %36)
  %38 = fadd double %32, %37
  %39 = fmul double 1.010000e+00, %38
  %40 = sext i32 %i.0 to i64
  %41 = getelementptr inbounds double* %c, i64 %40
  %42 = load double* %41
  %43 = fadd double %42, %39
  %44 = fcmp ogt double %43, %xmax.1
  br i1 %44, label %45, label %50

; <label>:45                                      ; preds = %28
  %46 = sext i32 %i.0 to i64
  %47 = getelementptr inbounds double* %c, i64 %46
  %48 = load double* %47
  %49 = fadd double %48, %39
  br label %50

; <label>:50                                      ; preds = %45, %28
  %xmax.0 = phi double [ %49, %45 ], [ %xmax.1, %28 ]
  %51 = sext i32 %i.0 to i64
  %52 = getelementptr inbounds double* %c, i64 %51
  %53 = load double* %52
  %54 = fsub double %53, %39
  %55 = fcmp olt double %54, %xmin.1
  br i1 %55, label %56, label %61

; <label>:56                                      ; preds = %50
  %57 = sext i32 %i.0 to i64
  %58 = getelementptr inbounds double* %c, i64 %57
  %59 = load double* %58
  %60 = fsub double %59, %39
  br label %61

; <label>:61                                      ; preds = %56, %50
  %xmin.0 = phi double [ %60, %56 ], [ %xmin.1, %50 ]
  br label %62

; <label>:62                                      ; preds = %61
  %63 = add nsw i32 %i.0, -1
  br label %26

; <label>:64                                      ; preds = %26
  %65 = fadd double %xmin.1, %xmax.1
  %66 = fcmp ogt double %65, 0.000000e+00
  br i1 %66, label %67, label %68

; <label>:67                                      ; preds = %64
  br label %70

; <label>:68                                      ; preds = %64
  %69 = fsub double -0.000000e+00, %xmin.1
  br label %70

; <label>:70                                      ; preds = %68, %67
  %71 = phi double [ %xmax.1, %67 ], [ %69, %68 ]
  %72 = fmul double 0x3CB0000000000000, %71
  store double %72, double* %eps2
  %73 = fcmp ole double %eps1, 0.000000e+00
  br i1 %73, label %74, label %76

; <label>:74                                      ; preds = %70
  %75 = load double* %eps2
  br label %76

; <label>:76                                      ; preds = %74, %70
  %.0 = phi double [ %75, %74 ], [ %eps1, %70 ]
  %77 = fmul double 5.000000e-01, %.0
  %78 = load double* %eps2
  %79 = fmul double 7.000000e+00, %78
  %80 = fadd double %77, %79
  store double %80, double* %eps2
  %81 = add nsw i32 %n, 1
  %82 = sext i32 %81 to i64
  %83 = call i8* @calloc(i64 %82, i64 8)
  %84 = bitcast i8* %83 to double*
  %85 = icmp eq double* %84, null
  br i1 %85, label %86, label %89

; <label>:86                                      ; preds = %76
  %87 = load %struct.__sFILE** @__stderrp, align 8
  %88 = call i32 @"\01_fputs"(i8* getelementptr inbounds ([40 x i8]* @.str1, i32 0, i32 0), %struct.__sFILE* %87)
  call void @exit(i32 1) noreturn
  unreachable

; <label>:89                                      ; preds = %76
  br label %90

; <label>:90                                      ; preds = %97, %89
  %i.1 = phi i32 [ %m2, %89 ], [ %98, %97 ]
  %91 = icmp sge i32 %i.1, %m1
  br i1 %91, label %92, label %99

; <label>:92                                      ; preds = %90
  %93 = sext i32 %i.1 to i64
  %94 = getelementptr inbounds double* %x, i64 %93
  store double %xmax.1, double* %94
  %95 = sext i32 %i.1 to i64
  %96 = getelementptr inbounds double* %84, i64 %95
  store double %xmin.1, double* %96
  br label %97

; <label>:97                                      ; preds = %92
  %98 = add nsw i32 %i.1, -1
  br label %90

; <label>:99                                      ; preds = %90
  store i32 0, i32* %z
  br label %100

; <label>:100                                     ; preds = %169, %99
  %k.0 = phi i32 [ %m2, %99 ], [ %170, %169 ]
  %x0.1 = phi double [ %xmax.1, %99 ], [ %x0.3, %169 ]
  %101 = icmp sge i32 %k.0, %m1
  br i1 %101, label %102, label %171

; <label>:102                                     ; preds = %100
  br label %103

; <label>:103                                     ; preds = %115, %102
  %i.2 = phi i32 [ %k.0, %102 ], [ %116, %115 ]
  %104 = icmp sge i32 %i.2, %m1
  br i1 %104, label %105, label %117

; <label>:105                                     ; preds = %103
  %106 = sext i32 %i.2 to i64
  %107 = getelementptr inbounds double* %84, i64 %106
  %108 = load double* %107
  %109 = fcmp olt double %xmin.1, %108
  br i1 %109, label %110, label %114

; <label>:110                                     ; preds = %105
  %111 = sext i32 %i.2 to i64
  %112 = getelementptr inbounds double* %84, i64 %111
  %113 = load double* %112
  br label %117

; <label>:114                                     ; preds = %105
  br label %115

; <label>:115                                     ; preds = %114
  %116 = add nsw i32 %i.2, -1
  br label %103

; <label>:117                                     ; preds = %110, %103
  %xu.0 = phi double [ %113, %110 ], [ %xmin.1, %103 ]
  %118 = sext i32 %k.0 to i64
  %119 = getelementptr inbounds double* %x, i64 %118
  %120 = load double* %119
  %121 = fcmp ogt double %x0.1, %120
  br i1 %121, label %122, label %126

; <label>:122                                     ; preds = %117
  %123 = sext i32 %k.0 to i64
  %124 = getelementptr inbounds double* %x, i64 %123
  %125 = load double* %124
  br label %126

; <label>:126                                     ; preds = %122, %117
  %x0.0 = phi double [ %125, %122 ], [ %x0.1, %117 ]
  %127 = fadd double %xu.0, %x0.0
  %128 = fdiv double %127, 2.000000e+00
  br label %129

; <label>:129                                     ; preds = %161, %126
  %x1.0 = phi double [ %128, %126 ], [ %163, %161 ]
  %xu.3 = phi double [ %xu.0, %126 ], [ %xu.2, %161 ]
  %x0.3 = phi double [ %x0.0, %126 ], [ %x0.2, %161 ]
  %130 = fsub double %x0.3, %xu.3
  %131 = call double @fabs(double %xu.3)
  %132 = call double @fabs(double %x0.3)
  %133 = fadd double %131, %132
  %134 = fmul double 0x3CC0000000000000, %133
  %135 = fadd double %134, %.0
  %136 = fcmp ogt double %130, %135
  br i1 %136, label %137, label %164

; <label>:137                                     ; preds = %129
  %138 = load i32* %z
  %139 = add nsw i32 %138, 1
  store i32 %139, i32* %z
  %140 = call i32 @sturm(i32 %n, double* %c, double* %b, double* %beta, double %x1.0)
  %141 = icmp slt i32 %140, %k.0
  br i1 %141, label %142, label %160

; <label>:142                                     ; preds = %137
  %143 = icmp slt i32 %140, %m1
  br i1 %143, label %144, label %147

; <label>:144                                     ; preds = %142
  %145 = sext i32 %m1 to i64
  %146 = getelementptr inbounds double* %84, i64 %145
  store double %x1.0, double* %146
  br label %159

; <label>:147                                     ; preds = %142
  %148 = add nsw i32 %140, 1
  %149 = sext i32 %148 to i64
  %150 = getelementptr inbounds double* %84, i64 %149
  store double %x1.0, double* %150
  %151 = sext i32 %140 to i64
  %152 = getelementptr inbounds double* %x, i64 %151
  %153 = load double* %152
  %154 = fcmp ogt double %153, %x1.0
  br i1 %154, label %155, label %158

; <label>:155                                     ; preds = %147
  %156 = sext i32 %140 to i64
  %157 = getelementptr inbounds double* %x, i64 %156
  store double %x1.0, double* %157
  br label %158

; <label>:158                                     ; preds = %155, %147
  br label %159

; <label>:159                                     ; preds = %158, %144
  br label %161

; <label>:160                                     ; preds = %137
  br label %161

; <label>:161                                     ; preds = %160, %159
  %xu.2 = phi double [ %x1.0, %159 ], [ %xu.3, %160 ]
  %x0.2 = phi double [ %x0.3, %159 ], [ %x1.0, %160 ]
  %162 = fadd double %xu.2, %x0.2
  %163 = fdiv double %162, 2.000000e+00
  br label %129

; <label>:164                                     ; preds = %129
  %165 = fadd double %xu.3, %x0.3
  %166 = fdiv double %165, 2.000000e+00
  %167 = sext i32 %k.0 to i64
  %168 = getelementptr inbounds double* %x, i64 %167
  store double %166, double* %168
  br label %169

; <label>:169                                     ; preds = %164
  %170 = add nsw i32 %k.0, -1
  br label %100

; <label>:171                                     ; preds = %100
  %172 = bitcast double* %84 to i8*
  call void @free(i8* %172)
  ret void
}

declare i8* @calloc(i64, i64)

declare i32 @"\01_fputs"(i8*, %struct.__sFILE*)

declare void @free(i8*)

define void @test_matrix(i32 %n, double* %C, double* %B) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %23, %0
  %i.0 = phi i32 [ 0, %0 ], [ %24, %23 ]
  %2 = icmp slt i32 %i.0, %n
  br i1 %2, label %3, label %25

; <label>:3                                       ; preds = %1
  %4 = sitofp i32 %i.0 to double
  %5 = sext i32 %i.0 to i64
  %6 = getelementptr inbounds double* %B, i64 %5
  store double %4, double* %6
  %7 = add nsw i32 %i.0, 1
  %8 = sitofp i32 %7 to double
  %9 = add nsw i32 %i.0, 1
  %10 = sitofp i32 %9 to double
  %11 = fmul double %8, %10
  %12 = sext i32 %i.0 to i64
  %13 = getelementptr inbounds double* %C, i64 %12
  store double %11, double* %13
  %14 = sext i32 %i.0 to i64
  %15 = getelementptr inbounds double* %C, i64 %14
  %16 = load double* %15
  %17 = sext i32 %i.0 to i64
  %18 = getelementptr inbounds double* %C, i64 %17
  %19 = load double* %18
  %20 = fmul double %16, %19
  %21 = sext i32 %i.0 to i64
  %22 = getelementptr inbounds double* %C, i64 %21
  store double %20, double* %22
  br label %23

; <label>:23                                      ; preds = %3
  %24 = add nsw i32 %i.0, 1
  br label %1

; <label>:25                                      ; preds = %1
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

; <label>:1                                       ; preds = %36, %0
  %j.0 = phi i32 [ 0, %0 ], [ %37, %36 ]
  %2 = icmp slt i32 %j.0, 50
  br i1 %2, label %3, label %38

; <label>:3                                       ; preds = %1
  %4 = load double** %D, align 8
  %5 = load double** %E, align 8
  call void @test_matrix(i32 500, double* %4, double* %5)
  br label %6

; <label>:6                                       ; preds = %24, %3
  %i.0 = phi i32 [ 0, %3 ], [ %25, %24 ]
  %7 = icmp slt i32 %i.0, 500
  br i1 %7, label %8, label %26

; <label>:8                                       ; preds = %6
  %9 = sext i32 %i.0 to i64
  %10 = load double** %E, align 8
  %11 = getelementptr inbounds double* %10, i64 %9
  %12 = load double* %11
  %13 = sext i32 %i.0 to i64
  %14 = load double** %E, align 8
  %15 = getelementptr inbounds double* %14, i64 %13
  %16 = load double* %15
  %17 = fmul double %12, %16
  %18 = sext i32 %i.0 to i64
  %19 = load double** %beta, align 8
  %20 = getelementptr inbounds double* %19, i64 %18
  store double %17, double* %20
  %21 = sext i32 %i.0 to i64
  %22 = load double** %S, align 8
  %23 = getelementptr inbounds double* %22, i64 %21
  store double 0.000000e+00, double* %23
  br label %24

; <label>:24                                      ; preds = %8
  %25 = add nsw i32 %i.0, 1
  br label %6

; <label>:26                                      ; preds = %6
  %27 = load double** %beta, align 8
  %28 = getelementptr inbounds double* %27, i64 0
  store double 0.000000e+00, double* %28
  %29 = load double** %E, align 8
  %30 = getelementptr inbounds double* %29, i64 0
  store double 0.000000e+00, double* %30
  %31 = load double** %D, align 8
  %32 = load double** %E, align 8
  %33 = load double** %beta, align 8
  %34 = load double** %S, align 8
  %35 = getelementptr inbounds double* %34, i64 -1
  call void @dbisect(double* %31, double* %32, double* %33, i32 500, i32 1, i32 500, double 0x3CB0000000000000, double* %eps2, i32* %k, double* %35)
  br label %36

; <label>:36                                      ; preds = %26
  %37 = add nsw i32 %j.0, 1
  br label %1

; <label>:38                                      ; preds = %1
  br label %39

; <label>:39                                      ; preds = %48, %38
  %i.1 = phi i32 [ 1, %38 ], [ %49, %48 ]
  %40 = icmp slt i32 %i.1, 20
  br i1 %40, label %41, label %50

; <label>:41                                      ; preds = %39
  %42 = add nsw i32 %i.1, 1
  %43 = sext i32 %i.1 to i64
  %44 = load double** %S, align 8
  %45 = getelementptr inbounds double* %44, i64 %43
  %46 = load double* %45
  %47 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i32 0, i32 0), i32 %42, double %46)
  br label %48

; <label>:48                                      ; preds = %41
  %49 = add nsw i32 %i.1, 1
  br label %39

; <label>:50                                      ; preds = %39
  %51 = load double* %eps2, align 8
  %52 = load i32* %k, align 4
  %53 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str3, i32 0, i32 0), double %51, i32 %52)
  ret i32 0
}

declare i32 @printf(i8*, ...)
