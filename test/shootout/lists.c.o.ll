; ModuleID = 'lists.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.list = type { i32, %struct.list* }

@.str = private constant [4 x i8] c"OK\0A\00"
@.str1 = private constant [6 x i8] c"Bug!\0A\00"

define %struct.list* @buildlist(i32 %n) nounwind ssp {
  %1 = alloca %struct.list*, align 8
  %2 = alloca i32, align 4
  %r = alloca %struct.list*, align 8
  store i32 %n, i32* %2, align 4
  %3 = load i32* %2, align 4
  %4 = icmp slt i32 %3, 0
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  store %struct.list* null, %struct.list** %1
  br label %18

; <label>:6                                       ; preds = %0
  %7 = call i8* @malloc(i64 16)
  %8 = bitcast i8* %7 to %struct.list*
  store %struct.list* %8, %struct.list** %r, align 8
  %9 = load i32* %2, align 4
  %10 = load %struct.list** %r, align 8
  %11 = getelementptr inbounds %struct.list* %10, i32 0, i32 0
  store i32 %9, i32* %11, align 4
  %12 = load i32* %2, align 4
  %13 = sub nsw i32 %12, 1
  %14 = call %struct.list* @buildlist(i32 %13)
  %15 = load %struct.list** %r, align 8
  %16 = getelementptr inbounds %struct.list* %15, i32 0, i32 1
  store %struct.list* %14, %struct.list** %16, align 8
  %17 = load %struct.list** %r, align 8
  store %struct.list* %17, %struct.list** %1
  br label %18

; <label>:18                                      ; preds = %6, %5
  %19 = load %struct.list** %1
  ret %struct.list* %19
}

declare i8* @malloc(i64)

define %struct.list* @reverselist(%struct.list* %l) nounwind ssp {
  %1 = alloca %struct.list*, align 8
  %r = alloca %struct.list*, align 8
  %r2 = alloca %struct.list*, align 8
  store %struct.list* %l, %struct.list** %1, align 8
  store %struct.list* null, %struct.list** %r, align 8
  br label %2

; <label>:2                                       ; preds = %17, %0
  %3 = load %struct.list** %1, align 8
  %4 = icmp ne %struct.list* %3, null
  br i1 %4, label %5, label %21

; <label>:5                                       ; preds = %2
  %6 = call i8* @malloc(i64 16)
  %7 = bitcast i8* %6 to %struct.list*
  store %struct.list* %7, %struct.list** %r2, align 8
  %8 = load %struct.list** %1, align 8
  %9 = getelementptr inbounds %struct.list* %8, i32 0, i32 0
  %10 = load i32* %9, align 4
  %11 = load %struct.list** %r2, align 8
  %12 = getelementptr inbounds %struct.list* %11, i32 0, i32 0
  store i32 %10, i32* %12, align 4
  %13 = load %struct.list** %r, align 8
  %14 = load %struct.list** %r2, align 8
  %15 = getelementptr inbounds %struct.list* %14, i32 0, i32 1
  store %struct.list* %13, %struct.list** %15, align 8
  %16 = load %struct.list** %r2, align 8
  store %struct.list* %16, %struct.list** %r, align 8
  br label %17

; <label>:17                                      ; preds = %5
  %18 = load %struct.list** %1, align 8
  %19 = getelementptr inbounds %struct.list* %18, i32 0, i32 1
  %20 = load %struct.list** %19, align 8
  store %struct.list* %20, %struct.list** %1, align 8
  br label %2

; <label>:21                                      ; preds = %2
  %22 = load %struct.list** %r, align 8
  ret %struct.list* %22
}

define %struct.list* @reverse_inplace(%struct.list* %l) nounwind ssp {
  %1 = alloca %struct.list*, align 8
  %prev = alloca %struct.list*, align 8
  %next = alloca %struct.list*, align 8
  store %struct.list* %l, %struct.list** %1, align 8
  store %struct.list* null, %struct.list** %prev, align 8
  br label %2

; <label>:2                                       ; preds = %5, %0
  %3 = load %struct.list** %1, align 8
  %4 = icmp ne %struct.list* %3, null
  br i1 %4, label %5, label %14

; <label>:5                                       ; preds = %2
  %6 = load %struct.list** %1, align 8
  %7 = getelementptr inbounds %struct.list* %6, i32 0, i32 1
  %8 = load %struct.list** %7, align 8
  store %struct.list* %8, %struct.list** %next, align 8
  %9 = load %struct.list** %prev, align 8
  %10 = load %struct.list** %1, align 8
  %11 = getelementptr inbounds %struct.list* %10, i32 0, i32 1
  store %struct.list* %9, %struct.list** %11, align 8
  %12 = load %struct.list** %1, align 8
  store %struct.list* %12, %struct.list** %prev, align 8
  %13 = load %struct.list** %next, align 8
  store %struct.list* %13, %struct.list** %1, align 8
  br label %2

; <label>:14                                      ; preds = %2
  %15 = load %struct.list** %prev, align 8
  ret %struct.list* %15
}

define i32 @checklist(i32 %n, %struct.list* %l) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca %struct.list*, align 8
  %i = alloca i32, align 4
  store i32 %n, i32* %2, align 4
  store %struct.list* %l, %struct.list** %3, align 8
  store i32 0, i32* %i, align 4
  br label %4

; <label>:4                                       ; preds = %23, %0
  %5 = load i32* %i, align 4
  %6 = load i32* %2, align 4
  %7 = icmp sle i32 %5, %6
  br i1 %7, label %8, label %26

; <label>:8                                       ; preds = %4
  %9 = load %struct.list** %3, align 8
  %10 = icmp eq %struct.list* %9, null
  br i1 %10, label %11, label %12

; <label>:11                                      ; preds = %8
  store i32 0, i32* %1
  br label %30

; <label>:12                                      ; preds = %8
  %13 = load %struct.list** %3, align 8
  %14 = getelementptr inbounds %struct.list* %13, i32 0, i32 0
  %15 = load i32* %14, align 4
  %16 = load i32* %i, align 4
  %17 = icmp ne i32 %15, %16
  br i1 %17, label %18, label %19

; <label>:18                                      ; preds = %12
  store i32 0, i32* %1
  br label %30

; <label>:19                                      ; preds = %12
  %20 = load %struct.list** %3, align 8
  %21 = getelementptr inbounds %struct.list* %20, i32 0, i32 1
  %22 = load %struct.list** %21, align 8
  store %struct.list* %22, %struct.list** %3, align 8
  br label %23

; <label>:23                                      ; preds = %19
  %24 = load i32* %i, align 4
  %25 = add nsw i32 %24, 1
  store i32 %25, i32* %i, align 4
  br label %4

; <label>:26                                      ; preds = %4
  %27 = load %struct.list** %3, align 8
  %28 = icmp eq %struct.list* %27, null
  %29 = zext i1 %28 to i32
  store i32 %29, i32* %1
  br label %30

; <label>:30                                      ; preds = %26, %18, %11
  %31 = load i32* %1
  ret i32 %31
}

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %n = alloca i32, align 4
  %niter = alloca i32, align 4
  %i = alloca i32, align 4
  %l = alloca %struct.list*, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
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
  store i32 1000, i32* %n, align 4
  br label %12

; <label>:12                                      ; preds = %11, %6
  %13 = load i32* %2, align 4
  %14 = icmp sge i32 %13, 3
  br i1 %14, label %15, label %20

; <label>:15                                      ; preds = %12
  %16 = load i8*** %3, align 8
  %17 = getelementptr inbounds i8** %16, i64 1
  %18 = load i8** %17
  %19 = call i32 @atoi(i8* %18)
  store i32 %19, i32* %niter, align 4
  br label %21

; <label>:20                                      ; preds = %12
  store i32 100000, i32* %niter, align 4
  br label %21

; <label>:21                                      ; preds = %20, %15
  %22 = load i32* %n, align 4
  %23 = call %struct.list* @buildlist(i32 %22)
  store %struct.list* %23, %struct.list** %l, align 8
  %24 = load i32* %n, align 4
  %25 = load %struct.list** %l, align 8
  %26 = call %struct.list* @reverselist(%struct.list* %25)
  %27 = call i32 @checklist(i32 %24, %struct.list* %26)
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %29, label %31

; <label>:29                                      ; preds = %21
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0))
  br label %33

; <label>:31                                      ; preds = %21
  %32 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0))
  store i32 2, i32* %1
  br label %56

; <label>:33                                      ; preds = %29
  store i32 0, i32* %i, align 4
  br label %34

; <label>:34                                      ; preds = %43, %33
  %35 = load i32* %i, align 4
  %36 = load i32* %niter, align 4
  %37 = mul nsw i32 2, %36
  %38 = add nsw i32 %37, 1
  %39 = icmp slt i32 %35, %38
  br i1 %39, label %40, label %46

; <label>:40                                      ; preds = %34
  %41 = load %struct.list** %l, align 8
  %42 = call %struct.list* @reverse_inplace(%struct.list* %41)
  store %struct.list* %42, %struct.list** %l, align 8
  br label %43

; <label>:43                                      ; preds = %40
  %44 = load i32* %i, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, i32* %i, align 4
  br label %34

; <label>:46                                      ; preds = %34
  %47 = load i32* %n, align 4
  %48 = load %struct.list** %l, align 8
  %49 = call i32 @checklist(i32 %47, %struct.list* %48)
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %51, label %53

; <label>:51                                      ; preds = %46
  %52 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0))
  br label %55

; <label>:53                                      ; preds = %46
  %54 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0))
  store i32 2, i32* %1
  br label %56

; <label>:55                                      ; preds = %51
  store i32 0, i32* %1
  br label %56

; <label>:56                                      ; preds = %55, %53, %31
  %57 = load i32* %1
  ret i32 %57
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)
