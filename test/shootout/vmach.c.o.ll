; ModuleID = 'vmach.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@stack = common global [256 x i64] zeroinitializer, align 16
@.str = private constant [19 x i8] c"Over-application.\0A\00"
@.str1 = private constant [22 x i8] c"Partial application.\0A\00"
@wordcode_fib = global [14 x i32] [i32 7682, i32 65537, i32 65550, i32 514, i32 16777481, i32 393221, i32 -16777205, i32 -327679, i32 -33554165, i32 -458751, i32 33619978, i32 131079, i32 258, i32 131079], align 16
@wordcode_tak = global [23 x i32] [i32 1538, i32 3074, i32 4610, i32 66310, i32 131328, i32 65550, i32 525, i32 265, i32 131077, i32 524, i32 262151, i32 -16777205, i32 -524026, i32 197120, i32 -16776693, i32 -720634, i32 132096, i32 -16776181, i32 -917242, i32 262912, i32 -1047802, i32 258, i32 262151], align 16
@.str2 = private constant [15 x i8] c"fib(30) = %ld\0A\00"
@.str3 = private constant [22 x i8] c"tak(18, 12, 6) = %ld\0A\00"

define i64 @wordcode_interp(i32* %code) nounwind ssp {
  %1 = alloca i32*, align 8
  %sp = alloca i64*, align 8
  %pc = alloca i32*, align 8
  %instr = alloca i32, align 4
  %extra_args = alloca i32, align 4
  %arg = alloca i64, align 8
  %arg1 = alloca i64, align 8
  %ext = alloca i32, align 4
  %arg12 = alloca i64, align 8
  %arg2 = alloca i64, align 8
  %arg3 = alloca i64, align 8
  %res = alloca i64, align 8
  %arg13 = alloca i64, align 8
  %arg24 = alloca i64, align 8
  %arg15 = alloca i64, align 8
  %arg26 = alloca i64, align 8
  %arg7 = alloca i64, align 8
  %arg8 = alloca i64, align 8
  %required = alloca i32, align 4
  %res9 = alloca i64, align 8
  store i32* %code, i32** %1, align 8
  store i32 0, i32* %extra_args, align 4
  store i64* getelementptr inbounds ([256 x i64]* @stack, i64 1, i64 0), i64** %sp, align 8
  %2 = load i32** %1, align 8
  store i32* %2, i32** %pc, align 8
  br label %3

; <label>:3                                       ; preds = %294, %0
  %4 = load i32** %pc, align 8
  %5 = getelementptr inbounds i32* %4, i32 1
  store i32* %5, i32** %pc, align 8
  %6 = load i32* %4
  store i32 %6, i32* %instr, align 4
  %7 = load i32* %instr, align 4
  %8 = and i32 %7, 255
  switch i32 %8, label %294 [
    i32 0, label %9
    i32 1, label %9
    i32 2, label %40
    i32 3, label %40
    i32 4, label %53
    i32 5, label %53
    i32 6, label %75
    i32 7, label %129
    i32 8, label %161
    i32 9, label %173
    i32 10, label %202
    i32 11, label %229
    i32 12, label %252
    i32 13, label %265
    i32 14, label %279
  ]

; <label>:9                                       ; preds = %3, %3
  %10 = load i32* %instr, align 4
  %11 = lshr i32 %10, 8
  %12 = and i32 %11, 255
  %13 = zext i32 %12 to i64
  %14 = load i64** %sp, align 8
  %15 = getelementptr inbounds i64* %14, i64 %13
  %16 = load i64* %15
  store i64 %16, i64* %arg, align 8
  %17 = load i32* %instr, align 4
  %18 = and i32 %17, 1
  %19 = load i64** %sp, align 8
  %20 = zext i32 %18 to i64
  %21 = getelementptr inbounds i64* %19, i64 %20
  store i64* %21, i64** %sp, align 8
  %22 = load i64** %sp, align 8
  %23 = getelementptr inbounds i64* %22, i64 -3
  store i64* %23, i64** %sp, align 8
  %24 = load i32** %pc, align 8
  %25 = ptrtoint i32* %24 to i64
  %26 = load i64** %sp, align 8
  %27 = getelementptr inbounds i64* %26, i64 2
  store i64 %25, i64* %27
  %28 = load i32* %extra_args, align 4
  %29 = sext i32 %28 to i64
  %30 = load i64** %sp, align 8
  %31 = getelementptr inbounds i64* %30, i64 1
  store i64 %29, i64* %31
  %32 = load i64* %arg, align 8
  %33 = load i64** %sp, align 8
  %34 = getelementptr inbounds i64* %33, i64 0
  store i64 %32, i64* %34
  %35 = load i32* %instr, align 4
  %36 = ashr i32 %35, 16
  %37 = load i32** %pc, align 8
  %38 = sext i32 %36 to i64
  %39 = getelementptr inbounds i32* %37, i64 %38
  store i32* %39, i32** %pc, align 8
  store i32 0, i32* %extra_args, align 4
  br label %294

; <label>:40                                      ; preds = %3, %3
  %41 = load i32* %instr, align 4
  %42 = and i32 %41, 1
  %43 = load i64** %sp, align 8
  %44 = zext i32 %42 to i64
  %45 = getelementptr inbounds i64* %43, i64 %44
  store i64* %45, i64** %sp, align 8
  %46 = load i64** %sp, align 8
  %47 = getelementptr inbounds i64* %46, i64 -1
  store i64* %47, i64** %sp, align 8
  %48 = load i32* %instr, align 4
  %49 = ashr i32 %48, 8
  %50 = sext i32 %49 to i64
  %51 = load i64** %sp, align 8
  %52 = getelementptr inbounds i64* %51, i64 0
  store i64 %50, i64* %52
  br label %294

; <label>:53                                      ; preds = %3, %3
  %54 = load i32* %instr, align 4
  %55 = lshr i32 %54, 8
  %56 = and i32 %55, 255
  %57 = zext i32 %56 to i64
  %58 = load i64** %sp, align 8
  %59 = getelementptr inbounds i64* %58, i64 %57
  %60 = load i64* %59
  store i64 %60, i64* %arg1, align 8
  %61 = load i32* %instr, align 4
  %62 = and i32 %61, 1
  %63 = load i64** %sp, align 8
  %64 = zext i32 %62 to i64
  %65 = getelementptr inbounds i64* %63, i64 %64
  store i64* %65, i64** %sp, align 8
  %66 = load i64* %arg1, align 8
  %67 = icmp ne i64 %66, 0
  br i1 %67, label %68, label %74

; <label>:68                                      ; preds = %53
  %69 = load i32* %instr, align 4
  %70 = ashr i32 %69, 16
  %71 = load i32** %pc, align 8
  %72 = sext i32 %70 to i64
  %73 = getelementptr inbounds i32* %71, i64 %72
  store i32* %73, i32** %pc, align 8
  br label %74

; <label>:74                                      ; preds = %68, %53
  br label %294

; <label>:75                                      ; preds = %3
  %76 = load i32** %pc, align 8
  %77 = getelementptr inbounds i32* %76, i32 1
  store i32* %77, i32** %pc, align 8
  %78 = load i32* %76
  store i32 %78, i32* %ext, align 4
  %79 = load i32* %ext, align 4
  %80 = and i32 %79, 255
  %81 = zext i32 %80 to i64
  %82 = load i64** %sp, align 8
  %83 = getelementptr inbounds i64* %82, i64 %81
  %84 = load i64* %83
  store i64 %84, i64* %arg12, align 8
  %85 = load i32* %ext, align 4
  %86 = lshr i32 %85, 8
  %87 = and i32 %86, 255
  %88 = zext i32 %87 to i64
  %89 = load i64** %sp, align 8
  %90 = getelementptr inbounds i64* %89, i64 %88
  %91 = load i64* %90
  store i64 %91, i64* %arg2, align 8
  %92 = load i32* %ext, align 4
  %93 = lshr i32 %92, 16
  %94 = and i32 %93, 255
  %95 = zext i32 %94 to i64
  %96 = load i64** %sp, align 8
  %97 = getelementptr inbounds i64* %96, i64 %95
  %98 = load i64* %97
  store i64 %98, i64* %arg3, align 8
  %99 = load i32* %instr, align 4
  %100 = lshr i32 %99, 8
  %101 = and i32 %100, 255
  %102 = load i64** %sp, align 8
  %103 = zext i32 %101 to i64
  %104 = getelementptr inbounds i64* %102, i64 %103
  store i64* %104, i64** %sp, align 8
  %105 = load i64** %sp, align 8
  %106 = getelementptr inbounds i64* %105, i64 -5
  store i64* %106, i64** %sp, align 8
  %107 = load i32** %pc, align 8
  %108 = ptrtoint i32* %107 to i64
  %109 = load i64** %sp, align 8
  %110 = getelementptr inbounds i64* %109, i64 4
  store i64 %108, i64* %110
  %111 = load i32* %extra_args, align 4
  %112 = sext i32 %111 to i64
  %113 = load i64** %sp, align 8
  %114 = getelementptr inbounds i64* %113, i64 3
  store i64 %112, i64* %114
  %115 = load i64* %arg3, align 8
  %116 = load i64** %sp, align 8
  %117 = getelementptr inbounds i64* %116, i64 2
  store i64 %115, i64* %117
  %118 = load i64* %arg2, align 8
  %119 = load i64** %sp, align 8
  %120 = getelementptr inbounds i64* %119, i64 1
  store i64 %118, i64* %120
  %121 = load i64* %arg12, align 8
  %122 = load i64** %sp, align 8
  %123 = getelementptr inbounds i64* %122, i64 0
  store i64 %121, i64* %123
  %124 = load i32* %instr, align 4
  %125 = ashr i32 %124, 16
  %126 = load i32** %pc, align 8
  %127 = sext i32 %125 to i64
  %128 = getelementptr inbounds i32* %126, i64 %127
  store i32* %128, i32** %pc, align 8
  store i32 2, i32* %extra_args, align 4
  br label %294

; <label>:129                                     ; preds = %3
  %130 = load i32* %instr, align 4
  %131 = lshr i32 %130, 8
  %132 = and i32 %131, 255
  %133 = zext i32 %132 to i64
  %134 = load i64** %sp, align 8
  %135 = getelementptr inbounds i64* %134, i64 %133
  %136 = load i64* %135
  store i64 %136, i64* %res, align 8
  %137 = load i32* %instr, align 4
  %138 = lshr i32 %137, 16
  %139 = and i32 %138, 255
  %140 = load i64** %sp, align 8
  %141 = zext i32 %139 to i64
  %142 = getelementptr inbounds i64* %140, i64 %141
  store i64* %142, i64** %sp, align 8
  %143 = load i32* %extra_args, align 4
  %144 = icmp sgt i32 %143, 0
  br i1 %144, label %145, label %147

; <label>:145                                     ; preds = %129
  %146 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str, i32 0, i32 0))
  call void @exit(i32 2) noreturn
  unreachable

; <label>:147                                     ; preds = %129
  %148 = load i64** %sp, align 8
  %149 = getelementptr inbounds i64* %148, i64 0
  %150 = load i64* %149
  %151 = trunc i64 %150 to i32
  store i32 %151, i32* %extra_args, align 4
  %152 = load i64** %sp, align 8
  %153 = getelementptr inbounds i64* %152, i64 1
  %154 = load i64* %153
  %155 = inttoptr i64 %154 to i32*
  store i32* %155, i32** %pc, align 8
  %156 = load i64** %sp, align 8
  %157 = getelementptr inbounds i64* %156, i64 1
  store i64* %157, i64** %sp, align 8
  %158 = load i64* %res, align 8
  %159 = load i64** %sp, align 8
  store i64 %158, i64* %159
  br label %160

; <label>:160                                     ; preds = %147
  br label %294

; <label>:161                                     ; preds = %3
  %162 = load i32* %instr, align 4
  %163 = lshr i32 %162, 8
  %164 = and i32 %163, 255
  %165 = load i64** %sp, align 8
  %166 = zext i32 %164 to i64
  %167 = getelementptr inbounds i64* %165, i64 %166
  store i64* %167, i64** %sp, align 8
  %168 = load i32* %instr, align 4
  %169 = ashr i32 %168, 16
  %170 = load i32** %pc, align 8
  %171 = sext i32 %169 to i64
  %172 = getelementptr inbounds i32* %170, i64 %171
  store i32* %172, i32** %pc, align 8
  br label %294

; <label>:173                                     ; preds = %3
  %174 = load i32* %instr, align 4
  %175 = lshr i32 %174, 8
  %176 = and i32 %175, 255
  %177 = zext i32 %176 to i64
  %178 = load i64** %sp, align 8
  %179 = getelementptr inbounds i64* %178, i64 %177
  %180 = load i64* %179
  store i64 %180, i64* %arg13, align 8
  %181 = load i32* %instr, align 4
  %182 = lshr i32 %181, 16
  %183 = and i32 %182, 255
  %184 = zext i32 %183 to i64
  %185 = load i64** %sp, align 8
  %186 = getelementptr inbounds i64* %185, i64 %184
  %187 = load i64* %186
  store i64 %187, i64* %arg24, align 8
  %188 = load i32* %instr, align 4
  %189 = lshr i32 %188, 24
  %190 = load i64** %sp, align 8
  %191 = zext i32 %189 to i64
  %192 = getelementptr inbounds i64* %190, i64 %191
  store i64* %192, i64** %sp, align 8
  %193 = load i64** %sp, align 8
  %194 = getelementptr inbounds i64* %193, i64 -1
  store i64* %194, i64** %sp, align 8
  %195 = load i64* %arg13, align 8
  %196 = load i64* %arg24, align 8
  %197 = icmp slt i64 %195, %196
  %198 = zext i1 %197 to i32
  %199 = sext i32 %198 to i64
  %200 = load i64** %sp, align 8
  %201 = getelementptr inbounds i64* %200, i64 0
  store i64 %199, i64* %201
  br label %294

; <label>:202                                     ; preds = %3
  %203 = load i32* %instr, align 4
  %204 = lshr i32 %203, 8
  %205 = and i32 %204, 255
  %206 = zext i32 %205 to i64
  %207 = load i64** %sp, align 8
  %208 = getelementptr inbounds i64* %207, i64 %206
  %209 = load i64* %208
  store i64 %209, i64* %arg15, align 8
  %210 = load i32* %instr, align 4
  %211 = lshr i32 %210, 16
  %212 = and i32 %211, 255
  %213 = zext i32 %212 to i64
  %214 = load i64** %sp, align 8
  %215 = getelementptr inbounds i64* %214, i64 %213
  %216 = load i64* %215
  store i64 %216, i64* %arg26, align 8
  %217 = load i32* %instr, align 4
  %218 = lshr i32 %217, 24
  %219 = load i64** %sp, align 8
  %220 = zext i32 %218 to i64
  %221 = getelementptr inbounds i64* %219, i64 %220
  store i64* %221, i64** %sp, align 8
  %222 = load i64** %sp, align 8
  %223 = getelementptr inbounds i64* %222, i64 -1
  store i64* %223, i64** %sp, align 8
  %224 = load i64* %arg15, align 8
  %225 = load i64* %arg26, align 8
  %226 = add nsw i64 %224, %225
  %227 = load i64** %sp, align 8
  %228 = getelementptr inbounds i64* %227, i64 0
  store i64 %226, i64* %228
  br label %294

; <label>:229                                     ; preds = %3
  %230 = load i32* %instr, align 4
  %231 = lshr i32 %230, 8
  %232 = and i32 %231, 255
  %233 = zext i32 %232 to i64
  %234 = load i64** %sp, align 8
  %235 = getelementptr inbounds i64* %234, i64 %233
  %236 = load i64* %235
  store i64 %236, i64* %arg7, align 8
  %237 = load i32* %instr, align 4
  %238 = lshr i32 %237, 16
  %239 = and i32 %238, 255
  %240 = load i64** %sp, align 8
  %241 = zext i32 %239 to i64
  %242 = getelementptr inbounds i64* %240, i64 %241
  store i64* %242, i64** %sp, align 8
  %243 = load i64** %sp, align 8
  %244 = getelementptr inbounds i64* %243, i64 -1
  store i64* %244, i64** %sp, align 8
  %245 = load i64* %arg7, align 8
  %246 = load i32* %instr, align 4
  %247 = ashr i32 %246, 24
  %248 = sext i32 %247 to i64
  %249 = add nsw i64 %245, %248
  %250 = load i64** %sp, align 8
  %251 = getelementptr inbounds i64* %250, i64 0
  store i64 %249, i64* %251
  br label %294

; <label>:252                                     ; preds = %3
  %253 = load i32* %instr, align 4
  %254 = lshr i32 %253, 8
  %255 = and i32 %254, 255
  %256 = zext i32 %255 to i64
  %257 = load i64** %sp, align 8
  %258 = getelementptr inbounds i64* %257, i64 %256
  %259 = load i64* %258
  store i64 %259, i64* %arg8, align 8
  %260 = load i64** %sp, align 8
  %261 = getelementptr inbounds i64* %260, i64 -1
  store i64* %261, i64** %sp, align 8
  %262 = load i64* %arg8, align 8
  %263 = load i64** %sp, align 8
  %264 = getelementptr inbounds i64* %263, i64 0
  store i64 %262, i64* %264
  br label %294

; <label>:265                                     ; preds = %3
  %266 = load i32* %instr, align 4
  %267 = lshr i32 %266, 8
  %268 = and i32 %267, 255
  store i32 %268, i32* %required, align 4
  %269 = load i32* %extra_args, align 4
  %270 = load i32* %required, align 4
  %271 = icmp sge i32 %269, %270
  br i1 %271, label %272, label %276

; <label>:272                                     ; preds = %265
  %273 = load i32* %required, align 4
  %274 = load i32* %extra_args, align 4
  %275 = sub nsw i32 %274, %273
  store i32 %275, i32* %extra_args, align 4
  br label %278

; <label>:276                                     ; preds = %265
  %277 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str1, i32 0, i32 0))
  call void @exit(i32 2) noreturn
  unreachable

; <label>:278                                     ; preds = %272
  br label %294

; <label>:279                                     ; preds = %3
  %280 = load i32* %instr, align 4
  %281 = lshr i32 %280, 8
  %282 = and i32 %281, 255
  %283 = zext i32 %282 to i64
  %284 = load i64** %sp, align 8
  %285 = getelementptr inbounds i64* %284, i64 %283
  %286 = load i64* %285
  store i64 %286, i64* %res9, align 8
  %287 = load i32* %instr, align 4
  %288 = lshr i32 %287, 16
  %289 = and i32 %288, 255
  %290 = load i64** %sp, align 8
  %291 = zext i32 %289 to i64
  %292 = getelementptr inbounds i64* %290, i64 %291
  store i64* %292, i64** %sp, align 8
  %293 = load i64* %res9, align 8
  ret i64 %293

; <label>:294                                     ; preds = %278, %252, %229, %202, %173, %161, %160, %75, %74, %40, %9, %3
  br label %3
}

declare i32 @printf(i8*, ...)

declare void @exit(i32) noreturn

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %i = alloca i32, align 4
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([14 x i32]* @wordcode_fib, i32 0, i32 0))
  %5 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str2, i32 0, i32 0), i64 %4)
  %6 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([23 x i32]* @wordcode_tak, i32 0, i32 0))
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str3, i32 0, i32 0), i64 %6)
  store i32 0, i32* %i, align 4
  br label %8

; <label>:8                                       ; preds = %13, %0
  %9 = load i32* %i, align 4
  %10 = icmp slt i32 %9, 20
  br i1 %10, label %11, label %16

; <label>:11                                      ; preds = %8
  %12 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([14 x i32]* @wordcode_fib, i32 0, i32 0))
  br label %13

; <label>:13                                      ; preds = %11
  %14 = load i32* %i, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, i32* %i, align 4
  br label %8

; <label>:16                                      ; preds = %8
  store i32 0, i32* %i, align 4
  br label %17

; <label>:17                                      ; preds = %22, %16
  %18 = load i32* %i, align 4
  %19 = icmp slt i32 %18, 1000
  br i1 %19, label %20, label %25

; <label>:20                                      ; preds = %17
  %21 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([23 x i32]* @wordcode_tak, i32 0, i32 0))
  br label %22

; <label>:22                                      ; preds = %20
  %23 = load i32* %i, align 4
  %24 = add nsw i32 %23, 1
  store i32 %24, i32* %i, align 4
  br label %17

; <label>:25                                      ; preds = %17
  ret i32 0
}
