; ModuleID = 'lists.c.pipeline.o'
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

; <label>:1                                       ; preds = %3, %0
  %r.0 = phi %struct.list* [ null, %0 ], [ %5, %3 ]
  %.0 = phi %struct.list* [ %l, %0 ], [ %11, %3 ]
  %2 = icmp ne %struct.list* %.0, null
  br i1 %2, label %3, label %12

; <label>:3                                       ; preds = %1
  %4 = call i8* @malloc(i64 16)
  %5 = bitcast i8* %4 to %struct.list*
  %6 = getelementptr inbounds %struct.list* %.0, i32 0, i32 0
  %7 = load i32* %6, align 4
  %8 = getelementptr inbounds %struct.list* %5, i32 0, i32 0
  store i32 %7, i32* %8, align 4
  %9 = getelementptr inbounds %struct.list* %5, i32 0, i32 1
  store %struct.list* %r.0, %struct.list** %9, align 8
  %10 = getelementptr inbounds %struct.list* %.0, i32 0, i32 1
  %11 = load %struct.list** %10, align 8
  br label %1

; <label>:12                                      ; preds = %1
  %r.0.lcssa = phi %struct.list* [ %r.0, %1 ]
  ret %struct.list* %r.0.lcssa
}

define %struct.list* @reverse_inplace(%struct.list* %l) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %3, %0
  %prev.0 = phi %struct.list* [ null, %0 ], [ %.0, %3 ]
  %.0 = phi %struct.list* [ %l, %0 ], [ %5, %3 ]
  %2 = icmp ne %struct.list* %.0, null
  br i1 %2, label %3, label %6

; <label>:3                                       ; preds = %1
  %4 = getelementptr inbounds %struct.list* %.0, i32 0, i32 1
  %5 = load %struct.list** %4, align 8
  store %struct.list* %prev.0, %struct.list** %4, align 8
  br label %1

; <label>:6                                       ; preds = %1
  %prev.0.lcssa = phi %struct.list* [ %prev.0, %1 ]
  ret %struct.list* %prev.0.lcssa
}

define i32 @checklist(i32 %n, %struct.list* %l) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %11, %0
  %.01 = phi %struct.list* [ %l, %0 ], [ %13, %11 ]
  %i.0 = phi i32 [ 0, %0 ], [ %14, %11 ]
  %2 = icmp sle i32 %i.0, %n
  br i1 %2, label %3, label %15

; <label>:3                                       ; preds = %1
  %4 = icmp eq %struct.list* %.01, null
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %3
  %.01.lcssa2 = phi %struct.list* [ %.01, %3 ]
  br label %18

; <label>:6                                       ; preds = %3
  %7 = getelementptr inbounds %struct.list* %.01, i32 0, i32 0
  %8 = load i32* %7, align 4
  %9 = icmp ne i32 %8, %i.0
  br i1 %9, label %10, label %11

; <label>:10                                      ; preds = %6
  %.01.lcssa1 = phi %struct.list* [ %.01, %6 ]
  br label %18

; <label>:11                                      ; preds = %6
  %12 = getelementptr inbounds %struct.list* %.01, i32 0, i32 1
  %13 = load %struct.list** %12, align 8
  %14 = add nsw i32 %i.0, 1
  br label %1

; <label>:15                                      ; preds = %1
  %.01.lcssa = phi %struct.list* [ %.01, %1 ]
  %16 = icmp eq %struct.list* %.01.lcssa, null
  %17 = zext i1 %16 to i32
  br label %18

; <label>:18                                      ; preds = %15, %10, %5
  %.0 = phi i32 [ 0, %5 ], [ 0, %10 ], [ %17, %15 ]
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
  br i1 %18, label %19, label %23

; <label>:19                                      ; preds = %14
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0))
  %21 = mul nsw i32 2, %niter.0
  %22 = add nsw i32 %21, 1
  br label %25

; <label>:23                                      ; preds = %14
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0))
  br label %37

; <label>:25                                      ; preds = %27, %19
  %i.0 = phi i32 [ 0, %19 ], [ %29, %27 ]
  %l.0 = phi %struct.list* [ %15, %19 ], [ %28, %27 ]
  %26 = icmp slt i32 %i.0, %22
  br i1 %26, label %27, label %30

; <label>:27                                      ; preds = %25
  %28 = call %struct.list* @reverse_inplace(%struct.list* %l.0)
  %29 = add nsw i32 %i.0, 1
  br label %25

; <label>:30                                      ; preds = %25
  %l.0.lcssa = phi %struct.list* [ %l.0, %25 ]
  %31 = call i32 @checklist(i32 %n.0, %struct.list* %l.0.lcssa)
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %33, label %35

; <label>:33                                      ; preds = %30
  %34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i32 0, i32 0))
  br label %37

; <label>:35                                      ; preds = %30
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i32 0, i32 0))
  br label %37

; <label>:37                                      ; preds = %35, %33, %23
  %.0 = phi i32 [ 0, %33 ], [ 2, %35 ], [ 2, %23 ]
  ret i32 %.0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)
