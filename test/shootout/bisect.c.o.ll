; ModuleID = 'bisect.c.o'
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
  %1 = alloca i64, align 8
  %V = alloca i8*, align 8
  store i64 %size, i64* %1, align 8
  %2 = load i64* %1, align 8
  %3 = call i8* @malloc(i64 %2)
  store i8* %3, i8** %V, align 8
  %4 = icmp eq i8* %3, null
  br i1 %4, label %5, label %8

; <label>:5                                       ; preds = %0
  %6 = load %struct.__sFILE** @__stderrp, align 8
  %7 = call i32 (%struct.__sFILE*, i8*, ...)* @fprintf(%struct.__sFILE* %6, i8* getelementptr inbounds ([44 x i8]* @.str, i32 0, i32 0))
  call void @exit(i32 2) noreturn
  unreachable

; <label>:8                                       ; preds = %0
  %9 = load i8** %V, align 8
  %10 = call i64 @llvm.objectsize.i64(i8* %9, i1 false)
  %11 = icmp ne i64 %10, -1
  br i1 %11, label %12, label %18

; <label>:12                                      ; preds = %8
  %13 = load i8** %V, align 8
  %14 = load i64* %1, align 8
  %15 = load i8** %V, align 8
  %16 = call i64 @llvm.objectsize.i64(i8* %15, i1 false)
  %17 = call i8* @__memset_chk(i8* %13, i32 0, i64 %14, i64 %16)
  br label %22

; <label>:18                                      ; preds = %8
  %19 = load i8** %V, align 8
  %20 = load i64* %1, align 8
  %21 = call i8* @__inline_memset_chk(i8* %19, i32 0, i64 %20)
  br label %22

; <label>:22                                      ; preds = %18, %12
  %23 = phi i8* [ %17, %12 ], [ %21, %18 ]
  %24 = load i8** %V, align 8
  ret i8* %24
}

declare i8* @malloc(i64)

declare i32 @fprintf(%struct.__sFILE*, i8*, ...)

declare void @exit(i32) noreturn

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

declare i8* @__memset_chk(i8*, i32, i64, i64) nounwind

define internal i8* @__inline_memset_chk(i8* %__dest, i32 %__val, i64 %__len) nounwind inlinehint ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  store i8* %__dest, i8** %1, align 8
  store i32 %__val, i32* %2, align 4
  store i64 %__len, i64* %3, align 8
  %4 = load i8** %1, align 8
  %5 = load i32* %2, align 4
  %6 = load i64* %3, align 8
  %7 = load i8** %1, align 8
  %8 = call i64 @llvm.objectsize.i64(i8* %7, i1 false)
  %9 = call i8* @__memset_chk(i8* %4, i32 %5, i64 %6, i64 %8)
  ret i8* %9
}

define void @dallocvector(i32 %n, double** %V) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca double**, align 8
  store i32 %n, i32* %1, align 4
  store double** %V, double*** %2, align 8
  %3 = load i32* %1, align 4
  %4 = sext i32 %3 to i64
  %5 = mul i64 %4, 8
  %6 = call i8* @allocvector(i64 %5)
  %7 = bitcast i8* %6 to double*
  %8 = load double*** %2, align 8
  store double* %7, double** %8
  ret void
}

define i32 @sturm(i32 %n, double* %c, double* %b, double* %beta, double %x) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca double*, align 8
  %3 = alloca double*, align 8
  %4 = alloca double*, align 8
  %5 = alloca double, align 8
  %i = alloca i32, align 4
  %a = alloca i32, align 4
  %q = alloca double, align 8
  store i32 %n, i32* %1, align 4
  store double* %c, double** %2, align 8
  store double* %b, double** %3, align 8
  store double* %beta, double** %4, align 8
  store double %x, double* %5, align 8
  store i32 0, i32* %a, align 4
  store double 1.000000e+00, double* %q, align 8
  store i32 0, i32* %i, align 4
  br label %6

; <label>:6                                       ; preds = %52, %0
  %7 = load i32* %i, align 4
  %8 = load i32* %1, align 4
  %9 = icmp slt i32 %7, %8
  br i1 %9, label %10, label %55

; <label>:10                                      ; preds = %6
  %11 = load double* %q, align 8
  %12 = fcmp une double %11, 0.000000e+00
  br i1 %12, label %13, label %29

; <label>:13                                      ; preds = %10
  %14 = load i32* %i, align 4
  %15 = sext i32 %14 to i64
  %16 = load double** %2, align 8
  %17 = getelementptr inbounds double* %16, i64 %15
  %18 = load double* %17
  %19 = load double* %5, align 8
  %20 = fsub double %18, %19
  %21 = load i32* %i, align 4
  %22 = sext i32 %21 to i64
  %23 = load double** %4, align 8
  %24 = getelementptr inbounds double* %23, i64 %22
  %25 = load double* %24
  %26 = load double* %q, align 8
  %27 = fdiv double %25, %26
  %28 = fsub double %20, %27
  store double %28, double* %q, align 8
  br label %45

; <label>:29                                      ; preds = %10
  %30 = load i32* %i, align 4
  %31 = sext i32 %30 to i64
  %32 = load double** %2, align 8
  %33 = getelementptr inbounds double* %32, i64 %31
  %34 = load double* %33
  %35 = load double* %5, align 8
  %36 = fsub double %34, %35
  %37 = load i32* %i, align 4
  %38 = sext i32 %37 to i64
  %39 = load double** %3, align 8
  %40 = getelementptr inbounds double* %39, i64 %38
  %41 = load double* %40
  %42 = call double @fabs(double %41)
  %43 = fdiv double %42, 0x3CB0000000000000
  %44 = fsub double %36, %43
  store double %44, double* %q, align 8
  br label %45

; <label>:45                                      ; preds = %29, %13
  %46 = load double* %q, align 8
  %47 = fcmp olt double %46, 0.000000e+00
  br i1 %47, label %48, label %51

; <label>:48                                      ; preds = %45
  %49 = load i32* %a, align 4
  %50 = add nsw i32 %49, 1
  store i32 %50, i32* %a, align 4
  br label %51

; <label>:51                                      ; preds = %48, %45
  br label %52

; <label>:52                                      ; preds = %51
  %53 = load i32* %i, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, i32* %i, align 4
  br label %6

; <label>:55                                      ; preds = %6
  %56 = load i32* %a, align 4
  ret i32 %56
}

declare double @fabs(double)

define void @dbisect(double* %c, double* %b, double* %beta, i32 %n, i32 %m1, i32 %m2, double %eps1, double* %eps2, i32* %z, double* %x) nounwind ssp {
  %1 = alloca double*, align 8
  %2 = alloca double*, align 8
  %3 = alloca double*, align 8
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca double, align 8
  %8 = alloca double*, align 8
  %9 = alloca i32*, align 8
  %10 = alloca double*, align 8
  %i = alloca i32, align 4
  %h = alloca double, align 8
  %xmin = alloca double, align 8
  %xmax = alloca double, align 8
  %a = alloca i32, align 4
  %k = alloca i32, align 4
  %x1 = alloca double, align 8
  %xu = alloca double, align 8
  %x0 = alloca double, align 8
  %wu = alloca double*, align 8
  store double* %c, double** %1, align 8
  store double* %b, double** %2, align 8
  store double* %beta, double** %3, align 8
  store i32 %n, i32* %4, align 4
  store i32 %m1, i32* %5, align 4
  store i32 %m2, i32* %6, align 4
  store double %eps1, double* %7, align 8
  store double* %eps2, double** %8, align 8
  store i32* %z, i32** %9, align 8
  store double* %x, double** %10, align 8
  %11 = load double** %2, align 8
  %12 = getelementptr inbounds double* %11, i64 0
  store double 0.000000e+00, double* %12
  %13 = load double** %3, align 8
  %14 = getelementptr inbounds double* %13, i64 0
  store double 0.000000e+00, double* %14
  %15 = load i32* %4, align 4
  %16 = sub nsw i32 %15, 1
  %17 = sext i32 %16 to i64
  %18 = load double** %1, align 8
  %19 = getelementptr inbounds double* %18, i64 %17
  %20 = load double* %19
  %21 = load i32* %4, align 4
  %22 = sub nsw i32 %21, 1
  %23 = sext i32 %22 to i64
  %24 = load double** %2, align 8
  %25 = getelementptr inbounds double* %24, i64 %23
  %26 = load double* %25
  %27 = call double @fabs(double %26)
  %28 = fmul double 1.010000e+00, %27
  %29 = fsub double %20, %28
  store double %29, double* %xmin, align 8
  %30 = load i32* %4, align 4
  %31 = sub nsw i32 %30, 1
  %32 = sext i32 %31 to i64
  %33 = load double** %1, align 8
  %34 = getelementptr inbounds double* %33, i64 %32
  %35 = load double* %34
  %36 = load i32* %4, align 4
  %37 = sub nsw i32 %36, 1
  %38 = sext i32 %37 to i64
  %39 = load double** %2, align 8
  %40 = getelementptr inbounds double* %39, i64 %38
  %41 = load double* %40
  %42 = call double @fabs(double %41)
  %43 = fmul double 1.010000e+00, %42
  %44 = fadd double %35, %43
  store double %44, double* %xmax, align 8
  %45 = load i32* %4, align 4
  %46 = sub nsw i32 %45, 2
  store i32 %46, i32* %i, align 4
  br label %47

; <label>:47                                      ; preds = %102, %0
  %48 = load i32* %i, align 4
  %49 = icmp sge i32 %48, 0
  br i1 %49, label %50, label %105

; <label>:50                                      ; preds = %47
  %51 = load i32* %i, align 4
  %52 = sext i32 %51 to i64
  %53 = load double** %2, align 8
  %54 = getelementptr inbounds double* %53, i64 %52
  %55 = load double* %54
  %56 = call double @fabs(double %55)
  %57 = load i32* %i, align 4
  %58 = add nsw i32 %57, 1
  %59 = sext i32 %58 to i64
  %60 = load double** %2, align 8
  %61 = getelementptr inbounds double* %60, i64 %59
  %62 = load double* %61
  %63 = call double @fabs(double %62)
  %64 = fadd double %56, %63
  %65 = fmul double 1.010000e+00, %64
  store double %65, double* %h, align 8
  %66 = load i32* %i, align 4
  %67 = sext i32 %66 to i64
  %68 = load double** %1, align 8
  %69 = getelementptr inbounds double* %68, i64 %67
  %70 = load double* %69
  %71 = load double* %h, align 8
  %72 = fadd double %70, %71
  %73 = load double* %xmax, align 8
  %74 = fcmp ogt double %72, %73
  br i1 %74, label %75, label %83

; <label>:75                                      ; preds = %50
  %76 = load i32* %i, align 4
  %77 = sext i32 %76 to i64
  %78 = load double** %1, align 8
  %79 = getelementptr inbounds double* %78, i64 %77
  %80 = load double* %79
  %81 = load double* %h, align 8
  %82 = fadd double %80, %81
  store double %82, double* %xmax, align 8
  br label %83

; <label>:83                                      ; preds = %75, %50
  %84 = load i32* %i, align 4
  %85 = sext i32 %84 to i64
  %86 = load double** %1, align 8
  %87 = getelementptr inbounds double* %86, i64 %85
  %88 = load double* %87
  %89 = load double* %h, align 8
  %90 = fsub double %88, %89
  %91 = load double* %xmin, align 8
  %92 = fcmp olt double %90, %91
  br i1 %92, label %93, label %101

; <label>:93                                      ; preds = %83
  %94 = load i32* %i, align 4
  %95 = sext i32 %94 to i64
  %96 = load double** %1, align 8
  %97 = getelementptr inbounds double* %96, i64 %95
  %98 = load double* %97
  %99 = load double* %h, align 8
  %100 = fsub double %98, %99
  store double %100, double* %xmin, align 8
  br label %101

; <label>:101                                     ; preds = %93, %83
  br label %102

; <label>:102                                     ; preds = %101
  %103 = load i32* %i, align 4
  %104 = add nsw i32 %103, -1
  store i32 %104, i32* %i, align 4
  br label %47

; <label>:105                                     ; preds = %47
  %106 = load double* %xmin, align 8
  %107 = load double* %xmax, align 8
  %108 = fadd double %106, %107
  %109 = fcmp ogt double %108, 0.000000e+00
  br i1 %109, label %110, label %112

; <label>:110                                     ; preds = %105
  %111 = load double* %xmax, align 8
  br label %115

; <label>:112                                     ; preds = %105
  %113 = load double* %xmin, align 8
  %114 = fsub double -0.000000e+00, %113
  br label %115

; <label>:115                                     ; preds = %112, %110
  %116 = phi double [ %111, %110 ], [ %114, %112 ]
  %117 = fmul double 0x3CB0000000000000, %116
  %118 = load double** %8, align 8
  store double %117, double* %118
  %119 = load double* %7, align 8
  %120 = fcmp ole double %119, 0.000000e+00
  br i1 %120, label %121, label %124

; <label>:121                                     ; preds = %115
  %122 = load double** %8, align 8
  %123 = load double* %122
  store double %123, double* %7, align 8
  br label %124

; <label>:124                                     ; preds = %121, %115
  %125 = load double* %7, align 8
  %126 = fmul double 5.000000e-01, %125
  %127 = load double** %8, align 8
  %128 = load double* %127
  %129 = fmul double 7.000000e+00, %128
  %130 = fadd double %126, %129
  %131 = load double** %8, align 8
  store double %130, double* %131
  %132 = load i32* %4, align 4
  %133 = add nsw i32 %132, 1
  %134 = sext i32 %133 to i64
  %135 = call i8* @calloc(i64 %134, i64 8)
  %136 = bitcast i8* %135 to double*
  store double* %136, double** %wu, align 8
  %137 = icmp eq double* %136, null
  br i1 %137, label %138, label %141

; <label>:138                                     ; preds = %124
  %139 = load %struct.__sFILE** @__stderrp, align 8
  %140 = call i32 @"\01_fputs"(i8* getelementptr inbounds ([40 x i8]* @.str1, i32 0, i32 0), %struct.__sFILE* %139)
  call void @exit(i32 1) noreturn
  unreachable

; <label>:141                                     ; preds = %124
  %142 = load double* %xmax, align 8
  store double %142, double* %x0, align 8
  %143 = load i32* %6, align 4
  store i32 %143, i32* %i, align 4
  br label %144

; <label>:144                                     ; preds = %159, %141
  %145 = load i32* %i, align 4
  %146 = load i32* %5, align 4
  %147 = icmp sge i32 %145, %146
  br i1 %147, label %148, label %162

; <label>:148                                     ; preds = %144
  %149 = load double* %xmax, align 8
  %150 = load i32* %i, align 4
  %151 = sext i32 %150 to i64
  %152 = load double** %10, align 8
  %153 = getelementptr inbounds double* %152, i64 %151
  store double %149, double* %153
  %154 = load double* %xmin, align 8
  %155 = load i32* %i, align 4
  %156 = sext i32 %155 to i64
  %157 = load double** %wu, align 8
  %158 = getelementptr inbounds double* %157, i64 %156
  store double %154, double* %158
  br label %159

; <label>:159                                     ; preds = %148
  %160 = load i32* %i, align 4
  %161 = add nsw i32 %160, -1
  store i32 %161, i32* %i, align 4
  br label %144

; <label>:162                                     ; preds = %144
  %163 = load i32** %9, align 8
  store i32 0, i32* %163
  %164 = load i32* %6, align 4
  store i32 %164, i32* %k, align 4
  br label %165

; <label>:165                                     ; preds = %288, %162
  %166 = load i32* %k, align 4
  %167 = load i32* %5, align 4
  %168 = icmp sge i32 %166, %167
  br i1 %168, label %169, label %291

; <label>:169                                     ; preds = %165
  %170 = load double* %xmin, align 8
  store double %170, double* %xu, align 8
  %171 = load i32* %k, align 4
  store i32 %171, i32* %i, align 4
  br label %172

; <label>:172                                     ; preds = %191, %169
  %173 = load i32* %i, align 4
  %174 = load i32* %5, align 4
  %175 = icmp sge i32 %173, %174
  br i1 %175, label %176, label %194

; <label>:176                                     ; preds = %172
  %177 = load double* %xu, align 8
  %178 = load i32* %i, align 4
  %179 = sext i32 %178 to i64
  %180 = load double** %wu, align 8
  %181 = getelementptr inbounds double* %180, i64 %179
  %182 = load double* %181
  %183 = fcmp olt double %177, %182
  br i1 %183, label %184, label %190

; <label>:184                                     ; preds = %176
  %185 = load i32* %i, align 4
  %186 = sext i32 %185 to i64
  %187 = load double** %wu, align 8
  %188 = getelementptr inbounds double* %187, i64 %186
  %189 = load double* %188
  store double %189, double* %xu, align 8
  br label %194

; <label>:190                                     ; preds = %176
  br label %191

; <label>:191                                     ; preds = %190
  %192 = load i32* %i, align 4
  %193 = add nsw i32 %192, -1
  store i32 %193, i32* %i, align 4
  br label %172

; <label>:194                                     ; preds = %184, %172
  %195 = load double* %x0, align 8
  %196 = load i32* %k, align 4
  %197 = sext i32 %196 to i64
  %198 = load double** %10, align 8
  %199 = getelementptr inbounds double* %198, i64 %197
  %200 = load double* %199
  %201 = fcmp ogt double %195, %200
  br i1 %201, label %202, label %208

; <label>:202                                     ; preds = %194
  %203 = load i32* %k, align 4
  %204 = sext i32 %203 to i64
  %205 = load double** %10, align 8
  %206 = getelementptr inbounds double* %205, i64 %204
  %207 = load double* %206
  store double %207, double* %x0, align 8
  br label %208

; <label>:208                                     ; preds = %202, %194
  %209 = load double* %xu, align 8
  %210 = load double* %x0, align 8
  %211 = fadd double %209, %210
  %212 = fdiv double %211, 2.000000e+00
  store double %212, double* %x1, align 8
  br label %213

; <label>:213                                     ; preds = %274, %208
  %214 = load double* %x0, align 8
  %215 = load double* %xu, align 8
  %216 = fsub double %214, %215
  %217 = load double* %xu, align 8
  %218 = call double @fabs(double %217)
  %219 = load double* %x0, align 8
  %220 = call double @fabs(double %219)
  %221 = fadd double %218, %220
  %222 = fmul double 0x3CC0000000000000, %221
  %223 = load double* %7, align 8
  %224 = fadd double %222, %223
  %225 = fcmp ogt double %216, %224
  br i1 %225, label %226, label %279

; <label>:226                                     ; preds = %213
  %227 = load i32** %9, align 8
  %228 = load i32* %227
  %229 = add nsw i32 %228, 1
  %230 = load i32** %9, align 8
  store i32 %229, i32* %230
  %231 = load i32* %4, align 4
  %232 = load double** %1, align 8
  %233 = load double** %2, align 8
  %234 = load double** %3, align 8
  %235 = load double* %x1, align 8
  %236 = call i32 @sturm(i32 %231, double* %232, double* %233, double* %234, double %235)
  store i32 %236, i32* %a, align 4
  %237 = load i32* %a, align 4
  %238 = load i32* %k, align 4
  %239 = icmp slt i32 %237, %238
  br i1 %239, label %240, label %272

; <label>:240                                     ; preds = %226
  %241 = load i32* %a, align 4
  %242 = load i32* %5, align 4
  %243 = icmp slt i32 %241, %242
  br i1 %243, label %244, label %250

; <label>:244                                     ; preds = %240
  %245 = load double* %x1, align 8
  %246 = load i32* %5, align 4
  %247 = sext i32 %246 to i64
  %248 = load double** %wu, align 8
  %249 = getelementptr inbounds double* %248, i64 %247
  store double %245, double* %249
  store double %245, double* %xu, align 8
  br label %271

; <label>:250                                     ; preds = %240
  %251 = load double* %x1, align 8
  %252 = load i32* %a, align 4
  %253 = add nsw i32 %252, 1
  %254 = sext i32 %253 to i64
  %255 = load double** %wu, align 8
  %256 = getelementptr inbounds double* %255, i64 %254
  store double %251, double* %256
  store double %251, double* %xu, align 8
  %257 = load i32* %a, align 4
  %258 = sext i32 %257 to i64
  %259 = load double** %10, align 8
  %260 = getelementptr inbounds double* %259, i64 %258
  %261 = load double* %260
  %262 = load double* %x1, align 8
  %263 = fcmp ogt double %261, %262
  br i1 %263, label %264, label %270

; <label>:264                                     ; preds = %250
  %265 = load double* %x1, align 8
  %266 = load i32* %a, align 4
  %267 = sext i32 %266 to i64
  %268 = load double** %10, align 8
  %269 = getelementptr inbounds double* %268, i64 %267
  store double %265, double* %269
  br label %270

; <label>:270                                     ; preds = %264, %250
  br label %271

; <label>:271                                     ; preds = %270, %244
  br label %274

; <label>:272                                     ; preds = %226
  %273 = load double* %x1, align 8
  store double %273, double* %x0, align 8
  br label %274

; <label>:274                                     ; preds = %272, %271
  %275 = load double* %xu, align 8
  %276 = load double* %x0, align 8
  %277 = fadd double %275, %276
  %278 = fdiv double %277, 2.000000e+00
  store double %278, double* %x1, align 8
  br label %213

; <label>:279                                     ; preds = %213
  %280 = load double* %xu, align 8
  %281 = load double* %x0, align 8
  %282 = fadd double %280, %281
  %283 = fdiv double %282, 2.000000e+00
  %284 = load i32* %k, align 4
  %285 = sext i32 %284 to i64
  %286 = load double** %10, align 8
  %287 = getelementptr inbounds double* %286, i64 %285
  store double %283, double* %287
  br label %288

; <label>:288                                     ; preds = %279
  %289 = load i32* %k, align 4
  %290 = add nsw i32 %289, -1
  store i32 %290, i32* %k, align 4
  br label %165

; <label>:291                                     ; preds = %165
  %292 = load double** %wu, align 8
  %293 = bitcast double* %292 to i8*
  call void @free(i8* %293)
  ret void
}

declare i8* @calloc(i64, i64)

declare i32 @"\01_fputs"(i8*, %struct.__sFILE*)

declare void @free(i8*)

define void @test_matrix(i32 %n, double* %C, double* %B) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca double*, align 8
  %3 = alloca double*, align 8
  %i = alloca i32, align 4
  store i32 %n, i32* %1, align 4
  store double* %C, double** %2, align 8
  store double* %B, double** %3, align 8
  store i32 0, i32* %i, align 4
  br label %4

; <label>:4                                       ; preds = %41, %0
  %5 = load i32* %i, align 4
  %6 = load i32* %1, align 4
  %7 = icmp slt i32 %5, %6
  br i1 %7, label %8, label %44

; <label>:8                                       ; preds = %4
  %9 = load i32* %i, align 4
  %10 = sitofp i32 %9 to double
  %11 = load i32* %i, align 4
  %12 = sext i32 %11 to i64
  %13 = load double** %3, align 8
  %14 = getelementptr inbounds double* %13, i64 %12
  store double %10, double* %14
  %15 = load i32* %i, align 4
  %16 = add nsw i32 %15, 1
  %17 = sitofp i32 %16 to double
  %18 = load i32* %i, align 4
  %19 = add nsw i32 %18, 1
  %20 = sitofp i32 %19 to double
  %21 = fmul double %17, %20
  %22 = load i32* %i, align 4
  %23 = sext i32 %22 to i64
  %24 = load double** %2, align 8
  %25 = getelementptr inbounds double* %24, i64 %23
  store double %21, double* %25
  %26 = load i32* %i, align 4
  %27 = sext i32 %26 to i64
  %28 = load double** %2, align 8
  %29 = getelementptr inbounds double* %28, i64 %27
  %30 = load double* %29
  %31 = load i32* %i, align 4
  %32 = sext i32 %31 to i64
  %33 = load double** %2, align 8
  %34 = getelementptr inbounds double* %33, i64 %32
  %35 = load double* %34
  %36 = fmul double %30, %35
  %37 = load i32* %i, align 4
  %38 = sext i32 %37 to i64
  %39 = load double** %2, align 8
  %40 = getelementptr inbounds double* %39, i64 %38
  store double %36, double* %40
  br label %41

; <label>:41                                      ; preds = %8
  %42 = load i32* %i, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, i32* %i, align 4
  br label %4

; <label>:44                                      ; preds = %4
  ret void
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %rep = alloca i32, align 4
  %n = alloca i32, align 4
  %k = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %eps = alloca double, align 8
  %eps2 = alloca double, align 8
  %D = alloca double*, align 8
  %E = alloca double*, align 8
  %beta = alloca double*, align 8
  %S = alloca double*, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  store i32 50, i32* %rep, align 4
  store i32 500, i32* %n, align 4
  store double 0x3CB0000000000000, double* %eps, align 8
  %4 = load i32* %n, align 4
  call void @dallocvector(i32 %4, double** %D)
  %5 = load i32* %n, align 4
  call void @dallocvector(i32 %5, double** %E)
  %6 = load i32* %n, align 4
  call void @dallocvector(i32 %6, double** %beta)
  %7 = load i32* %n, align 4
  call void @dallocvector(i32 %7, double** %S)
  store i32 0, i32* %j, align 4
  br label %8

; <label>:8                                       ; preds = %56, %0
  %9 = load i32* %j, align 4
  %10 = load i32* %rep, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %59

; <label>:12                                      ; preds = %8
  %13 = load i32* %n, align 4
  %14 = load double** %D, align 8
  %15 = load double** %E, align 8
  call void @test_matrix(i32 %13, double* %14, double* %15)
  store i32 0, i32* %i, align 4
  br label %16

; <label>:16                                      ; preds = %40, %12
  %17 = load i32* %i, align 4
  %18 = load i32* %n, align 4
  %19 = icmp slt i32 %17, %18
  br i1 %19, label %20, label %43

; <label>:20                                      ; preds = %16
  %21 = load i32* %i, align 4
  %22 = sext i32 %21 to i64
  %23 = load double** %E, align 8
  %24 = getelementptr inbounds double* %23, i64 %22
  %25 = load double* %24
  %26 = load i32* %i, align 4
  %27 = sext i32 %26 to i64
  %28 = load double** %E, align 8
  %29 = getelementptr inbounds double* %28, i64 %27
  %30 = load double* %29
  %31 = fmul double %25, %30
  %32 = load i32* %i, align 4
  %33 = sext i32 %32 to i64
  %34 = load double** %beta, align 8
  %35 = getelementptr inbounds double* %34, i64 %33
  store double %31, double* %35
  %36 = load i32* %i, align 4
  %37 = sext i32 %36 to i64
  %38 = load double** %S, align 8
  %39 = getelementptr inbounds double* %38, i64 %37
  store double 0.000000e+00, double* %39
  br label %40

; <label>:40                                      ; preds = %20
  %41 = load i32* %i, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %i, align 4
  br label %16

; <label>:43                                      ; preds = %16
  %44 = load double** %beta, align 8
  %45 = getelementptr inbounds double* %44, i64 0
  store double 0.000000e+00, double* %45
  %46 = load double** %E, align 8
  %47 = getelementptr inbounds double* %46, i64 0
  store double 0.000000e+00, double* %47
  %48 = load double** %D, align 8
  %49 = load double** %E, align 8
  %50 = load double** %beta, align 8
  %51 = load i32* %n, align 4
  %52 = load i32* %n, align 4
  %53 = load double* %eps, align 8
  %54 = load double** %S, align 8
  %55 = getelementptr inbounds double* %54, i64 -1
  call void @dbisect(double* %48, double* %49, double* %50, i32 %51, i32 1, i32 %52, double %53, double* %eps2, i32* %k, double* %55)
  br label %56

; <label>:56                                      ; preds = %43
  %57 = load i32* %j, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, i32* %j, align 4
  br label %8

; <label>:59                                      ; preds = %8
  store i32 1, i32* %i, align 4
  br label %60

; <label>:60                                      ; preds = %72, %59
  %61 = load i32* %i, align 4
  %62 = icmp slt i32 %61, 20
  br i1 %62, label %63, label %75

; <label>:63                                      ; preds = %60
  %64 = load i32* %i, align 4
  %65 = add nsw i32 %64, 1
  %66 = load i32* %i, align 4
  %67 = sext i32 %66 to i64
  %68 = load double** %S, align 8
  %69 = getelementptr inbounds double* %68, i64 %67
  %70 = load double* %69
  %71 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i32 0, i32 0), i32 %65, double %70)
  br label %72

; <label>:72                                      ; preds = %63
  %73 = load i32* %i, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, i32* %i, align 4
  br label %60

; <label>:75                                      ; preds = %60
  %76 = load double* %eps2, align 8
  %77 = load i32* %k, align 4
  %78 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str3, i32 0, i32 0), double %76, i32 %77)
  ret i32 0
}

declare i32 @printf(i8*, ...)
