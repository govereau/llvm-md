; ModuleID = 'qsort.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [6 x i8] c"Bug!\0A\00"
@.str1 = private constant [4 x i8] c"OK\0A\00"

define void @quicksort(i32 %lo, i32 %hi, i32* %base) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32*, align 8
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %pivot = alloca i32, align 4
  %temp = alloca i32, align 4
  store i32 %lo, i32* %1, align 4
  store i32 %hi, i32* %2, align 4
  store i32* %base, i32** %3, align 8
  %4 = load i32* %1, align 4
  %5 = load i32* %2, align 4
  %6 = icmp slt i32 %4, %5
  br i1 %6, label %7, label %108

; <label>:7                                       ; preds = %0
  %8 = load i32* %1, align 4
  store i32 %8, i32* %i, align 4
  %9 = load i32* %2, align 4
  store i32 %9, i32* %j, align 4
  %10 = load i32* %2, align 4
  %11 = sext i32 %10 to i64
  %12 = load i32** %3, align 8
  %13 = getelementptr inbounds i32* %12, i64 %11
  %14 = load i32* %13
  store i32 %14, i32* %pivot, align 4
  br label %15

; <label>:15                                      ; preds = %79, %7
  %16 = load i32* %i, align 4
  %17 = load i32* %j, align 4
  %18 = icmp slt i32 %16, %17
  br i1 %18, label %19, label %80

; <label>:19                                      ; preds = %15
  br label %20

; <label>:20                                      ; preds = %34, %19
  %21 = load i32* %i, align 4
  %22 = load i32* %2, align 4
  %23 = icmp slt i32 %21, %22
  br i1 %23, label %24, label %32

; <label>:24                                      ; preds = %20
  %25 = load i32* %i, align 4
  %26 = sext i32 %25 to i64
  %27 = load i32** %3, align 8
  %28 = getelementptr inbounds i32* %27, i64 %26
  %29 = load i32* %28
  %30 = load i32* %pivot, align 4
  %31 = icmp sle i32 %29, %30
  br label %32

; <label>:32                                      ; preds = %24, %20
  %33 = phi i1 [ false, %20 ], [ %31, %24 ]
  br i1 %33, label %34, label %37

; <label>:34                                      ; preds = %32
  %35 = load i32* %i, align 4
  %36 = add nsw i32 %35, 1
  store i32 %36, i32* %i, align 4
  br label %20

; <label>:37                                      ; preds = %32
  br label %38

; <label>:38                                      ; preds = %52, %37
  %39 = load i32* %j, align 4
  %40 = load i32* %1, align 4
  %41 = icmp sgt i32 %39, %40
  br i1 %41, label %42, label %50

; <label>:42                                      ; preds = %38
  %43 = load i32* %j, align 4
  %44 = sext i32 %43 to i64
  %45 = load i32** %3, align 8
  %46 = getelementptr inbounds i32* %45, i64 %44
  %47 = load i32* %46
  %48 = load i32* %pivot, align 4
  %49 = icmp sge i32 %47, %48
  br label %50

; <label>:50                                      ; preds = %42, %38
  %51 = phi i1 [ false, %38 ], [ %49, %42 ]
  br i1 %51, label %52, label %55

; <label>:52                                      ; preds = %50
  %53 = load i32* %j, align 4
  %54 = add nsw i32 %53, -1
  store i32 %54, i32* %j, align 4
  br label %38

; <label>:55                                      ; preds = %50
  %56 = load i32* %i, align 4
  %57 = load i32* %j, align 4
  %58 = icmp slt i32 %56, %57
  br i1 %58, label %59, label %79

; <label>:59                                      ; preds = %55
  %60 = load i32* %i, align 4
  %61 = sext i32 %60 to i64
  %62 = load i32** %3, align 8
  %63 = getelementptr inbounds i32* %62, i64 %61
  %64 = load i32* %63
  store i32 %64, i32* %temp, align 4
  %65 = load i32* %j, align 4
  %66 = sext i32 %65 to i64
  %67 = load i32** %3, align 8
  %68 = getelementptr inbounds i32* %67, i64 %66
  %69 = load i32* %68
  %70 = load i32* %i, align 4
  %71 = sext i32 %70 to i64
  %72 = load i32** %3, align 8
  %73 = getelementptr inbounds i32* %72, i64 %71
  store i32 %69, i32* %73
  %74 = load i32* %temp, align 4
  %75 = load i32* %j, align 4
  %76 = sext i32 %75 to i64
  %77 = load i32** %3, align 8
  %78 = getelementptr inbounds i32* %77, i64 %76
  store i32 %74, i32* %78
  br label %79

; <label>:79                                      ; preds = %59, %55
  br label %15

; <label>:80                                      ; preds = %15
  %81 = load i32* %i, align 4
  %82 = sext i32 %81 to i64
  %83 = load i32** %3, align 8
  %84 = getelementptr inbounds i32* %83, i64 %82
  %85 = load i32* %84
  store i32 %85, i32* %temp, align 4
  %86 = load i32* %2, align 4
  %87 = sext i32 %86 to i64
  %88 = load i32** %3, align 8
  %89 = getelementptr inbounds i32* %88, i64 %87
  %90 = load i32* %89
  %91 = load i32* %i, align 4
  %92 = sext i32 %91 to i64
  %93 = load i32** %3, align 8
  %94 = getelementptr inbounds i32* %93, i64 %92
  store i32 %90, i32* %94
  %95 = load i32* %temp, align 4
  %96 = load i32* %2, align 4
  %97 = sext i32 %96 to i64
  %98 = load i32** %3, align 8
  %99 = getelementptr inbounds i32* %98, i64 %97
  store i32 %95, i32* %99
  %100 = load i32* %1, align 4
  %101 = load i32* %i, align 4
  %102 = sub nsw i32 %101, 1
  %103 = load i32** %3, align 8
  call void @quicksort(i32 %100, i32 %102, i32* %103)
  %104 = load i32* %i, align 4
  %105 = add nsw i32 %104, 1
  %106 = load i32* %2, align 4
  %107 = load i32** %3, align 8
  call void @quicksort(i32 %105, i32 %106, i32* %107)
  br label %108

; <label>:108                                     ; preds = %80, %0
  ret void
}

define i32 @cmpint(i8* %i, i8* %j) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %3 = alloca i8*, align 8
  %vi = alloca i32, align 4
  %vj = alloca i32, align 4
  store i8* %i, i8** %2, align 8
  store i8* %j, i8** %3, align 8
  %4 = load i8** %2, align 8
  %5 = bitcast i8* %4 to i32*
  %6 = load i32* %5
  store i32 %6, i32* %vi, align 4
  %7 = load i8** %3, align 8
  %8 = bitcast i8* %7 to i32*
  %9 = load i32* %8
  store i32 %9, i32* %vj, align 4
  %10 = load i32* %vi, align 4
  %11 = load i32* %vj, align 4
  %12 = icmp eq i32 %10, %11
  br i1 %12, label %13, label %14

; <label>:13                                      ; preds = %0
  store i32 0, i32* %1
  br label %20

; <label>:14                                      ; preds = %0
  %15 = load i32* %vi, align 4
  %16 = load i32* %vj, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %19

; <label>:18                                      ; preds = %14
  store i32 -1, i32* %1
  br label %20

; <label>:19                                      ; preds = %14
  store i32 1, i32* %1
  br label %20

; <label>:20                                      ; preds = %19, %18, %13
  %21 = load i32* %1
  ret i32 %21
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %n = alloca i32, align 4
  %i = alloca i32, align 4
  %a = alloca i32*, align 8
  %b = alloca i32*, align 8
  %bench = alloca i32, align 4
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  store i32 0, i32* %bench, align 4
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
  store i32 1000000, i32* %n, align 4
  br label %12

; <label>:12                                      ; preds = %11, %6
  %13 = load i32* %2, align 4
  %14 = icmp sge i32 %13, 3
  br i1 %14, label %15, label %16

; <label>:15                                      ; preds = %12
  store i32 1, i32* %bench, align 4
  br label %16

; <label>:16                                      ; preds = %15, %12
  %17 = load i32* %n, align 4
  %18 = sext i32 %17 to i64
  %19 = mul i64 %18, 4
  %20 = call i8* @malloc(i64 %19)
  %21 = bitcast i8* %20 to i32*
  store i32* %21, i32** %a, align 8
  %22 = load i32* %n, align 4
  %23 = sext i32 %22 to i64
  %24 = mul i64 %23, 4
  %25 = call i8* @malloc(i64 %24)
  %26 = bitcast i8* %25 to i32*
  store i32* %26, i32** %b, align 8
  store i32 0, i32* %i, align 4
  br label %27

; <label>:27                                      ; preds = %42, %16
  %28 = load i32* %i, align 4
  %29 = load i32* %n, align 4
  %30 = icmp slt i32 %28, %29
  br i1 %30, label %31, label %45

; <label>:31                                      ; preds = %27
  %32 = call i32 @rand()
  %33 = and i32 %32, 65535
  %34 = load i32* %i, align 4
  %35 = sext i32 %34 to i64
  %36 = load i32** %a, align 8
  %37 = getelementptr inbounds i32* %36, i64 %35
  store i32 %33, i32* %37
  %38 = load i32* %i, align 4
  %39 = sext i32 %38 to i64
  %40 = load i32** %b, align 8
  %41 = getelementptr inbounds i32* %40, i64 %39
  store i32 %33, i32* %41
  br label %42

; <label>:42                                      ; preds = %31
  %43 = load i32* %i, align 4
  %44 = add nsw i32 %43, 1
  store i32 %44, i32* %i, align 4
  br label %27

; <label>:45                                      ; preds = %27
  %46 = load i32* %n, align 4
  %47 = sub nsw i32 %46, 1
  %48 = load i32** %a, align 8
  call void @quicksort(i32 0, i32 %47, i32* %48)
  %49 = load i32* %bench, align 4
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %80, label %51

; <label>:51                                      ; preds = %45
  %52 = load i32** %b, align 8
  %53 = bitcast i32* %52 to i8*
  %54 = load i32* %n, align 4
  %55 = sext i32 %54 to i64
  call void @qsort(i8* %53, i64 %55, i64 4, i32 (i8*, i8*)* @cmpint)
  store i32 0, i32* %i, align 4
  br label %56

; <label>:56                                      ; preds = %75, %51
  %57 = load i32* %i, align 4
  %58 = load i32* %n, align 4
  %59 = icmp slt i32 %57, %58
  br i1 %59, label %60, label %78

; <label>:60                                      ; preds = %56
  %61 = load i32* %i, align 4
  %62 = sext i32 %61 to i64
  %63 = load i32** %a, align 8
  %64 = getelementptr inbounds i32* %63, i64 %62
  %65 = load i32* %64
  %66 = load i32* %i, align 4
  %67 = sext i32 %66 to i64
  %68 = load i32** %b, align 8
  %69 = getelementptr inbounds i32* %68, i64 %67
  %70 = load i32* %69
  %71 = icmp ne i32 %65, %70
  br i1 %71, label %72, label %74

; <label>:72                                      ; preds = %60
  %73 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0))
  store i32 2, i32* %1
  br label %81

; <label>:74                                      ; preds = %60
  br label %75

; <label>:75                                      ; preds = %74
  %76 = load i32* %i, align 4
  %77 = add nsw i32 %76, 1
  store i32 %77, i32* %i, align 4
  br label %56

; <label>:78                                      ; preds = %56
  %79 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0))
  br label %80

; <label>:80                                      ; preds = %78, %45
  store i32 0, i32* %1
  br label %81

; <label>:81                                      ; preds = %80, %72
  %82 = load i32* %1
  ret i32 %82
}

declare i32 @atoi(i8*)

declare i8* @malloc(i64)

declare i32 @rand()

declare void @qsort(i8*, i64, i64, i32 (i8*, i8*)*)

declare i32 @printf(i8*, ...)
