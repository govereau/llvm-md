; ModuleID = 'sha1.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.SHA1Context = type { [5 x i32], [2 x i32], i32, [64 x i8] }
%union.anon = type { i32 }

@test_input_1 = global [4 x i8] c"abc\00", align 1
@test_output_1 = global [20 x i8] c"\A9\99>6G\06\81j\BA>%qxP\C2l\9C\D0\D8\9D", align 16
@test_input_2 = global [57 x i8] c"abcdbcdecdefdefgefghfghighijhijkijkljklmklmnlmnomnopnopq\00", align 16
@test_output_2 = global [20 x i8] c"\84\98>D\1C;\D2n\BA\AEJ\A1\F9Q)\E5\E5Fp\F1", align 16
@arch_big_endian = internal global i32 0, align 4
@.str = private constant [29 x i8] c"Cannot determine endianness\0A\00"
@.str1 = private constant [15 x i8] c"Test `%s': %s\0A\00"
@.str2 = private constant [7 x i8] c"passed\00"
@.str3 = private constant [7 x i8] c"FAILED\00"

define void @SHA1_init(%struct.SHA1Context* %ctx) nounwind ssp {
  %1 = alloca %struct.SHA1Context*, align 8
  store %struct.SHA1Context* %ctx, %struct.SHA1Context** %1, align 8
  %2 = load %struct.SHA1Context** %1, align 8
  %3 = getelementptr inbounds %struct.SHA1Context* %2, i32 0, i32 0
  %4 = getelementptr inbounds [5 x i32]* %3, i32 0, i64 0
  store i32 1732584193, i32* %4
  %5 = load %struct.SHA1Context** %1, align 8
  %6 = getelementptr inbounds %struct.SHA1Context* %5, i32 0, i32 0
  %7 = getelementptr inbounds [5 x i32]* %6, i32 0, i64 1
  store i32 -271733879, i32* %7
  %8 = load %struct.SHA1Context** %1, align 8
  %9 = getelementptr inbounds %struct.SHA1Context* %8, i32 0, i32 0
  %10 = getelementptr inbounds [5 x i32]* %9, i32 0, i64 2
  store i32 -1732584194, i32* %10
  %11 = load %struct.SHA1Context** %1, align 8
  %12 = getelementptr inbounds %struct.SHA1Context* %11, i32 0, i32 0
  %13 = getelementptr inbounds [5 x i32]* %12, i32 0, i64 3
  store i32 271733878, i32* %13
  %14 = load %struct.SHA1Context** %1, align 8
  %15 = getelementptr inbounds %struct.SHA1Context* %14, i32 0, i32 0
  %16 = getelementptr inbounds [5 x i32]* %15, i32 0, i64 4
  store i32 -1009589776, i32* %16
  %17 = load %struct.SHA1Context** %1, align 8
  %18 = getelementptr inbounds %struct.SHA1Context* %17, i32 0, i32 2
  store i32 0, i32* %18, align 4
  %19 = load %struct.SHA1Context** %1, align 8
  %20 = getelementptr inbounds %struct.SHA1Context* %19, i32 0, i32 1
  %21 = getelementptr inbounds [2 x i32]* %20, i32 0, i64 0
  store i32 0, i32* %21
  %22 = load %struct.SHA1Context** %1, align 8
  %23 = getelementptr inbounds %struct.SHA1Context* %22, i32 0, i32 1
  %24 = getelementptr inbounds [2 x i32]* %23, i32 0, i64 1
  store i32 0, i32* %24
  ret void
}

define void @SHA1_add_data(%struct.SHA1Context* %ctx, i8* %data, i64 %len) nounwind ssp {
  %1 = alloca %struct.SHA1Context*, align 8
  %2 = alloca i8*, align 8
  %3 = alloca i64, align 8
  %t = alloca i32, align 4
  store %struct.SHA1Context* %ctx, %struct.SHA1Context** %1, align 8
  store i8* %data, i8** %2, align 8
  store i64 %len, i64* %3, align 8
  %4 = load %struct.SHA1Context** %1, align 8
  %5 = getelementptr inbounds %struct.SHA1Context* %4, i32 0, i32 1
  %6 = getelementptr inbounds [2 x i32]* %5, i32 0, i64 1
  %7 = load i32* %6
  store i32 %7, i32* %t, align 4
  %8 = load i32* %t, align 4
  %9 = load i64* %3, align 8
  %10 = shl i64 %9, 3
  %11 = trunc i64 %10 to i32
  %12 = add i32 %8, %11
  %13 = load %struct.SHA1Context** %1, align 8
  %14 = getelementptr inbounds %struct.SHA1Context* %13, i32 0, i32 1
  %15 = getelementptr inbounds [2 x i32]* %14, i32 0, i64 1
  store i32 %12, i32* %15
  %16 = load i32* %t, align 4
  %17 = icmp ult i32 %12, %16
  br i1 %17, label %18, label %24

; <label>:18                                      ; preds = %0
  %19 = load %struct.SHA1Context** %1, align 8
  %20 = getelementptr inbounds %struct.SHA1Context* %19, i32 0, i32 1
  %21 = getelementptr inbounds [2 x i32]* %20, i32 0, i64 0
  %22 = load i32* %21
  %23 = add i32 %22, 1
  store i32 %23, i32* %21
  br label %24

; <label>:24                                      ; preds = %18, %0
  %25 = load i64* %3, align 8
  %26 = lshr i64 %25, 29
  %27 = trunc i64 %26 to i32
  %28 = load %struct.SHA1Context** %1, align 8
  %29 = getelementptr inbounds %struct.SHA1Context* %28, i32 0, i32 1
  %30 = getelementptr inbounds [2 x i32]* %29, i32 0, i64 0
  %31 = load i32* %30
  %32 = add i32 %31, %27
  store i32 %32, i32* %30
  %33 = load %struct.SHA1Context** %1, align 8
  %34 = getelementptr inbounds %struct.SHA1Context* %33, i32 0, i32 2
  %35 = load i32* %34, align 4
  %36 = icmp ne i32 %35, 0
  br i1 %36, label %37, label %156

; <label>:37                                      ; preds = %24
  %38 = load %struct.SHA1Context** %1, align 8
  %39 = getelementptr inbounds %struct.SHA1Context* %38, i32 0, i32 2
  %40 = load i32* %39, align 4
  %41 = sub nsw i32 64, %40
  store i32 %41, i32* %t, align 4
  %42 = load i64* %3, align 8
  %43 = load i32* %t, align 4
  %44 = zext i32 %43 to i64
  %45 = icmp ult i64 %42, %44
  br i1 %45, label %46, label %99

; <label>:46                                      ; preds = %37
  %47 = load %struct.SHA1Context** %1, align 8
  %48 = getelementptr inbounds %struct.SHA1Context* %47, i32 0, i32 3
  %49 = getelementptr inbounds [64 x i8]* %48, i32 0, i32 0
  %50 = load %struct.SHA1Context** %1, align 8
  %51 = getelementptr inbounds %struct.SHA1Context* %50, i32 0, i32 2
  %52 = load i32* %51, align 4
  %53 = sext i32 %52 to i64
  %54 = getelementptr inbounds i8* %49, i64 %53
  %55 = call i64 @llvm.objectsize.i64(i8* %54, i1 false)
  %56 = icmp ne i64 %55, -1
  br i1 %56, label %57, label %78

; <label>:57                                      ; preds = %46
  %58 = load %struct.SHA1Context** %1, align 8
  %59 = getelementptr inbounds %struct.SHA1Context* %58, i32 0, i32 3
  %60 = getelementptr inbounds [64 x i8]* %59, i32 0, i32 0
  %61 = load %struct.SHA1Context** %1, align 8
  %62 = getelementptr inbounds %struct.SHA1Context* %61, i32 0, i32 2
  %63 = load i32* %62, align 4
  %64 = sext i32 %63 to i64
  %65 = getelementptr inbounds i8* %60, i64 %64
  %66 = load i8** %2, align 8
  %67 = load i64* %3, align 8
  %68 = load %struct.SHA1Context** %1, align 8
  %69 = getelementptr inbounds %struct.SHA1Context* %68, i32 0, i32 3
  %70 = getelementptr inbounds [64 x i8]* %69, i32 0, i32 0
  %71 = load %struct.SHA1Context** %1, align 8
  %72 = getelementptr inbounds %struct.SHA1Context* %71, i32 0, i32 2
  %73 = load i32* %72, align 4
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds i8* %70, i64 %74
  %76 = call i64 @llvm.objectsize.i64(i8* %75, i1 false)
  %77 = call i8* @__memcpy_chk(i8* %65, i8* %66, i64 %67, i64 %76)
  br label %90

; <label>:78                                      ; preds = %46
  %79 = load %struct.SHA1Context** %1, align 8
  %80 = getelementptr inbounds %struct.SHA1Context* %79, i32 0, i32 3
  %81 = getelementptr inbounds [64 x i8]* %80, i32 0, i32 0
  %82 = load %struct.SHA1Context** %1, align 8
  %83 = getelementptr inbounds %struct.SHA1Context* %82, i32 0, i32 2
  %84 = load i32* %83, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds i8* %81, i64 %85
  %87 = load i8** %2, align 8
  %88 = load i64* %3, align 8
  %89 = call i8* @__inline_memcpy_chk(i8* %86, i8* %87, i64 %88)
  br label %90

; <label>:90                                      ; preds = %78, %57
  %91 = phi i8* [ %77, %57 ], [ %89, %78 ]
  %92 = load i64* %3, align 8
  %93 = load %struct.SHA1Context** %1, align 8
  %94 = getelementptr inbounds %struct.SHA1Context* %93, i32 0, i32 2
  %95 = load i32* %94, align 4
  %96 = sext i32 %95 to i64
  %97 = add i64 %96, %92
  %98 = trunc i64 %97 to i32
  store i32 %98, i32* %94, align 4
  br label %219

; <label>:99                                      ; preds = %37
  %100 = load %struct.SHA1Context** %1, align 8
  %101 = getelementptr inbounds %struct.SHA1Context* %100, i32 0, i32 3
  %102 = getelementptr inbounds [64 x i8]* %101, i32 0, i32 0
  %103 = load %struct.SHA1Context** %1, align 8
  %104 = getelementptr inbounds %struct.SHA1Context* %103, i32 0, i32 2
  %105 = load i32* %104, align 4
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds i8* %102, i64 %106
  %108 = call i64 @llvm.objectsize.i64(i8* %107, i1 false)
  %109 = icmp ne i64 %108, -1
  br i1 %109, label %110, label %132

; <label>:110                                     ; preds = %99
  %111 = load %struct.SHA1Context** %1, align 8
  %112 = getelementptr inbounds %struct.SHA1Context* %111, i32 0, i32 3
  %113 = getelementptr inbounds [64 x i8]* %112, i32 0, i32 0
  %114 = load %struct.SHA1Context** %1, align 8
  %115 = getelementptr inbounds %struct.SHA1Context* %114, i32 0, i32 2
  %116 = load i32* %115, align 4
  %117 = sext i32 %116 to i64
  %118 = getelementptr inbounds i8* %113, i64 %117
  %119 = load i8** %2, align 8
  %120 = load i32* %t, align 4
  %121 = zext i32 %120 to i64
  %122 = load %struct.SHA1Context** %1, align 8
  %123 = getelementptr inbounds %struct.SHA1Context* %122, i32 0, i32 3
  %124 = getelementptr inbounds [64 x i8]* %123, i32 0, i32 0
  %125 = load %struct.SHA1Context** %1, align 8
  %126 = getelementptr inbounds %struct.SHA1Context* %125, i32 0, i32 2
  %127 = load i32* %126, align 4
  %128 = sext i32 %127 to i64
  %129 = getelementptr inbounds i8* %124, i64 %128
  %130 = call i64 @llvm.objectsize.i64(i8* %129, i1 false)
  %131 = call i8* @__memcpy_chk(i8* %118, i8* %119, i64 %121, i64 %130)
  br label %145

; <label>:132                                     ; preds = %99
  %133 = load %struct.SHA1Context** %1, align 8
  %134 = getelementptr inbounds %struct.SHA1Context* %133, i32 0, i32 3
  %135 = getelementptr inbounds [64 x i8]* %134, i32 0, i32 0
  %136 = load %struct.SHA1Context** %1, align 8
  %137 = getelementptr inbounds %struct.SHA1Context* %136, i32 0, i32 2
  %138 = load i32* %137, align 4
  %139 = sext i32 %138 to i64
  %140 = getelementptr inbounds i8* %135, i64 %139
  %141 = load i8** %2, align 8
  %142 = load i32* %t, align 4
  %143 = zext i32 %142 to i64
  %144 = call i8* @__inline_memcpy_chk(i8* %140, i8* %141, i64 %143)
  br label %145

; <label>:145                                     ; preds = %132, %110
  %146 = phi i8* [ %131, %110 ], [ %144, %132 ]
  %147 = load %struct.SHA1Context** %1, align 8
  call void @SHA1_transform(%struct.SHA1Context* %147)
  %148 = load i32* %t, align 4
  %149 = load i8** %2, align 8
  %150 = zext i32 %148 to i64
  %151 = getelementptr inbounds i8* %149, i64 %150
  store i8* %151, i8** %2, align 8
  %152 = load i32* %t, align 4
  %153 = zext i32 %152 to i64
  %154 = load i64* %3, align 8
  %155 = sub i64 %154, %153
  store i64 %155, i64* %3, align 8
  br label %156

; <label>:156                                     ; preds = %145, %24
  br label %157

; <label>:157                                     ; preds = %182, %156
  %158 = load i64* %3, align 8
  %159 = icmp uge i64 %158, 64
  br i1 %159, label %160, label %189

; <label>:160                                     ; preds = %157
  %161 = load %struct.SHA1Context** %1, align 8
  %162 = getelementptr inbounds %struct.SHA1Context* %161, i32 0, i32 3
  %163 = getelementptr inbounds [64 x i8]* %162, i32 0, i32 0
  %164 = call i64 @llvm.objectsize.i64(i8* %163, i1 false)
  %165 = icmp ne i64 %164, -1
  br i1 %165, label %166, label %176

; <label>:166                                     ; preds = %160
  %167 = load %struct.SHA1Context** %1, align 8
  %168 = getelementptr inbounds %struct.SHA1Context* %167, i32 0, i32 3
  %169 = getelementptr inbounds [64 x i8]* %168, i32 0, i32 0
  %170 = load i8** %2, align 8
  %171 = load %struct.SHA1Context** %1, align 8
  %172 = getelementptr inbounds %struct.SHA1Context* %171, i32 0, i32 3
  %173 = getelementptr inbounds [64 x i8]* %172, i32 0, i32 0
  %174 = call i64 @llvm.objectsize.i64(i8* %173, i1 false)
  %175 = call i8* @__memcpy_chk(i8* %169, i8* %170, i64 64, i64 %174)
  br label %182

; <label>:176                                     ; preds = %160
  %177 = load %struct.SHA1Context** %1, align 8
  %178 = getelementptr inbounds %struct.SHA1Context* %177, i32 0, i32 3
  %179 = getelementptr inbounds [64 x i8]* %178, i32 0, i32 0
  %180 = load i8** %2, align 8
  %181 = call i8* @__inline_memcpy_chk(i8* %179, i8* %180, i64 64)
  br label %182

; <label>:182                                     ; preds = %176, %166
  %183 = phi i8* [ %175, %166 ], [ %181, %176 ]
  %184 = load %struct.SHA1Context** %1, align 8
  call void @SHA1_transform(%struct.SHA1Context* %184)
  %185 = load i8** %2, align 8
  %186 = getelementptr inbounds i8* %185, i64 64
  store i8* %186, i8** %2, align 8
  %187 = load i64* %3, align 8
  %188 = sub i64 %187, 64
  store i64 %188, i64* %3, align 8
  br label %157

; <label>:189                                     ; preds = %157
  %190 = load %struct.SHA1Context** %1, align 8
  %191 = getelementptr inbounds %struct.SHA1Context* %190, i32 0, i32 3
  %192 = getelementptr inbounds [64 x i8]* %191, i32 0, i32 0
  %193 = call i64 @llvm.objectsize.i64(i8* %192, i1 false)
  %194 = icmp ne i64 %193, -1
  br i1 %194, label %195, label %206

; <label>:195                                     ; preds = %189
  %196 = load %struct.SHA1Context** %1, align 8
  %197 = getelementptr inbounds %struct.SHA1Context* %196, i32 0, i32 3
  %198 = getelementptr inbounds [64 x i8]* %197, i32 0, i32 0
  %199 = load i8** %2, align 8
  %200 = load i64* %3, align 8
  %201 = load %struct.SHA1Context** %1, align 8
  %202 = getelementptr inbounds %struct.SHA1Context* %201, i32 0, i32 3
  %203 = getelementptr inbounds [64 x i8]* %202, i32 0, i32 0
  %204 = call i64 @llvm.objectsize.i64(i8* %203, i1 false)
  %205 = call i8* @__memcpy_chk(i8* %198, i8* %199, i64 %200, i64 %204)
  br label %213

; <label>:206                                     ; preds = %189
  %207 = load %struct.SHA1Context** %1, align 8
  %208 = getelementptr inbounds %struct.SHA1Context* %207, i32 0, i32 3
  %209 = getelementptr inbounds [64 x i8]* %208, i32 0, i32 0
  %210 = load i8** %2, align 8
  %211 = load i64* %3, align 8
  %212 = call i8* @__inline_memcpy_chk(i8* %209, i8* %210, i64 %211)
  br label %213

; <label>:213                                     ; preds = %206, %195
  %214 = phi i8* [ %205, %195 ], [ %212, %206 ]
  %215 = load i64* %3, align 8
  %216 = trunc i64 %215 to i32
  %217 = load %struct.SHA1Context** %1, align 8
  %218 = getelementptr inbounds %struct.SHA1Context* %217, i32 0, i32 2
  store i32 %216, i32* %218, align 4
  br label %219

; <label>:219                                     ; preds = %213, %90
  ret void
}

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

declare i8* @__memcpy_chk(i8*, i8*, i64, i64) nounwind

define internal i8* @__inline_memcpy_chk(i8* %__dest, i8* %__src, i64 %__len) nounwind inlinehint ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  %3 = alloca i64, align 8
  store i8* %__dest, i8** %1, align 8
  store i8* %__src, i8** %2, align 8
  store i64 %__len, i64* %3, align 8
  %4 = load i8** %1, align 8
  %5 = load i8** %2, align 8
  %6 = load i64* %3, align 8
  %7 = load i8** %1, align 8
  %8 = call i64 @llvm.objectsize.i64(i8* %7, i1 false)
  %9 = call i8* @__memcpy_chk(i8* %4, i8* %5, i64 %6, i64 %8)
  ret i8* %9
}

define internal void @SHA1_transform(%struct.SHA1Context* %ctx) nounwind ssp {
  %1 = alloca %struct.SHA1Context*, align 8
  %i = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %t = alloca i32, align 4
  %data = alloca [80 x i32], align 16
  store %struct.SHA1Context* %ctx, %struct.SHA1Context** %1, align 8
  %2 = load %struct.SHA1Context** %1, align 8
  %3 = getelementptr inbounds %struct.SHA1Context* %2, i32 0, i32 3
  %4 = getelementptr inbounds [64 x i8]* %3, i32 0, i32 0
  %5 = getelementptr inbounds [80 x i32]* %data, i32 0, i32 0
  %6 = bitcast i32* %5 to i8*
  call void @SHA1_copy_and_swap(i8* %4, i8* %6, i32 16)
  store i32 16, i32* %i, align 4
  br label %7

; <label>:7                                       ; preds = %42, %0
  %8 = load i32* %i, align 4
  %9 = icmp slt i32 %8, 80
  br i1 %9, label %10, label %45

; <label>:10                                      ; preds = %7
  %11 = load i32* %i, align 4
  %12 = sub nsw i32 %11, 3
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %13
  %15 = load i32* %14
  %16 = load i32* %i, align 4
  %17 = sub nsw i32 %16, 8
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %18
  %20 = load i32* %19
  %21 = xor i32 %15, %20
  %22 = load i32* %i, align 4
  %23 = sub nsw i32 %22, 14
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %24
  %26 = load i32* %25
  %27 = xor i32 %21, %26
  %28 = load i32* %i, align 4
  %29 = sub nsw i32 %28, 16
  %30 = sext i32 %29 to i64
  %31 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %30
  %32 = load i32* %31
  %33 = xor i32 %27, %32
  store i32 %33, i32* %t, align 4
  %34 = load i32* %t, align 4
  %35 = shl i32 %34, 1
  %36 = load i32* %t, align 4
  %37 = lshr i32 %36, 31
  %38 = or i32 %35, %37
  %39 = load i32* %i, align 4
  %40 = sext i32 %39 to i64
  %41 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %40
  store i32 %38, i32* %41
  br label %42

; <label>:42                                      ; preds = %10
  %43 = load i32* %i, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, i32* %i, align 4
  br label %7

; <label>:45                                      ; preds = %7
  %46 = load %struct.SHA1Context** %1, align 8
  %47 = getelementptr inbounds %struct.SHA1Context* %46, i32 0, i32 0
  %48 = getelementptr inbounds [5 x i32]* %47, i32 0, i64 0
  %49 = load i32* %48
  store i32 %49, i32* %a, align 4
  %50 = load %struct.SHA1Context** %1, align 8
  %51 = getelementptr inbounds %struct.SHA1Context* %50, i32 0, i32 0
  %52 = getelementptr inbounds [5 x i32]* %51, i32 0, i64 1
  %53 = load i32* %52
  store i32 %53, i32* %b, align 4
  %54 = load %struct.SHA1Context** %1, align 8
  %55 = getelementptr inbounds %struct.SHA1Context* %54, i32 0, i32 0
  %56 = getelementptr inbounds [5 x i32]* %55, i32 0, i64 2
  %57 = load i32* %56
  store i32 %57, i32* %c, align 4
  %58 = load %struct.SHA1Context** %1, align 8
  %59 = getelementptr inbounds %struct.SHA1Context* %58, i32 0, i32 0
  %60 = getelementptr inbounds [5 x i32]* %59, i32 0, i64 3
  %61 = load i32* %60
  store i32 %61, i32* %d, align 4
  %62 = load %struct.SHA1Context** %1, align 8
  %63 = getelementptr inbounds %struct.SHA1Context* %62, i32 0, i32 0
  %64 = getelementptr inbounds [5 x i32]* %63, i32 0, i64 4
  %65 = load i32* %64
  store i32 %65, i32* %e, align 4
  store i32 0, i32* %i, align 4
  br label %66

; <label>:66                                      ; preds = %100, %45
  %67 = load i32* %i, align 4
  %68 = icmp slt i32 %67, 20
  br i1 %68, label %69, label %103

; <label>:69                                      ; preds = %66
  %70 = load i32* %d, align 4
  %71 = load i32* %b, align 4
  %72 = load i32* %c, align 4
  %73 = load i32* %d, align 4
  %74 = xor i32 %72, %73
  %75 = and i32 %71, %74
  %76 = xor i32 %70, %75
  %77 = add i32 %76, 1518500249
  %78 = load i32* %a, align 4
  %79 = shl i32 %78, 5
  %80 = load i32* %a, align 4
  %81 = lshr i32 %80, 27
  %82 = or i32 %79, %81
  %83 = add i32 %77, %82
  %84 = load i32* %e, align 4
  %85 = add i32 %83, %84
  %86 = load i32* %i, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %87
  %89 = load i32* %88
  %90 = add i32 %85, %89
  store i32 %90, i32* %t, align 4
  %91 = load i32* %d, align 4
  store i32 %91, i32* %e, align 4
  %92 = load i32* %c, align 4
  store i32 %92, i32* %d, align 4
  %93 = load i32* %b, align 4
  %94 = shl i32 %93, 30
  %95 = load i32* %b, align 4
  %96 = lshr i32 %95, 2
  %97 = or i32 %94, %96
  store i32 %97, i32* %c, align 4
  %98 = load i32* %a, align 4
  store i32 %98, i32* %b, align 4
  %99 = load i32* %t, align 4
  store i32 %99, i32* %a, align 4
  br label %100

; <label>:100                                     ; preds = %69
  %101 = load i32* %i, align 4
  %102 = add nsw i32 %101, 1
  store i32 %102, i32* %i, align 4
  br label %66

; <label>:103                                     ; preds = %66
  br label %104

; <label>:104                                     ; preds = %136, %103
  %105 = load i32* %i, align 4
  %106 = icmp slt i32 %105, 40
  br i1 %106, label %107, label %139

; <label>:107                                     ; preds = %104
  %108 = load i32* %b, align 4
  %109 = load i32* %c, align 4
  %110 = xor i32 %108, %109
  %111 = load i32* %d, align 4
  %112 = xor i32 %110, %111
  %113 = add i32 %112, 1859775393
  %114 = load i32* %a, align 4
  %115 = shl i32 %114, 5
  %116 = load i32* %a, align 4
  %117 = lshr i32 %116, 27
  %118 = or i32 %115, %117
  %119 = add i32 %113, %118
  %120 = load i32* %e, align 4
  %121 = add i32 %119, %120
  %122 = load i32* %i, align 4
  %123 = sext i32 %122 to i64
  %124 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %123
  %125 = load i32* %124
  %126 = add i32 %121, %125
  store i32 %126, i32* %t, align 4
  %127 = load i32* %d, align 4
  store i32 %127, i32* %e, align 4
  %128 = load i32* %c, align 4
  store i32 %128, i32* %d, align 4
  %129 = load i32* %b, align 4
  %130 = shl i32 %129, 30
  %131 = load i32* %b, align 4
  %132 = lshr i32 %131, 2
  %133 = or i32 %130, %132
  store i32 %133, i32* %c, align 4
  %134 = load i32* %a, align 4
  store i32 %134, i32* %b, align 4
  %135 = load i32* %t, align 4
  store i32 %135, i32* %a, align 4
  br label %136

; <label>:136                                     ; preds = %107
  %137 = load i32* %i, align 4
  %138 = add nsw i32 %137, 1
  store i32 %138, i32* %i, align 4
  br label %104

; <label>:139                                     ; preds = %104
  br label %140

; <label>:140                                     ; preds = %176, %139
  %141 = load i32* %i, align 4
  %142 = icmp slt i32 %141, 60
  br i1 %142, label %143, label %179

; <label>:143                                     ; preds = %140
  %144 = load i32* %b, align 4
  %145 = load i32* %c, align 4
  %146 = and i32 %144, %145
  %147 = load i32* %d, align 4
  %148 = load i32* %b, align 4
  %149 = load i32* %c, align 4
  %150 = or i32 %148, %149
  %151 = and i32 %147, %150
  %152 = or i32 %146, %151
  %153 = add i32 %152, -1894007588
  %154 = load i32* %a, align 4
  %155 = shl i32 %154, 5
  %156 = load i32* %a, align 4
  %157 = lshr i32 %156, 27
  %158 = or i32 %155, %157
  %159 = add i32 %153, %158
  %160 = load i32* %e, align 4
  %161 = add i32 %159, %160
  %162 = load i32* %i, align 4
  %163 = sext i32 %162 to i64
  %164 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %163
  %165 = load i32* %164
  %166 = add i32 %161, %165
  store i32 %166, i32* %t, align 4
  %167 = load i32* %d, align 4
  store i32 %167, i32* %e, align 4
  %168 = load i32* %c, align 4
  store i32 %168, i32* %d, align 4
  %169 = load i32* %b, align 4
  %170 = shl i32 %169, 30
  %171 = load i32* %b, align 4
  %172 = lshr i32 %171, 2
  %173 = or i32 %170, %172
  store i32 %173, i32* %c, align 4
  %174 = load i32* %a, align 4
  store i32 %174, i32* %b, align 4
  %175 = load i32* %t, align 4
  store i32 %175, i32* %a, align 4
  br label %176

; <label>:176                                     ; preds = %143
  %177 = load i32* %i, align 4
  %178 = add nsw i32 %177, 1
  store i32 %178, i32* %i, align 4
  br label %140

; <label>:179                                     ; preds = %140
  br label %180

; <label>:180                                     ; preds = %212, %179
  %181 = load i32* %i, align 4
  %182 = icmp slt i32 %181, 80
  br i1 %182, label %183, label %215

; <label>:183                                     ; preds = %180
  %184 = load i32* %b, align 4
  %185 = load i32* %c, align 4
  %186 = xor i32 %184, %185
  %187 = load i32* %d, align 4
  %188 = xor i32 %186, %187
  %189 = add i32 %188, -899497514
  %190 = load i32* %a, align 4
  %191 = shl i32 %190, 5
  %192 = load i32* %a, align 4
  %193 = lshr i32 %192, 27
  %194 = or i32 %191, %193
  %195 = add i32 %189, %194
  %196 = load i32* %e, align 4
  %197 = add i32 %195, %196
  %198 = load i32* %i, align 4
  %199 = sext i32 %198 to i64
  %200 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %199
  %201 = load i32* %200
  %202 = add i32 %197, %201
  store i32 %202, i32* %t, align 4
  %203 = load i32* %d, align 4
  store i32 %203, i32* %e, align 4
  %204 = load i32* %c, align 4
  store i32 %204, i32* %d, align 4
  %205 = load i32* %b, align 4
  %206 = shl i32 %205, 30
  %207 = load i32* %b, align 4
  %208 = lshr i32 %207, 2
  %209 = or i32 %206, %208
  store i32 %209, i32* %c, align 4
  %210 = load i32* %a, align 4
  store i32 %210, i32* %b, align 4
  %211 = load i32* %t, align 4
  store i32 %211, i32* %a, align 4
  br label %212

; <label>:212                                     ; preds = %183
  %213 = load i32* %i, align 4
  %214 = add nsw i32 %213, 1
  store i32 %214, i32* %i, align 4
  br label %180

; <label>:215                                     ; preds = %180
  %216 = load i32* %a, align 4
  %217 = load %struct.SHA1Context** %1, align 8
  %218 = getelementptr inbounds %struct.SHA1Context* %217, i32 0, i32 0
  %219 = getelementptr inbounds [5 x i32]* %218, i32 0, i64 0
  %220 = load i32* %219
  %221 = add i32 %220, %216
  store i32 %221, i32* %219
  %222 = load i32* %b, align 4
  %223 = load %struct.SHA1Context** %1, align 8
  %224 = getelementptr inbounds %struct.SHA1Context* %223, i32 0, i32 0
  %225 = getelementptr inbounds [5 x i32]* %224, i32 0, i64 1
  %226 = load i32* %225
  %227 = add i32 %226, %222
  store i32 %227, i32* %225
  %228 = load i32* %c, align 4
  %229 = load %struct.SHA1Context** %1, align 8
  %230 = getelementptr inbounds %struct.SHA1Context* %229, i32 0, i32 0
  %231 = getelementptr inbounds [5 x i32]* %230, i32 0, i64 2
  %232 = load i32* %231
  %233 = add i32 %232, %228
  store i32 %233, i32* %231
  %234 = load i32* %d, align 4
  %235 = load %struct.SHA1Context** %1, align 8
  %236 = getelementptr inbounds %struct.SHA1Context* %235, i32 0, i32 0
  %237 = getelementptr inbounds [5 x i32]* %236, i32 0, i64 3
  %238 = load i32* %237
  %239 = add i32 %238, %234
  store i32 %239, i32* %237
  %240 = load i32* %e, align 4
  %241 = load %struct.SHA1Context** %1, align 8
  %242 = getelementptr inbounds %struct.SHA1Context* %241, i32 0, i32 0
  %243 = getelementptr inbounds [5 x i32]* %242, i32 0, i64 4
  %244 = load i32* %243
  %245 = add i32 %244, %240
  store i32 %245, i32* %243
  ret void
}

define void @SHA1_finish(%struct.SHA1Context* %ctx, i8* %output) nounwind ssp {
  %1 = alloca %struct.SHA1Context*, align 8
  %2 = alloca i8*, align 8
  %i = alloca i32, align 4
  store %struct.SHA1Context* %ctx, %struct.SHA1Context** %1, align 8
  store i8* %output, i8** %2, align 8
  %3 = load %struct.SHA1Context** %1, align 8
  %4 = getelementptr inbounds %struct.SHA1Context* %3, i32 0, i32 2
  %5 = load i32* %4, align 4
  store i32 %5, i32* %i, align 4
  %6 = load i32* %i, align 4
  %7 = add nsw i32 %6, 1
  store i32 %7, i32* %i, align 4
  %8 = sext i32 %6 to i64
  %9 = load %struct.SHA1Context** %1, align 8
  %10 = getelementptr inbounds %struct.SHA1Context* %9, i32 0, i32 3
  %11 = getelementptr inbounds [64 x i8]* %10, i32 0, i64 %8
  store i8 -128, i8* %11
  %12 = load i32* %i, align 4
  %13 = icmp sgt i32 %12, 56
  br i1 %13, label %14, label %55

; <label>:14                                      ; preds = %0
  %15 = load %struct.SHA1Context** %1, align 8
  %16 = getelementptr inbounds %struct.SHA1Context* %15, i32 0, i32 3
  %17 = getelementptr inbounds [64 x i8]* %16, i32 0, i32 0
  %18 = load i32* %i, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds i8* %17, i64 %19
  %21 = call i64 @llvm.objectsize.i64(i8* %20, i1 false)
  %22 = icmp ne i64 %21, -1
  br i1 %22, label %23, label %41

; <label>:23                                      ; preds = %14
  %24 = load %struct.SHA1Context** %1, align 8
  %25 = getelementptr inbounds %struct.SHA1Context* %24, i32 0, i32 3
  %26 = getelementptr inbounds [64 x i8]* %25, i32 0, i32 0
  %27 = load i32* %i, align 4
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds i8* %26, i64 %28
  %30 = load i32* %i, align 4
  %31 = sub nsw i32 64, %30
  %32 = sext i32 %31 to i64
  %33 = load %struct.SHA1Context** %1, align 8
  %34 = getelementptr inbounds %struct.SHA1Context* %33, i32 0, i32 3
  %35 = getelementptr inbounds [64 x i8]* %34, i32 0, i32 0
  %36 = load i32* %i, align 4
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds i8* %35, i64 %37
  %39 = call i64 @llvm.objectsize.i64(i8* %38, i1 false)
  %40 = call i8* @__memset_chk(i8* %29, i32 0, i64 %32, i64 %39)
  br label %52

; <label>:41                                      ; preds = %14
  %42 = load %struct.SHA1Context** %1, align 8
  %43 = getelementptr inbounds %struct.SHA1Context* %42, i32 0, i32 3
  %44 = getelementptr inbounds [64 x i8]* %43, i32 0, i32 0
  %45 = load i32* %i, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds i8* %44, i64 %46
  %48 = load i32* %i, align 4
  %49 = sub nsw i32 64, %48
  %50 = sext i32 %49 to i64
  %51 = call i8* @__inline_memset_chk(i8* %47, i32 0, i64 %50)
  br label %52

; <label>:52                                      ; preds = %41, %23
  %53 = phi i8* [ %40, %23 ], [ %51, %41 ]
  %54 = load %struct.SHA1Context** %1, align 8
  call void @SHA1_transform(%struct.SHA1Context* %54)
  store i32 0, i32* %i, align 4
  br label %55

; <label>:55                                      ; preds = %52, %0
  %56 = load %struct.SHA1Context** %1, align 8
  %57 = getelementptr inbounds %struct.SHA1Context* %56, i32 0, i32 3
  %58 = getelementptr inbounds [64 x i8]* %57, i32 0, i32 0
  %59 = load i32* %i, align 4
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds i8* %58, i64 %60
  %62 = call i64 @llvm.objectsize.i64(i8* %61, i1 false)
  %63 = icmp ne i64 %62, -1
  br i1 %63, label %64, label %82

; <label>:64                                      ; preds = %55
  %65 = load %struct.SHA1Context** %1, align 8
  %66 = getelementptr inbounds %struct.SHA1Context* %65, i32 0, i32 3
  %67 = getelementptr inbounds [64 x i8]* %66, i32 0, i32 0
  %68 = load i32* %i, align 4
  %69 = sext i32 %68 to i64
  %70 = getelementptr inbounds i8* %67, i64 %69
  %71 = load i32* %i, align 4
  %72 = sub nsw i32 56, %71
  %73 = sext i32 %72 to i64
  %74 = load %struct.SHA1Context** %1, align 8
  %75 = getelementptr inbounds %struct.SHA1Context* %74, i32 0, i32 3
  %76 = getelementptr inbounds [64 x i8]* %75, i32 0, i32 0
  %77 = load i32* %i, align 4
  %78 = sext i32 %77 to i64
  %79 = getelementptr inbounds i8* %76, i64 %78
  %80 = call i64 @llvm.objectsize.i64(i8* %79, i1 false)
  %81 = call i8* @__memset_chk(i8* %70, i32 0, i64 %73, i64 %80)
  br label %93

; <label>:82                                      ; preds = %55
  %83 = load %struct.SHA1Context** %1, align 8
  %84 = getelementptr inbounds %struct.SHA1Context* %83, i32 0, i32 3
  %85 = getelementptr inbounds [64 x i8]* %84, i32 0, i32 0
  %86 = load i32* %i, align 4
  %87 = sext i32 %86 to i64
  %88 = getelementptr inbounds i8* %85, i64 %87
  %89 = load i32* %i, align 4
  %90 = sub nsw i32 56, %89
  %91 = sext i32 %90 to i64
  %92 = call i8* @__inline_memset_chk(i8* %88, i32 0, i64 %91)
  br label %93

; <label>:93                                      ; preds = %82, %64
  %94 = phi i8* [ %81, %64 ], [ %92, %82 ]
  %95 = load %struct.SHA1Context** %1, align 8
  %96 = getelementptr inbounds %struct.SHA1Context* %95, i32 0, i32 1
  %97 = getelementptr inbounds [2 x i32]* %96, i32 0, i32 0
  %98 = bitcast i32* %97 to i8*
  %99 = load %struct.SHA1Context** %1, align 8
  %100 = getelementptr inbounds %struct.SHA1Context* %99, i32 0, i32 3
  %101 = getelementptr inbounds [64 x i8]* %100, i32 0, i32 0
  %102 = getelementptr inbounds i8* %101, i64 56
  call void @SHA1_copy_and_swap(i8* %98, i8* %102, i32 2)
  %103 = load %struct.SHA1Context** %1, align 8
  call void @SHA1_transform(%struct.SHA1Context* %103)
  %104 = load %struct.SHA1Context** %1, align 8
  %105 = getelementptr inbounds %struct.SHA1Context* %104, i32 0, i32 0
  %106 = getelementptr inbounds [5 x i32]* %105, i32 0, i32 0
  %107 = bitcast i32* %106 to i8*
  %108 = load i8** %2, align 8
  call void @SHA1_copy_and_swap(i8* %107, i8* %108, i32 5)
  ret void
}

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

define internal void @SHA1_copy_and_swap(i8* %src, i8* %dst, i32 %numwords) nounwind ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  %3 = alloca i32, align 4
  %s = alloca i8*, align 8
  %d = alloca i8*, align 8
  %a = alloca i8, align 1
  %b = alloca i8, align 1
  store i8* %src, i8** %1, align 8
  store i8* %dst, i8** %2, align 8
  store i32 %numwords, i32* %3, align 4
  %4 = load i32* @arch_big_endian, align 4
  %5 = icmp ne i32 %4, 0
  br i1 %5, label %6, label %28

; <label>:6                                       ; preds = %0
  %7 = load i8** %2, align 8
  %8 = call i64 @llvm.objectsize.i64(i8* %7, i1 false)
  %9 = icmp ne i64 %8, -1
  br i1 %9, label %10, label %19

; <label>:10                                      ; preds = %6
  %11 = load i8** %2, align 8
  %12 = load i8** %1, align 8
  %13 = load i32* %3, align 4
  %14 = sext i32 %13 to i64
  %15 = mul i64 %14, 4
  %16 = load i8** %2, align 8
  %17 = call i64 @llvm.objectsize.i64(i8* %16, i1 false)
  %18 = call i8* @__memcpy_chk(i8* %11, i8* %12, i64 %15, i64 %17)
  br label %26

; <label>:19                                      ; preds = %6
  %20 = load i8** %2, align 8
  %21 = load i8** %1, align 8
  %22 = load i32* %3, align 4
  %23 = sext i32 %22 to i64
  %24 = mul i64 %23, 4
  %25 = call i8* @__inline_memcpy_chk(i8* %20, i8* %21, i64 %24)
  br label %26

; <label>:26                                      ; preds = %19, %10
  %27 = phi i8* [ %18, %10 ], [ %25, %19 ]
  br label %65

; <label>:28                                      ; preds = %0
  %29 = load i8** %1, align 8
  store i8* %29, i8** %s, align 8
  %30 = load i8** %2, align 8
  store i8* %30, i8** %d, align 8
  br label %31

; <label>:31                                      ; preds = %57, %28
  %32 = load i32* %3, align 4
  %33 = icmp sgt i32 %32, 0
  br i1 %33, label %34, label %64

; <label>:34                                      ; preds = %31
  %35 = load i8** %s, align 8
  %36 = getelementptr inbounds i8* %35, i64 0
  %37 = load i8* %36
  store i8 %37, i8* %a, align 1
  %38 = load i8** %s, align 8
  %39 = getelementptr inbounds i8* %38, i64 1
  %40 = load i8* %39
  store i8 %40, i8* %b, align 1
  %41 = load i8** %s, align 8
  %42 = getelementptr inbounds i8* %41, i64 3
  %43 = load i8* %42
  %44 = load i8** %d, align 8
  %45 = getelementptr inbounds i8* %44, i64 0
  store i8 %43, i8* %45
  %46 = load i8** %s, align 8
  %47 = getelementptr inbounds i8* %46, i64 2
  %48 = load i8* %47
  %49 = load i8** %d, align 8
  %50 = getelementptr inbounds i8* %49, i64 1
  store i8 %48, i8* %50
  %51 = load i8* %b, align 1
  %52 = load i8** %d, align 8
  %53 = getelementptr inbounds i8* %52, i64 2
  store i8 %51, i8* %53
  %54 = load i8* %a, align 1
  %55 = load i8** %d, align 8
  %56 = getelementptr inbounds i8* %55, i64 3
  store i8 %54, i8* %56
  br label %57

; <label>:57                                      ; preds = %34
  %58 = load i8** %s, align 8
  %59 = getelementptr inbounds i8* %58, i64 4
  store i8* %59, i8** %s, align 8
  %60 = load i8** %d, align 8
  %61 = getelementptr inbounds i8* %60, i64 4
  store i8* %61, i8** %d, align 8
  %62 = load i32* %3, align 4
  %63 = add nsw i32 %62, -1
  store i32 %63, i32* %3, align 4
  br label %31

; <label>:64                                      ; preds = %31
  br label %65

; <label>:65                                      ; preds = %64, %26
  ret void
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %u = alloca %union.anon, align 4
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = getelementptr inbounds %union.anon* %u, i32 0, i32 0
  store i32 305419896, i32* %4, align 4
  %5 = getelementptr inbounds %union.anon* %u, i32 0, i32 0
  %6 = bitcast i32* %5 to [4 x i8]*
  %7 = getelementptr inbounds [4 x i8]* %6, i32 0, i64 0
  %8 = load i8* %7
  %9 = zext i8 %8 to i32
  switch i32 %9, label %12 [
    i32 18, label %10
    i32 120, label %11
  ]

; <label>:10                                      ; preds = %0
  store i32 1, i32* @arch_big_endian, align 4
  br label %14

; <label>:11                                      ; preds = %0
  store i32 0, i32* @arch_big_endian, align 4
  br label %14

; <label>:12                                      ; preds = %0
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([29 x i8]* @.str, i32 0, i32 0))
  store i32 2, i32* %1
  br label %15

; <label>:14                                      ; preds = %11, %10
  call void @do_test(i8* getelementptr inbounds ([4 x i8]* @test_input_1, i32 0, i32 0), i8* getelementptr inbounds ([20 x i8]* @test_output_1, i32 0, i32 0))
  call void @do_test(i8* getelementptr inbounds ([57 x i8]* @test_input_2, i32 0, i32 0), i8* getelementptr inbounds ([20 x i8]* @test_output_2, i32 0, i32 0))
  call void @do_bench(i32 1000000)
  store i32 0, i32* %1
  br label %15

; <label>:15                                      ; preds = %14, %12
  %16 = load i32* %1
  ret i32 %16
}

declare i32 @printf(i8*, ...)

define internal void @do_test(i8* %txt, i8* %expected_output) nounwind ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  %ctx = alloca %struct.SHA1Context, align 4
  %output = alloca [20 x i8], align 16
  %ok = alloca i32, align 4
  store i8* %txt, i8** %1, align 8
  store i8* %expected_output, i8** %2, align 8
  call void @SHA1_init(%struct.SHA1Context* %ctx)
  %3 = load i8** %1, align 8
  %4 = load i8** %1, align 8
  %5 = call i64 @strlen(i8* %4)
  call void @SHA1_add_data(%struct.SHA1Context* %ctx, i8* %3, i64 %5)
  %6 = getelementptr inbounds [20 x i8]* %output, i32 0, i32 0
  call void @SHA1_finish(%struct.SHA1Context* %ctx, i8* %6)
  %7 = getelementptr inbounds [20 x i8]* %output, i32 0, i32 0
  %8 = load i8** %2, align 8
  %9 = call i32 @memcmp(i8* %7, i8* %8, i64 20)
  %10 = icmp eq i32 %9, 0
  %11 = zext i1 %10 to i32
  store i32 %11, i32* %ok, align 4
  %12 = load i8** %1, align 8
  %13 = load i32* %ok, align 4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %16

; <label>:15                                      ; preds = %0
  br label %17

; <label>:16                                      ; preds = %0
  br label %17

; <label>:17                                      ; preds = %16, %15
  %18 = phi i8* [ getelementptr inbounds ([7 x i8]* @.str2, i32 0, i32 0), %15 ], [ getelementptr inbounds ([7 x i8]* @.str3, i32 0, i32 0), %16 ]
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str1, i32 0, i32 0), i8* %12, i8* %18)
  ret void
}

define internal void @do_bench(i32 %nblocks) nounwind ssp {
  %1 = alloca i32, align 4
  %ctx = alloca %struct.SHA1Context, align 4
  %output = alloca [20 x i8], align 16
  %data = alloca [64 x i8], align 16
  store i32 %nblocks, i32* %1, align 4
  call void @SHA1_init(%struct.SHA1Context* %ctx)
  br label %2

; <label>:2                                       ; preds = %7, %0
  %3 = load i32* %1, align 4
  %4 = icmp sgt i32 %3, 0
  br i1 %4, label %5, label %10

; <label>:5                                       ; preds = %2
  %6 = getelementptr inbounds [64 x i8]* %data, i32 0, i32 0
  call void @SHA1_add_data(%struct.SHA1Context* %ctx, i8* %6, i64 64)
  br label %7

; <label>:7                                       ; preds = %5
  %8 = load i32* %1, align 4
  %9 = add nsw i32 %8, -1
  store i32 %9, i32* %1, align 4
  br label %2

; <label>:10                                      ; preds = %2
  %11 = getelementptr inbounds [20 x i8]* %output, i32 0, i32 0
  call void @SHA1_finish(%struct.SHA1Context* %ctx, i8* %11)
  ret void
}

declare i64 @strlen(i8*)

declare i32 @memcmp(i8*, i8*, i64)
