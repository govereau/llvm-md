; ModuleID = 'fft.c.m2r.o'
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
  %9 = icmp ne i32 %i.0, %np
  br i1 %9, label %10, label %22

; <label>:10                                      ; preds = %8
  %11 = add nsw i32 %np, 1
  br label %12

; <label>:12                                      ; preds = %19, %10
  %i.1 = phi i32 [ %11, %10 ], [ %20, %19 ]
  %13 = icmp sle i32 %i.1, %i.0
  br i1 %13, label %14, label %21

; <label>:14                                      ; preds = %12
  %15 = sext i32 %i.1 to i64
  %16 = getelementptr inbounds double* %1, i64 %15
  store double 0.000000e+00, double* %16
  %17 = sext i32 %i.1 to i64
  %18 = getelementptr inbounds double* %2, i64 %17
  store double 0.000000e+00, double* %18
  br label %19

; <label>:19                                      ; preds = %14
  %20 = add nsw i32 %i.1, 1
  br label %12

; <label>:21                                      ; preds = %12
  br label %22

; <label>:22                                      ; preds = %21, %8
  %23 = add nsw i32 %i.0, %i.0
  br label %24

; <label>:24                                      ; preds = %153, %22
  %k.0 = phi i32 [ 1, %22 ], [ %154, %153 ]
  %n2.0 = phi i32 [ %23, %22 ], [ %28, %153 ]
  %25 = sub nsw i32 %m.0, 1
  %26 = icmp sle i32 %k.0, %25
  br i1 %26, label %27, label %155

; <label>:27                                      ; preds = %24
  %28 = sdiv i32 %n2.0, 2
  %29 = sdiv i32 %28, 4
  %30 = sitofp i32 %28 to double
  %31 = fdiv double 0x401921FB54442D18, %30
  br label %32

; <label>:32                                      ; preds = %150, %27
  %j.0 = phi i32 [ 1, %27 ], [ %151, %150 ]
  %a.0 = phi double [ 0.000000e+00, %27 ], [ %41, %150 ]
  %33 = icmp sle i32 %j.0, %29
  br i1 %33, label %34, label %152

; <label>:34                                      ; preds = %32
  %35 = fmul double 3.000000e+00, %a.0
  %36 = call double @cos(double %a.0)
  %37 = call double @sin(double %a.0)
  %38 = call double @cos(double %35)
  %39 = call double @sin(double %35)
  %40 = sitofp i32 %j.0 to double
  %41 = fmul double %31, %40
  %42 = mul nsw i32 2, %28
  br label %43

; <label>:43                                      ; preds = %144, %34
  %is.0 = phi i32 [ %j.0, %34 ], [ %147, %144 ]
  %id.0 = phi i32 [ %42, %34 ], [ %148, %144 ]
  %44 = icmp slt i32 %is.0, %i.0
  br i1 %44, label %45, label %149

; <label>:45                                      ; preds = %43
  br label %46

; <label>:46                                      ; preds = %142, %45
  %i0.0 = phi i32 [ %is.0, %45 ], [ %143, %142 ]
  %47 = sub nsw i32 %i.0, 1
  %48 = icmp sle i32 %i0.0, %47
  br i1 %48, label %49, label %144

; <label>:49                                      ; preds = %46
  %50 = add nsw i32 %i0.0, %29
  %51 = add nsw i32 %50, %29
  %52 = add nsw i32 %51, %29
  %53 = sext i32 %i0.0 to i64
  %54 = getelementptr inbounds double* %1, i64 %53
  %55 = load double* %54
  %56 = sext i32 %51 to i64
  %57 = getelementptr inbounds double* %1, i64 %56
  %58 = load double* %57
  %59 = fsub double %55, %58
  %60 = sext i32 %i0.0 to i64
  %61 = getelementptr inbounds double* %1, i64 %60
  %62 = load double* %61
  %63 = sext i32 %51 to i64
  %64 = getelementptr inbounds double* %1, i64 %63
  %65 = load double* %64
  %66 = fadd double %62, %65
  %67 = sext i32 %i0.0 to i64
  %68 = getelementptr inbounds double* %1, i64 %67
  store double %66, double* %68
  %69 = sext i32 %50 to i64
  %70 = getelementptr inbounds double* %1, i64 %69
  %71 = load double* %70
  %72 = sext i32 %52 to i64
  %73 = getelementptr inbounds double* %1, i64 %72
  %74 = load double* %73
  %75 = fsub double %71, %74
  %76 = sext i32 %50 to i64
  %77 = getelementptr inbounds double* %1, i64 %76
  %78 = load double* %77
  %79 = sext i32 %52 to i64
  %80 = getelementptr inbounds double* %1, i64 %79
  %81 = load double* %80
  %82 = fadd double %78, %81
  %83 = sext i32 %50 to i64
  %84 = getelementptr inbounds double* %1, i64 %83
  store double %82, double* %84
  %85 = sext i32 %i0.0 to i64
  %86 = getelementptr inbounds double* %2, i64 %85
  %87 = load double* %86
  %88 = sext i32 %51 to i64
  %89 = getelementptr inbounds double* %2, i64 %88
  %90 = load double* %89
  %91 = fsub double %87, %90
  %92 = sext i32 %i0.0 to i64
  %93 = getelementptr inbounds double* %2, i64 %92
  %94 = load double* %93
  %95 = sext i32 %51 to i64
  %96 = getelementptr inbounds double* %2, i64 %95
  %97 = load double* %96
  %98 = fadd double %94, %97
  %99 = sext i32 %i0.0 to i64
  %100 = getelementptr inbounds double* %2, i64 %99
  store double %98, double* %100
  %101 = sext i32 %50 to i64
  %102 = getelementptr inbounds double* %2, i64 %101
  %103 = load double* %102
  %104 = sext i32 %52 to i64
  %105 = getelementptr inbounds double* %2, i64 %104
  %106 = load double* %105
  %107 = fsub double %103, %106
  %108 = sext i32 %50 to i64
  %109 = getelementptr inbounds double* %2, i64 %108
  %110 = load double* %109
  %111 = sext i32 %52 to i64
  %112 = getelementptr inbounds double* %2, i64 %111
  %113 = load double* %112
  %114 = fadd double %110, %113
  %115 = sext i32 %50 to i64
  %116 = getelementptr inbounds double* %2, i64 %115
  store double %114, double* %116
  %117 = fsub double %59, %107
  %118 = fadd double %59, %107
  %119 = fsub double %75, %91
  %120 = fadd double %75, %91
  %121 = fmul double %118, %36
  %122 = fmul double %119, %37
  %123 = fsub double %121, %122
  %124 = sext i32 %51 to i64
  %125 = getelementptr inbounds double* %1, i64 %124
  store double %123, double* %125
  %126 = fsub double -0.000000e+00, %119
  %127 = fmul double %126, %36
  %128 = fmul double %118, %37
  %129 = fsub double %127, %128
  %130 = sext i32 %51 to i64
  %131 = getelementptr inbounds double* %2, i64 %130
  store double %129, double* %131
  %132 = fmul double %117, %38
  %133 = fmul double %120, %39
  %134 = fadd double %132, %133
  %135 = sext i32 %52 to i64
  %136 = getelementptr inbounds double* %1, i64 %135
  store double %134, double* %136
  %137 = fmul double %120, %38
  %138 = fmul double %117, %39
  %139 = fsub double %137, %138
  %140 = sext i32 %52 to i64
  %141 = getelementptr inbounds double* %2, i64 %140
  store double %139, double* %141
  br label %142

; <label>:142                                     ; preds = %49
  %143 = add nsw i32 %i0.0, %id.0
  br label %46

; <label>:144                                     ; preds = %46
  %145 = mul nsw i32 2, %id.0
  %146 = sub nsw i32 %145, %28
  %147 = add nsw i32 %146, %j.0
  %148 = mul nsw i32 4, %id.0
  br label %43

; <label>:149                                     ; preds = %43
  br label %150

; <label>:150                                     ; preds = %149
  %151 = add nsw i32 %j.0, 1
  br label %32

; <label>:152                                     ; preds = %32
  br label %153

; <label>:153                                     ; preds = %152
  %154 = add nsw i32 %k.0, 1
  br label %24

; <label>:155                                     ; preds = %24
  br label %156

; <label>:156                                     ; preds = %195, %155
  %is.1 = phi i32 [ 1, %155 ], [ %197, %195 ]
  %id.1 = phi i32 [ 4, %155 ], [ %198, %195 ]
  %157 = icmp slt i32 %is.1, %i.0
  br i1 %157, label %158, label %199

; <label>:158                                     ; preds = %156
  br label %159

; <label>:159                                     ; preds = %193, %158
  %i0.1 = phi i32 [ %is.1, %158 ], [ %194, %193 ]
  %160 = icmp sle i32 %i0.1, %i.0
  br i1 %160, label %161, label %195

; <label>:161                                     ; preds = %159
  %162 = add nsw i32 %i0.1, 1
  %163 = sext i32 %i0.1 to i64
  %164 = getelementptr inbounds double* %1, i64 %163
  %165 = load double* %164
  %166 = sext i32 %162 to i64
  %167 = getelementptr inbounds double* %1, i64 %166
  %168 = load double* %167
  %169 = fadd double %165, %168
  %170 = sext i32 %i0.1 to i64
  %171 = getelementptr inbounds double* %1, i64 %170
  store double %169, double* %171
  %172 = sext i32 %162 to i64
  %173 = getelementptr inbounds double* %1, i64 %172
  %174 = load double* %173
  %175 = fsub double %165, %174
  %176 = sext i32 %162 to i64
  %177 = getelementptr inbounds double* %1, i64 %176
  store double %175, double* %177
  %178 = sext i32 %i0.1 to i64
  %179 = getelementptr inbounds double* %2, i64 %178
  %180 = load double* %179
  %181 = sext i32 %162 to i64
  %182 = getelementptr inbounds double* %2, i64 %181
  %183 = load double* %182
  %184 = fadd double %180, %183
  %185 = sext i32 %i0.1 to i64
  %186 = getelementptr inbounds double* %2, i64 %185
  store double %184, double* %186
  %187 = sext i32 %162 to i64
  %188 = getelementptr inbounds double* %2, i64 %187
  %189 = load double* %188
  %190 = fsub double %180, %189
  %191 = sext i32 %162 to i64
  %192 = getelementptr inbounds double* %2, i64 %191
  store double %190, double* %192
  br label %193

; <label>:193                                     ; preds = %161
  %194 = add nsw i32 %i0.1, %id.1
  br label %159

; <label>:195                                     ; preds = %159
  %196 = mul nsw i32 2, %id.1
  %197 = sub nsw i32 %196, 1
  %198 = mul nsw i32 4, %id.1
  br label %156

; <label>:199                                     ; preds = %156
  %200 = sub nsw i32 %i.0, 1
  br label %201

; <label>:201                                     ; preds = %235, %199
  %j.2 = phi i32 [ 1, %199 ], [ %234, %235 ]
  %i.2 = phi i32 [ 1, %199 ], [ %236, %235 ]
  %202 = icmp sle i32 %i.2, %200
  br i1 %202, label %203, label %237

; <label>:203                                     ; preds = %201
  %204 = icmp slt i32 %i.2, %j.2
  br i1 %204, label %205, label %226

; <label>:205                                     ; preds = %203
  %206 = sext i32 %j.2 to i64
  %207 = getelementptr inbounds double* %1, i64 %206
  %208 = load double* %207
  %209 = sext i32 %i.2 to i64
  %210 = getelementptr inbounds double* %1, i64 %209
  %211 = load double* %210
  %212 = sext i32 %j.2 to i64
  %213 = getelementptr inbounds double* %1, i64 %212
  store double %211, double* %213
  %214 = sext i32 %i.2 to i64
  %215 = getelementptr inbounds double* %1, i64 %214
  store double %208, double* %215
  %216 = sext i32 %j.2 to i64
  %217 = getelementptr inbounds double* %2, i64 %216
  %218 = load double* %217
  %219 = sext i32 %i.2 to i64
  %220 = getelementptr inbounds double* %2, i64 %219
  %221 = load double* %220
  %222 = sext i32 %j.2 to i64
  %223 = getelementptr inbounds double* %2, i64 %222
  store double %221, double* %223
  %224 = sext i32 %i.2 to i64
  %225 = getelementptr inbounds double* %2, i64 %224
  store double %218, double* %225
  br label %226

; <label>:226                                     ; preds = %205, %203
  %227 = sdiv i32 %i.0, 2
  br label %228

; <label>:228                                     ; preds = %230, %226
  %k.1 = phi i32 [ %227, %226 ], [ %232, %230 ]
  %j.1 = phi i32 [ %j.2, %226 ], [ %231, %230 ]
  %229 = icmp slt i32 %k.1, %j.1
  br i1 %229, label %230, label %233

; <label>:230                                     ; preds = %228
  %231 = sub nsw i32 %j.1, %k.1
  %232 = sdiv i32 %k.1, 2
  br label %228

; <label>:233                                     ; preds = %228
  %234 = add nsw i32 %j.1, %k.1
  br label %235

; <label>:235                                     ; preds = %233
  %236 = add nsw i32 %i.2, 1
  br label %201

; <label>:237                                     ; preds = %201
  ret i32 %i.0
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
  %16 = sext i32 %8 to i64
  %17 = call i8* @calloc(i64 %16, i64 8)
  %18 = bitcast i8* %17 to double*
  store double* %18, double** @xi, align 8
  %19 = load double** @xr, align 8
  %20 = load double** @xi, align 8
  %21 = fsub double %9, 1.000000e+00
  %22 = fmul double %21, 5.000000e-01
  store double %22, double* %19
  store double 0.000000e+00, double* %20
  %23 = sdiv i32 %8, 2
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds double* %19, i64 %24
  store double -5.000000e-01, double* %25
  %26 = sext i32 %23 to i64
  %27 = getelementptr inbounds double* %20, i64 %26
  store double 0.000000e+00, double* %27
  br label %28

; <label>:28                                      ; preds = %47, %7
  %i.0 = phi i32 [ 1, %7 ], [ %48, %47 ]
  %29 = icmp sle i32 %i.0, %11
  br i1 %29, label %30, label %49

; <label>:30                                      ; preds = %28
  %31 = sub nsw i32 %8, %i.0
  %32 = sext i32 %i.0 to i64
  %33 = getelementptr inbounds double* %19, i64 %32
  store double -5.000000e-01, double* %33
  %34 = sext i32 %31 to i64
  %35 = getelementptr inbounds double* %19, i64 %34
  store double -5.000000e-01, double* %35
  %36 = sitofp i32 %i.0 to double
  %37 = fmul double %12, %36
  %38 = call double @cos(double %37)
  %39 = call double @sin(double %37)
  %40 = fdiv double %38, %39
  %41 = fmul double -5.000000e-01, %40
  %42 = sext i32 %i.0 to i64
  %43 = getelementptr inbounds double* %20, i64 %42
  store double %41, double* %43
  %44 = fsub double -0.000000e+00, %41
  %45 = sext i32 %31 to i64
  %46 = getelementptr inbounds double* %20, i64 %45
  store double %44, double* %46
  br label %47

; <label>:47                                      ; preds = %30
  %48 = add nsw i32 %i.0, 1
  br label %28

; <label>:49                                      ; preds = %28
  %50 = load double** @xr, align 8
  %51 = load double** @xi, align 8
  %52 = call i32 @dfft(double* %50, double* %51, i32 %8)
  %53 = sub nsw i32 %8, 1
  br label %54

; <label>:54                                      ; preds = %73, %49
  %i.1 = phi i32 [ 0, %49 ], [ %74, %73 ]
  %zr.1 = phi double [ 0.000000e+00, %49 ], [ %zr.0, %73 ]
  %zi.1 = phi double [ 0.000000e+00, %49 ], [ %zi.0, %73 ]
  %55 = icmp sle i32 %i.1, %53
  br i1 %55, label %56, label %75

; <label>:56                                      ; preds = %54
  %57 = sext i32 %i.1 to i64
  %58 = getelementptr inbounds double* %19, i64 %57
  %59 = load double* %58
  %60 = sitofp i32 %i.1 to double
  %61 = fsub double %59, %60
  %62 = call double @fabs(double %61)
  %63 = fcmp olt double %zr.1, %62
  br i1 %63, label %64, label %65

; <label>:64                                      ; preds = %56
  br label %65

; <label>:65                                      ; preds = %64, %56
  %zr.0 = phi double [ %62, %64 ], [ %zr.1, %56 ]
  %66 = sext i32 %i.1 to i64
  %67 = getelementptr inbounds double* %20, i64 %66
  %68 = load double* %67
  %69 = call double @fabs(double %68)
  %70 = fcmp olt double %zi.1, %69
  br i1 %70, label %71, label %72

; <label>:71                                      ; preds = %65
  br label %72

; <label>:72                                      ; preds = %71, %65
  %zi.0 = phi double [ %69, %71 ], [ %zi.1, %65 ]
  br label %73

; <label>:73                                      ; preds = %72
  %74 = add nsw i32 %i.1, 1
  br label %54

; <label>:75                                      ; preds = %54
  %76 = fcmp olt double %zr.1, %zi.1
  br i1 %76, label %77, label %78

; <label>:77                                      ; preds = %75
  br label %78

; <label>:78                                      ; preds = %77, %75
  %zm.0 = phi double [ %zi.1, %77 ], [ %zr.1, %75 ]
  %79 = fcmp olt double %zm.0, 1.000000e-09
  br i1 %79, label %80, label %81

; <label>:80                                      ; preds = %78
  br label %82

; <label>:81                                      ; preds = %78
  br label %82

; <label>:82                                      ; preds = %81, %80
  %83 = phi i8* [ getelementptr inbounds ([10 x i8]* @.str1, i32 0, i32 0), %80 ], [ getelementptr inbounds ([13 x i8]* @.str2, i32 0, i32 0), %81 ]
  %84 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str, i32 0, i32 0), i32 %8, i8* %83)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i8* @calloc(i64, i64)

declare double @fabs(double)

declare i32 @printf(i8*, ...)
