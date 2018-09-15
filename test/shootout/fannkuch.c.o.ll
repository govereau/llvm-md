; ModuleID = 'fannkuch.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [23 x i8] c"Pfannkuchen(%d) = %ld\0A\00"
@.str1 = private constant [3 x i8] c"%d\00"
@.str2 = private constant [2 x i8] c"\0A\00"

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %n = alloca i32, align 4
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  %4 = load i32* %2, align 4
  %5 = icmp sgt i32 %4, 1
  br i1 %5, label %6, label %11

; <label>:6                                       ; preds = %0
  %7 = load i8*** %3, align 8
  %8 = getelementptr inbounds i8** %7, i64 1
  %9 = load i8** %8
  %10 = call i32 @atoi(i8* %9)
  br label %12

; <label>:11                                      ; preds = %0
  br label %12

; <label>:12                                      ; preds = %11, %6
  %13 = phi i32 [ %10, %6 ], [ 10, %11 ]
  store i32 %13, i32* %n, align 4
  %14 = load i32* %n, align 4
  %15 = load i32* %n, align 4
  %16 = call i64 @fannkuch(i32 %15)
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str, i32 0, i32 0), i32 %14, i64 %16)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)

define internal i64 @fannkuch(i32 %n) nounwind ssp {
  %1 = alloca i64, align 8
  %2 = alloca i32, align 4
  %perm = alloca i32*, align 8
  %perm1 = alloca i32*, align 8
  %count = alloca i32*, align 8
  %flips = alloca i64, align 8
  %flipsMax = alloca i64, align 8
  %r = alloca i32, align 4
  %i = alloca i32, align 4
  %k = alloca i32, align 4
  %didpr = alloca i32, align 4
  %n1 = alloca i32, align 4
  %j = alloca i32, align 4
  %t_mp = alloca i32, align 4
  %perm0 = alloca i32, align 4
  store i32 %n, i32* %2, align 4
  %3 = load i32* %2, align 4
  %4 = sub nsw i32 %3, 1
  store i32 %4, i32* %n1, align 4
  %5 = load i32* %2, align 4
  %6 = icmp slt i32 %5, 1
  br i1 %6, label %7, label %8

; <label>:7                                       ; preds = %0
  store i64 0, i64* %1
  br label %210

; <label>:8                                       ; preds = %0
  %9 = load i32* %2, align 4
  %10 = sext i32 %9 to i64
  %11 = call i8* @calloc(i64 %10, i64 4)
  %12 = bitcast i8* %11 to i32*
  store i32* %12, i32** %perm, align 8
  %13 = load i32* %2, align 4
  %14 = sext i32 %13 to i64
  %15 = call i8* @calloc(i64 %14, i64 4)
  %16 = bitcast i8* %15 to i32*
  store i32* %16, i32** %perm1, align 8
  %17 = load i32* %2, align 4
  %18 = sext i32 %17 to i64
  %19 = call i8* @calloc(i64 %18, i64 4)
  %20 = bitcast i8* %19 to i32*
  store i32* %20, i32** %count, align 8
  store i32 0, i32* %i, align 4
  br label %21

; <label>:21                                      ; preds = %31, %8
  %22 = load i32* %i, align 4
  %23 = load i32* %2, align 4
  %24 = icmp slt i32 %22, %23
  br i1 %24, label %25, label %34

; <label>:25                                      ; preds = %21
  %26 = load i32* %i, align 4
  %27 = load i32* %i, align 4
  %28 = sext i32 %27 to i64
  %29 = load i32** %perm1, align 8
  %30 = getelementptr inbounds i32* %29, i64 %28
  store i32 %26, i32* %30
  br label %31

; <label>:31                                      ; preds = %25
  %32 = load i32* %i, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, i32* %i, align 4
  br label %21

; <label>:34                                      ; preds = %21
  %35 = load i32* %2, align 4
  store i32 %35, i32* %r, align 4
  store i32 0, i32* %didpr, align 4
  store i64 0, i64* %flipsMax, align 8
  br label %36

; <label>:36                                      ; preds = %209, %34
  %37 = load i32* %didpr, align 4
  %38 = icmp slt i32 %37, 30
  br i1 %38, label %39, label %59

; <label>:39                                      ; preds = %36
  store i32 0, i32* %i, align 4
  br label %40

; <label>:40                                      ; preds = %52, %39
  %41 = load i32* %i, align 4
  %42 = load i32* %2, align 4
  %43 = icmp slt i32 %41, %42
  br i1 %43, label %44, label %55

; <label>:44                                      ; preds = %40
  %45 = load i32* %i, align 4
  %46 = sext i32 %45 to i64
  %47 = load i32** %perm1, align 8
  %48 = getelementptr inbounds i32* %47, i64 %46
  %49 = load i32* %48
  %50 = add nsw i32 1, %49
  %51 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32 %50)
  br label %52

; <label>:52                                      ; preds = %44
  %53 = load i32* %i, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, i32* %i, align 4
  br label %40

; <label>:55                                      ; preds = %40
  %56 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str2, i32 0, i32 0))
  %57 = load i32* %didpr, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, i32* %didpr, align 4
  br label %59

; <label>:59                                      ; preds = %55, %36
  br label %60

; <label>:60                                      ; preds = %70, %59
  %61 = load i32* %r, align 4
  %62 = icmp ne i32 %61, 1
  br i1 %62, label %63, label %73

; <label>:63                                      ; preds = %60
  %64 = load i32* %r, align 4
  %65 = load i32* %r, align 4
  %66 = sub nsw i32 %65, 1
  %67 = sext i32 %66 to i64
  %68 = load i32** %count, align 8
  %69 = getelementptr inbounds i32* %68, i64 %67
  store i32 %64, i32* %69
  br label %70

; <label>:70                                      ; preds = %63
  %71 = load i32* %r, align 4
  %72 = add nsw i32 %71, -1
  store i32 %72, i32* %r, align 4
  br label %60

; <label>:73                                      ; preds = %60
  %74 = load i32** %perm1, align 8
  %75 = getelementptr inbounds i32* %74, i64 0
  %76 = load i32* %75
  %77 = icmp eq i32 %76, 0
  br i1 %77, label %164, label %78

; <label>:78                                      ; preds = %73
  %79 = load i32* %n1, align 4
  %80 = sext i32 %79 to i64
  %81 = load i32** %perm1, align 8
  %82 = getelementptr inbounds i32* %81, i64 %80
  %83 = load i32* %82
  %84 = load i32* %n1, align 4
  %85 = icmp eq i32 %83, %84
  br i1 %85, label %164, label %86

; <label>:86                                      ; preds = %78
  store i64 0, i64* %flips, align 8
  store i32 1, i32* %i, align 4
  br label %87

; <label>:87                                      ; preds = %101, %86
  %88 = load i32* %i, align 4
  %89 = load i32* %2, align 4
  %90 = icmp slt i32 %88, %89
  br i1 %90, label %91, label %104

; <label>:91                                      ; preds = %87
  %92 = load i32* %i, align 4
  %93 = sext i32 %92 to i64
  %94 = load i32** %perm1, align 8
  %95 = getelementptr inbounds i32* %94, i64 %93
  %96 = load i32* %95
  %97 = load i32* %i, align 4
  %98 = sext i32 %97 to i64
  %99 = load i32** %perm, align 8
  %100 = getelementptr inbounds i32* %99, i64 %98
  store i32 %96, i32* %100
  br label %101

; <label>:101                                     ; preds = %91
  %102 = load i32* %i, align 4
  %103 = add nsw i32 %102, 1
  store i32 %103, i32* %i, align 4
  br label %87

; <label>:104                                     ; preds = %87
  %105 = load i32** %perm1, align 8
  %106 = getelementptr inbounds i32* %105, i64 0
  %107 = load i32* %106
  store i32 %107, i32* %k, align 4
  br label %108

; <label>:108                                     ; preds = %154, %104
  store i32 1, i32* %i, align 4
  %109 = load i32* %k, align 4
  %110 = sub nsw i32 %109, 1
  store i32 %110, i32* %j, align 4
  br label %111

; <label>:111                                     ; preds = %135, %108
  %112 = load i32* %i, align 4
  %113 = load i32* %j, align 4
  %114 = icmp slt i32 %112, %113
  br i1 %114, label %115, label %140

; <label>:115                                     ; preds = %111
  %116 = load i32* %i, align 4
  %117 = sext i32 %116 to i64
  %118 = load i32** %perm, align 8
  %119 = getelementptr inbounds i32* %118, i64 %117
  %120 = load i32* %119
  store i32 %120, i32* %t_mp, align 4
  %121 = load i32* %j, align 4
  %122 = sext i32 %121 to i64
  %123 = load i32** %perm, align 8
  %124 = getelementptr inbounds i32* %123, i64 %122
  %125 = load i32* %124
  %126 = load i32* %i, align 4
  %127 = sext i32 %126 to i64
  %128 = load i32** %perm, align 8
  %129 = getelementptr inbounds i32* %128, i64 %127
  store i32 %125, i32* %129
  %130 = load i32* %t_mp, align 4
  %131 = load i32* %j, align 4
  %132 = sext i32 %131 to i64
  %133 = load i32** %perm, align 8
  %134 = getelementptr inbounds i32* %133, i64 %132
  store i32 %130, i32* %134
  br label %135

; <label>:135                                     ; preds = %115
  %136 = load i32* %i, align 4
  %137 = add nsw i32 %136, 1
  store i32 %137, i32* %i, align 4
  %138 = load i32* %j, align 4
  %139 = add nsw i32 %138, -1
  store i32 %139, i32* %j, align 4
  br label %111

; <label>:140                                     ; preds = %111
  %141 = load i64* %flips, align 8
  %142 = add nsw i64 %141, 1
  store i64 %142, i64* %flips, align 8
  %143 = load i32* %k, align 4
  %144 = sext i32 %143 to i64
  %145 = load i32** %perm, align 8
  %146 = getelementptr inbounds i32* %145, i64 %144
  %147 = load i32* %146
  store i32 %147, i32* %j, align 4
  %148 = load i32* %k, align 4
  %149 = load i32* %k, align 4
  %150 = sext i32 %149 to i64
  %151 = load i32** %perm, align 8
  %152 = getelementptr inbounds i32* %151, i64 %150
  store i32 %148, i32* %152
  %153 = load i32* %j, align 4
  store i32 %153, i32* %k, align 4
  br label %154

; <label>:154                                     ; preds = %140
  %155 = load i32* %k, align 4
  %156 = icmp ne i32 %155, 0
  br i1 %156, label %108, label %157

; <label>:157                                     ; preds = %154
  %158 = load i64* %flipsMax, align 8
  %159 = load i64* %flips, align 8
  %160 = icmp slt i64 %158, %159
  br i1 %160, label %161, label %163

; <label>:161                                     ; preds = %157
  %162 = load i64* %flips, align 8
  store i64 %162, i64* %flipsMax, align 8
  br label %163

; <label>:163                                     ; preds = %161, %157
  br label %164

; <label>:164                                     ; preds = %163, %78, %73
  br label %165

; <label>:165                                     ; preds = %206, %164
  %166 = load i32* %r, align 4
  %167 = load i32* %2, align 4
  %168 = icmp eq i32 %166, %167
  br i1 %168, label %169, label %171

; <label>:169                                     ; preds = %165
  %170 = load i64* %flipsMax, align 8
  store i64 %170, i64* %1
  br label %210

; <label>:171                                     ; preds = %165
  %172 = load i32** %perm1, align 8
  %173 = getelementptr inbounds i32* %172, i64 0
  %174 = load i32* %173
  store i32 %174, i32* %perm0, align 4
  store i32 0, i32* %i, align 4
  br label %175

; <label>:175                                     ; preds = %179, %171
  %176 = load i32* %i, align 4
  %177 = load i32* %r, align 4
  %178 = icmp slt i32 %176, %177
  br i1 %178, label %179, label %192

; <label>:179                                     ; preds = %175
  %180 = load i32* %i, align 4
  %181 = add nsw i32 %180, 1
  store i32 %181, i32* %k, align 4
  %182 = load i32* %k, align 4
  %183 = sext i32 %182 to i64
  %184 = load i32** %perm1, align 8
  %185 = getelementptr inbounds i32* %184, i64 %183
  %186 = load i32* %185
  %187 = load i32* %i, align 4
  %188 = sext i32 %187 to i64
  %189 = load i32** %perm1, align 8
  %190 = getelementptr inbounds i32* %189, i64 %188
  store i32 %186, i32* %190
  %191 = load i32* %k, align 4
  store i32 %191, i32* %i, align 4
  br label %175

; <label>:192                                     ; preds = %175
  %193 = load i32* %perm0, align 4
  %194 = load i32* %r, align 4
  %195 = sext i32 %194 to i64
  %196 = load i32** %perm1, align 8
  %197 = getelementptr inbounds i32* %196, i64 %195
  store i32 %193, i32* %197
  %198 = load i32* %r, align 4
  %199 = sext i32 %198 to i64
  %200 = load i32** %count, align 8
  %201 = getelementptr inbounds i32* %200, i64 %199
  %202 = load i32* %201
  %203 = sub nsw i32 %202, 1
  store i32 %203, i32* %201
  %204 = icmp sgt i32 %203, 0
  br i1 %204, label %205, label %206

; <label>:205                                     ; preds = %192
  br label %209

; <label>:206                                     ; preds = %192
  %207 = load i32* %r, align 4
  %208 = add nsw i32 %207, 1
  store i32 %208, i32* %r, align 4
  br label %165

; <label>:209                                     ; preds = %205
  br label %36

; <label>:210                                     ; preds = %169, %7
  %211 = load i64* %1
  ret i64 %211
}

declare i8* @calloc(i64, i64)
