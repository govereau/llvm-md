; ModuleID = 'vmach.c.pipeline.o'
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
; <label>:0
  br label %1

; <label>:1                                       ; preds = %179, %0
  %pc.0 = phi i32* [ %code, %0 ], [ %pc.1, %179 ]
  %sp.1 = phi i64* [ getelementptr inbounds ([256 x i64]* @stack, i64 1, i64 0), %0 ], [ %sp.0, %179 ]
  %extra_args.1 = phi i32 [ 0, %0 ], [ %extra_args.0, %179 ]
  %2 = getelementptr inbounds i32* %pc.0, i32 1
  %3 = load i32* %pc.0
  %4 = and i32 %3, 255
  switch i32 %4, label %179 [
    i32 0, label %5
    i32 1, label %5
    i32 2, label %23
    i32 3, label %23
    i32 4, label %31
    i32 5, label %31
    i32 6, label %46
    i32 7, label %78
    i32 8, label %98
    i32 9, label %106
    i32 10, label %125
    i32 11, label %142
    i32 12, label %157
    i32 13, label %165
    i32 14, label %173
  ]

; <label>:5                                       ; preds = %1, %1
  %6 = lshr i32 %3, 8
  %7 = and i32 %6, 255
  %8 = zext i32 %7 to i64
  %9 = getelementptr inbounds i64* %sp.1, i64 %8
  %10 = load i64* %9
  %11 = and i32 %3, 1
  %12 = zext i32 %11 to i64
  %13 = getelementptr inbounds i64* %sp.1, i64 %12
  %14 = getelementptr inbounds i64* %13, i64 -3
  %15 = ptrtoint i32* %2 to i64
  %16 = getelementptr inbounds i64* %14, i64 2
  store i64 %15, i64* %16
  %17 = sext i32 %extra_args.1 to i64
  %18 = getelementptr inbounds i64* %14, i64 1
  store i64 %17, i64* %18
  %19 = getelementptr inbounds i64* %14, i64 0
  store i64 %10, i64* %19
  %20 = ashr i32 %3, 16
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds i32* %2, i64 %21
  br label %179

; <label>:23                                      ; preds = %1, %1
  %24 = and i32 %3, 1
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds i64* %sp.1, i64 %25
  %27 = getelementptr inbounds i64* %26, i64 -1
  %28 = ashr i32 %3, 8
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i64* %27, i64 0
  store i64 %29, i64* %30
  br label %179

; <label>:31                                      ; preds = %1, %1
  %32 = lshr i32 %3, 8
  %33 = and i32 %32, 255
  %34 = zext i32 %33 to i64
  %35 = getelementptr inbounds i64* %sp.1, i64 %34
  %36 = load i64* %35
  %37 = and i32 %3, 1
  %38 = zext i32 %37 to i64
  %39 = getelementptr inbounds i64* %sp.1, i64 %38
  %40 = icmp ne i64 %36, 0
  br i1 %40, label %41, label %45

; <label>:41                                      ; preds = %31
  %42 = ashr i32 %3, 16
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds i32* %2, i64 %43
  br label %45

; <label>:45                                      ; preds = %41, %31
  %pc.2 = phi i32* [ %44, %41 ], [ %2, %31 ]
  br label %179

; <label>:46                                      ; preds = %1
  %47 = getelementptr inbounds i32* %2, i32 1
  %48 = load i32* %2
  %49 = and i32 %48, 255
  %50 = zext i32 %49 to i64
  %51 = getelementptr inbounds i64* %sp.1, i64 %50
  %52 = load i64* %51
  %53 = lshr i32 %48, 8
  %54 = and i32 %53, 255
  %55 = zext i32 %54 to i64
  %56 = getelementptr inbounds i64* %sp.1, i64 %55
  %57 = load i64* %56
  %58 = lshr i32 %48, 16
  %59 = and i32 %58, 255
  %60 = zext i32 %59 to i64
  %61 = getelementptr inbounds i64* %sp.1, i64 %60
  %62 = load i64* %61
  %63 = lshr i32 %3, 8
  %64 = and i32 %63, 255
  %65 = zext i32 %64 to i64
  %66 = getelementptr inbounds i64* %sp.1, i64 %65
  %67 = getelementptr inbounds i64* %66, i64 -5
  %68 = ptrtoint i32* %47 to i64
  %69 = getelementptr inbounds i64* %67, i64 4
  store i64 %68, i64* %69
  %70 = sext i32 %extra_args.1 to i64
  %71 = getelementptr inbounds i64* %67, i64 3
  store i64 %70, i64* %71
  %72 = getelementptr inbounds i64* %67, i64 2
  store i64 %62, i64* %72
  %73 = getelementptr inbounds i64* %67, i64 1
  store i64 %57, i64* %73
  %74 = getelementptr inbounds i64* %67, i64 0
  store i64 %52, i64* %74
  %75 = ashr i32 %3, 16
  %76 = sext i32 %75 to i64
  %77 = getelementptr inbounds i32* %47, i64 %76
  br label %179

; <label>:78                                      ; preds = %1
  %79 = lshr i32 %3, 8
  %80 = and i32 %79, 255
  %81 = zext i32 %80 to i64
  %82 = getelementptr inbounds i64* %sp.1, i64 %81
  %83 = load i64* %82
  %84 = lshr i32 %3, 16
  %85 = and i32 %84, 255
  %86 = zext i32 %85 to i64
  %87 = getelementptr inbounds i64* %sp.1, i64 %86
  %88 = icmp sgt i32 %extra_args.1, 0
  br i1 %88, label %89, label %91

; <label>:89                                      ; preds = %78
  %90 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([19 x i8]* @.str, i32 0, i32 0))
  call void @exit(i32 2) noreturn
  unreachable

; <label>:91                                      ; preds = %78
  %92 = getelementptr inbounds i64* %87, i64 0
  %93 = load i64* %92
  %94 = trunc i64 %93 to i32
  %95 = getelementptr inbounds i64* %87, i64 1
  %96 = load i64* %95
  %97 = inttoptr i64 %96 to i32*
  store i64 %83, i64* %95
  br label %179

; <label>:98                                      ; preds = %1
  %99 = lshr i32 %3, 8
  %100 = and i32 %99, 255
  %101 = zext i32 %100 to i64
  %102 = getelementptr inbounds i64* %sp.1, i64 %101
  %103 = ashr i32 %3, 16
  %104 = sext i32 %103 to i64
  %105 = getelementptr inbounds i32* %2, i64 %104
  br label %179

; <label>:106                                     ; preds = %1
  %107 = lshr i32 %3, 8
  %108 = and i32 %107, 255
  %109 = zext i32 %108 to i64
  %110 = getelementptr inbounds i64* %sp.1, i64 %109
  %111 = load i64* %110
  %112 = lshr i32 %3, 16
  %113 = and i32 %112, 255
  %114 = zext i32 %113 to i64
  %115 = getelementptr inbounds i64* %sp.1, i64 %114
  %116 = load i64* %115
  %117 = lshr i32 %3, 24
  %118 = zext i32 %117 to i64
  %119 = getelementptr inbounds i64* %sp.1, i64 %118
  %120 = getelementptr inbounds i64* %119, i64 -1
  %121 = icmp slt i64 %111, %116
  %122 = zext i1 %121 to i32
  %123 = sext i32 %122 to i64
  %124 = getelementptr inbounds i64* %120, i64 0
  store i64 %123, i64* %124
  br label %179

; <label>:125                                     ; preds = %1
  %126 = lshr i32 %3, 8
  %127 = and i32 %126, 255
  %128 = zext i32 %127 to i64
  %129 = getelementptr inbounds i64* %sp.1, i64 %128
  %130 = load i64* %129
  %131 = lshr i32 %3, 16
  %132 = and i32 %131, 255
  %133 = zext i32 %132 to i64
  %134 = getelementptr inbounds i64* %sp.1, i64 %133
  %135 = load i64* %134
  %136 = lshr i32 %3, 24
  %137 = zext i32 %136 to i64
  %138 = getelementptr inbounds i64* %sp.1, i64 %137
  %139 = getelementptr inbounds i64* %138, i64 -1
  %140 = add nsw i64 %130, %135
  %141 = getelementptr inbounds i64* %139, i64 0
  store i64 %140, i64* %141
  br label %179

; <label>:142                                     ; preds = %1
  %143 = lshr i32 %3, 8
  %144 = and i32 %143, 255
  %145 = zext i32 %144 to i64
  %146 = getelementptr inbounds i64* %sp.1, i64 %145
  %147 = load i64* %146
  %148 = lshr i32 %3, 16
  %149 = and i32 %148, 255
  %150 = zext i32 %149 to i64
  %151 = getelementptr inbounds i64* %sp.1, i64 %150
  %152 = getelementptr inbounds i64* %151, i64 -1
  %153 = ashr i32 %3, 24
  %154 = sext i32 %153 to i64
  %155 = add nsw i64 %147, %154
  %156 = getelementptr inbounds i64* %152, i64 0
  store i64 %155, i64* %156
  br label %179

; <label>:157                                     ; preds = %1
  %158 = lshr i32 %3, 8
  %159 = and i32 %158, 255
  %160 = zext i32 %159 to i64
  %161 = getelementptr inbounds i64* %sp.1, i64 %160
  %162 = load i64* %161
  %163 = getelementptr inbounds i64* %sp.1, i64 -1
  %164 = getelementptr inbounds i64* %163, i64 0
  store i64 %162, i64* %164
  br label %179

; <label>:165                                     ; preds = %1
  %166 = lshr i32 %3, 8
  %167 = and i32 %166, 255
  %168 = icmp sge i32 %extra_args.1, %167
  br i1 %168, label %169, label %171

; <label>:169                                     ; preds = %165
  %170 = sub nsw i32 %extra_args.1, %167
  br label %179

; <label>:171                                     ; preds = %165
  %172 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str1, i32 0, i32 0))
  call void @exit(i32 2) noreturn
  unreachable

; <label>:173                                     ; preds = %1
  %.lcssa = phi i32 [ %3, %1 ]
  %sp.1.lcssa = phi i64* [ %sp.1, %1 ]
  %174 = lshr i32 %.lcssa, 8
  %175 = and i32 %174, 255
  %176 = zext i32 %175 to i64
  %177 = getelementptr inbounds i64* %sp.1.lcssa, i64 %176
  %178 = load i64* %177
  ret i64 %178

; <label>:179                                     ; preds = %169, %157, %142, %125, %106, %98, %91, %46, %45, %23, %5, %1
  %pc.1 = phi i32* [ %2, %1 ], [ %2, %169 ], [ %2, %157 ], [ %2, %142 ], [ %2, %125 ], [ %2, %106 ], [ %105, %98 ], [ %97, %91 ], [ %77, %46 ], [ %pc.2, %45 ], [ %2, %23 ], [ %22, %5 ]
  %sp.0 = phi i64* [ %sp.1, %1 ], [ %sp.1, %169 ], [ %163, %157 ], [ %152, %142 ], [ %139, %125 ], [ %120, %106 ], [ %102, %98 ], [ %95, %91 ], [ %67, %46 ], [ %39, %45 ], [ %27, %23 ], [ %14, %5 ]
  %extra_args.0 = phi i32 [ %extra_args.1, %1 ], [ %170, %169 ], [ %extra_args.1, %157 ], [ %extra_args.1, %142 ], [ %extra_args.1, %125 ], [ %extra_args.1, %106 ], [ %extra_args.1, %98 ], [ %94, %91 ], [ 2, %46 ], [ %extra_args.1, %45 ], [ %extra_args.1, %23 ], [ 0, %5 ]
  br label %1
}

declare i32 @printf(i8*, ...)

declare void @exit(i32) noreturn

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
; <label>:0
  %1 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([14 x i32]* @wordcode_fib, i32 0, i32 0))
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str2, i32 0, i32 0), i64 %1)
  %3 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([23 x i32]* @wordcode_tak, i32 0, i32 0))
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str3, i32 0, i32 0), i64 %3)
  br label %5

; <label>:5                                       ; preds = %7, %0
  %i.0 = phi i32 [ 0, %0 ], [ %9, %7 ]
  %6 = icmp slt i32 %i.0, 20
  br i1 %6, label %7, label %10

; <label>:7                                       ; preds = %5
  %8 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([14 x i32]* @wordcode_fib, i32 0, i32 0))
  %9 = add nsw i32 %i.0, 1
  br label %5

; <label>:10                                      ; preds = %5
  br label %11

; <label>:11                                      ; preds = %13, %10
  %i.1 = phi i32 [ 0, %10 ], [ %15, %13 ]
  %12 = icmp slt i32 %i.1, 1000
  br i1 %12, label %13, label %16

; <label>:13                                      ; preds = %11
  %14 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([23 x i32]* @wordcode_tak, i32 0, i32 0))
  %15 = add nsw i32 %i.1, 1
  br label %11

; <label>:16                                      ; preds = %11
  ret i32 0
}
