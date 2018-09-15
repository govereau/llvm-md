; ModuleID = 'lists.c.m2r.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.list = type { i32, %struct.list* }

@.str = private constant [4 x i8] c"OK\0A\00"
@.str1 = private constant [6 x i8] c"Bug!\0A\00"

define %struct.list* @buildlist(i32 %n) nounwind ssp {
  %1 = icmp slt i32 %n, 0
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  br label %10

; <label>:3                                       ; preds = %0
  %4 = call i8* @malloc(i64 16)
  %5 = bitcast i8* %4 to %struct.list*
  %6 = getelementptr inbounds %struct.list* %5, i32 0, i32 0
  store i32 %n, i32* %6, align 4
  %7 = sub nsw i32 %n, 1
  %8 = call %struct.list* @buildlist(i32 %7)
  %9 = getelementptr inbounds %struct.list* %5, i32 0, i32 1
  store %struct.list* %8, %struct.list** %9, align 8
  br label %10

; <label>:10                                      ; preds = %3, %2
  %.0 = phi %struct.list* [ null, %2 ], [ %5, %3 ]
  ret %struct.list* %.0
}

declare i8* @malloc(i64)

define %struct.list* @reverselist(%struct.list* %l) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %10, %0
  %r.0 = phi %struct.list* [ null, %0 ], [ %5, %10 ]
  %.0 = phi %struct.list* [ %l, %0 ], [ %12, %10 ]
  %2 = icmp ne %struct.list* %.0, null
  br i1 %2, label %3, label %13

; <label>:3                                       ; preds = %1
  %4 = call i8* @malloc(i64 16)
  %5 = bitcast i8* %4 to %struct.list*
  %6 = getelementptr inbounds %struct.list* %.0, i32 0, i32 0
  %7 = load i32* %6, align 4
  %8 = getelementptr inbounds %struct.list* %5, i32 0, i32 0
  store i32 %7, i32* %8, align 4
  %9 = getelementptr inbounds %struct.list* %5, i32 0, i32 1
  store %struct.list* %r.0, %struct.list** %9, align 8
  br label %10

; <label>:10                                      ; preds = %3
  %11 = getelementptr inbounds %struct.list* %.0, i32 0, i32 1
  %12 = load %struct.list** %11, align 8
  br label %1

; <label>:13                                      ; preds = %1
  ret %struct.list* %r.0
}

define %struct.list* @reverse_inplace(%struct.list* %l) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %3, %0
  %prev.0 = phi %struct.list* [ null, %0 ], [ %.0, %3 ]
  %.0 = phi %struct.list* [ %l, %0 ], [ %5, %3 ]
  %2 = icmp ne %struct.list* %.0, null
  br i1 %2, label %3, label %7

; <label>:3                                       ; preds = %1
  %4 = getelementptr inbounds %struct.list* %.0, i32 0, i32 1
  %5 = load %struct.list** %4, align 8
  %6 = getelementptr inbounds %struct.list* %.0, i32 0, i32 1
  store %struct.list* %prev.0, %struct.list** %6, align 8
  br label %1

; <label>:7                                       ; preds = %1
  ret %struct.list* %prev.0
}

define i32 @checklist(i32 %n, %struct.list* %l) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %14, %0
  %.01 = phi %struct.list* [ %l, %0 ], [ %13, %14 ]
  %i.0 = phi i32 [ 0, %0 ], [ %15, %14 ]
  %2 = icmp sle i32 %i.0, %n
  br i1 %2, label %3, label %16

; <label>:3                                       ; preds = %1
  %4 = icmp eq %struct.list* %.01, null
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %3
  br label %19

; <label>:6                                       ; preds = %3
  %7 = getelementptr inbounds %struct.list* %.01, i32 0, i32 0
  %8 = load i32* %7, align 4
  %9 = icmp ne i32 %8, %i.0
  br i1 %9, label %10, label %11

; <label>:10                                      ; preds = %6
  br label %19

; <label>:11                                      ; preds = %6
  %12 = getelementptr inbounds %struct.list* %.01, i32 0, i32 1
  %13 = load %struct.list** %12, align 8
  br label %14

; <label>:14                                      ; preds = %11
  %15 = add nsw i32 %i.0, 1
  br label %1

; <label>:16                                      ; preds = %1
  %17 = icmp eq %struct.list* %.01, null
  %18 = zext i1 %17 to i32
  br label %19

; <label>:19                                      ; preds = %16, %10, %5
  %.0 = phi i32 [ 0, %5 ], [ 0, %10 ], [ %18, %16 ]
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
  %n.0 = phi i32 [ %5, %2 ], [ 1000, %6 ]
  %8 = icmp sge i32 %argc, 3
  br i1 %8, label %9, label %13

; <label>:9                                       ; preds = %7
  %10 = getelementptr inbounds i8** %argv, i64 1
  %11 = load i8** %10
  %12 = call i32 @atoi(i8* %11)
  br label %14

; <label>:13                                      ; preds = %7
  br label %14

; <label>:14                                      ; preds = %13, %9
  %niter.0 = phi i32 [ %12, %9 ], [ 100000, %13 ]
  %15 = call %struct.list* @buildlist(i32 %n.0)
  %16 = call %struct.list* @reverselist(%struct.list* %15)
  %17 = call i32 @checklist(i32 %n.0, %struct.list* %16)
  %18 = icmp ne i32 %17, 0
  br i1 %18, label %19, label %21

; <label>:19                                      ; preds = %14
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0))
  br label %23

; <label>:21                                      ; preds = %14
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0))
  br label %40

; <label>:23                                      ; preds = %19
  br label %24

; <label>:24                                      ; preds = %30, %23
  %i.0 = phi i32 [ 0, %23 ], [ %31, %30 ]
  %l.0 = phi %struct.list* [ %15, %23 ], [ %29, %30 ]
  %25 = mul nsw i32 2, %niter.0
  %26 = add nsw i32 %25, 1
  %27 = icmp slt i32 %i.0, %26
  br i1 %27, label %28, label %32

; <label>:28                                      ; preds = %24
  %29 = call %struct.list* @reverse_inplace(%struct.list* %l.0)
  br label %30

; <label>:30                                      ; preds = %28
  %31 = add nsw i32 %i.0, 1
  br label %24

; <label>:32                                      ; preds = %24
  %33 = call i32 @checklist(i32 %n.0, %struct.list* %l.0)
  %34 = icmp ne i32 %33, 0
  br i1 %34, label %35, label %37

; <label>:35                                      ; preds = %32
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0))
  br label %39

; <label>:37                                      ; preds = %32
  %38 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0))
  br label %40

; <label>:39                                      ; preds = %35
  br label %40

; <label>:40                                      ; preds = %39, %37, %21
  %.0 = phi i32 [ 0, %39 ], [ 2, %37 ], [ 2, %21 ]
  ret i32 %.0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)
