; ModuleID = 'fft.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@xr = common global double* null, align 8
@xi = common global double* null, align 8
@.str = private constant [15 x i8] c"%d points, %s\0A\00"
@.str1 = private constant [10 x i8] c"result OK\00"
@.str2 = private constant [13 x i8] c"WRONG result\00"

define i32 @dfft(double* %x, double* %y, i32 %np) nounwind ssp {
  %1 = alloca double*, align 8
  %2 = alloca double*, align 8
  %3 = alloca i32, align 4
  %px = alloca double*, align 8
  %py = alloca double*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %m = alloca i32, align 4
  %n = alloca i32, align 4
  %i0 = alloca i32, align 4
  %i1 = alloca i32, align 4
  %i2 = alloca i32, align 4
  %i3 = alloca i32, align 4
  %is = alloca i32, align 4
  %id = alloca i32, align 4
  %n1 = alloca i32, align 4
  %n2 = alloca i32, align 4
  %n4 = alloca i32, align 4
  %a = alloca double, align 8
  %e = alloca double, align 8
  %a3 = alloca double, align 8
  %cc1 = alloca double, align 8
  %ss1 = alloca double, align 8
  %cc3 = alloca double, align 8
  %ss3 = alloca double, align 8
  %r1 = alloca double, align 8
  %r2 = alloca double, align 8
  %s1 = alloca double, align 8
  %s2 = alloca double, align 8
  %s3 = alloca double, align 8
  %xt = alloca double, align 8
  %tpi = alloca double, align 8
  store double* %x, double** %1, align 8
  store double* %y, double** %2, align 8
  store i32 %np, i32* %3, align 4
  %4 = load double** %1, align 8
  %5 = getelementptr inbounds double* %4, i64 -1
  store double* %5, double** %px, align 8
  %6 = load double** %2, align 8
  %7 = getelementptr inbounds double* %6, i64 -1
  store double* %7, double** %py, align 8
  store i32 2, i32* %i, align 4
  store i32 1, i32* %m, align 4
  br label %8

; <label>:8                                       ; preds = %12, %0
  %9 = load i32* %i, align 4
  %10 = load i32* %3, align 4
  %11 = icmp slt i32 %9, %10
  br i1 %11, label %12, label %18

; <label>:12                                      ; preds = %8
  %13 = load i32* %i, align 4
  %14 = load i32* %i, align 4
  %15 = add nsw i32 %13, %14
  store i32 %15, i32* %i, align 4
  %16 = load i32* %m, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, i32* %m, align 4
  br label %8

; <label>:18                                      ; preds = %8
  %19 = load i32* %i, align 4
  store i32 %19, i32* %n, align 4
  %20 = load i32* %n, align 4
  %21 = load i32* %3, align 4
  %22 = icmp ne i32 %20, %21
  br i1 %22, label %23, label %43

; <label>:23                                      ; preds = %18
  %24 = load i32* %3, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, i32* %i, align 4
  br label %26

; <label>:26                                      ; preds = %39, %23
  %27 = load i32* %i, align 4
  %28 = load i32* %n, align 4
  %29 = icmp sle i32 %27, %28
  br i1 %29, label %30, label %42

; <label>:30                                      ; preds = %26
  %31 = load i32* %i, align 4
  %32 = sext i32 %31 to i64
  %33 = load double** %px, align 8
  %34 = getelementptr inbounds double* %33, i64 %32
  store double 0.000000e+00, double* %34
  %35 = load i32* %i, align 4
  %36 = sext i32 %35 to i64
  %37 = load double** %py, align 8
  %38 = getelementptr inbounds double* %37, i64 %36
  store double 0.000000e+00, double* %38
  br label %39

; <label>:39                                      ; preds = %30
  %40 = load i32* %i, align 4
  %41 = add nsw i32 %40, 1
  store i32 %41, i32* %i, align 4
  br label %26

; <label>:42                                      ; preds = %26
  br label %43

; <label>:43                                      ; preds = %42, %18
  %44 = load i32* %n, align 4
  %45 = load i32* %n, align 4
  %46 = add nsw i32 %44, %45
  store i32 %46, i32* %n2, align 4
  store double 0x401921FB54442D18, double* %tpi, align 8
  store i32 1, i32* %k, align 4
  br label %47

; <label>:47                                      ; preds = %283, %43
  %48 = load i32* %k, align 4
  %49 = load i32* %m, align 4
  %50 = sub nsw i32 %49, 1
  %51 = icmp sle i32 %48, %50
  br i1 %51, label %52, label %286

; <label>:52                                      ; preds = %47
  %53 = load i32* %n2, align 4
  %54 = sdiv i32 %53, 2
  store i32 %54, i32* %n2, align 4
  %55 = load i32* %n2, align 4
  %56 = sdiv i32 %55, 4
  store i32 %56, i32* %n4, align 4
  %57 = load double* %tpi, align 8
  %58 = load i32* %n2, align 4
  %59 = sitofp i32 %58 to double
  %60 = fdiv double %57, %59
  store double %60, double* %e, align 8
  store double 0.000000e+00, double* %a, align 8
  store i32 1, i32* %j, align 4
  br label %61

; <label>:61                                      ; preds = %279, %52
  %62 = load i32* %j, align 4
  %63 = load i32* %n4, align 4
  %64 = icmp sle i32 %62, %63
  br i1 %64, label %65, label %282

; <label>:65                                      ; preds = %61
  %66 = load double* %a, align 8
  %67 = fmul double 3.000000e+00, %66
  store double %67, double* %a3, align 8
  %68 = load double* %a, align 8
  %69 = call double @cos(double %68)
  store double %69, double* %cc1, align 8
  %70 = load double* %a, align 8
  %71 = call double @sin(double %70)
  store double %71, double* %ss1, align 8
  %72 = load double* %a3, align 8
  %73 = call double @cos(double %72)
  store double %73, double* %cc3, align 8
  %74 = load double* %a3, align 8
  %75 = call double @sin(double %74)
  store double %75, double* %ss3, align 8
  %76 = load double* %e, align 8
  %77 = load i32* %j, align 4
  %78 = sitofp i32 %77 to double
  %79 = fmul double %76, %78
  store double %79, double* %a, align 8
  %80 = load i32* %j, align 4
  store i32 %80, i32* %is, align 4
  %81 = load i32* %n2, align 4
  %82 = mul nsw i32 2, %81
  store i32 %82, i32* %id, align 4
  br label %83

; <label>:83                                      ; preds = %269, %65
  %84 = load i32* %is, align 4
  %85 = load i32* %n, align 4
  %86 = icmp slt i32 %84, %85
  br i1 %86, label %87, label %278

; <label>:87                                      ; preds = %83
  %88 = load i32* %is, align 4
  store i32 %88, i32* %i0, align 4
  br label %89

; <label>:89                                      ; preds = %265, %87
  %90 = load i32* %i0, align 4
  %91 = load i32* %n, align 4
  %92 = sub nsw i32 %91, 1
  %93 = icmp sle i32 %90, %92
  br i1 %93, label %94, label %269

; <label>:94                                      ; preds = %89
  %95 = load i32* %i0, align 4
  %96 = load i32* %n4, align 4
  %97 = add nsw i32 %95, %96
  store i32 %97, i32* %i1, align 4
  %98 = load i32* %i1, align 4
  %99 = load i32* %n4, align 4
  %100 = add nsw i32 %98, %99
  store i32 %100, i32* %i2, align 4
  %101 = load i32* %i2, align 4
  %102 = load i32* %n4, align 4
  %103 = add nsw i32 %101, %102
  store i32 %103, i32* %i3, align 4
  %104 = load i32* %i0, align 4
  %105 = sext i32 %104 to i64
  %106 = load double** %px, align 8
  %107 = getelementptr inbounds double* %106, i64 %105
  %108 = load double* %107
  %109 = load i32* %i2, align 4
  %110 = sext i32 %109 to i64
  %111 = load double** %px, align 8
  %112 = getelementptr inbounds double* %111, i64 %110
  %113 = load double* %112
  %114 = fsub double %108, %113
  store double %114, double* %r1, align 8
  %115 = load i32* %i0, align 4
  %116 = sext i32 %115 to i64
  %117 = load double** %px, align 8
  %118 = getelementptr inbounds double* %117, i64 %116
  %119 = load double* %118
  %120 = load i32* %i2, align 4
  %121 = sext i32 %120 to i64
  %122 = load double** %px, align 8
  %123 = getelementptr inbounds double* %122, i64 %121
  %124 = load double* %123
  %125 = fadd double %119, %124
  %126 = load i32* %i0, align 4
  %127 = sext i32 %126 to i64
  %128 = load double** %px, align 8
  %129 = getelementptr inbounds double* %128, i64 %127
  store double %125, double* %129
  %130 = load i32* %i1, align 4
  %131 = sext i32 %130 to i64
  %132 = load double** %px, align 8
  %133 = getelementptr inbounds double* %132, i64 %131
  %134 = load double* %133
  %135 = load i32* %i3, align 4
  %136 = sext i32 %135 to i64
  %137 = load double** %px, align 8
  %138 = getelementptr inbounds double* %137, i64 %136
  %139 = load double* %138
  %140 = fsub double %134, %139
  store double %140, double* %r2, align 8
  %141 = load i32* %i1, align 4
  %142 = sext i32 %141 to i64
  %143 = load double** %px, align 8
  %144 = getelementptr inbounds double* %143, i64 %142
  %145 = load double* %144
  %146 = load i32* %i3, align 4
  %147 = sext i32 %146 to i64
  %148 = load double** %px, align 8
  %149 = getelementptr inbounds double* %148, i64 %147
  %150 = load double* %149
  %151 = fadd double %145, %150
  %152 = load i32* %i1, align 4
  %153 = sext i32 %152 to i64
  %154 = load double** %px, align 8
  %155 = getelementptr inbounds double* %154, i64 %153
  store double %151, double* %155
  %156 = load i32* %i0, align 4
  %157 = sext i32 %156 to i64
  %158 = load double** %py, align 8
  %159 = getelementptr inbounds double* %158, i64 %157
  %160 = load double* %159
  %161 = load i32* %i2, align 4
  %162 = sext i32 %161 to i64
  %163 = load double** %py, align 8
  %164 = getelementptr inbounds double* %163, i64 %162
  %165 = load double* %164
  %166 = fsub double %160, %165
  store double %166, double* %s1, align 8
  %167 = load i32* %i0, align 4
  %168 = sext i32 %167 to i64
  %169 = load double** %py, align 8
  %170 = getelementptr inbounds double* %169, i64 %168
  %171 = load double* %170
  %172 = load i32* %i2, align 4
  %173 = sext i32 %172 to i64
  %174 = load double** %py, align 8
  %175 = getelementptr inbounds double* %174, i64 %173
  %176 = load double* %175
  %177 = fadd double %171, %176
  %178 = load i32* %i0, align 4
  %179 = sext i32 %178 to i64
  %180 = load double** %py, align 8
  %181 = getelementptr inbounds double* %180, i64 %179
  store double %177, double* %181
  %182 = load i32* %i1, align 4
  %183 = sext i32 %182 to i64
  %184 = load double** %py, align 8
  %185 = getelementptr inbounds double* %184, i64 %183
  %186 = load double* %185
  %187 = load i32* %i3, align 4
  %188 = sext i32 %187 to i64
  %189 = load double** %py, align 8
  %190 = getelementptr inbounds double* %189, i64 %188
  %191 = load double* %190
  %192 = fsub double %186, %191
  store double %192, double* %s2, align 8
  %193 = load i32* %i1, align 4
  %194 = sext i32 %193 to i64
  %195 = load double** %py, align 8
  %196 = getelementptr inbounds double* %195, i64 %194
  %197 = load double* %196
  %198 = load i32* %i3, align 4
  %199 = sext i32 %198 to i64
  %200 = load double** %py, align 8
  %201 = getelementptr inbounds double* %200, i64 %199
  %202 = load double* %201
  %203 = fadd double %197, %202
  %204 = load i32* %i1, align 4
  %205 = sext i32 %204 to i64
  %206 = load double** %py, align 8
  %207 = getelementptr inbounds double* %206, i64 %205
  store double %203, double* %207
  %208 = load double* %r1, align 8
  %209 = load double* %s2, align 8
  %210 = fsub double %208, %209
  store double %210, double* %s3, align 8
  %211 = load double* %r1, align 8
  %212 = load double* %s2, align 8
  %213 = fadd double %211, %212
  store double %213, double* %r1, align 8
  %214 = load double* %r2, align 8
  %215 = load double* %s1, align 8
  %216 = fsub double %214, %215
  store double %216, double* %s2, align 8
  %217 = load double* %r2, align 8
  %218 = load double* %s1, align 8
  %219 = fadd double %217, %218
  store double %219, double* %r2, align 8
  %220 = load double* %r1, align 8
  %221 = load double* %cc1, align 8
  %222 = fmul double %220, %221
  %223 = load double* %s2, align 8
  %224 = load double* %ss1, align 8
  %225 = fmul double %223, %224
  %226 = fsub double %222, %225
  %227 = load i32* %i2, align 4
  %228 = sext i32 %227 to i64
  %229 = load double** %px, align 8
  %230 = getelementptr inbounds double* %229, i64 %228
  store double %226, double* %230
  %231 = load double* %s2, align 8
  %232 = fsub double -0.000000e+00, %231
  %233 = load double* %cc1, align 8
  %234 = fmul double %232, %233
  %235 = load double* %r1, align 8
  %236 = load double* %ss1, align 8
  %237 = fmul double %235, %236
  %238 = fsub double %234, %237
  %239 = load i32* %i2, align 4
  %240 = sext i32 %239 to i64
  %241 = load double** %py, align 8
  %242 = getelementptr inbounds double* %241, i64 %240
  store double %238, double* %242
  %243 = load double* %s3, align 8
  %244 = load double* %cc3, align 8
  %245 = fmul double %243, %244
  %246 = load double* %r2, align 8
  %247 = load double* %ss3, align 8
  %248 = fmul double %246, %247
  %249 = fadd double %245, %248
  %250 = load i32* %i3, align 4
  %251 = sext i32 %250 to i64
  %252 = load double** %px, align 8
  %253 = getelementptr inbounds double* %252, i64 %251
  store double %249, double* %253
  %254 = load double* %r2, align 8
  %255 = load double* %cc3, align 8
  %256 = fmul double %254, %255
  %257 = load double* %s3, align 8
  %258 = load double* %ss3, align 8
  %259 = fmul double %257, %258
  %260 = fsub double %256, %259
  %261 = load i32* %i3, align 4
  %262 = sext i32 %261 to i64
  %263 = load double** %py, align 8
  %264 = getelementptr inbounds double* %263, i64 %262
  store double %260, double* %264
  br label %265

; <label>:265                                     ; preds = %94
  %266 = load i32* %i0, align 4
  %267 = load i32* %id, align 4
  %268 = add nsw i32 %266, %267
  store i32 %268, i32* %i0, align 4
  br label %89

; <label>:269                                     ; preds = %89
  %270 = load i32* %id, align 4
  %271 = mul nsw i32 2, %270
  %272 = load i32* %n2, align 4
  %273 = sub nsw i32 %271, %272
  %274 = load i32* %j, align 4
  %275 = add nsw i32 %273, %274
  store i32 %275, i32* %is, align 4
  %276 = load i32* %id, align 4
  %277 = mul nsw i32 4, %276
  store i32 %277, i32* %id, align 4
  br label %83

; <label>:278                                     ; preds = %83
  br label %279

; <label>:279                                     ; preds = %278
  %280 = load i32* %j, align 4
  %281 = add nsw i32 %280, 1
  store i32 %281, i32* %j, align 4
  br label %61

; <label>:282                                     ; preds = %61
  br label %283

; <label>:283                                     ; preds = %282
  %284 = load i32* %k, align 4
  %285 = add nsw i32 %284, 1
  store i32 %285, i32* %k, align 4
  br label %47

; <label>:286                                     ; preds = %47
  store i32 1, i32* %is, align 4
  store i32 4, i32* %id, align 4
  br label %287

; <label>:287                                     ; preds = %358, %286
  %288 = load i32* %is, align 4
  %289 = load i32* %n, align 4
  %290 = icmp slt i32 %288, %289
  br i1 %290, label %291, label %364

; <label>:291                                     ; preds = %287
  %292 = load i32* %is, align 4
  store i32 %292, i32* %i0, align 4
  br label %293

; <label>:293                                     ; preds = %354, %291
  %294 = load i32* %i0, align 4
  %295 = load i32* %n, align 4
  %296 = icmp sle i32 %294, %295
  br i1 %296, label %297, label %358

; <label>:297                                     ; preds = %293
  %298 = load i32* %i0, align 4
  %299 = add nsw i32 %298, 1
  store i32 %299, i32* %i1, align 4
  %300 = load i32* %i0, align 4
  %301 = sext i32 %300 to i64
  %302 = load double** %px, align 8
  %303 = getelementptr inbounds double* %302, i64 %301
  %304 = load double* %303
  store double %304, double* %r1, align 8
  %305 = load double* %r1, align 8
  %306 = load i32* %i1, align 4
  %307 = sext i32 %306 to i64
  %308 = load double** %px, align 8
  %309 = getelementptr inbounds double* %308, i64 %307
  %310 = load double* %309
  %311 = fadd double %305, %310
  %312 = load i32* %i0, align 4
  %313 = sext i32 %312 to i64
  %314 = load double** %px, align 8
  %315 = getelementptr inbounds double* %314, i64 %313
  store double %311, double* %315
  %316 = load double* %r1, align 8
  %317 = load i32* %i1, align 4
  %318 = sext i32 %317 to i64
  %319 = load double** %px, align 8
  %320 = getelementptr inbounds double* %319, i64 %318
  %321 = load double* %320
  %322 = fsub double %316, %321
  %323 = load i32* %i1, align 4
  %324 = sext i32 %323 to i64
  %325 = load double** %px, align 8
  %326 = getelementptr inbounds double* %325, i64 %324
  store double %322, double* %326
  %327 = load i32* %i0, align 4
  %328 = sext i32 %327 to i64
  %329 = load double** %py, align 8
  %330 = getelementptr inbounds double* %329, i64 %328
  %331 = load double* %330
  store double %331, double* %r1, align 8
  %332 = load double* %r1, align 8
  %333 = load i32* %i1, align 4
  %334 = sext i32 %333 to i64
  %335 = load double** %py, align 8
  %336 = getelementptr inbounds double* %335, i64 %334
  %337 = load double* %336
  %338 = fadd double %332, %337
  %339 = load i32* %i0, align 4
  %340 = sext i32 %339 to i64
  %341 = load double** %py, align 8
  %342 = getelementptr inbounds double* %341, i64 %340
  store double %338, double* %342
  %343 = load double* %r1, align 8
  %344 = load i32* %i1, align 4
  %345 = sext i32 %344 to i64
  %346 = load double** %py, align 8
  %347 = getelementptr inbounds double* %346, i64 %345
  %348 = load double* %347
  %349 = fsub double %343, %348
  %350 = load i32* %i1, align 4
  %351 = sext i32 %350 to i64
  %352 = load double** %py, align 8
  %353 = getelementptr inbounds double* %352, i64 %351
  store double %349, double* %353
  br label %354

; <label>:354                                     ; preds = %297
  %355 = load i32* %i0, align 4
  %356 = load i32* %id, align 4
  %357 = add nsw i32 %355, %356
  store i32 %357, i32* %i0, align 4
  br label %293

; <label>:358                                     ; preds = %293
  %359 = load i32* %id, align 4
  %360 = mul nsw i32 2, %359
  %361 = sub nsw i32 %360, 1
  store i32 %361, i32* %is, align 4
  %362 = load i32* %id, align 4
  %363 = mul nsw i32 4, %362
  store i32 %363, i32* %id, align 4
  br label %287

; <label>:364                                     ; preds = %287
  store i32 1, i32* %j, align 4
  %365 = load i32* %n, align 4
  %366 = sub nsw i32 %365, 1
  store i32 %366, i32* %n1, align 4
  store i32 1, i32* %i, align 4
  br label %367

; <label>:367                                     ; preds = %431, %364
  %368 = load i32* %i, align 4
  %369 = load i32* %n1, align 4
  %370 = icmp sle i32 %368, %369
  br i1 %370, label %371, label %434

; <label>:371                                     ; preds = %367
  %372 = load i32* %i, align 4
  %373 = load i32* %j, align 4
  %374 = icmp slt i32 %372, %373
  br i1 %374, label %375, label %414

; <label>:375                                     ; preds = %371
  %376 = load i32* %j, align 4
  %377 = sext i32 %376 to i64
  %378 = load double** %px, align 8
  %379 = getelementptr inbounds double* %378, i64 %377
  %380 = load double* %379
  store double %380, double* %xt, align 8
  %381 = load i32* %i, align 4
  %382 = sext i32 %381 to i64
  %383 = load double** %px, align 8
  %384 = getelementptr inbounds double* %383, i64 %382
  %385 = load double* %384
  %386 = load i32* %j, align 4
  %387 = sext i32 %386 to i64
  %388 = load double** %px, align 8
  %389 = getelementptr inbounds double* %388, i64 %387
  store double %385, double* %389
  %390 = load double* %xt, align 8
  %391 = load i32* %i, align 4
  %392 = sext i32 %391 to i64
  %393 = load double** %px, align 8
  %394 = getelementptr inbounds double* %393, i64 %392
  store double %390, double* %394
  %395 = load i32* %j, align 4
  %396 = sext i32 %395 to i64
  %397 = load double** %py, align 8
  %398 = getelementptr inbounds double* %397, i64 %396
  %399 = load double* %398
  store double %399, double* %xt, align 8
  %400 = load i32* %i, align 4
  %401 = sext i32 %400 to i64
  %402 = load double** %py, align 8
  %403 = getelementptr inbounds double* %402, i64 %401
  %404 = load double* %403
  %405 = load i32* %j, align 4
  %406 = sext i32 %405 to i64
  %407 = load double** %py, align 8
  %408 = getelementptr inbounds double* %407, i64 %406
  store double %404, double* %408
  %409 = load double* %xt, align 8
  %410 = load i32* %i, align 4
  %411 = sext i32 %410 to i64
  %412 = load double** %py, align 8
  %413 = getelementptr inbounds double* %412, i64 %411
  store double %409, double* %413
  br label %414

; <label>:414                                     ; preds = %375, %371
  %415 = load i32* %n, align 4
  %416 = sdiv i32 %415, 2
  store i32 %416, i32* %k, align 4
  br label %417

; <label>:417                                     ; preds = %421, %414
  %418 = load i32* %k, align 4
  %419 = load i32* %j, align 4
  %420 = icmp slt i32 %418, %419
  br i1 %420, label %421, label %427

; <label>:421                                     ; preds = %417
  %422 = load i32* %j, align 4
  %423 = load i32* %k, align 4
  %424 = sub nsw i32 %422, %423
  store i32 %424, i32* %j, align 4
  %425 = load i32* %k, align 4
  %426 = sdiv i32 %425, 2
  store i32 %426, i32* %k, align 4
  br label %417

; <label>:427                                     ; preds = %417
  %428 = load i32* %j, align 4
  %429 = load i32* %k, align 4
  %430 = add nsw i32 %428, %429
  store i32 %430, i32* %j, align 4
  br label %431

; <label>:431                                     ; preds = %427
  %432 = load i32* %i, align 4
  %433 = add nsw i32 %432, 1
  store i32 %433, i32* %i, align 4
  br label %367

; <label>:434                                     ; preds = %367
  %435 = load i32* %n, align 4
  ret i32 %435
}

declare double @cos(double) readnone

declare double @sin(double) readnone

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %n = alloca i32, align 4
  %np = alloca i32, align 4
  %npm = alloca i32, align 4
  %n2 = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %enp = alloca double, align 8
  %t = alloca double, align 8
  %y = alloca double, align 8
  %z = alloca double, align 8
  %zr = alloca double, align 8
  %zi = alloca double, align 8
  %zm = alloca double, align 8
  %a = alloca double, align 8
  %pxr = alloca double*, align 8
  %pxi = alloca double*, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = load i32* %2, align 4
  %5 = icmp sge i32 %4, 2
  br i1 %5, label %6, label %11

; <label>:6                                       ; preds = %0
  %7 = load i8*** %3, align 8
  %8 = getelementptr inbounds i8** %7, i64 1
  %9 = load i8** %8
  %10 = call i32 @atoi(i8* %9)
  store i32 %10, i32* %n, align 4
  br label %12

; <label>:11                                      ; preds = %0
  store i32 18, i32* %n, align 4
  br label %12

; <label>:12                                      ; preds = %11, %6
  %13 = load i32* %n, align 4
  %14 = shl i32 1, %13
  store i32 %14, i32* %np, align 4
  %15 = load i32* %np, align 4
  %16 = sitofp i32 %15 to double
  store double %16, double* %enp, align 8
  %17 = load i32* %np, align 4
  %18 = sdiv i32 %17, 2
  %19 = sub nsw i32 %18, 1
  store i32 %19, i32* %npm, align 4
  %20 = load double* %enp, align 8
  %21 = fdiv double 0x400921FB54442D18, %20
  store double %21, double* %t, align 8
  %22 = load i32* %np, align 4
  %23 = sext i32 %22 to i64
  %24 = call i8* @calloc(i64 %23, i64 8)
  %25 = bitcast i8* %24 to double*
  store double* %25, double** @xr, align 8
  %26 = load i32* %np, align 4
  %27 = sext i32 %26 to i64
  %28 = call i8* @calloc(i64 %27, i64 8)
  %29 = bitcast i8* %28 to double*
  store double* %29, double** @xi, align 8
  %30 = load double** @xr, align 8
  store double* %30, double** %pxr, align 8
  %31 = load double** @xi, align 8
  store double* %31, double** %pxi, align 8
  %32 = load double* %enp, align 8
  %33 = fsub double %32, 1.000000e+00
  %34 = fmul double %33, 5.000000e-01
  %35 = load double** %pxr, align 8
  store double %34, double* %35
  %36 = load double** %pxi, align 8
  store double 0.000000e+00, double* %36
  %37 = load i32* %np, align 4
  %38 = sdiv i32 %37, 2
  store i32 %38, i32* %n2, align 4
  %39 = load double** %pxr, align 8
  %40 = load i32* %n2, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds double* %39, i64 %41
  store double -5.000000e-01, double* %42
  %43 = load double** %pxi, align 8
  %44 = load i32* %n2, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds double* %43, i64 %45
  store double 0.000000e+00, double* %46
  store i32 1, i32* %i, align 4
  br label %47

; <label>:47                                      ; preds = %84, %12
  %48 = load i32* %i, align 4
  %49 = load i32* %npm, align 4
  %50 = icmp sle i32 %48, %49
  br i1 %50, label %51, label %87

; <label>:51                                      ; preds = %47
  %52 = load i32* %np, align 4
  %53 = load i32* %i, align 4
  %54 = sub nsw i32 %52, %53
  store i32 %54, i32* %j, align 4
  %55 = load double** %pxr, align 8
  %56 = load i32* %i, align 4
  %57 = sext i32 %56 to i64
  %58 = getelementptr inbounds double* %55, i64 %57
  store double -5.000000e-01, double* %58
  %59 = load double** %pxr, align 8
  %60 = load i32* %j, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds double* %59, i64 %61
  store double -5.000000e-01, double* %62
  %63 = load double* %t, align 8
  %64 = load i32* %i, align 4
  %65 = sitofp i32 %64 to double
  %66 = fmul double %63, %65
  store double %66, double* %z, align 8
  %67 = load double* %z, align 8
  %68 = call double @cos(double %67)
  %69 = load double* %z, align 8
  %70 = call double @sin(double %69)
  %71 = fdiv double %68, %70
  %72 = fmul double -5.000000e-01, %71
  store double %72, double* %y, align 8
  %73 = load double* %y, align 8
  %74 = load double** %pxi, align 8
  %75 = load i32* %i, align 4
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds double* %74, i64 %76
  store double %73, double* %77
  %78 = load double* %y, align 8
  %79 = fsub double -0.000000e+00, %78
  %80 = load double** %pxi, align 8
  %81 = load i32* %j, align 4
  %82 = sext i32 %81 to i64
  %83 = getelementptr inbounds double* %80, i64 %82
  store double %79, double* %83
  br label %84

; <label>:84                                      ; preds = %51
  %85 = load i32* %i, align 4
  %86 = add nsw i32 %85, 1
  store i32 %86, i32* %i, align 4
  br label %47

; <label>:87                                      ; preds = %47
  %88 = load double** @xr, align 8
  %89 = load double** @xi, align 8
  %90 = load i32* %np, align 4
  %91 = call i32 @dfft(double* %88, double* %89, i32 %90)
  store double 0.000000e+00, double* %zr, align 8
  store double 0.000000e+00, double* %zi, align 8
  %92 = load i32* %np, align 4
  %93 = sub nsw i32 %92, 1
  store i32 %93, i32* %npm, align 4
  store i32 0, i32* %i, align 4
  br label %94

; <label>:94                                      ; preds = %126, %87
  %95 = load i32* %i, align 4
  %96 = load i32* %npm, align 4
  %97 = icmp sle i32 %95, %96
  br i1 %97, label %98, label %129

; <label>:98                                      ; preds = %94
  %99 = load i32* %i, align 4
  %100 = sext i32 %99 to i64
  %101 = load double** %pxr, align 8
  %102 = getelementptr inbounds double* %101, i64 %100
  %103 = load double* %102
  %104 = load i32* %i, align 4
  %105 = sitofp i32 %104 to double
  %106 = fsub double %103, %105
  %107 = call double @fabs(double %106)
  store double %107, double* %a, align 8
  %108 = load double* %zr, align 8
  %109 = load double* %a, align 8
  %110 = fcmp olt double %108, %109
  br i1 %110, label %111, label %113

; <label>:111                                     ; preds = %98
  %112 = load double* %a, align 8
  store double %112, double* %zr, align 8
  br label %113

; <label>:113                                     ; preds = %111, %98
  %114 = load i32* %i, align 4
  %115 = sext i32 %114 to i64
  %116 = load double** %pxi, align 8
  %117 = getelementptr inbounds double* %116, i64 %115
  %118 = load double* %117
  %119 = call double @fabs(double %118)
  store double %119, double* %a, align 8
  %120 = load double* %zi, align 8
  %121 = load double* %a, align 8
  %122 = fcmp olt double %120, %121
  br i1 %122, label %123, label %125

; <label>:123                                     ; preds = %113
  %124 = load double* %a, align 8
  store double %124, double* %zi, align 8
  br label %125

; <label>:125                                     ; preds = %123, %113
  br label %126

; <label>:126                                     ; preds = %125
  %127 = load i32* %i, align 4
  %128 = add nsw i32 %127, 1
  store i32 %128, i32* %i, align 4
  br label %94

; <label>:129                                     ; preds = %94
  %130 = load double* %zr, align 8
  store double %130, double* %zm, align 8
  %131 = load double* %zr, align 8
  %132 = load double* %zi, align 8
  %133 = fcmp olt double %131, %132
  br i1 %133, label %134, label %136

; <label>:134                                     ; preds = %129
  %135 = load double* %zi, align 8
  store double %135, double* %zm, align 8
  br label %136

; <label>:136                                     ; preds = %134, %129
  %137 = load i32* %np, align 4
  %138 = load double* %zm, align 8
  %139 = fcmp olt double %138, 1.000000e-09
  br i1 %139, label %140, label %141

; <label>:140                                     ; preds = %136
  br label %142

; <label>:141                                     ; preds = %136
  br label %142

; <label>:142                                     ; preds = %141, %140
  %143 = phi i8* [ getelementptr inbounds ([10 x i8]* @.str1, i32 0, i32 0), %140 ], [ getelementptr inbounds ([13 x i8]* @.str2, i32 0, i32 0), %141 ]
  %144 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str, i32 0, i32 0), i32 %137, i8* %143)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i8* @calloc(i64, i64)

declare double @fabs(double)

declare i32 @printf(i8*, ...)
