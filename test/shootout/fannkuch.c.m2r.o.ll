; ModuleID = 'fannkuch.c.m2r.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [23 x i8] c"Pfannkuchen(%d) = %ld\0A\00"
@.str1 = private constant [3 x i8] c"%d\00"
@.str2 = private constant [2 x i8] c"\0A\00"

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = icmp sgt i32 %argc, 1
  br i1 %1, label %2, label %6

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds i8** %argv, i64 1
  %4 = load i8** %3
  %5 = call i32 @atoi(i8* %4)
  br label %7

; <label>:6                                       ; preds = %0
  br label %7

; <label>:7                                       ; preds = %6, %2
  %8 = phi i32 [ %5, %2 ], [ 10, %6 ]
  %9 = call i64 @fannkuch(i32 %8)
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str, i32 0, i32 0), i32 %8, i64 %9)
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)

define internal i64 @fannkuch(i32 %n) nounwind ssp {
  %1 = sub nsw i32 %n, 1
  %2 = icmp slt i32 %n, 1
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  br label %129

; <label>:4                                       ; preds = %0
  %5 = sext i32 %n to i64
  %6 = call i8* @calloc(i64 %5, i64 4)
  %7 = bitcast i8* %6 to i32*
  %8 = sext i32 %n to i64
  %9 = call i8* @calloc(i64 %8, i64 4)
  %10 = bitcast i8* %9 to i32*
  %11 = sext i32 %n to i64
  %12 = call i8* @calloc(i64 %11, i64 4)
  %13 = bitcast i8* %12 to i32*
  br label %14

; <label>:14                                      ; preds = %19, %4
  %i.0 = phi i32 [ 0, %4 ], [ %20, %19 ]
  %15 = icmp slt i32 %i.0, %n
  br i1 %15, label %16, label %21

; <label>:16                                      ; preds = %14
  %17 = sext i32 %i.0 to i64
  %18 = getelementptr inbounds i32* %10, i64 %17
  store i32 %i.0, i32* %18
  br label %19

; <label>:19                                      ; preds = %16
  %20 = add nsw i32 %i.0, 1
  br label %14

; <label>:21                                      ; preds = %14
  br label %22

; <label>:22                                      ; preds = %128, %21
  %r.1 = phi i32 [ %n, %21 ], [ %r.2, %128 ]
  %flipsMax.2 = phi i64 [ 0, %21 ], [ %flipsMax.1, %128 ]
  %didpr.1 = phi i32 [ 0, %21 ], [ %didpr.0, %128 ]
  %23 = icmp slt i32 %didpr.1, 30
  br i1 %23, label %24, label %38

; <label>:24                                      ; preds = %22
  br label %25

; <label>:25                                      ; preds = %33, %24
  %i.1 = phi i32 [ 0, %24 ], [ %34, %33 ]
  %26 = icmp slt i32 %i.1, %n
  br i1 %26, label %27, label %35

; <label>:27                                      ; preds = %25
  %28 = sext i32 %i.1 to i64
  %29 = getelementptr inbounds i32* %10, i64 %28
  %30 = load i32* %29
  %31 = add nsw i32 1, %30
  %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32 %31)
  br label %33

; <label>:33                                      ; preds = %27
  %34 = add nsw i32 %i.1, 1
  br label %25

; <label>:35                                      ; preds = %25
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str2, i32 0, i32 0))
  %37 = add nsw i32 %didpr.1, 1
  br label %38

; <label>:38                                      ; preds = %35, %22
  %didpr.0 = phi i32 [ %37, %35 ], [ %didpr.1, %22 ]
  br label %39

; <label>:39                                      ; preds = %45, %38
  %r.0 = phi i32 [ %r.1, %38 ], [ %46, %45 ]
  %40 = icmp ne i32 %r.0, 1
  br i1 %40, label %41, label %47

; <label>:41                                      ; preds = %39
  %42 = sub nsw i32 %r.0, 1
  %43 = sext i32 %42 to i64
  %44 = getelementptr inbounds i32* %13, i64 %43
  store i32 %r.0, i32* %44
  br label %45

; <label>:45                                      ; preds = %41
  %46 = add nsw i32 %r.0, -1
  br label %39

; <label>:47                                      ; preds = %39
  %48 = getelementptr inbounds i32* %10, i64 0
  %49 = load i32* %48
  %50 = icmp eq i32 %49, 0
  br i1 %50, label %101, label %51

; <label>:51                                      ; preds = %47
  %52 = sext i32 %1 to i64
  %53 = getelementptr inbounds i32* %10, i64 %52
  %54 = load i32* %53
  %55 = icmp eq i32 %54, %1
  br i1 %55, label %101, label %56

; <label>:56                                      ; preds = %51
  br label %57

; <label>:57                                      ; preds = %65, %56
  %i.2 = phi i32 [ 1, %56 ], [ %66, %65 ]
  %58 = icmp slt i32 %i.2, %n
  br i1 %58, label %59, label %67

; <label>:59                                      ; preds = %57
  %60 = sext i32 %i.2 to i64
  %61 = getelementptr inbounds i32* %10, i64 %60
  %62 = load i32* %61
  %63 = sext i32 %i.2 to i64
  %64 = getelementptr inbounds i32* %7, i64 %63
  store i32 %62, i32* %64
  br label %65

; <label>:65                                      ; preds = %59
  %66 = add nsw i32 %i.2, 1
  br label %57

; <label>:67                                      ; preds = %57
  %68 = getelementptr inbounds i32* %10, i64 0
  %69 = load i32* %68
  br label %70

; <label>:70                                      ; preds = %95, %67
  %flips.0 = phi i64 [ 0, %67 ], [ %89, %95 ]
  %k.0 = phi i32 [ %69, %67 ], [ %92, %95 ]
  %71 = sub nsw i32 %k.0, 1
  br label %72

; <label>:72                                      ; preds = %85, %70
  %i.3 = phi i32 [ 1, %70 ], [ %86, %85 ]
  %j.0 = phi i32 [ %71, %70 ], [ %87, %85 ]
  %73 = icmp slt i32 %i.3, %j.0
  br i1 %73, label %74, label %88

; <label>:74                                      ; preds = %72
  %75 = sext i32 %i.3 to i64
  %76 = getelementptr inbounds i32* %7, i64 %75
  %77 = load i32* %76
  %78 = sext i32 %j.0 to i64
  %79 = getelementptr inbounds i32* %7, i64 %78
  %80 = load i32* %79
  %81 = sext i32 %i.3 to i64
  %82 = getelementptr inbounds i32* %7, i64 %81
  store i32 %80, i32* %82
  %83 = sext i32 %j.0 to i64
  %84 = getelementptr inbounds i32* %7, i64 %83
  store i32 %77, i32* %84
  br label %85

; <label>:85                                      ; preds = %74
  %86 = add nsw i32 %i.3, 1
  %87 = add nsw i32 %j.0, -1
  br label %72

; <label>:88                                      ; preds = %72
  %89 = add nsw i64 %flips.0, 1
  %90 = sext i32 %k.0 to i64
  %91 = getelementptr inbounds i32* %7, i64 %90
  %92 = load i32* %91
  %93 = sext i32 %k.0 to i64
  %94 = getelementptr inbounds i32* %7, i64 %93
  store i32 %k.0, i32* %94
  br label %95

; <label>:95                                      ; preds = %88
  %96 = icmp ne i32 %92, 0
  br i1 %96, label %70, label %97

; <label>:97                                      ; preds = %95
  %98 = icmp slt i64 %flipsMax.2, %89
  br i1 %98, label %99, label %100

; <label>:99                                      ; preds = %97
  br label %100

; <label>:100                                     ; preds = %99, %97
  %flipsMax.0 = phi i64 [ %89, %99 ], [ %flipsMax.2, %97 ]
  br label %101

; <label>:101                                     ; preds = %100, %51, %47
  %flipsMax.1 = phi i64 [ %flipsMax.2, %47 ], [ %flipsMax.2, %51 ], [ %flipsMax.0, %100 ]
  br label %102

; <label>:102                                     ; preds = %126, %101
  %r.2 = phi i32 [ %r.0, %101 ], [ %127, %126 ]
  %103 = icmp eq i32 %r.2, %n
  br i1 %103, label %104, label %105

; <label>:104                                     ; preds = %102
  br label %129

; <label>:105                                     ; preds = %102
  %106 = getelementptr inbounds i32* %10, i64 0
  %107 = load i32* %106
  br label %108

; <label>:108                                     ; preds = %110, %105
  %i.4 = phi i32 [ 0, %105 ], [ %111, %110 ]
  %109 = icmp slt i32 %i.4, %r.2
  br i1 %109, label %110, label %117

; <label>:110                                     ; preds = %108
  %111 = add nsw i32 %i.4, 1
  %112 = sext i32 %111 to i64
  %113 = getelementptr inbounds i32* %10, i64 %112
  %114 = load i32* %113
  %115 = sext i32 %i.4 to i64
  %116 = getelementptr inbounds i32* %10, i64 %115
  store i32 %114, i32* %116
  br label %108

; <label>:117                                     ; preds = %108
  %118 = sext i32 %r.2 to i64
  %119 = getelementptr inbounds i32* %10, i64 %118
  store i32 %107, i32* %119
  %120 = sext i32 %r.2 to i64
  %121 = getelementptr inbounds i32* %13, i64 %120
  %122 = load i32* %121
  %123 = sub nsw i32 %122, 1
  store i32 %123, i32* %121
  %124 = icmp sgt i32 %123, 0
  br i1 %124, label %125, label %126

; <label>:125                                     ; preds = %117
  br label %128

; <label>:126                                     ; preds = %117
  %127 = add nsw i32 %r.2, 1
  br label %102

; <label>:128                                     ; preds = %125
  br label %22

; <label>:129                                     ; preds = %104, %3
  %.0 = phi i64 [ 0, %3 ], [ %flipsMax.1, %104 ]
  ret i64 %.0
}

declare i8* @calloc(i64, i64)
