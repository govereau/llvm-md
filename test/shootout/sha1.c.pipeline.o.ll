; ModuleID = 'sha1.c.pipeline.o'
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
  %3 = getelementptr inbounds [5 x i32]* %1, i32 0, i64 1
  store i32 -271733879, i32* %3
  %4 = getelementptr inbounds [5 x i32]* %1, i32 0, i64 2
  store i32 -1732584194, i32* %4
  %5 = getelementptr inbounds [5 x i32]* %1, i32 0, i64 3
  store i32 271733878, i32* %5
  %6 = getelementptr inbounds [5 x i32]* %1, i32 0, i64 4
  store i32 -1009589776, i32* %6
  %7 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  store i32 0, i32* %7, align 4
  %8 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %9 = getelementptr inbounds [2 x i32]* %8, i32 0, i64 0
  store i32 0, i32* %9
  %10 = getelementptr inbounds [2 x i32]* %8, i32 0, i64 1
  store i32 0, i32* %10
  ret void
}

define void @SHA1_add_data(%struct.SHA1Context* %ctx, i8* %data, i64 %len) nounwind ssp {
  %1 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %2 = getelementptr inbounds [2 x i32]* %1, i32 0, i64 1
  %3 = load i32* %2
  %4 = shl i64 %len, 3
  %5 = trunc i64 %4 to i32
  %6 = add i32 %3, %5
  store i32 %6, i32* %2
  %7 = icmp ult i32 %6, %3
  br i1 %7, label %8, label %._crit_edge

._crit_edge:                                      ; preds = %0
  %.phi.trans.insert = getelementptr inbounds [2 x i32]* %1, i32 0, i64 0
  %.pre = load i32* %.phi.trans.insert
  br label %12

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds [2 x i32]* %1, i32 0, i64 0
  %10 = load i32* %9
  %11 = add i32 %10, 1
  store i32 %11, i32* %9
  br label %12

; <label>:12                                      ; preds = %8, %._crit_edge
  %13 = phi i32 [ %.pre, %._crit_edge ], [ %11, %8 ]
  %14 = lshr i64 %len, 29
  %15 = trunc i64 %14 to i32
  %16 = getelementptr inbounds [2 x i32]* %1, i32 0, i64 0
  %17 = add i32 %13, %15
  store i32 %17, i32* %16
  %18 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 2
  %19 = load i32* %18, align 4
  %20 = icmp ne i32 %19, 0
  br i1 %20, label %21, label %55

; <label>:21                                      ; preds = %12
  %22 = sub nsw i32 64, %19
  %23 = zext i32 %22 to i64
  %24 = icmp ult i64 %len, %23
  br i1 %24, label %25, label %41

; <label>:25                                      ; preds = %21
  %26 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %27 = getelementptr inbounds [64 x i8]* %26, i32 0, i32 0
  %28 = sext i32 %19 to i64
  %29 = getelementptr inbounds i8* %27, i64 %28
  %30 = call i64 @llvm.objectsize.i64(i8* %29, i1 false)
  %31 = icmp ne i64 %30, -1
  br i1 %31, label %32, label %34

; <label>:32                                      ; preds = %25
  %33 = call i8* @__memcpy_chk(i8* %29, i8* %data, i64 %len, i64 %30)
  br label %36

; <label>:34                                      ; preds = %25
  %35 = call i8* @__inline_memcpy_chk(i8* %29, i8* %data, i64 %len)
  br label %36

; <label>:36                                      ; preds = %34, %32
  %37 = load i32* %18, align 4
  %38 = sext i32 %37 to i64
  %39 = add i64 %38, %len
  %40 = trunc i64 %39 to i32
  store i32 %40, i32* %18, align 4
  br label %81

; <label>:41                                      ; preds = %21
  %42 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %43 = getelementptr inbounds [64 x i8]* %42, i32 0, i32 0
  %44 = sext i32 %19 to i64
  %45 = getelementptr inbounds i8* %43, i64 %44
  %46 = call i64 @llvm.objectsize.i64(i8* %45, i1 false)
  %47 = icmp ne i64 %46, -1
  br i1 %47, label %48, label %50

; <label>:48                                      ; preds = %41
  %49 = call i8* @__memcpy_chk(i8* %45, i8* %data, i64 %23, i64 %46)
  br label %52

; <label>:50                                      ; preds = %41
  %51 = call i8* @__inline_memcpy_chk(i8* %45, i8* %data, i64 %23)
  br label %52

; <label>:52                                      ; preds = %50, %48
  call void @SHA1_transform(%struct.SHA1Context* %ctx)
  %53 = getelementptr inbounds i8* %data, i64 %23
  %54 = sub i64 %len, %23
  br label %55

; <label>:55                                      ; preds = %52, %12
  %.01 = phi i64 [ %54, %52 ], [ %len, %12 ]
  %.0 = phi i8* [ %53, %52 ], [ %data, %12 ]
  %56 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %57 = getelementptr inbounds [64 x i8]* %56, i32 0, i32 0
  br label %58

; <label>:58                                      ; preds = %67, %55
  %.12 = phi i64 [ %.01, %55 ], [ %69, %67 ]
  %.1 = phi i8* [ %.0, %55 ], [ %68, %67 ]
  %59 = icmp uge i64 %.12, 64
  br i1 %59, label %60, label %70

; <label>:60                                      ; preds = %58
  %61 = call i64 @llvm.objectsize.i64(i8* %57, i1 false)
  %62 = icmp ne i64 %61, -1
  br i1 %62, label %63, label %65

; <label>:63                                      ; preds = %60
  %64 = call i8* @__memcpy_chk(i8* %57, i8* %.1, i64 64, i64 %61)
  br label %67

; <label>:65                                      ; preds = %60
  %66 = call i8* @__inline_memcpy_chk(i8* %57, i8* %.1, i64 64)
  br label %67

; <label>:67                                      ; preds = %65, %63
  call void @SHA1_transform(%struct.SHA1Context* %ctx)
  %68 = getelementptr inbounds i8* %.1, i64 64
  %69 = sub i64 %.12, 64
  br label %58

; <label>:70                                      ; preds = %58
  %.1.lcssa = phi i8* [ %.1, %58 ]
  %.12.lcssa = phi i64 [ %.12, %58 ]
  %71 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 3
  %72 = getelementptr inbounds [64 x i8]* %71, i32 0, i32 0
  %73 = call i64 @llvm.objectsize.i64(i8* %72, i1 false)
  %74 = icmp ne i64 %73, -1
  br i1 %74, label %75, label %77

; <label>:75                                      ; preds = %70
  %76 = call i8* @__memcpy_chk(i8* %72, i8* %.1.lcssa, i64 %.12.lcssa, i64 %73)
  br label %79

; <label>:77                                      ; preds = %70
  %78 = call i8* @__inline_memcpy_chk(i8* %72, i8* %.1.lcssa, i64 %.12.lcssa)
  br label %79

; <label>:79                                      ; preds = %77, %75
  %80 = trunc i64 %.12.lcssa to i32
  store i32 %80, i32* %18, align 4
  br label %81

; <label>:81                                      ; preds = %79, %36
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

; <label>:5                                       ; preds = %7, %0
  %i.0 = phi i32 [ 16, %0 ], [ %32, %7 ]
  %6 = icmp slt i32 %i.0, 80
  br i1 %6, label %7, label %33

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
  %32 = add nsw i32 %i.0, 1
  br label %5

; <label>:33                                      ; preds = %5
  %34 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %35 = getelementptr inbounds [5 x i32]* %34, i32 0, i64 0
  %36 = load i32* %35
  %37 = getelementptr inbounds [5 x i32]* %34, i32 0, i64 1
  %38 = load i32* %37
  %39 = getelementptr inbounds [5 x i32]* %34, i32 0, i64 2
  %40 = load i32* %39
  %41 = getelementptr inbounds [5 x i32]* %34, i32 0, i64 3
  %42 = load i32* %41
  %43 = getelementptr inbounds [5 x i32]* %34, i32 0, i64 4
  %44 = load i32* %43
  br label %45

; <label>:45                                      ; preds = %47, %33
  %e.0 = phi i32 [ %44, %33 ], [ %d.0, %47 ]
  %d.0 = phi i32 [ %42, %33 ], [ %c.0, %47 ]
  %c.0 = phi i32 [ %40, %33 ], [ %63, %47 ]
  %b.0 = phi i32 [ %38, %33 ], [ %a.0, %47 ]
  %a.0 = phi i32 [ %36, %33 ], [ %60, %47 ]
  %i.1 = phi i32 [ 0, %33 ], [ %64, %47 ]
  %46 = icmp slt i32 %i.1, 20
  br i1 %46, label %47, label %65

; <label>:47                                      ; preds = %45
  %48 = xor i32 %c.0, %d.0
  %49 = and i32 %b.0, %48
  %50 = xor i32 %d.0, %49
  %51 = add i32 %50, 1518500249
  %52 = shl i32 %a.0, 5
  %53 = lshr i32 %a.0, 27
  %54 = or i32 %52, %53
  %55 = add i32 %51, %54
  %56 = add i32 %55, %e.0
  %57 = sext i32 %i.1 to i64
  %58 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %57
  %59 = load i32* %58
  %60 = add i32 %56, %59
  %61 = shl i32 %b.0, 30
  %62 = lshr i32 %b.0, 2
  %63 = or i32 %61, %62
  %64 = add nsw i32 %i.1, 1
  br label %45

; <label>:65                                      ; preds = %45
  %i.1.lcssa = phi i32 [ %i.1, %45 ]
  %a.0.lcssa = phi i32 [ %a.0, %45 ]
  %b.0.lcssa = phi i32 [ %b.0, %45 ]
  %c.0.lcssa = phi i32 [ %c.0, %45 ]
  %d.0.lcssa = phi i32 [ %d.0, %45 ]
  %e.0.lcssa = phi i32 [ %e.0, %45 ]
  br label %66

; <label>:66                                      ; preds = %68, %65
  %e.1 = phi i32 [ %e.0.lcssa, %65 ], [ %d.1, %68 ]
  %d.1 = phi i32 [ %d.0.lcssa, %65 ], [ %c.1, %68 ]
  %c.1 = phi i32 [ %c.0.lcssa, %65 ], [ %83, %68 ]
  %b.1 = phi i32 [ %b.0.lcssa, %65 ], [ %a.1, %68 ]
  %a.1 = phi i32 [ %a.0.lcssa, %65 ], [ %80, %68 ]
  %i.2 = phi i32 [ %i.1.lcssa, %65 ], [ %84, %68 ]
  %67 = icmp slt i32 %i.2, 40
  br i1 %67, label %68, label %85

; <label>:68                                      ; preds = %66
  %69 = xor i32 %b.1, %c.1
  %70 = xor i32 %69, %d.1
  %71 = add i32 %70, 1859775393
  %72 = shl i32 %a.1, 5
  %73 = lshr i32 %a.1, 27
  %74 = or i32 %72, %73
  %75 = add i32 %71, %74
  %76 = add i32 %75, %e.1
  %77 = sext i32 %i.2 to i64
  %78 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %77
  %79 = load i32* %78
  %80 = add i32 %76, %79
  %81 = shl i32 %b.1, 30
  %82 = lshr i32 %b.1, 2
  %83 = or i32 %81, %82
  %84 = add nsw i32 %i.2, 1
  br label %66

; <label>:85                                      ; preds = %66
  %i.2.lcssa = phi i32 [ %i.2, %66 ]
  %a.1.lcssa = phi i32 [ %a.1, %66 ]
  %b.1.lcssa = phi i32 [ %b.1, %66 ]
  %c.1.lcssa = phi i32 [ %c.1, %66 ]
  %d.1.lcssa = phi i32 [ %d.1, %66 ]
  %e.1.lcssa = phi i32 [ %e.1, %66 ]
  br label %86

; <label>:86                                      ; preds = %88, %85
  %e.2 = phi i32 [ %e.1.lcssa, %85 ], [ %d.2, %88 ]
  %d.2 = phi i32 [ %d.1.lcssa, %85 ], [ %c.2, %88 ]
  %c.2 = phi i32 [ %c.1.lcssa, %85 ], [ %105, %88 ]
  %b.2 = phi i32 [ %b.1.lcssa, %85 ], [ %a.2, %88 ]
  %a.2 = phi i32 [ %a.1.lcssa, %85 ], [ %102, %88 ]
  %i.3 = phi i32 [ %i.2.lcssa, %85 ], [ %106, %88 ]
  %87 = icmp slt i32 %i.3, 60
  br i1 %87, label %88, label %107

; <label>:88                                      ; preds = %86
  %89 = and i32 %b.2, %c.2
  %90 = or i32 %b.2, %c.2
  %91 = and i32 %d.2, %90
  %92 = or i32 %89, %91
  %93 = add i32 %92, -1894007588
  %94 = shl i32 %a.2, 5
  %95 = lshr i32 %a.2, 27
  %96 = or i32 %94, %95
  %97 = add i32 %93, %96
  %98 = add i32 %97, %e.2
  %99 = sext i32 %i.3 to i64
  %100 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %99
  %101 = load i32* %100
  %102 = add i32 %98, %101
  %103 = shl i32 %b.2, 30
  %104 = lshr i32 %b.2, 2
  %105 = or i32 %103, %104
  %106 = add nsw i32 %i.3, 1
  br label %86

; <label>:107                                     ; preds = %86
  %i.3.lcssa = phi i32 [ %i.3, %86 ]
  %a.2.lcssa = phi i32 [ %a.2, %86 ]
  %b.2.lcssa = phi i32 [ %b.2, %86 ]
  %c.2.lcssa = phi i32 [ %c.2, %86 ]
  %d.2.lcssa = phi i32 [ %d.2, %86 ]
  %e.2.lcssa = phi i32 [ %e.2, %86 ]
  br label %108

; <label>:108                                     ; preds = %110, %107
  %e.3 = phi i32 [ %e.2.lcssa, %107 ], [ %d.3, %110 ]
  %d.3 = phi i32 [ %d.2.lcssa, %107 ], [ %c.3, %110 ]
  %c.3 = phi i32 [ %c.2.lcssa, %107 ], [ %125, %110 ]
  %b.3 = phi i32 [ %b.2.lcssa, %107 ], [ %a.3, %110 ]
  %a.3 = phi i32 [ %a.2.lcssa, %107 ], [ %122, %110 ]
  %i.4 = phi i32 [ %i.3.lcssa, %107 ], [ %126, %110 ]
  %109 = icmp slt i32 %i.4, 80
  br i1 %109, label %110, label %127

; <label>:110                                     ; preds = %108
  %111 = xor i32 %b.3, %c.3
  %112 = xor i32 %111, %d.3
  %113 = add i32 %112, -899497514
  %114 = shl i32 %a.3, 5
  %115 = lshr i32 %a.3, 27
  %116 = or i32 %114, %115
  %117 = add i32 %113, %116
  %118 = add i32 %117, %e.3
  %119 = sext i32 %i.4 to i64
  %120 = getelementptr inbounds [80 x i32]* %data, i32 0, i64 %119
  %121 = load i32* %120
  %122 = add i32 %118, %121
  %123 = shl i32 %b.3, 30
  %124 = lshr i32 %b.3, 2
  %125 = or i32 %123, %124
  %126 = add nsw i32 %i.4, 1
  br label %108

; <label>:127                                     ; preds = %108
  %a.3.lcssa = phi i32 [ %a.3, %108 ]
  %b.3.lcssa = phi i32 [ %b.3, %108 ]
  %c.3.lcssa = phi i32 [ %c.3, %108 ]
  %d.3.lcssa = phi i32 [ %d.3, %108 ]
  %e.3.lcssa = phi i32 [ %e.3, %108 ]
  %128 = add i32 %36, %a.3.lcssa
  store i32 %128, i32* %35
  %129 = add i32 %38, %b.3.lcssa
  store i32 %129, i32* %37
  %130 = add i32 %40, %c.3.lcssa
  store i32 %130, i32* %39
  %131 = add i32 %42, %d.3.lcssa
  store i32 %131, i32* %41
  %132 = add i32 %44, %e.3.lcssa
  store i32 %132, i32* %43
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
  br i1 %7, label %8, label %23

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds [64 x i8]* %5, i32 0, i32 0
  %10 = sext i32 %3 to i64
  %11 = getelementptr inbounds i8* %9, i64 %10
  %12 = call i64 @llvm.objectsize.i64(i8* %11, i1 false)
  %13 = icmp ne i64 %12, -1
  br i1 %13, label %14, label %18

; <label>:14                                      ; preds = %8
  %15 = sub nsw i32 64, %3
  %16 = sext i32 %15 to i64
  %17 = call i8* @__memset_chk(i8* %11, i32 0, i64 %16, i64 %12)
  br label %22

; <label>:18                                      ; preds = %8
  %19 = sub nsw i32 64, %3
  %20 = sext i32 %19 to i64
  %21 = call i8* @__inline_memset_chk(i8* %11, i32 0, i64 %20)
  br label %22

; <label>:22                                      ; preds = %18, %14
  call void @SHA1_transform(%struct.SHA1Context* %ctx)
  br label %23

; <label>:23                                      ; preds = %22, %0
  %i.0 = phi i32 [ 0, %22 ], [ %3, %0 ]
  %24 = getelementptr inbounds [64 x i8]* %5, i32 0, i32 0
  %25 = sext i32 %i.0 to i64
  %26 = getelementptr inbounds i8* %24, i64 %25
  %27 = call i64 @llvm.objectsize.i64(i8* %26, i1 false)
  %28 = icmp ne i64 %27, -1
  br i1 %28, label %29, label %33

; <label>:29                                      ; preds = %23
  %30 = sub nsw i32 56, %i.0
  %31 = sext i32 %30 to i64
  %32 = call i8* @__memset_chk(i8* %26, i32 0, i64 %31, i64 %27)
  br label %37

; <label>:33                                      ; preds = %23
  %34 = sub nsw i32 56, %i.0
  %35 = sext i32 %34 to i64
  %36 = call i8* @__inline_memset_chk(i8* %26, i32 0, i64 %35)
  br label %37

; <label>:37                                      ; preds = %33, %29
  %38 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 1
  %39 = getelementptr inbounds [2 x i32]* %38, i32 0, i32 0
  %40 = bitcast i32* %39 to i8*
  %41 = getelementptr inbounds i8* %24, i64 56
  call void @SHA1_copy_and_swap(i8* %40, i8* %41, i32 2)
  call void @SHA1_transform(%struct.SHA1Context* %ctx)
  %42 = getelementptr inbounds %struct.SHA1Context* %ctx, i32 0, i32 0
  %43 = getelementptr inbounds [5 x i32]* %42, i32 0, i32 0
  %44 = bitcast i32* %43 to i8*
  call void @SHA1_copy_and_swap(i8* %44, i8* %output, i32 5)
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
  br i1 %2, label %3, label %15

; <label>:3                                       ; preds = %0
  %4 = call i64 @llvm.objectsize.i64(i8* %dst, i1 false)
  %5 = icmp ne i64 %4, -1
  br i1 %5, label %6, label %10

; <label>:6                                       ; preds = %3
  %7 = sext i32 %numwords to i64
  %8 = mul i64 %7, 4
  %9 = call i8* @__memcpy_chk(i8* %dst, i8* %src, i64 %8, i64 %4)
  br label %14

; <label>:10                                      ; preds = %3
  %11 = sext i32 %numwords to i64
  %12 = mul i64 %11, 4
  %13 = call i8* @__inline_memcpy_chk(i8* %dst, i8* %src, i64 %12)
  br label %14

; <label>:14                                      ; preds = %10, %6
  br label %35

; <label>:15                                      ; preds = %0
  br label %16

; <label>:16                                      ; preds = %18, %15
  %.0 = phi i32 [ %numwords, %15 ], [ %33, %18 ]
  %s.0 = phi i8* [ %src, %15 ], [ %31, %18 ]
  %d.0 = phi i8* [ %dst, %15 ], [ %32, %18 ]
  %17 = icmp sgt i32 %.0, 0
  br i1 %17, label %18, label %34

; <label>:18                                      ; preds = %16
  %19 = getelementptr inbounds i8* %s.0, i64 0
  %20 = load i8* %19
  %21 = getelementptr inbounds i8* %s.0, i64 1
  %22 = load i8* %21
  %23 = getelementptr inbounds i8* %s.0, i64 3
  %24 = load i8* %23
  %25 = getelementptr inbounds i8* %d.0, i64 0
  store i8 %24, i8* %25
  %26 = getelementptr inbounds i8* %s.0, i64 2
  %27 = load i8* %26
  %28 = getelementptr inbounds i8* %d.0, i64 1
  store i8 %27, i8* %28
  %29 = getelementptr inbounds i8* %d.0, i64 2
  store i8 %22, i8* %29
  %30 = getelementptr inbounds i8* %d.0, i64 3
  store i8 %20, i8* %30
  %31 = getelementptr inbounds i8* %s.0, i64 4
  %32 = getelementptr inbounds i8* %d.0, i64 4
  %33 = add nsw i32 %.0, -1
  br label %16

; <label>:34                                      ; preds = %16
  br label %35

; <label>:35                                      ; preds = %34, %14
  ret void
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %u = alloca %union.anon, align 4
  %1 = getelementptr inbounds %union.anon* %u, i32 0, i32 0
  store i32 305419896, i32* %1, align 4
  %2 = bitcast i32* %1 to [4 x i8]*
  %3 = getelementptr inbounds [4 x i8]* %2, i32 0, i64 0
  switch i32 120, label %6 [
    i32 18, label %4
    i32 120, label %5
  ]

; <label>:4                                       ; preds = %0
  br label %7

; <label>:5                                       ; preds = %0
  store i32 0, i32* @arch_big_endian, align 4
  br label %7

; <label>:6                                       ; preds = %0
  br label %8

; <label>:7                                       ; preds = %5, %4
  call void @do_test(i8* getelementptr inbounds ([4 x i8]* @test_input_1, i32 0, i32 0), i8* getelementptr inbounds ([20 x i8]* @test_output_1, i32 0, i32 0))
  call void @do_test(i8* getelementptr inbounds ([57 x i8]* @test_input_2, i32 0, i32 0), i8* getelementptr inbounds ([20 x i8]* @test_output_2, i32 0, i32 0))
  call void @do_bench(i32 1000000)
  br label %8

; <label>:8                                       ; preds = %7, %6
  ret i32 0
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
  %3 = call i32 @memcmp(i8* %2, i8* %expected_output, i64 20)
  %4 = icmp eq i32 %3, 0
  %5 = zext i1 %4 to i32
  %6 = icmp ne i32 %5, 0
  br i1 %6, label %7, label %8

; <label>:7                                       ; preds = %0
  br label %9

; <label>:8                                       ; preds = %0
  br label %9

; <label>:9                                       ; preds = %8, %7
  %10 = phi i8* [ getelementptr inbounds ([7 x i8]* @.str2, i32 0, i32 0), %7 ], [ getelementptr inbounds ([7 x i8]* @.str3, i32 0, i32 0), %8 ]
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str1, i32 0, i32 0), i8* %txt, i8* %10)
  ret void
}

define internal void @do_bench(i32 %nblocks) nounwind ssp {
; <label>:0
  %ctx = alloca %struct.SHA1Context, align 4
  %output = alloca [20 x i8], align 16
  %data = alloca [64 x i8], align 16
  call void @SHA1_init(%struct.SHA1Context* %ctx)
  %1 = getelementptr inbounds [64 x i8]* %data, i32 0, i32 0
  br label %2

; <label>:2                                       ; preds = %4, %0
  %.0 = phi i32 [ %nblocks, %0 ], [ %5, %4 ]
  %3 = icmp sgt i32 %.0, 0
  br i1 %3, label %4, label %6

; <label>:4                                       ; preds = %2
  call void @SHA1_add_data(%struct.SHA1Context* %ctx, i8* %1, i64 64)
  %5 = add nsw i32 %.0, -1
  br label %2

; <label>:6                                       ; preds = %2
  %7 = getelementptr inbounds [20 x i8]* %output, i32 0, i32 0
  call void @SHA1_finish(%struct.SHA1Context* %ctx, i8* %7)
  ret void
}

declare i64 @strlen(i8*)

declare i32 @memcmp(i8*, i8*, i64)
