; ModuleID = 'sha1.c.m2r.o'
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
  %1 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %2 = getelementptr inbounds [5 x i32]* %1, i32 0, i64 0
  store i32 1732584193, i32* %2
  %3 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %4 = getelementptr inbounds [5 x i32]* %3, i32 0, i64 1
  store i32 -271733879, i32* %4
  %5 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %6 = getelementptr inbounds [5 x i32]* %5, i32 0, i64 2
  store i32 -1732584194, i32* %6
  %7 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %8 = getelementptr inbounds [5 x i32]* %7, i32 0, i64 3
  store i32 271733878, i32* %8
  %9 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %10 = getelementptr inbounds [5 x i32]* %9, i32 0, i64 4
  store i32 -1009589776, i32* %10
  %11 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  store i32 0, i32* %11, align 4
  %12 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %13 = getelementptr inbounds [2 x i32]* %12, i32 0, i64 0
  store i32 0, i32* %13
  %14 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %15 = getelementptr inbounds [2 x i32]* %14, i32 0, i64 1
  store i32 0, i32* %15
  ret void
}

define void @SHA1_add_data(%struct.SHA1Context* %ctx, i8* %data, i64 %len) nounwind ssp {
  %1 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %2 = getelementptr inbounds [2 x i32]* %1, i32 0, i64 1
  %3 = load i32* %2
  %4 = shl i64 %len, 3
  %5 = trunc i64 %4 to i32
  %6 = add i32 %3, %5
  %7 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %8 = getelementptr inbounds [2 x i32]* %7, i32 0, i64 1
  store i32 %6, i32* %8
  %9 = icmp ult i32 %6, %3
  br i1 %9, label %10, label %15

; <label>:10                                      ; preds = %0
  %11 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %12 = getelementptr inbounds [2 x i32]* %11, i32 0, i64 0
  %13 = load i32* %12
  %14 = add i32 %13, 1
  store i32 %14, i32* %12
  br label %15

; <label>:15                                      ; preds = %10, %0
  %16 = lshr i64 %len, 29
  %17 = trunc i64 %16 to i32
  %18 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %19 = getelementptr inbounds [2 x i32]* %18, i32 0, i64 0
  %20 = load i32* %19
  %21 = add i32 %20, %17
  store i32 %21, i32* %19
  %22 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %23 = load i32* %22, align 4
  %24 = icmp ne i32 %23, 0
  br i1 %24, label %25, label %110

; <label>:25                                      ; preds = %15
  %26 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %27 = load i32* %26, align 4
  %28 = sub nsw i32 64, %27
  %29 = zext i32 %28 to i64
  %30 = icmp ult i64 %len, %29
  br i1 %30, label %31, label %70

; <label>:31                                      ; preds = %25
  %32 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %33 = getelementptr inbounds [64 x i8]* %32, i32 0, i32 0
  %34 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %35 = load i32* %34, align 4
  %36 = sext i32 %35 to i64
  %37 = getelementptr inbounds i8* %33, i64 %36
  %38 = call i64 @llvm.objectsize.i64(i8* %37, i1 false)
  %39 = icmp ne i64 %38, -1
  br i1 %39, label %40, label %55

; <label>:40                                      ; preds = %31
  %41 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %42 = getelementptr inbounds [64 x i8]* %41, i32 0, i32 0
  %43 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %44 = load i32* %43, align 4
  %45 = sext i32 %44 to i64
  %46 = getelementptr inbounds i8* %42, i64 %45
  %47 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %48 = getelementptr inbounds [64 x i8]* %47, i32 0, i32 0
  %49 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %50 = load i32* %49, align 4
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds i8* %48, i64 %51
  %53 = call i64 @llvm.objectsize.i64(i8* %52, i1 false)
  %54 = call i8* @__memcpy_chk(i8* %46, i8* %data, i64 %len, i64 %53)
  br label %63

; <label>:55                                      ; preds = %31
  %56 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %57 = getelementptr inbounds [64 x i8]* %56, i32 0, i32 0
  %58 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %59 = load i32* %58, align 4
  %60 = sext i32 %59 to i64
  %61 = getelementptr inbounds i8* %57, i64 %60
  %62 = call i8* @__inline_memcpy_chk(i8* %61, i8* %data, i64 %len)
  br label %63

; <label>:63                                      ; preds = %55, %40
  %64 = phi i8* [ %54, %40 ], [ %62, %55 ]
  %65 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %66 = load i32* %65, align 4
  %67 = sext i32 %66 to i64
  %68 = add i64 %67, %len
  %69 = trunc i64 %68 to i32
  store i32 %69, i32* %65, align 4
  br label %153

; <label>:70                                      ; preds = %25
  %71 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %72 = getelementptr inbounds [64 x i8]* %71, i32 0, i32 0
  %73 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %74 = load i32* %73, align 4
  %75 = sext i32 %74 to i64
  %76 = getelementptr inbounds i8* %72, i64 %75
  %77 = call i64 @llvm.objectsize.i64(i8* %76, i1 false)
  %78 = icmp ne i64 %77, -1
  br i1 %78, label %79, label %95

; <label>:79                                      ; preds = %70
  %80 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %81 = getelementptr inbounds [64 x i8]* %80, i32 0, i32 0
  %82 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %83 = load i32* %82, align 4
  %84 = sext i32 %83 to i64
  %85 = getelementptr inbounds i8* %81, i64 %84
  %86 = zext i32 %28 to i64
  %87 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %88 = getelementptr inbounds [64 x i8]* %87, i32 0, i32 0
  %89 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %90 = load i32* %89, align 4
  %91 = sext i32 %90 to i64
  %92 = getelementptr inbounds i8* %88, i64 %91
  %93 = call i64 @llvm.objectsize.i64(i8* %92, i1 false)
  %94 = call i8* @__memcpy_chk(i8* %85, i8* %data, i64 %86, i64 %93)
  br label %104

; <label>:95                                      ; preds = %70
  %96 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %97 = getelementptr inbounds [64 x i8]* %96, i32 0, i32 0
  %98 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %99 = load i32* %98, align 4
  %100 = sext i32 %99 to i64
  %101 = getelementptr inbounds i8* %97, i64 %100
  %102 = zext i32 %28 to i64
  %103 = call i8* @__inline_memcpy_chk(i8* %101, i8* %data, i64 %102)
  br label %104

; <label>:104                                     ; preds = %95, %79
  %105 = phi i8* [ %94, %79 ], [ %103, %95 ]
  call void @SHA1_transform(%struct.SHA1Context* %ctx)
  %106 = zext i32 %28 to i64
  %107 = getelementptr inbounds i8* %data, i64 %106
  %108 = zext i32 %28 to i64
  %109 = sub i64 %len, %108
  br label %110

; <label>:110                                     ; preds = %104, %15
  %.01 = phi i64 [ %109, %104 ], [ %len, %15 ]
  %.0 = phi i8* [ %107, %104 ], [ %data, %15 ]
  br label %111

; <label>:111                                     ; preds = %129, %110
  %.12 = phi i64 [ %.01, %110 ], [ %132, %129 ]
  %.1 = phi i8* [ %.0, %110 ], [ %131, %129 ]
  %112 = icmp uge i64 %.12, 64
  br i1 %112, label %113, label %133

; <label>:113                                     ; preds = %111
  %114 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %115 = getelementptr inbounds [64 x i8]* %114, i32 0, i32 0
  %116 = call i64 @llvm.objectsize.i64(i8* %115, i1 false)
  %117 = icmp ne i64 %116, -1
  br i1 %117, label %118, label %125

; <label>:118                                     ; preds = %113
  %119 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %120 = getelementptr inbounds [64 x i8]* %119, i32 0, i32 0
  %121 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %122 = getelementptr inbounds [64 x i8]* %121, i32 0, i32 0
  %123 = call i64 @llvm.objectsize.i64(i8* %122, i1 false)
  %124 = call i8* @__memcpy_chk(i8* %120, i8* %.1, i64 64, i64 %123)
  br label %129

; <label>:125                                     ; preds = %113
  %126 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %127 = getelementptr inbounds [64 x i8]* %126, i32 0, i32 0
  %128 = call i8* @__inline_memcpy_chk(i8* %127, i8* %.1, i64 64)
  br label %129

; <label>:129                                     ; preds = %125, %118
  %130 = phi i8* [ %124, %118 ], [ %128, %125 ]
  call void @SHA1_transform(%struct.SHA1Context* %ctx)
  %131 = getelementptr inbounds i8* %.1, i64 64
  %132 = sub i64 %.12, 64
  br label %111

; <label>:133                                     ; preds = %111
  %134 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %135 = getelementptr inbounds [64 x i8]* %134, i32 0, i32 0
  %136 = call i64 @llvm.objectsize.i64(i8* %135, i1 false)
  %137 = icmp ne i64 %136, -1
  br i1 %137, label %138, label %145

; <label>:138                                     ; preds = %133
  %139 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %140 = getelementptr inbounds [64 x i8]* %139, i32 0, i32 0
  %141 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %142 = getelementptr inbounds [64 x i8]* %141, i32 0, i32 0
  %143 = call i64 @llvm.objectsize.i64(i8* %142, i1 false)
  %144 = call i8* @__memcpy_chk(i8* %140, i8* %.1, i64 %.12, i64 %143)
  br label %149

; <label>:145                                     ; preds = %133
  %146 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %147 = getelementptr inbounds [64 x i8]* %146, i32 0, i32 0
  %148 = call i8* @__inline_memcpy_chk(i8* %147, i8* %.1, i64 %.12)
  br label %149

; <label>:149                                     ; preds = %145, %138
  %150 = phi i8* [ %144, %138 ], [ %148, %145 ]
  %151 = trunc i64 %.12 to i32
  %152 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  store i32 %151, i32* %152, align 4
  br label %153

; <label>:153                                     ; preds = %149, %63
  ret void
}

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

declare i8* @__memcpy_chk(i8*, i8*, i64, i64) nounwind

define internal i8* @__inline_memcpy_chk(i8* %__dest, i8* %__src, i64 %__len) nounwind inlinehint ssp {
  %1 = call i64 @llvm.objectsize.i64(i8* %__dest, i1 false)
  %2 = call i8* @__memcpy_chk(i8* %__dest, i8* %__src, i64 %__len, i64 %1)
  ret i8* %2
}

define internal void @SHA1_transform(%struct.SHA1Context* %ctx) nounwind ssp {
; <label>:0
  %data = alloca [80 x i32], align 16
  %1 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %2 = getelementptr inbounds [64 x i8]* %1, i32 0, i32 0
  %3 = getelementptr inbounds [80 x i32]* %data, i32 0, i32 0
  %4 = bitcast i32* %3 to i8*
  call void @SHA1_copy_and_swap(i8* %2, i8* %4, i32 16)
  br label %5

; <label>:5                                       ; preds = %32, %0
  %i.0 = phi i32 [ 16, %0 ], [ %33, %32 ]
  %6 = icmp slt i32 %i.0, 80
  br i1 %6, label %7, label %34

; <label>:7                                       ; preds = %5
  %8 = sub nsw i32 %i.0, 3
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %9
  %11 = load i32* %10
  %12 = sub nsw i32 %i.0, 8
  %13 = sext i32 %12 to i64
  %14 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %13
  %15 = load i32* %14
  %16 = xor i32 %11, %15
  %17 = sub nsw i32 %i.0, 14
  %18 = sext i32 %17 to i64
  %19 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %18
  %20 = load i32* %19
  %21 = xor i32 %16, %20
  %22 = sub nsw i32 %i.0, 16
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %23
  %25 = load i32* %24
  %26 = xor i32 %21, %25
  %27 = shl i32 %26, 1
  %28 = lshr i32 %26, 31
  %29 = or i32 %27, %28
  %30 = sext i32 %i.0 to i64
  %31 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %30
  store i32 %29, i32* %31
  br label %32

; <label>:32                                      ; preds = %7
  %33 = add nsw i32 %i.0, 1
  br label %5

; <label>:34                                      ; preds = %5
  %35 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %36 = getelementptr inbounds [5 x i32]* %35, i32 0, i64 0
  %37 = load i32* %36
  %38 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %39 = getelementptr inbounds [5 x i32]* %38, i32 0, i64 1
  %40 = load i32* %39
  %41 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %42 = getelementptr inbounds [5 x i32]* %41, i32 0, i64 2
  %43 = load i32* %42
  %44 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %45 = getelementptr inbounds [5 x i32]* %44, i32 0, i64 3
  %46 = load i32* %45
  %47 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %48 = getelementptr inbounds [5 x i32]* %47, i32 0, i64 4
  %49 = load i32* %48
  br label %50

; <label>:50                                      ; preds = %69, %34
  %e.0 = phi i32 [ %49, %34 ], [ %d.0, %69 ]
  %d.0 = phi i32 [ %46, %34 ], [ %c.0, %69 ]
  %c.0 = phi i32 [ %43, %34 ], [ %68, %69 ]
  %b.0 = phi i32 [ %40, %34 ], [ %a.0, %69 ]
  %a.0 = phi i32 [ %37, %34 ], [ %65, %69 ]
  %i.1 = phi i32 [ 0, %34 ], [ %70, %69 ]
  %51 = icmp slt i32 %i.1, 20
  br i1 %51, label %52, label %71

; <label>:52                                      ; preds = %50
  %53 = xor i32 %c.0, %d.0
  %54 = and i32 %b.0, %53
  %55 = xor i32 %d.0, %54
  %56 = add i32 %55, 1518500249
  %57 = shl i32 %a.0, 5
  %58 = lshr i32 %a.0, 27
  %59 = or i32 %57, %58
  %60 = add i32 %56, %59
  %61 = add i32 %60, %e.0
  %62 = sext i32 %i.1 to i64
  %63 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %62
  %64 = load i32* %63
  %65 = add i32 %61, %64
  %66 = shl i32 %b.0, 30
  %67 = lshr i32 %b.0, 2
  %68 = or i32 %66, %67
  br label %69

; <label>:69                                      ; preds = %52
  %70 = add nsw i32 %i.1, 1
  br label %50

; <label>:71                                      ; preds = %50
  br label %72

; <label>:72                                      ; preds = %90, %71
  %e.1 = phi i32 [ %e.0, %71 ], [ %d.1, %90 ]
  %d.1 = phi i32 [ %d.0, %71 ], [ %c.1, %90 ]
  %c.1 = phi i32 [ %c.0, %71 ], [ %89, %90 ]
  %b.1 = phi i32 [ %b.0, %71 ], [ %a.1, %90 ]
  %a.1 = phi i32 [ %a.0, %71 ], [ %86, %90 ]
  %i.2 = phi i32 [ %i.1, %71 ], [ %91, %90 ]
  %73 = icmp slt i32 %i.2, 40
  br i1 %73, label %74, label %92

; <label>:74                                      ; preds = %72
  %75 = xor i32 %b.1, %c.1
  %76 = xor i32 %75, %d.1
  %77 = add i32 %76, 1859775393
  %78 = shl i32 %a.1, 5
  %79 = lshr i32 %a.1, 27
  %80 = or i32 %78, %79
  %81 = add i32 %77, %80
  %82 = add i32 %81, %e.1
  %83 = sext i32 %i.2 to i64
  %84 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %83
  %85 = load i32* %84
  %86 = add i32 %82, %85
  %87 = shl i32 %b.1, 30
  %88 = lshr i32 %b.1, 2
  %89 = or i32 %87, %88
  br label %90

; <label>:90                                      ; preds = %74
  %91 = add nsw i32 %i.2, 1
  br label %72

; <label>:92                                      ; preds = %72
  br label %93

; <label>:93                                      ; preds = %113, %92
  %e.2 = phi i32 [ %e.1, %92 ], [ %d.2, %113 ]
  %d.2 = phi i32 [ %d.1, %92 ], [ %c.2, %113 ]
  %c.2 = phi i32 [ %c.1, %92 ], [ %112, %113 ]
  %b.2 = phi i32 [ %b.1, %92 ], [ %a.2, %113 ]
  %a.2 = phi i32 [ %a.1, %92 ], [ %109, %113 ]
  %i.3 = phi i32 [ %i.2, %92 ], [ %114, %113 ]
  %94 = icmp slt i32 %i.3, 60
  br i1 %94, label %95, label %115

; <label>:95                                      ; preds = %93
  %96 = and i32 %b.2, %c.2
  %97 = or i32 %b.2, %c.2
  %98 = and i32 %d.2, %97
  %99 = or i32 %96, %98
  %100 = add i32 %99, -1894007588
  %101 = shl i32 %a.2, 5
  %102 = lshr i32 %a.2, 27
  %103 = or i32 %101, %102
  %104 = add i32 %100, %103
  %105 = add i32 %104, %e.2
  %106 = sext i32 %i.3 to i64
  %107 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %106
  %108 = load i32* %107
  %109 = add i32 %105, %108
  %110 = shl i32 %b.2, 30
  %111 = lshr i32 %b.2, 2
  %112 = or i32 %110, %111
  br label %113

; <label>:113                                     ; preds = %95
  %114 = add nsw i32 %i.3, 1
  br label %93

; <label>:115                                     ; preds = %93
  br label %116

; <label>:116                                     ; preds = %134, %115
  %e.3 = phi i32 [ %e.2, %115 ], [ %d.3, %134 ]
  %d.3 = phi i32 [ %d.2, %115 ], [ %c.3, %134 ]
  %c.3 = phi i32 [ %c.2, %115 ], [ %133, %134 ]
  %b.3 = phi i32 [ %b.2, %115 ], [ %a.3, %134 ]
  %a.3 = phi i32 [ %a.2, %115 ], [ %130, %134 ]
  %i.4 = phi i32 [ %i.3, %115 ], [ %135, %134 ]
  %117 = icmp slt i32 %i.4, 80
  br i1 %117, label %118, label %136

; <label>:118                                     ; preds = %116
  %119 = xor i32 %b.3, %c.3
  %120 = xor i32 %119, %d.3
  %121 = add i32 %120, -899497514
  %122 = shl i32 %a.3, 5
  %123 = lshr i32 %a.3, 27
  %124 = or i32 %122, %123
  %125 = add i32 %121, %124
  %126 = add i32 %125, %e.3
  %127 = sext i32 %i.4 to i64
  %128 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %127
  %129 = load i32* %128
  %130 = add i32 %126, %129
  %131 = shl i32 %b.3, 30
  %132 = lshr i32 %b.3, 2
  %133 = or i32 %131, %132
  br label %134

; <label>:134                                     ; preds = %118
  %135 = add nsw i32 %i.4, 1
  br label %116

; <label>:136                                     ; preds = %116
  %137 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %138 = getelementptr inbounds [5 x i32]* %137, i32 0, i64 0
  %139 = load i32* %138
  %140 = add i32 %139, %a.3
  store i32 %140, i32* %138
  %141 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %142 = getelementptr inbounds [5 x i32]* %141, i32 0, i64 1
  %143 = load i32* %142
  %144 = add i32 %143, %b.3
  store i32 %144, i32* %142
  %145 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %146 = getelementptr inbounds [5 x i32]* %145, i32 0, i64 2
  %147 = load i32* %146
  %148 = add i32 %147, %c.3
  store i32 %148, i32* %146
  %149 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %150 = getelementptr inbounds [5 x i32]* %149, i32 0, i64 3
  %151 = load i32* %150
  %152 = add i32 %151, %d.3
  store i32 %152, i32* %150
  %153 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %154 = getelementptr inbounds [5 x i32]* %153, i32 0, i64 4
  %155 = load i32* %154
  %156 = add i32 %155, %e.3
  store i32 %156, i32* %154
  ret void
}

define void @SHA1_finish(%struct.SHA1Context* %ctx, i8* %output) nounwind ssp {
; <label>:0
  %1 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %2 = load i32* %1, align 4
  %3 = add nsw i32 %2, 1
  %4 = sext i32 %2 to i64
  %5 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %6 = getelementptr inbounds [64 x i8]* %5, i32 0, i64 %4
  store i8 -128, i8* %6
  %7 = icmp sgt i32 %3, 56
  br i1 %7, label %8, label %38

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %10 = getelementptr inbounds [64 x i8]* %9, i32 0, i32 0
  %11 = sext i32 %3 to i64
  %12 = getelementptr inbounds i8* %10, i64 %11
  %13 = call i64 @llvm.objectsize.i64(i8* %12, i1 false)
  %14 = icmp ne i64 %13, -1
  br i1 %14, label %15, label %28

; <label>:15                                      ; preds = %8
  %16 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %17 = getelementptr inbounds [64 x i8]* %16, i32 0, i32 0
  %18 = sext i32 %3 to i64
  %19 = getelementptr inbounds i8* %17, i64 %18
  %20 = sub nsw i32 64, %3
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %23 = getelementptr inbounds [64 x i8]* %22, i32 0, i32 0
  %24 = sext i32 %3 to i64
  %25 = getelementptr inbounds i8* %23, i64 %24
  %26 = call i64 @llvm.objectsize.i64(i8* %25, i1 false)
  %27 = call i8* @__memset_chk(i8* %19, i32 0, i64 %21, i64 %26)
  br label %36

; <label>:28                                      ; preds = %8
  %29 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %30 = getelementptr inbounds [64 x i8]* %29, i32 0, i32 0
  %31 = sext i32 %3 to i64
  %32 = getelementptr inbounds i8* %30, i64 %31
  %33 = sub nsw i32 64, %3
  %34 = sext i32 %33 to i64
  %35 = call i8* @__inline_memset_chk(i8* %32, i32 0, i64 %34)
  br label %36

; <label>:36                                      ; preds = %28, %15
  %37 = phi i8* [ %27, %15 ], [ %35, %28 ]
  call void @SHA1_transform(%struct.SHA1Context* %ctx)
  br label %38

; <label>:38                                      ; preds = %36, %0
  %i.0 = phi i32 [ 0, %36 ], [ %3, %0 ]
  %39 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %40 = getelementptr inbounds [64 x i8]* %39, i32 0, i32 0
  %41 = sext i32 %i.0 to i64
  %42 = getelementptr inbounds i8* %40, i64 %41
  %43 = call i64 @llvm.objectsize.i64(i8* %42, i1 false)
  %44 = icmp ne i64 %43, -1
  br i1 %44, label %45, label %58

; <label>:45                                      ; preds = %38
  %46 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %47 = getelementptr inbounds [64 x i8]* %46, i32 0, i32 0
  %48 = sext i32 %i.0 to i64
  %49 = getelementptr inbounds i8* %47, i64 %48
  %50 = sub nsw i32 56, %i.0
  %51 = sext i32 %50 to i64
  %52 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %53 = getelementptr inbounds [64 x i8]* %52, i32 0, i32 0
  %54 = sext i32 %i.0 to i64
  %55 = getelementptr inbounds i8* %53, i64 %54
  %56 = call i64 @llvm.objectsize.i64(i8* %55, i1 false)
  %57 = call i8* @__memset_chk(i8* %49, i32 0, i64 %51, i64 %56)
  br label %66

; <label>:58                                      ; preds = %38
  %59 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %60 = getelementptr inbounds [64 x i8]* %59, i32 0, i32 0
  %61 = sext i32 %i.0 to i64
  %62 = getelementptr inbounds i8* %60, i64 %61
  %63 = sub nsw i32 56, %i.0
  %64 = sext i32 %63 to i64
  %65 = call i8* @__inline_memset_chk(i8* %62, i32 0, i64 %64)
  br label %66

; <label>:66                                      ; preds = %58, %45
  %67 = phi i8* [ %57, %45 ], [ %65, %58 ]
  %68 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %69 = getelementptr inbounds [2 x i32]* %68, i32 0, i32 0
  %70 = bitcast i32* %69 to i8*
  %71 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %72 = getelementptr inbounds [64 x i8]* %71, i32 0, i32 0
  %73 = getelementptr inbounds i8* %72, i64 56
  call void @SHA1_copy_and_swap(i8* %70, i8* %73, i32 2)
  call void @SHA1_transform(%struct.SHA1Context* %ctx)
  %74 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %75 = getelementptr inbounds [5 x i32]* %74, i32 0, i32 0
  %76 = bitcast i32* %75 to i8*
  call void @SHA1_copy_and_swap(i8* %76, i8* %output, i32 5)
  ret void
}

declare i8* @__memset_chk(i8*, i32, i64, i64) nounwind

define internal i8* @__inline_memset_chk(i8* %__dest, i32 %__val, i64 %__len) nounwind inlinehint ssp {
  %1 = call i64 @llvm.objectsize.i64(i8* %__dest, i1 false)
  %2 = call i8* @__memset_chk(i8* %__dest, i32 %__val, i64 %__len, i64 %1)
  ret i8* %2
}

define internal void @SHA1_copy_and_swap(i8* %src, i8* %dst, i32 %numwords) nounwind ssp {
  %1 = load i32* @arch_big_endian, align 4
  %2 = icmp ne i32 %1, 0
  br i1 %2, label %3, label %17

; <label>:3                                       ; preds = %0
  %4 = call i64 @llvm.objectsize.i64(i8* %dst, i1 false)
  %5 = icmp ne i64 %4, -1
  br i1 %5, label %6, label %11

; <label>:6                                       ; preds = %3
  %7 = sext i32 %numwords to i64
  %8 = mul i64 %7, 4
  %9 = call i64 @llvm.objectsize.i64(i8* %dst, i1 false)
  %10 = call i8* @__memcpy_chk(i8* %dst, i8* %src, i64 %8, i64 %9)
  br label %15

; <label>:11                                      ; preds = %3
  %12 = sext i32 %numwords to i64
  %13 = mul i64 %12, 4
  %14 = call i8* @__inline_memcpy_chk(i8* %dst, i8* %src, i64 %13)
  br label %15

; <label>:15                                      ; preds = %11, %6
  %16 = phi i8* [ %10, %6 ], [ %14, %11 ]
  br label %38

; <label>:17                                      ; preds = %0
  br label %18

; <label>:18                                      ; preds = %33, %17
  %.0 = phi i32 [ %numwords, %17 ], [ %36, %33 ]
  %s.0 = phi i8* [ %src, %17 ], [ %34, %33 ]
  %d.0 = phi i8* [ %dst, %17 ], [ %35, %33 ]
  %19 = icmp sgt i32 %.0, 0
  br i1 %19, label %20, label %37

; <label>:20                                      ; preds = %18
  %21 = getelementptr inbounds i8* %s.0, i64 0
  %22 = load i8* %21
  %23 = getelementptr inbounds i8* %s.0, i64 1
  %24 = load i8* %23
  %25 = getelementptr inbounds i8* %s.0, i64 3
  %26 = load i8* %25
  %27 = getelementptr inbounds i8* %d.0, i64 0
  store i8 %26, i8* %27
  %28 = getelementptr inbounds i8* %s.0, i64 2
  %29 = load i8* %28
  %30 = getelementptr inbounds i8* %d.0, i64 1
  store i8 %29, i8* %30
  %31 = getelementptr inbounds i8* %d.0, i64 2
  store i8 %24, i8* %31
  %32 = getelementptr inbounds i8* %d.0, i64 3
  store i8 %22, i8* %32
  br label %33

; <label>:33                                      ; preds = %20
  %34 = getelementptr inbounds i8* %s.0, i64 4
  %35 = getelementptr inbounds i8* %d.0, i64 4
  %36 = add nsw i32 %.0, -1
  br label %18

; <label>:37                                      ; preds = %18
  br label %38

; <label>:38                                      ; preds = %37, %15
  ret void
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %u = alloca %union.anon, align 4
  %1 = getelementptr inbounds %union.anon* %u, i32 0, i32 0
  store i32 305419896, i32* %1, align 4
  %2 = getelementptr inbounds %union.anon* %u, i32 0, i32 0
  %3 = bitcast i32* %2 to [4 x i8]*
  %4 = getelementptr inbounds [4 x i8]* %3, i32 0, i64 0
  %5 = load i8* %4
  %6 = zext i8 %5 to i32
  switch i32 %6, label %9 [
    i32 18, label %7
    i32 120, label %8
  ]

; <label>:7                                       ; preds = %0
  store i32 1, i32* @arch_big_endian, align 4
  br label %11

; <label>:8                                       ; preds = %0
  store i32 0, i32* @arch_big_endian, align 4
  br label %11

; <label>:9                                       ; preds = %0
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([29 x i8]* @.str, i32 0, i32 0))
  br label %12

; <label>:11                                      ; preds = %8, %7
  call void @do_test(i8* getelementptr inbounds ([4 x i8]* @test_input_1, i32 0, i32 0), i8* getelementptr inbounds ([20 x i8]* @test_output_1, i32 0, i32 0))
  call void @do_test(i8* getelementptr inbounds ([57 x i8]* @test_input_2, i32 0, i32 0), i8* getelementptr inbounds ([20 x i8]* @test_output_2, i32 0, i32 0))
  call void @do_bench(i32 1000000)
  br label %12

; <label>:12                                      ; preds = %11, %9
  %.0 = phi i32 [ 2, %9 ], [ 0, %11 ]
  ret i32 %.0
}

declare i32 @printf(i8*, ...)

define internal void @do_test(i8* %txt, i8* %expected_output) nounwind ssp {
  %ctx = alloca %struct.SHA1Context, align 4
  %output = alloca [20 x i8], align 16
  call void @SHA1_init(%struct.SHA1Context* %ctx)
  %1 = call i64 @strlen(i8* %txt)
  call void @SHA1_add_data(%struct.SHA1Context* %ctx, i8* %txt, i64 %1)
  %2 = getelementptr inbounds [20 x i8]* %output, i32 0, i32 0
  call void @SHA1_finish(%struct.SHA1Context* %ctx, i8* %2)
  %3 = getelementptr inbounds [20 x i8]* %output, i32 0, i32 0
  %4 = call i32 @memcmp(i8* %3, i8* %expected_output, i64 20)
  %5 = icmp eq i32 %4, 0
  %6 = zext i1 %5 to i32
  %7 = icmp ne i32 %6, 0
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %0
  br label %10

; <label>:9                                       ; preds = %0
  br label %10

; <label>:10                                      ; preds = %9, %8
  %11 = phi i8* [ getelementptr inbounds ([7 x i8]* @.str2, i32 0, i32 0), %8 ], [ getelementptr inbounds ([7 x i8]* @.str3, i32 0, i32 0), %9 ]
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str1, i32 0, i32 0), i8* %txt, i8* %11)
  ret void
}

define internal void @do_bench(i32 %nblocks) nounwind ssp {
; <label>:0
  %ctx = alloca %struct.SHA1Context, align 4
  %output = alloca [20 x i8], align 16
  %data = alloca [64 x i8], align 16
  call void @SHA1_init(%struct.SHA1Context* %ctx)
  br label %1

; <label>:1                                       ; preds = %5, %0
  %.0 = phi i32 [ %nblocks, %0 ], [ %6, %5 ]
  %2 = icmp sgt i32 %.0, 0
  br i1 %2, label %3, label %7

; <label>:3                                       ; preds = %1
  %4 = getelementptr inbounds [64 x i8]* %data, i32 0, i32 0
  call void @SHA1_add_data(%struct.SHA1Context* %ctx, i8* %4, i64 64)
  br label %5

; <label>:5                                       ; preds = %3
  %6 = add nsw i32 %.0, -1
  br label %1

; <label>:7                                       ; preds = %1
  %8 = getelementptr inbounds [20 x i8]* %output, i32 0, i32 0
  call void @SHA1_finish(%struct.SHA1Context* %ctx, i8* %8)
  ret void
}

declare i64 @strlen(i8*)

declare i32 @memcmp(i8*, i8*, i64)
