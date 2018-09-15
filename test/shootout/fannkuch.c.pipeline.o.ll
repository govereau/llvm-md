; ModuleID = 'fannkuch.c.pipeline.o'
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
  br label %110

; <label>:4                                       ; preds = %0
  %5 = sext i32 %n to i64
  %6 = call i8* @calloc(i64 %5, i64 4)
  %7 = bitcast i8* %6 to i32*
  %8 = call i8* @calloc(i64 %5, i64 4)
  %9 = bitcast i8* %8 to i32*
  %10 = call i8* @calloc(i64 %5, i64 4)
  %11 = bitcast i8* %10 to i32*
  br label %12

; <label>:12                                      ; preds = %14, %4
  %i.0 = phi i32 [ 0, %4 ], [ %17, %14 ]
  %13 = icmp slt i32 %i.0, %n
  br i1 %13, label %14, label %18

; <label>:14                                      ; preds = %12
  %15 = sext i32 %i.0 to i64
  %16 = getelementptr inbounds i32* %9, i64 %15
  store i32 %i.0, i32* %16
  %17 = add nsw i32 %i.0, 1
  br label %12

; <label>:18                                      ; preds = %12
  %19 = getelementptr inbounds i32* %9, i64 0
  %20 = sext i32 %1 to i64
  %21 = getelementptr inbounds i32* %9, i64 %20
  br label %22

; <label>:22                                      ; preds = %107, %18
  %r.1 = phi i32 [ %n, %18 ], [ %r.2.lcssa1, %107 ]
  %flipsMax.2 = phi i64 [ 0, %18 ], [ %flipsMax.1, %107 ]
  %didpr.1 = phi i32 [ 0, %18 ], [ %didpr.0, %107 ]
  %23 = icmp slt i32 %didpr.1, 30
  br i1 %23, label %24, label %37

; <label>:24                                      ; preds = %22
  br label %25

; <label>:25                                      ; preds = %27, %24
  %i.1 = phi i32 [ 0, %24 ], [ %33, %27 ]
  %26 = icmp slt i32 %i.1, %n
  br i1 %26, label %27, label %34

; <label>:27                                      ; preds = %25
  %28 = sext i32 %i.1 to i64
  %29 = getelementptr inbounds i32* %9, i64 %28
  %30 = load i32* %29
  %31 = add nsw i32 1, %30
  %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0), i32 %31)
  %33 = add nsw i32 %i.1, 1
  br label %25

; <label>:34                                      ; preds = %25
  %35 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str2, i32 0, i32 0))
  %36 = add nsw i32 %didpr.1, 1
  br label %37

; <label>:37                                      ; preds = %34, %22
  %didpr.0 = phi i32 [ %36, %34 ], [ %didpr.1, %22 ]
  br label %38

; <label>:38                                      ; preds = %40, %37
  %r.0 = phi i32 [ %r.1, %37 ], [ %44, %40 ]
  %39 = icmp ne i32 %r.0, 1
  br i1 %39, label %40, label %45

; <label>:40                                      ; preds = %38
  %41 = sub nsw i32 %r.0, 1
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds i32* %11, i64 %42
  store i32 %r.0, i32* %43
  %44 = add nsw i32 %r.0, -1
  br label %38

; <label>:45                                      ; preds = %38
  %r.0.lcssa = phi i32 [ %r.0, %38 ]
  %46 = load i32* %19
  %47 = icmp eq i32 %46, 0
  br i1 %47, label %85, label %48

; <label>:48                                      ; preds = %45
  %49 = load i32* %21
  %50 = icmp eq i32 %49, %1
  br i1 %50, label %85, label %51

; <label>:51                                      ; preds = %48
  br label %52

; <label>:52                                      ; preds = %54, %51
  %i.2 = phi i32 [ 1, %51 ], [ %59, %54 ]
  %53 = icmp slt i32 %i.2, %n
  br i1 %53, label %54, label %60

; <label>:54                                      ; preds = %52
  %55 = sext i32 %i.2 to i64
  %56 = getelementptr inbounds i32* %9, i64 %55
  %57 = load i32* %56
  %58 = getelementptr inbounds i32* %7, i64 %55
  store i32 %57, i32* %58
  %59 = add nsw i32 %i.2, 1
  br label %52

; <label>:60                                      ; preds = %52
  %61 = load i32* %19
  br label %62

; <label>:62                                      ; preds = %75, %60
  %flips.0 = phi i64 [ 0, %60 ], [ %76, %75 ]
  %k.0 = phi i32 [ %61, %60 ], [ %79, %75 ]
  %63 = sub nsw i32 %k.0, 1
  br label %64

; <label>:64                                      ; preds = %66, %62
  %i.3 = phi i32 [ 1, %62 ], [ %73, %66 ]
  %j.0 = phi i32 [ %63, %62 ], [ %74, %66 ]
  %65 = icmp slt i32 %i.3, %j.0
  br i1 %65, label %66, label %75

; <label>:66                                      ; preds = %64
  %67 = sext i32 %i.3 to i64
  %68 = getelementptr inbounds i32* %7, i64 %67
  %69 = load i32* %68
  %70 = sext i32 %j.0 to i64
  %71 = getelementptr inbounds i32* %7, i64 %70
  %72 = load i32* %71
  store i32 %72, i32* %68
  store i32 %69, i32* %71
  %73 = add nsw i32 %i.3, 1
  %74 = add nsw i32 %j.0, -1
  br label %64

; <label>:75                                      ; preds = %64
  %76 = add nsw i64 %flips.0, 1
  %77 = sext i32 %k.0 to i64
  %78 = getelementptr inbounds i32* %7, i64 %77
  %79 = load i32* %78
  store i32 %k.0, i32* %78
  %80 = icmp ne i32 %79, 0
  br i1 %80, label %62, label %81

; <label>:81                                      ; preds = %75
  %.lcssa = phi i64 [ %76, %75 ]
  %82 = icmp slt i64 %flipsMax.2, %.lcssa
  br i1 %82, label %83, label %84

; <label>:83                                      ; preds = %81
  br label %84

; <label>:84                                      ; preds = %83, %81
  %flipsMax.0 = phi i64 [ %.lcssa, %83 ], [ %flipsMax.2, %81 ]
  br label %85

; <label>:85                                      ; preds = %84, %48, %45
  %flipsMax.1 = phi i64 [ %flipsMax.2, %45 ], [ %flipsMax.2, %48 ], [ %flipsMax.0, %84 ]
  br label %86

; <label>:86                                      ; preds = %108, %85
  %r.2 = phi i32 [ %r.0.lcssa, %85 ], [ %109, %108 ]
  %87 = icmp eq i32 %r.2, %n
  br i1 %87, label %88, label %89

; <label>:88                                      ; preds = %86
  %flipsMax.1.lcssa = phi i64 [ %flipsMax.1, %86 ]
  %r.2.lcssa = phi i32 [ %r.2, %86 ]
  br label %110

; <label>:89                                      ; preds = %86
  %90 = load i32* %19
  br label %91

; <label>:91                                      ; preds = %93, %89
  %i.4 = phi i32 [ 0, %89 ], [ %94, %93 ]
  %92 = icmp slt i32 %i.4, %r.2
  br i1 %92, label %93, label %100

; <label>:93                                      ; preds = %91
  %94 = add nsw i32 %i.4, 1
  %95 = sext i32 %94 to i64
  %96 = getelementptr inbounds i32* %9, i64 %95
  %97 = load i32* %96
  %98 = sext i32 %i.4 to i64
  %99 = getelementptr inbounds i32* %9, i64 %98
  store i32 %97, i32* %99
  br label %91

; <label>:100                                     ; preds = %91
  %101 = sext i32 %r.2 to i64
  %102 = getelementptr inbounds i32* %9, i64 %101
  store i32 %90, i32* %102
  %103 = getelementptr inbounds i32* %11, i64 %101
  %104 = load i32* %103
  %105 = sub nsw i32 %104, 1
  store i32 %105, i32* %103
  %106 = icmp sgt i32 %105, 0
  br i1 %106, label %107, label %108

; <label>:107                                     ; preds = %100
  %r.2.lcssa1 = phi i32 [ %r.2, %100 ]
  br label %22

; <label>:108                                     ; preds = %100
  %109 = add nsw i32 %r.2, 1
  br label %86

; <label>:110                                     ; preds = %88, %3
  %.0 = phi i64 [ 0, %3 ], [ %flipsMax.1.lcssa, %88 ]
  ret i64 %.0
}

declare i8* @calloc(i64, i64)
