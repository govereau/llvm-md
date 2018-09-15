; ModuleID = 'chomp.c.pipeline.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct._list = type { i32*, %struct._list* }
%struct._play = type { i32, i32*, %struct._list*, %struct._play* }

@ncol = common global i32 0, align 4
@nrow = common global i32 0, align 4
@game_tree = common global %struct._play* null, align 8
@.str = private constant [3 x i8] c"%d\00"
@.str1 = private constant [3 x i8] c")\0A\00"
@.str2 = private constant [13 x i8] c"For state :\0A\00"
@.str3 = private constant [14 x i8] c"  value = %d\0A\00"
@.str4 = private constant [20 x i8] c"We get, in order :\0A\00"
@wanted = common global %struct._list* null, align 8
@.str5 = private constant [28 x i8] c"player %d plays at (%d,%d)\0A\00"
@.str6 = private constant [17 x i8] c"player %d loses\0A\00"

define i32* @copy_data(i32* %data) nounwind ssp {
; <label>:0
  %1 = load i32* @ncol, align 4
  %2 = sext i32 %1 to i64
  %3 = mul i64 %2, 4
  %4 = call i8* @malloc(i64 %3)
  %5 = bitcast i8* %4 to i32*
  br label %6

; <label>:6                                       ; preds = %9, %0
  %counter.0 = phi i32 [ %1, %0 ], [ %7, %9 ]
  %7 = add nsw i32 %counter.0, -1
  %8 = icmp ne i32 %counter.0, 0
  br i1 %8, label %9, label %14

; <label>:9                                       ; preds = %6
  %10 = sext i32 %7 to i64
  %11 = getelementptr inbounds i32* %data, i64 %10
  %12 = load i32* %11
  %13 = getelementptr inbounds i32* %5, i64 %10
  store i32 %12, i32* %13
  br label %6

; <label>:14                                      ; preds = %6
  ret i32* %5
}

declare i8* @malloc(i64)

define i32 @next_data(i32* %data) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %19, %0
  %counter.1 = phi i32 [ 0, %0 ], [ %counter.0, %19 ]
  %valid.1 = phi i32 [ 0, %0 ], [ %valid.0, %19 ]
  %2 = load i32* @ncol, align 4
  %3 = icmp ne i32 %counter.1, %2
  br i1 %3, label %4, label %7

; <label>:4                                       ; preds = %1
  %5 = icmp ne i32 %valid.1, 0
  %6 = xor i1 %5, true
  br label %7

; <label>:7                                       ; preds = %4, %1
  %8 = phi i1 [ false, %1 ], [ %6, %4 ]
  br i1 %8, label %9, label %20

; <label>:9                                       ; preds = %7
  %10 = sext i32 %counter.1 to i64
  %11 = getelementptr inbounds i32* %data, i64 %10
  %12 = load i32* %11
  %13 = load i32* @nrow, align 4
  %14 = icmp eq i32 %12, %13
  br i1 %14, label %15, label %17

; <label>:15                                      ; preds = %9
  store i32 0, i32* %11
  %16 = add nsw i32 %counter.1, 1
  br label %19

; <label>:17                                      ; preds = %9
  %18 = add nsw i32 %12, 1
  store i32 %18, i32* %11
  br label %19

; <label>:19                                      ; preds = %17, %15
  %counter.0 = phi i32 [ %16, %15 ], [ %counter.1, %17 ]
  %valid.0 = phi i32 [ %valid.1, %15 ], [ 1, %17 ]
  br label %1

; <label>:20                                      ; preds = %7
  %valid.1.lcssa = phi i32 [ %valid.1, %7 ]
  ret i32 %valid.1.lcssa
}

define void @melt_data(i32* %data1, i32* %data2) nounwind ssp {
; <label>:0
  %1 = load i32* @ncol, align 4
  br label %2

; <label>:2                                       ; preds = %13, %0
  %counter.0 = phi i32 [ %1, %0 ], [ %3, %13 ]
  %3 = add nsw i32 %counter.0, -1
  %4 = icmp ne i32 %counter.0, 0
  br i1 %4, label %5, label %14

; <label>:5                                       ; preds = %2
  %6 = sext i32 %3 to i64
  %7 = getelementptr inbounds i32* %data1, i64 %6
  %8 = load i32* %7
  %9 = getelementptr inbounds i32* %data2, i64 %6
  %10 = load i32* %9
  %11 = icmp sgt i32 %8, %10
  br i1 %11, label %12, label %13

; <label>:12                                      ; preds = %5
  store i32 %10, i32* %7
  br label %13

; <label>:13                                      ; preds = %12, %5
  br label %2

; <label>:14                                      ; preds = %2
  ret void
}

define i32 @equal_data(i32* %data1, i32* %data2) nounwind ssp {
; <label>:0
  %1 = load i32* @ncol, align 4
  br label %2

; <label>:2                                       ; preds = %14, %0
  %counter.0 = phi i32 [ %1, %0 ], [ %3, %14 ]
  %3 = add nsw i32 %counter.0, -1
  %4 = icmp ne i32 %counter.0, 0
  br i1 %4, label %5, label %12

; <label>:5                                       ; preds = %2
  %6 = sext i32 %3 to i64
  %7 = getelementptr inbounds i32* %data1, i64 %6
  %8 = load i32* %7
  %9 = getelementptr inbounds i32* %data2, i64 %6
  %10 = load i32* %9
  %11 = icmp eq i32 %8, %10
  br label %12

; <label>:12                                      ; preds = %5, %2
  %13 = phi i1 [ false, %2 ], [ %11, %5 ]
  br i1 %13, label %14, label %15

; <label>:14                                      ; preds = %12
  br label %2

; <label>:15                                      ; preds = %12
  %.lcssa = phi i32 [ %3, %12 ]
  %16 = icmp slt i32 %.lcssa, 0
  %17 = zext i1 %16 to i32
  ret i32 %17
}

define i32 @valid_data(i32* %data) nounwind ssp {
; <label>:0
  %1 = load i32* @nrow, align 4
  %2 = load i32* @ncol, align 4
  br label %3

; <label>:3                                       ; preds = %11, %0
  %low.0 = phi i32 [ %1, %0 ], [ %8, %11 ]
  %counter.0 = phi i32 [ 0, %0 ], [ %12, %11 ]
  %4 = icmp ne i32 %counter.0, %2
  br i1 %4, label %5, label %.loopexit

; <label>:5                                       ; preds = %3
  %6 = sext i32 %counter.0 to i64
  %7 = getelementptr inbounds i32* %data, i64 %6
  %8 = load i32* %7
  %9 = icmp sgt i32 %8, %low.0
  br i1 %9, label %10, label %11

; <label>:10                                      ; preds = %5
  %counter.0.lcssa1 = phi i32 [ %counter.0, %5 ]
  br label %13

; <label>:11                                      ; preds = %5
  %12 = add nsw i32 %counter.0, 1
  br label %3

.loopexit:                                        ; preds = %3
  %counter.0.lcssa = phi i32 [ %counter.0, %3 ]
  br label %13

; <label>:13                                      ; preds = %.loopexit, %10
  %counter.02 = phi i32 [ %counter.0.lcssa, %.loopexit ], [ %counter.0.lcssa1, %10 ]
  %14 = icmp eq i32 %counter.02, %2
  %15 = zext i1 %14 to i32
  ret i32 %15
}

define void @dump_list(%struct._list* %list) nounwind ssp {
  %1 = icmp ne %struct._list* %list, null
  br i1 %1, label %2, label %9

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds %struct._list* %list, i32 0, i32 1
  %4 = load %struct._list** %3, align 8
  call void @dump_list(%struct._list* %4)
  %5 = getelementptr inbounds %struct._list* %list, i32 0, i32 0
  %6 = load i32** %5, align 8
  %7 = bitcast i32* %6 to i8*
  call void @free(i8* %7)
  %8 = bitcast %struct._list* %list to i8*
  call void @free(i8* %8)
  br label %9

; <label>:9                                       ; preds = %2, %0
  ret void
}

declare void @free(i8*)

define void @dump_play(%struct._play* %play) nounwind ssp {
  %1 = icmp ne %struct._play* %play, null
  br i1 %1, label %2, label %11

; <label>:2                                       ; preds = %0
  %3 = getelementptr inbounds %struct._play* %play, i32 0, i32 3
  %4 = load %struct._play** %3, align 8
  call void (...)* bitcast (void (%struct._play*)* @dump_play to void (...)*)(%struct._play* %4)
  %5 = getelementptr inbounds %struct._play* %play, i32 0, i32 2
  %6 = load %struct._list** %5, align 8
  call void @dump_list(%struct._list* %6)
  %7 = getelementptr inbounds %struct._play* %play, i32 0, i32 1
  %8 = load i32** %7, align 8
  %9 = bitcast i32* %8 to i8*
  call void @free(i8* %9)
  %10 = bitcast %struct._play* %play to i8*
  call void @free(i8* %10)
  br label %11

; <label>:11                                      ; preds = %2, %0
  ret void
}

define i32 @get_value(i32* %data) nounwind ssp {
; <label>:0
  %1 = load %struct._play** @game_tree, align 8
  br label %2

; <label>:2                                       ; preds = %8, %0
  %search.0 = phi %struct._play* [ %1, %0 ], [ %10, %8 ]
  %3 = getelementptr inbounds %struct._play* %search.0, i32 0, i32 1
  %4 = load i32** %3, align 8
  %5 = call i32 @equal_data(i32* %4, i32* %data)
  %6 = icmp ne i32 %5, 0
  %7 = xor i1 %6, true
  br i1 %7, label %8, label %11

; <label>:8                                       ; preds = %2
  %9 = getelementptr inbounds %struct._play* %search.0, i32 0, i32 3
  %10 = load %struct._play** %9, align 8
  br label %2

; <label>:11                                      ; preds = %2
  %search.0.lcssa = phi %struct._play* [ %search.0, %2 ]
  %12 = getelementptr inbounds %struct._play* %search.0.lcssa, i32 0, i32 0
  %13 = load i32* %12, align 4
  ret i32 %13
}

define void @show_data(i32* %data) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %14, %0
  %counter.0 = phi i32 [ 0, %0 ], [ %5, %14 ]
  %2 = load i32* @ncol, align 4
  %3 = icmp ne i32 %counter.0, %2
  br i1 %3, label %4, label %15

; <label>:4                                       ; preds = %1
  %5 = add nsw i32 %counter.0, 1
  %6 = sext i32 %counter.0 to i64
  %7 = getelementptr inbounds i32* %data, i64 %6
  %8 = load i32* %7
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32 %8)
  %10 = load i32* @ncol, align 4
  %11 = icmp ne i32 %5, %10
  br i1 %11, label %12, label %14

; <label>:12                                      ; preds = %4
  %13 = call i32 @putchar(i32 44)
  br label %14

; <label>:14                                      ; preds = %12, %4
  br label %1

; <label>:15                                      ; preds = %1
  ret void
}

declare i32 @printf(i8*, ...)

declare i32 @putchar(i32)

define void @show_move(i32* %data) nounwind ssp {
  %1 = call i32 @putchar(i32 40)
  call void @show_data(i32* %data)
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0))
  ret void
}

define void @show_list(%struct._list* %list) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %3, %0
  %.0 = phi %struct._list* [ %list, %0 ], [ %7, %3 ]
  %2 = icmp ne %struct._list* %.0, null
  br i1 %2, label %3, label %8

; <label>:3                                       ; preds = %1
  %4 = getelementptr inbounds %struct._list* %.0, i32 0, i32 0
  %5 = load i32** %4, align 8
  call void @show_move(i32* %5)
  %6 = getelementptr inbounds %struct._list* %.0, i32 0, i32 1
  %7 = load %struct._list** %6, align 8
  br label %1

; <label>:8                                       ; preds = %1
  ret void
}

define void @show_play(%struct._play* %play) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %3, %0
  %.0 = phi %struct._play* [ %play, %0 ], [ %14, %3 ]
  %2 = icmp ne %struct._play* %.0, null
  br i1 %2, label %3, label %15

; <label>:3                                       ; preds = %1
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str2, i32 0, i32 0))
  %5 = getelementptr inbounds %struct._play* %.0, i32 0, i32 1
  %6 = load i32** %5, align 8
  call void @show_data(i32* %6)
  %7 = getelementptr inbounds %struct._play* %.0, i32 0, i32 0
  %8 = load i32* %7, align 4
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str3, i32 0, i32 0), i32 %8)
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str4, i32 0, i32 0))
  %11 = getelementptr inbounds %struct._play* %.0, i32 0, i32 2
  %12 = load %struct._list** %11, align 8
  call void @show_list(%struct._list* %12)
  %13 = getelementptr inbounds %struct._play* %.0, i32 0, i32 3
  %14 = load %struct._play** %13, align 8
  br label %1

; <label>:15                                      ; preds = %1
  ret void
}

define i32 @in_wanted(i32* %data) nounwind ssp {
; <label>:0
  %1 = load %struct._list** @wanted, align 8
  br label %2

; <label>:2                                       ; preds = %10, %0
  %current.0 = phi %struct._list* [ %1, %0 ], [ %12, %10 ]
  %3 = icmp ne %struct._list* %current.0, null
  br i1 %3, label %4, label %.loopexit

; <label>:4                                       ; preds = %2
  %5 = getelementptr inbounds %struct._list* %current.0, i32 0, i32 0
  %6 = load i32** %5, align 8
  %7 = call i32 @equal_data(i32* %6, i32* %data)
  %8 = icmp ne i32 %7, 0
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %4
  %current.0.lcssa1 = phi %struct._list* [ %current.0, %4 ]
  br label %13

; <label>:10                                      ; preds = %4
  %11 = getelementptr inbounds %struct._list* %current.0, i32 0, i32 1
  %12 = load %struct._list** %11, align 8
  br label %2

.loopexit:                                        ; preds = %2
  %current.0.lcssa = phi %struct._list* [ %current.0, %2 ]
  br label %13

; <label>:13                                      ; preds = %.loopexit, %9
  %current.02 = phi %struct._list* [ %current.0.lcssa, %.loopexit ], [ %current.0.lcssa1, %9 ]
  %14 = icmp eq %struct._list* %current.02, null
  br i1 %14, label %15, label %16

; <label>:15                                      ; preds = %13
  br label %17

; <label>:16                                      ; preds = %13
  br label %17

; <label>:17                                      ; preds = %16, %15
  %.0 = phi i32 [ 0, %15 ], [ 1, %16 ]
  ret i32 %.0
}

define i32* @make_data(i32 %row, i32 %col) nounwind ssp {
; <label>:0
  %1 = load i32* @ncol, align 4
  %2 = sext i32 %1 to i64
  %3 = mul i64 %2, 4
  %4 = call i8* @malloc(i64 %3)
  %5 = bitcast i8* %4 to i32*
  br label %6

; <label>:6                                       ; preds = %8, %0
  %count.0 = phi i32 [ 0, %0 ], [ %12, %8 ]
  %7 = icmp ne i32 %count.0, %col
  br i1 %7, label %8, label %13

; <label>:8                                       ; preds = %6
  %9 = load i32* @nrow, align 4
  %10 = sext i32 %count.0 to i64
  %11 = getelementptr inbounds i32* %5, i64 %10
  store i32 %9, i32* %11
  %12 = add nsw i32 %count.0, 1
  br label %6

; <label>:13                                      ; preds = %6
  %count.0.lcssa = phi i32 [ %count.0, %6 ]
  br label %14

; <label>:14                                      ; preds = %17, %13
  %count.1 = phi i32 [ %count.0.lcssa, %13 ], [ %20, %17 ]
  %15 = load i32* @ncol, align 4
  %16 = icmp ne i32 %count.1, %15
  br i1 %16, label %17, label %21

; <label>:17                                      ; preds = %14
  %18 = sext i32 %count.1 to i64
  %19 = getelementptr inbounds i32* %5, i64 %18
  store i32 %row, i32* %19
  %20 = add nsw i32 %count.1, 1
  br label %14

; <label>:21                                      ; preds = %14
  ret i32* %5
}

define %struct._list* @make_list(i32* %data, i32* %value, i32* %all) nounwind ssp {
; <label>:0
  store i32 1, i32* %value
  %1 = call i8* @malloc(i64 16)
  %2 = bitcast i8* %1 to %struct._list*
  %3 = getelementptr inbounds %struct._list* %2, i32 0, i32 1
  store %struct._list* null, %struct._list** %3, align 8
  br label %4

; <label>:4                                       ; preds = %56, %0
  %row.3 = phi i32 [ 0, %0 ], [ %57, %56 ]
  %current.2 = phi %struct._list* [ %2, %0 ], [ %current.1.lcssa, %56 ]
  %5 = load i32* @nrow, align 4
  %6 = icmp ne i32 %row.3, %5
  br i1 %6, label %7, label %58

; <label>:7                                       ; preds = %4
  br label %8

; <label>:8                                       ; preds = %53, %7
  %row.2 = phi i32 [ %row.3, %7 ], [ %row.1, %53 ]
  %col.2 = phi i32 [ 0, %7 ], [ %55, %53 ]
  %current.1 = phi %struct._list* [ %current.2, %7 ], [ %current.0, %53 ]
  %9 = load i32* @ncol, align 4
  %10 = icmp ne i32 %col.2, %9
  br i1 %10, label %11, label %56

; <label>:11                                      ; preds = %8
  %12 = call i32* @make_data(i32 %row.2, i32 %col.2)
  call void @melt_data(i32* %12, i32* %data)
  %13 = call i32 @equal_data(i32* %12, i32* %data)
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %45, label %15

; <label>:15                                      ; preds = %11
  %16 = call i8* @malloc(i64 16)
  %17 = bitcast i8* %16 to %struct._list*
  %18 = getelementptr inbounds %struct._list* %current.1, i32 0, i32 1
  store %struct._list* %17, %struct._list** %18, align 8
  %19 = call i32* (...)* bitcast (i32* (i32*)* @copy_data to i32* (...)*)(i32* %12)
  %20 = load %struct._list** %18, align 8
  %21 = getelementptr inbounds %struct._list* %20, i32 0, i32 0
  store i32* %19, i32** %21, align 8
  %22 = load %struct._list** %18, align 8
  %23 = getelementptr inbounds %struct._list* %22, i32 0, i32 1
  store %struct._list* null, %struct._list** %23, align 8
  %24 = load %struct._list** %18, align 8
  %25 = load i32* %value
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %29

; <label>:27                                      ; preds = %15
  %28 = call i32 @get_value(i32* %12)
  store i32 %28, i32* %value
  br label %29

; <label>:29                                      ; preds = %27, %15
  %30 = phi i32 [ %28, %27 ], [ %25, %15 ]
  %31 = load i32* %all
  %32 = icmp ne i32 %31, 0
  br i1 %32, label %44, label %33

; <label>:33                                      ; preds = %29
  %34 = icmp eq i32 %30, 0
  br i1 %34, label %35, label %44

; <label>:35                                      ; preds = %33
  %36 = load i32* @ncol, align 4
  %37 = sub nsw i32 %36, 1
  %38 = load i32* @nrow, align 4
  %39 = sub nsw i32 %38, 1
  %40 = call i32 @in_wanted(i32* %12)
  %41 = icmp ne i32 %40, 0
  br i1 %41, label %42, label %43

; <label>:42                                      ; preds = %35
  store i32 2, i32* %all
  br label %43

; <label>:43                                      ; preds = %42, %35
  br label %44

; <label>:44                                      ; preds = %43, %33, %29
  %row.0 = phi i32 [ %row.2, %29 ], [ %39, %43 ], [ %row.2, %33 ]
  %col.0 = phi i32 [ %col.2, %29 ], [ %37, %43 ], [ %col.2, %33 ]
  br label %53

; <label>:45                                      ; preds = %11
  %46 = icmp eq i32 %col.2, 0
  br i1 %46, label %47, label %50

; <label>:47                                      ; preds = %45
  %48 = load i32* @nrow, align 4
  %49 = sub nsw i32 %48, 1
  br label %50

; <label>:50                                      ; preds = %47, %45
  %row.4 = phi i32 [ %49, %47 ], [ %row.2, %45 ]
  %51 = load i32* @ncol, align 4
  %52 = sub nsw i32 %51, 1
  br label %53

; <label>:53                                      ; preds = %50, %44
  %row.1 = phi i32 [ %row.4, %50 ], [ %row.0, %44 ]
  %col.1 = phi i32 [ %52, %50 ], [ %col.0, %44 ]
  %current.0 = phi %struct._list* [ %current.1, %50 ], [ %24, %44 ]
  %54 = bitcast i32* %12 to i8*
  call void @free(i8* %54)
  %55 = add nsw i32 %col.1, 1
  br label %8

; <label>:56                                      ; preds = %8
  %current.1.lcssa = phi %struct._list* [ %current.1, %8 ]
  %row.2.lcssa = phi i32 [ %row.2, %8 ]
  %57 = add nsw i32 %row.2.lcssa, 1
  br label %4

; <label>:58                                      ; preds = %4
  %59 = load %struct._list** %3, align 8
  %60 = bitcast %struct._list* %2 to i8*
  call void @free(i8* %60)
  %61 = icmp ne %struct._list* %59, null
  br i1 %61, label %62, label %65

; <label>:62                                      ; preds = %58
  %63 = load i32* %value
  %64 = sub nsw i32 1, %63
  store i32 %64, i32* %value
  br label %65

; <label>:65                                      ; preds = %62, %58
  ret %struct._list* %59
}

define %struct._play* @make_play(i32 %all) nounwind ssp {
; <label>:0
  %1 = alloca i32, align 4
  %val = alloca i32, align 4
  store i32 %all, i32* %1, align 4
  %2 = call i8* @malloc(i64 32)
  %3 = bitcast i8* %2 to %struct._play*
  store %struct._play* null, %struct._play** @game_tree, align 8
  %4 = call i32* @make_data(i32 0, i32 0)
  %5 = getelementptr inbounds i32* %4, i64 0
  %6 = load i32* %5
  %7 = add nsw i32 %6, -1
  store i32 %7, i32* %5
  br label %8

; <label>:8                                       ; preds = %42, %0
  %current.1 = phi %struct._play* [ %3, %0 ], [ %current.0, %42 ]
  %temp.2 = phi i32* [ %4, %0 ], [ %temp.1, %42 ]
  %9 = call i32 @next_data(i32* %temp.2)
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %43

; <label>:11                                      ; preds = %8
  %12 = call i32 @valid_data(i32* %temp.2)
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %42

; <label>:14                                      ; preds = %11
  %15 = call i8* @malloc(i64 32)
  %16 = bitcast i8* %15 to %struct._play*
  %17 = getelementptr inbounds %struct._play* %current.1, i32 0, i32 3
  store %struct._play* %16, %struct._play** %17, align 8
  %18 = load %struct._play** @game_tree, align 8
  %19 = icmp eq %struct._play* %18, null
  br i1 %19, label %20, label %21

; <label>:20                                      ; preds = %14
  store %struct._play* %16, %struct._play** @game_tree, align 8
  br label %21

; <label>:21                                      ; preds = %20, %14
  %22 = call i32* (...)* bitcast (i32* (i32*)* @copy_data to i32* (...)*)(i32* %temp.2)
  %23 = load %struct._play** %17, align 8
  %24 = getelementptr inbounds %struct._play* %23, i32 0, i32 1
  store i32* %22, i32** %24, align 8
  %25 = call %struct._list* @make_list(i32* %temp.2, i32* %val, i32* %1)
  %26 = load %struct._play** %17, align 8
  %27 = getelementptr inbounds %struct._play* %26, i32 0, i32 2
  store %struct._list* %25, %struct._list** %27, align 8
  %28 = load i32* %val, align 4
  %29 = load %struct._play** %17, align 8
  %30 = getelementptr inbounds %struct._play* %29, i32 0, i32 0
  store i32 %28, i32* %30, align 4
  %31 = load %struct._play** %17, align 8
  %32 = getelementptr inbounds %struct._play* %31, i32 0, i32 3
  store %struct._play* null, %struct._play** %32, align 8
  %33 = load %struct._play** %17, align 8
  %34 = load i32* %1, align 4
  %35 = icmp eq i32 %34, 2
  br i1 %35, label %36, label %41

; <label>:36                                      ; preds = %21
  %37 = bitcast i32* %temp.2 to i8*
  call void @free(i8* %37)
  %38 = load i32* @nrow, align 4
  %39 = load i32* @ncol, align 4
  %40 = call i32* @make_data(i32 %38, i32 %39)
  br label %41

; <label>:41                                      ; preds = %36, %21
  %temp.0 = phi i32* [ %40, %36 ], [ %temp.2, %21 ]
  br label %42

; <label>:42                                      ; preds = %41, %11
  %current.0 = phi %struct._play* [ %33, %41 ], [ %current.1, %11 ]
  %temp.1 = phi i32* [ %temp.0, %41 ], [ %temp.2, %11 ]
  br label %8

; <label>:43                                      ; preds = %8
  %44 = getelementptr inbounds %struct._play* %3, i32 0, i32 3
  %45 = load %struct._play** %44, align 8
  %46 = bitcast %struct._play* %3 to i8*
  call void @free(i8* %46)
  ret %struct._play* %45
}

define void @make_wanted(i32* %data) nounwind ssp {
; <label>:0
  %1 = call i8* @malloc(i64 16)
  %2 = bitcast i8* %1 to %struct._list*
  %3 = getelementptr inbounds %struct._list* %2, i32 0, i32 1
  store %struct._list* null, %struct._list** %3, align 8
  br label %4

; <label>:4                                       ; preds = %36, %0
  %row.3 = phi i32 [ 0, %0 ], [ %37, %36 ]
  %current.2 = phi %struct._list* [ %2, %0 ], [ %current.1.lcssa, %36 ]
  %5 = load i32* @nrow, align 4
  %6 = icmp ne i32 %row.3, %5
  br i1 %6, label %7, label %38

; <label>:7                                       ; preds = %4
  br label %8

; <label>:8                                       ; preds = %33, %7
  %col.1 = phi i32 [ 0, %7 ], [ %35, %33 ]
  %row.2 = phi i32 [ %row.3, %7 ], [ %row.1, %33 ]
  %current.1 = phi %struct._list* [ %current.2, %7 ], [ %current.0, %33 ]
  %9 = load i32* @ncol, align 4
  %10 = icmp ne i32 %col.1, %9
  br i1 %10, label %11, label %36

; <label>:11                                      ; preds = %8
  %12 = call i32* @make_data(i32 %row.2, i32 %col.1)
  call void @melt_data(i32* %12, i32* %data)
  %13 = call i32 @equal_data(i32* %12, i32* %data)
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %25, label %15

; <label>:15                                      ; preds = %11
  %16 = call i8* @malloc(i64 16)
  %17 = bitcast i8* %16 to %struct._list*
  %18 = getelementptr inbounds %struct._list* %current.1, i32 0, i32 1
  store %struct._list* %17, %struct._list** %18, align 8
  %19 = call i32* (...)* bitcast (i32* (i32*)* @copy_data to i32* (...)*)(i32* %12)
  %20 = load %struct._list** %18, align 8
  %21 = getelementptr inbounds %struct._list* %20, i32 0, i32 0
  store i32* %19, i32** %21, align 8
  %22 = load %struct._list** %18, align 8
  %23 = getelementptr inbounds %struct._list* %22, i32 0, i32 1
  store %struct._list* null, %struct._list** %23, align 8
  %24 = load %struct._list** %18, align 8
  br label %33

; <label>:25                                      ; preds = %11
  %26 = icmp eq i32 %col.1, 0
  br i1 %26, label %27, label %30

; <label>:27                                      ; preds = %25
  %28 = load i32* @nrow, align 4
  %29 = sub nsw i32 %28, 1
  br label %30

; <label>:30                                      ; preds = %27, %25
  %row.0 = phi i32 [ %29, %27 ], [ %row.2, %25 ]
  %31 = load i32* @ncol, align 4
  %32 = sub nsw i32 %31, 1
  br label %33

; <label>:33                                      ; preds = %30, %15
  %col.0 = phi i32 [ %32, %30 ], [ %col.1, %15 ]
  %row.1 = phi i32 [ %row.0, %30 ], [ %row.2, %15 ]
  %current.0 = phi %struct._list* [ %current.1, %30 ], [ %24, %15 ]
  %34 = bitcast i32* %12 to i8*
  call void @free(i8* %34)
  %35 = add nsw i32 %col.0, 1
  br label %8

; <label>:36                                      ; preds = %8
  %current.1.lcssa = phi %struct._list* [ %current.1, %8 ]
  %row.2.lcssa = phi i32 [ %row.2, %8 ]
  %37 = add nsw i32 %row.2.lcssa, 1
  br label %4

; <label>:38                                      ; preds = %4
  %39 = load %struct._list** %3, align 8
  %40 = bitcast %struct._list* %2 to i8*
  call void @free(i8* %40)
  store %struct._list* %39, %struct._list** @wanted, align 8
  ret void
}

define i32* @get_good_move(%struct._list* %list) nounwind ssp {
  %1 = icmp eq %struct._list* %list, null
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  br label %21

; <label>:3                                       ; preds = %0
  br label %4

; <label>:4                                       ; preds = %15, %3
  %.01 = phi %struct._list* [ %list, %3 ], [ %16, %15 ]
  %5 = getelementptr inbounds %struct._list* %.01, i32 0, i32 1
  %6 = load %struct._list** %5, align 8
  %7 = icmp ne %struct._list* %6, null
  br i1 %7, label %8, label %13

; <label>:8                                       ; preds = %4
  %9 = getelementptr inbounds %struct._list* %.01, i32 0, i32 0
  %10 = load i32** %9, align 8
  %11 = call i32 @get_value(i32* %10)
  %12 = icmp ne i32 %11, 0
  br label %13

; <label>:13                                      ; preds = %8, %4
  %14 = phi i1 [ false, %4 ], [ %12, %8 ]
  br i1 %14, label %15, label %17

; <label>:15                                      ; preds = %13
  %16 = load %struct._list** %5, align 8
  br label %4

; <label>:17                                      ; preds = %13
  %.01.lcssa = phi %struct._list* [ %.01, %13 ]
  %18 = getelementptr inbounds %struct._list* %.01.lcssa, i32 0, i32 0
  %19 = load i32** %18, align 8
  %20 = call i32* (...)* bitcast (i32* (i32*)* @copy_data to i32* (...)*)(i32* %19)
  br label %21

; <label>:21                                      ; preds = %17, %2
  %.0 = phi i32* [ null, %2 ], [ %20, %17 ]
  ret i32* %.0
}

define i32* @get_winning_move(%struct._play* %play) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %5, %0
  %.0 = phi %struct._play* [ %play, %0 ], [ %3, %5 ]
  %2 = getelementptr inbounds %struct._play* %.0, i32 0, i32 3
  %3 = load %struct._play** %2, align 8
  %4 = icmp ne %struct._play* %3, null
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %1
  br label %1

; <label>:6                                       ; preds = %1
  %.0.lcssa = phi %struct._play* [ %.0, %1 ]
  %7 = getelementptr inbounds %struct._play* %.0.lcssa, i32 0, i32 2
  %8 = load %struct._list** %7, align 8
  %9 = call i32* @get_good_move(%struct._list* %8)
  ret i32* %9
}

define %struct._list* @where(i32* %data, %struct._play* %play) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %7, %0
  %.0 = phi %struct._play* [ %play, %0 ], [ %9, %7 ]
  %2 = getelementptr inbounds %struct._play* %.0, i32 0, i32 1
  %3 = load i32** %2, align 8
  %4 = call i32 @equal_data(i32* %3, i32* %data)
  %5 = icmp ne i32 %4, 0
  %6 = xor i1 %5, true
  br i1 %6, label %7, label %10

; <label>:7                                       ; preds = %1
  %8 = getelementptr inbounds %struct._play* %.0, i32 0, i32 3
  %9 = load %struct._play** %8, align 8
  br label %1

; <label>:10                                      ; preds = %1
  %.0.lcssa = phi %struct._play* [ %.0, %1 ]
  %11 = getelementptr inbounds %struct._play* %.0.lcssa, i32 0, i32 2
  %12 = load %struct._list** %11, align 8
  ret %struct._list* %12
}

define void @get_real_move(i32* %data1, i32* %data2, i32* %row, i32* %col) nounwind ssp {
; <label>:0
  store i32 0, i32* %col
  br label %1

; <label>:1                                       ; preds = %9, %0
  %2 = phi i32 [ %10, %9 ], [ 0, %0 ]
  %3 = sext i32 %2 to i64
  %4 = getelementptr inbounds i32* %data1, i64 %3
  %5 = load i32* %4
  %6 = getelementptr inbounds i32* %data2, i64 %3
  %7 = load i32* %6
  %8 = icmp eq i32 %5, %7
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %1
  %10 = add nsw i32 %2, 1
  store i32 %10, i32* %col
  br label %1

; <label>:11                                      ; preds = %1
  %.lcssa = phi i32 [ %5, %1 ]
  store i32 %.lcssa, i32* %row
  ret void
}

define i32 @main() nounwind ssp {
; <label>:0
  %row = alloca i32, align 4
  %col = alloca i32, align 4
  store i32 7, i32* @ncol, align 4
  store i32 8, i32* @nrow, align 4
  %1 = call %struct._play* @make_play(i32 1)
  %2 = load i32* @nrow, align 4
  %3 = load i32* @ncol, align 4
  %4 = call i32* @make_data(i32 %2, i32 %3)
  br label %5

; <label>:5                                       ; preds = %17, %0
  %player.1 = phi i32 [ 0, %0 ], [ %player.0, %17 ]
  %current.0 = phi i32* [ %4, %0 ], [ %9, %17 ]
  %6 = icmp ne i32* %current.0, null
  br i1 %6, label %7, label %18

; <label>:7                                       ; preds = %5
  %8 = call %struct._list* @where(i32* %current.0, %struct._play* %1)
  %9 = call i32* @get_good_move(%struct._list* %8)
  %10 = icmp ne i32* %9, null
  br i1 %10, label %11, label %17

; <label>:11                                      ; preds = %7
  call void @get_real_move(i32* %9, i32* %current.0, i32* %row, i32* %col)
  %12 = load i32* %row, align 4
  %13 = load i32* %col, align 4
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([28 x i8]* @.str5, i32 0, i32 0), i32 %player.1, i32 %12, i32 %13)
  %15 = sub nsw i32 1, %player.1
  %16 = bitcast i32* %current.0 to i8*
  call void @free(i8* %16)
  br label %17

; <label>:17                                      ; preds = %11, %7
  %player.0 = phi i32 [ %15, %11 ], [ %player.1, %7 ]
  br label %5

; <label>:18                                      ; preds = %5
  %player.1.lcssa = phi i32 [ %player.1, %5 ]
  call void (...)* bitcast (void (%struct._play*)* @dump_play to void (...)*)(%struct._play* %1)
  %19 = sub nsw i32 1, %player.1.lcssa
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str6, i32 0, i32 0), i32 %19)
  ret i32 0
}
