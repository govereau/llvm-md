; ModuleID = 'qsort.c.m2r.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [6 x i8] c"Bug!\0A\00"
@.str1 = private constant [4 x i8] c"OK\0A\00"

define void @quicksort(i32 %lo, i32 %hi, i32* %base) nounwind ssp {
  %1 = icmp slt i32 %lo, %hi
  br i1 %1, label %2, label %59

; <label>:2                                       ; preds = %0
  %3 = sext i32 %hi to i64
  %4 = getelementptr inbounds i32* %base, i64 %3
  %5 = load i32* %4
  br label %6

; <label>:6                                       ; preds = %45, %2
  %i.1 = phi i32 [ %lo, %2 ], [ %i.0, %45 ]
  %j.1 = phi i32 [ %hi, %2 ], [ %j.0, %45 ]
  %7 = icmp slt i32 %i.1, %j.1
  br i1 %7, label %8, label %46

; <label>:8                                       ; preds = %6
  br label %9

; <label>:9                                       ; preds = %18, %8
  %i.0 = phi i32 [ %i.1, %8 ], [ %19, %18 ]
  %10 = icmp slt i32 %i.0, %hi
  br i1 %10, label %11, label %16

; <label>:11                                      ; preds = %9
  %12 = sext i32 %i.0 to i64
  %13 = getelementptr inbounds i32* %base, i64 %12
  %14 = load i32* %13
  %15 = icmp sle i32 %14, %5
  br label %16

; <label>:16                                      ; preds = %11, %9
  %17 = phi i1 [ false, %9 ], [ %15, %11 ]
  br i1 %17, label %18, label %20

; <label>:18                                      ; preds = %16
  %19 = add nsw i32 %i.0, 1
  br label %9

; <label>:20                                      ; preds = %16
  br label %21

; <label>:21                                      ; preds = %30, %20
  %j.0 = phi i32 [ %j.1, %20 ], [ %31, %30 ]
  %22 = icmp sgt i32 %j.0, %lo
  br i1 %22, label %23, label %28

; <label>:23                                      ; preds = %21
  %24 = sext i32 %j.0 to i64
  %25 = getelementptr inbounds i32* %base, i64 %24
  %26 = load i32* %25
  %27 = icmp sge i32 %26, %5
  br label %28

; <label>:28                                      ; preds = %23, %21
  %29 = phi i1 [ false, %21 ], [ %27, %23 ]
  br i1 %29, label %30, label %32

; <label>:30                                      ; preds = %28
  %31 = add nsw i32 %j.0, -1
  br label %21

; <label>:32                                      ; preds = %28
  %33 = icmp slt i32 %i.0, %j.0
  br i1 %33, label %34, label %45

; <label>:34                                      ; preds = %32
  %35 = sext i32 %i.0 to i64
  %36 = getelementptr inbounds i32* %base, i64 %35
  %37 = load i32* %36
  %38 = sext i32 %j.0 to i64
  %39 = getelementptr inbounds i32* %base, i64 %38
  %40 = load i32* %39
  %41 = sext i32 %i.0 to i64
  %42 = getelementptr inbounds i32* %base, i64 %41
  store i32 %40, i32* %42
  %43 = sext i32 %j.0 to i64
  %44 = getelementptr inbounds i32* %base, i64 %43
  store i32 %37, i32* %44
  br label %45

; <label>:45                                      ; preds = %34, %32
  br label %6

; <label>:46                                      ; preds = %6
  %47 = sext i32 %i.1 to i64
  %48 = getelementptr inbounds i32* %base, i64 %47
  %49 = load i32* %48
  %50 = sext i32 %hi to i64
  %51 = getelementptr inbounds i32* %base, i64 %50
  %52 = load i32* %51
  %53 = sext i32 %i.1 to i64
  %54 = getelementptr inbounds i32* %base, i64 %53
  store i32 %52, i32* %54
  %55 = sext i32 %hi to i64
  %56 = getelementptr inbounds i32* %base, i64 %55
  store i32 %49, i32* %56
  %57 = sub nsw i32 %i.1, 1
  call void @quicksort(i32 %lo, i32 %57, i32* %base)
  %58 = add nsw i32 %i.1, 1
  call void @quicksort(i32 %58, i32 %hi, i32* %base)
  br label %59

; <label>:59                                      ; preds = %46, %0
  ret void
}

define i32 @cmpint(i8* %i, i8* %j) nounwind ssp {
  %1 = bitcast i8* %i to i32*
  %2 = load i32* %1
  %3 = bitcast i8* %j to i32*
  %4 = load i32* %3
  %5 = icmp eq i32 %2, %4
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %0
  br label %11

; <label>:7                                       ; preds = %0
  %8 = icmp slt i32 %2, %4
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %7
  br label %11

; <label>:10                                      ; preds = %7
  br label %11

; <label>:11                                      ; preds = %10, %9, %6
  %.0 = phi i32 [ 0, %6 ], [ -1, %9 ], [ 1, %10 ]
  ret i32 %.0
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = icmp sge i32 %argc, 2
  br i1 %1, label %2, label %6

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds i8** %argv, i64 1
  %4 = load i8** %3
  %5 = call i32 @atoi(i8* %4)
  br label %7

; <label>:6                                       ; preds = %0
  br label %7

; <label>:7                                       ; preds = %6, %2
  %n.0 = phi i32 [ %5, %2 ], [ 1000000, %6 ]
  %8 = icmp sge i32 %argc, 3
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %7
  br label %10

; <label>:10                                      ; preds = %9, %7
  %bench.0 = phi i32 [ 1, %9 ], [ 0, %7 ]
  %11 = sext i32 %n.0 to i64
  %12 = mul i64 %11, 4
  %13 = call i8* @malloc(i64 %12)
  %14 = bitcast i8* %13 to i32*
  %15 = sext i32 %n.0 to i64
  %16 = mul i64 %15, 4
  %17 = call i8* @malloc(i64 %16)
  %18 = bitcast i8* %17 to i32*
  br label %19

; <label>:19                                      ; preds = %28, %10
  %i.0 = phi i32 [ 0, %10 ], [ %29, %28 ]
  %20 = icmp slt i32 %i.0, %n.0
  br i1 %20, label %21, label %30

; <label>:21                                      ; preds = %19
  %22 = call i32 @rand()
  %23 = and i32 %22, 65535
  %24 = sext i32 %i.0 to i64
  %25 = getelementptr inbounds i32* %14, i64 %24
  store i32 %23, i32* %25
  %26 = sext i32 %i.0 to i64
  %27 = getelementptr inbounds i32* %18, i64 %26
  store i32 %23, i32* %27
  br label %28

; <label>:28                                      ; preds = %21
  %29 = add nsw i32 %i.0, 1
  br label %19

; <label>:30                                      ; preds = %19
  %31 = sub nsw i32 %n.0, 1
  call void @quicksort(i32 0, i32 %31, i32* %14)
  %32 = icmp ne i32 %bench.0, 0
  br i1 %32, label %53, label %33

; <label>:33                                      ; preds = %30
  %34 = bitcast i32* %18 to i8*
  %35 = sext i32 %n.0 to i64
  call void @qsort(i8* %34, i64 %35, i64 4, i32 (i8*, i8*)* @cmpint)
  br label %36

; <label>:36                                      ; preds = %49, %33
  %i.1 = phi i32 [ 0, %33 ], [ %50, %49 ]
  %37 = icmp slt i32 %i.1, %n.0
  br i1 %37, label %38, label %51

; <label>:38                                      ; preds = %36
  %39 = sext i32 %i.1 to i64
  %40 = getelementptr inbounds i32* %14, i64 %39
  %41 = load i32* %40
  %42 = sext i32 %i.1 to i64
  %43 = getelementptr inbounds i32* %18, i64 %42
  %44 = load i32* %43
  %45 = icmp ne i32 %41, %44
  br i1 %45, label %46, label %48

; <label>:46                                      ; preds = %38
  %47 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0))
  br label %54

; <label>:48                                      ; preds = %38
  br label %49

; <label>:49                                      ; preds = %48
  %50 = add nsw i32 %i.1, 1
  br label %36

; <label>:51                                      ; preds = %36
  %52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i32 0, i32 0))
  br label %53

; <label>:53                                      ; preds = %51, %30
  br label %54

; <label>:54                                      ; preds = %53, %46
  %.0 = phi i32 [ 0, %53 ], [ 2, %46 ]
  ret i32 %.0
}

declare i32 @atoi(i8*)

declare i8* @malloc(i64)

declare i32 @rand()

declare void @qsort(i8*, i64, i64, i32 (i8*, i8*)*)

declare i32 @printf(i8*, ...)
