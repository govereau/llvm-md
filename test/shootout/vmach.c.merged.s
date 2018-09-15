; ModuleID = 'vmach.c.m2r.o'
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

; <label>:1                                       ; preds = %186, %0
  %pc.0 = phi i32* [ %code, %0 ], [ %pc.1, %186 ]
  %sp.1 = phi i64* [ getelementptr inbounds ([256 x i64]* @stack, i64 1, i64 0), %0 ], [ %sp.0, %186 ]
  %extra_args.1 = phi i32 [ 0, %0 ], [ %extra_args.0, %186 ]
  %2 = getelementptr inbounds i32* %pc.0, i32 1
  %3 = load i32* %pc.0
  %4 = and i32 %3, 255
  switch i32 %4, label %186 [
    i32 0, label %5
    i32 1, label %5
    i32 2, label %23
    i32 3, label %23
    i32 4, label %31
    i32 5, label %31
    i32 6, label %46
    i32 7, label %78
    i32 8, label %100
    i32 9, label %108
    i32 10, label %127
    i32 11, label %144
    i32 12, label %159
    i32 13, label %167
    i32 14, label %176
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
  br label %186

; <label>:23                                      ; preds = %1, %1
  %24 = and i32 %3, 1
  %25 = zext i32 %24 to i64
  %26 = getelementptr inbounds i64* %sp.1, i64 %25
  %27 = getelementptr inbounds i64* %26, i64 -1
  %28 = ashr i32 %3, 8
  %29 = sext i32 %28 to i64
  %30 = getelementptr inbounds i64* %27, i64 0
  store i64 %29, i64* %30
  br label %186

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
  br label %186

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
  br label %186

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
  %98 = getelementptr inbounds i64* %87, i64 1
  store i64 %83, i64* %98
  br label %99

; <label>:99                                      ; preds = %91
  br label %186

; <label>:100                                     ; preds = %1
  %101 = lshr i32 %3, 8
  %102 = and i32 %101, 255
  %103 = zext i32 %102 to i64
  %104 = getelementptr inbounds i64* %sp.1, i64 %103
  %105 = ashr i32 %3, 16
  %106 = sext i32 %105 to i64
  %107 = getelementptr inbounds i32* %2, i64 %106
  br label %186

; <label>:108                                     ; preds = %1
  %109 = lshr i32 %3, 8
  %110 = and i32 %109, 255
  %111 = zext i32 %110 to i64
  %112 = getelementptr inbounds i64* %sp.1, i64 %111
  %113 = load i64* %112
  %114 = lshr i32 %3, 16
  %115 = and i32 %114, 255
  %116 = zext i32 %115 to i64
  %117 = getelementptr inbounds i64* %sp.1, i64 %116
  %118 = load i64* %117
  %119 = lshr i32 %3, 24
  %120 = zext i32 %119 to i64
  %121 = getelementptr inbounds i64* %sp.1, i64 %120
  %122 = getelementptr inbounds i64* %121, i64 -1
  %123 = icmp slt i64 %113, %118
  %124 = zext i1 %123 to i32
  %125 = sext i32 %124 to i64
  %126 = getelementptr inbounds i64* %122, i64 0
  store i64 %125, i64* %126
  br label %186

; <label>:127                                     ; preds = %1
  %128 = lshr i32 %3, 8
  %129 = and i32 %128, 255
  %130 = zext i32 %129 to i64
  %131 = getelementptr inbounds i64* %sp.1, i64 %130
  %132 = load i64* %131
  %133 = lshr i32 %3, 16
  %134 = and i32 %133, 255
  %135 = zext i32 %134 to i64
  %136 = getelementptr inbounds i64* %sp.1, i64 %135
  %137 = load i64* %136
  %138 = lshr i32 %3, 24
  %139 = zext i32 %138 to i64
  %140 = getelementptr inbounds i64* %sp.1, i64 %139
  %141 = getelementptr inbounds i64* %140, i64 -1
  %142 = add nsw i64 %132, %137
  %143 = getelementptr inbounds i64* %141, i64 0
  store i64 %142, i64* %143
  br label %186

; <label>:144                                     ; preds = %1
  %145 = lshr i32 %3, 8
  %146 = and i32 %145, 255
  %147 = zext i32 %146 to i64
  %148 = getelementptr inbounds i64* %sp.1, i64 %147
  %149 = load i64* %148
  %150 = lshr i32 %3, 16
  %151 = and i32 %150, 255
  %152 = zext i32 %151 to i64
  %153 = getelementptr inbounds i64* %sp.1, i64 %152
  %154 = getelementptr inbounds i64* %153, i64 -1
  %155 = ashr i32 %3, 24
  %156 = sext i32 %155 to i64
  %157 = add nsw i64 %149, %156
  %158 = getelementptr inbounds i64* %154, i64 0
  store i64 %157, i64* %158
  br label %186

; <label>:159                                     ; preds = %1
  %160 = lshr i32 %3, 8
  %161 = and i32 %160, 255
  %162 = zext i32 %161 to i64
  %163 = getelementptr inbounds i64* %sp.1, i64 %162
  %164 = load i64* %163
  %165 = getelementptr inbounds i64* %sp.1, i64 -1
  %166 = getelementptr inbounds i64* %165, i64 0
  store i64 %164, i64* %166
  br label %186

; <label>:167                                     ; preds = %1
  %168 = lshr i32 %3, 8
  %169 = and i32 %168, 255
  %170 = icmp sge i32 %extra_args.1, %169
  br i1 %170, label %171, label %173

; <label>:171                                     ; preds = %167
  %172 = sub nsw i32 %extra_args.1, %169
  br label %175

; <label>:173                                     ; preds = %167
  %174 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str1, i32 0, i32 0))
  call void @exit(i32 2) noreturn
  unreachable

; <label>:175                                     ; preds = %171
  br label %186

; <label>:176                                     ; preds = %1
  %177 = lshr i32 %3, 8
  %178 = and i32 %177, 255
  %179 = zext i32 %178 to i64
  %180 = getelementptr inbounds i64* %sp.1, i64 %179
  %181 = load i64* %180
  %182 = lshr i32 %3, 16
  %183 = and i32 %182, 255
  %184 = zext i32 %183 to i64
  %185 = getelementptr inbounds i64* %sp.1, i64 %184
  ret i64 %181

; <label>:186                                     ; preds = %175, %159, %144, %127, %108, %100, %99, %46, %45, %23, %5, %1
  %pc.1 = phi i32* [ %2, %1 ], [ %2, %175 ], [ %2, %159 ], [ %2, %144 ], [ %2, %127 ], [ %2, %108 ], [ %107, %100 ], [ %97, %99 ], [ %77, %46 ], [ %pc.2, %45 ], [ %2, %23 ], [ %22, %5 ]
  %sp.0 = phi i64* [ %sp.1, %1 ], [ %sp.1, %175 ], [ %165, %159 ], [ %154, %144 ], [ %141, %127 ], [ %122, %108 ], [ %104, %100 ], [ %98, %99 ], [ %67, %46 ], [ %39, %45 ], [ %27, %23 ], [ %14, %5 ]
  %extra_args.0 = phi i32 [ %extra_args.1, %1 ], [ %172, %175 ], [ %extra_args.1, %159 ], [ %extra_args.1, %144 ], [ %extra_args.1, %127 ], [ %extra_args.1, %108 ], [ %extra_args.1, %100 ], [ %94, %99 ], [ 2, %46 ], [ %extra_args.1, %45 ], [ %extra_args.1, %23 ], [ 0, %5 ]
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

; <label>:5                                       ; preds = %9, %0
  %i.0 = phi i32 [ 0, %0 ], [ %10, %9 ]
  %6 = icmp slt i32 %i.0, 20
  br i1 %6, label %7, label %11

; <label>:7                                       ; preds = %5
  %8 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([14 x i32]* @wordcode_fib, i32 0, i32 0))
  br label %9

; <label>:9                                       ; preds = %7
  %10 = add nsw i32 %i.0, 1
  br label %5

; <label>:11                                      ; preds = %5
  br label %12

; <label>:12                                      ; preds = %16, %11
  %i.1 = phi i32 [ 0, %11 ], [ %17, %16 ]
  %13 = icmp slt i32 %i.1, 1000
  br i1 %13, label %14, label %18

; <label>:14                                      ; preds = %12
  %15 = call i64 (...)* bitcast (i64 (i32*)* @wordcode_interp to i64 (...)*)(i32* getelementptr inbounds ([23 x i32]* @wordcode_tak, i32 0, i32 0))
  br label %16

; <label>:16                                      ; preds = %14
  %17 = add nsw i32 %i.1, 1
  br label %12

; <label>:18                                      ; preds = %12
  ret i32 0
}
