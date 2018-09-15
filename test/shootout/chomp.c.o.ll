; ModuleID = 'chomp.c.o'
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
  %1 = alloca i32*, align 8
  %new = alloca i32*, align 8
  %counter = alloca i32, align 4
  store i32* %data, i32** %1, align 8
  %2 = load i32* @ncol, align 4
  %3 = sext i32 %2 to i64
  %4 = mul i64 %3, 4
  %5 = call i8* @malloc(i64 %4)
  %6 = bitcast i8* %5 to i32*
  store i32* %6, i32** %new, align 8
  %7 = load i32* @ncol, align 4
  store i32 %7, i32* %counter, align 4
  br label %8

; <label>:8                                       ; preds = %12, %0
  %9 = load i32* %counter, align 4
  %10 = add nsw i32 %9, -1
  store i32 %10, i32* %counter, align 4
  %11 = icmp ne i32 %9, 0
  br i1 %11, label %12, label %22

; <label>:12                                      ; preds = %8
  %13 = load i32* %counter, align 4
  %14 = sext i32 %13 to i64
  %15 = load i32** %1, align 8
  %16 = getelementptr inbounds i32* %15, i64 %14
  %17 = load i32* %16
  %18 = load i32* %counter, align 4
  %19 = sext i32 %18 to i64
  %20 = load i32** %new, align 8
  %21 = getelementptr inbounds i32* %20, i64 %19
  store i32 %17, i32* %21
  br label %8

; <label>:22                                      ; preds = %8
  %23 = load i32** %new, align 8
  ret i32* %23
}

declare i8* @malloc(i64)

define i32 @next_data(i32* %data) nounwind ssp {
  %1 = alloca i32*, align 8
  %counter = alloca i32, align 4
  %valid = alloca i32, align 4
  store i32* %data, i32** %1, align 8
  store i32 0, i32* %counter, align 4
  store i32 0, i32* %valid, align 4
  br label %2

; <label>:2                                       ; preds = %34, %0
  %3 = load i32* %counter, align 4
  %4 = load i32* @ncol, align 4
  %5 = icmp ne i32 %3, %4
  br i1 %5, label %6, label %10

; <label>:6                                       ; preds = %2
  %7 = load i32* %valid, align 4
  %8 = icmp ne i32 %7, 0
  %9 = xor i1 %8, true
  br label %10

; <label>:10                                      ; preds = %6, %2
  %11 = phi i1 [ false, %2 ], [ %9, %6 ]
  br i1 %11, label %12, label %35

; <label>:12                                      ; preds = %10
  %13 = load i32* %counter, align 4
  %14 = sext i32 %13 to i64
  %15 = load i32** %1, align 8
  %16 = getelementptr inbounds i32* %15, i64 %14
  %17 = load i32* %16
  %18 = load i32* @nrow, align 4
  %19 = icmp eq i32 %17, %18
  br i1 %19, label %20, label %27

; <label>:20                                      ; preds = %12
  %21 = load i32* %counter, align 4
  %22 = sext i32 %21 to i64
  %23 = load i32** %1, align 8
  %24 = getelementptr inbounds i32* %23, i64 %22
  store i32 0, i32* %24
  %25 = load i32* %counter, align 4
  %26 = add nsw i32 %25, 1
  store i32 %26, i32* %counter, align 4
  br label %34

; <label>:27                                      ; preds = %12
  %28 = load i32* %counter, align 4
  %29 = sext i32 %28 to i64
  %30 = load i32** %1, align 8
  %31 = getelementptr inbounds i32* %30, i64 %29
  %32 = load i32* %31
  %33 = add nsw i32 %32, 1
  store i32 %33, i32* %31
  store i32 1, i32* %valid, align 4
  br label %34

; <label>:34                                      ; preds = %27, %20
  br label %2

; <label>:35                                      ; preds = %10
  %36 = load i32* %valid, align 4
  ret i32 %36
}

define void @melt_data(i32* %data1, i32* %data2) nounwind ssp {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %counter = alloca i32, align 4
  store i32* %data1, i32** %1, align 8
  store i32* %data2, i32** %2, align 8
  %3 = load i32* @ncol, align 4
  store i32 %3, i32* %counter, align 4
  br label %4

; <label>:4                                       ; preds = %30, %0
  %5 = load i32* %counter, align 4
  %6 = add nsw i32 %5, -1
  store i32 %6, i32* %counter, align 4
  %7 = icmp ne i32 %5, 0
  br i1 %7, label %8, label %31

; <label>:8                                       ; preds = %4
  %9 = load i32* %counter, align 4
  %10 = sext i32 %9 to i64
  %11 = load i32** %1, align 8
  %12 = getelementptr inbounds i32* %11, i64 %10
  %13 = load i32* %12
  %14 = load i32* %counter, align 4
  %15 = sext i32 %14 to i64
  %16 = load i32** %2, align 8
  %17 = getelementptr inbounds i32* %16, i64 %15
  %18 = load i32* %17
  %19 = icmp sgt i32 %13, %18
  br i1 %19, label %20, label %30

; <label>:20                                      ; preds = %8
  %21 = load i32* %counter, align 4
  %22 = sext i32 %21 to i64
  %23 = load i32** %2, align 8
  %24 = getelementptr inbounds i32* %23, i64 %22
  %25 = load i32* %24
  %26 = load i32* %counter, align 4
  %27 = sext i32 %26 to i64
  %28 = load i32** %1, align 8
  %29 = getelementptr inbounds i32* %28, i64 %27
  store i32 %25, i32* %29
  br label %30

; <label>:30                                      ; preds = %20, %8
  br label %4

; <label>:31                                      ; preds = %4
  ret void
}

define i32 @equal_data(i32* %data1, i32* %data2) nounwind ssp {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %counter = alloca i32, align 4
  store i32* %data1, i32** %1, align 8
  store i32* %data2, i32** %2, align 8
  %3 = load i32* @ncol, align 4
  store i32 %3, i32* %counter, align 4
  br label %4

; <label>:4                                       ; preds = %22, %0
  %5 = load i32* %counter, align 4
  %6 = add nsw i32 %5, -1
  store i32 %6, i32* %counter, align 4
  %7 = icmp ne i32 %5, 0
  br i1 %7, label %8, label %20

; <label>:8                                       ; preds = %4
  %9 = load i32* %counter, align 4
  %10 = sext i32 %9 to i64
  %11 = load i32** %1, align 8
  %12 = getelementptr inbounds i32* %11, i64 %10
  %13 = load i32* %12
  %14 = load i32* %counter, align 4
  %15 = sext i32 %14 to i64
  %16 = load i32** %2, align 8
  %17 = getelementptr inbounds i32* %16, i64 %15
  %18 = load i32* %17
  %19 = icmp eq i32 %13, %18
  br label %20

; <label>:20                                      ; preds = %8, %4
  %21 = phi i1 [ false, %4 ], [ %19, %8 ]
  br i1 %21, label %22, label %23

; <label>:22                                      ; preds = %20
  br label %4

; <label>:23                                      ; preds = %20
  %24 = load i32* %counter, align 4
  %25 = icmp slt i32 %24, 0
  %26 = zext i1 %25 to i32
  ret i32 %26
}

define i32 @valid_data(i32* %data) nounwind ssp {
  %1 = alloca i32*, align 8
  %low = alloca i32, align 4
  %counter = alloca i32, align 4
  store i32* %data, i32** %1, align 8
  store i32 0, i32* %counter, align 4
  %2 = load i32* @nrow, align 4
  store i32 %2, i32* %low, align 4
  br label %3

; <label>:3                                       ; preds = %16, %0
  %4 = load i32* %counter, align 4
  %5 = load i32* @ncol, align 4
  %6 = icmp ne i32 %4, %5
  br i1 %6, label %7, label %24

; <label>:7                                       ; preds = %3
  %8 = load i32* %counter, align 4
  %9 = sext i32 %8 to i64
  %10 = load i32** %1, align 8
  %11 = getelementptr inbounds i32* %10, i64 %9
  %12 = load i32* %11
  %13 = load i32* %low, align 4
  %14 = icmp sgt i32 %12, %13
  br i1 %14, label %15, label %16

; <label>:15                                      ; preds = %7
  br label %24

; <label>:16                                      ; preds = %7
  %17 = load i32* %counter, align 4
  %18 = sext i32 %17 to i64
  %19 = load i32** %1, align 8
  %20 = getelementptr inbounds i32* %19, i64 %18
  %21 = load i32* %20
  store i32 %21, i32* %low, align 4
  %22 = load i32* %counter, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %counter, align 4
  br label %3

; <label>:24                                      ; preds = %15, %3
  %25 = load i32* %counter, align 4
  %26 = load i32* @ncol, align 4
  %27 = icmp eq i32 %25, %26
  %28 = zext i1 %27 to i32
  ret i32 %28
}

define void @dump_list(%struct._list* %list) nounwind ssp {
  %1 = alloca %struct._list*, align 8
  store %struct._list* %list, %struct._list** %1, align 8
  %2 = load %struct._list** %1, align 8
  %3 = icmp ne %struct._list* %2, null
  br i1 %3, label %4, label %14

; <label>:4                                       ; preds = %0
  %5 = load %struct._list** %1, align 8
  %6 = getelementptr inbounds %struct._list* %5, i32 0, i32 1
  %7 = load %struct._list** %6, align 8
  call void @dump_list(%struct._list* %7)
  %8 = load %struct._list** %1, align 8
  %9 = getelementptr inbounds %struct._list* %8, i32 0, i32 0
  %10 = load i32** %9, align 8
  %11 = bitcast i32* %10 to i8*
  call void @free(i8* %11)
  %12 = load %struct._list** %1, align 8
  %13 = bitcast %struct._list* %12 to i8*
  call void @free(i8* %13)
  br label %14

; <label>:14                                      ; preds = %4, %0
  ret void
}

declare void @free(i8*)

define void @dump_play(%struct._play* %play) nounwind ssp {
  %1 = alloca %struct._play*, align 8
  store %struct._play* %play, %struct._play** %1, align 8
  %2 = load %struct._play** %1, align 8
  %3 = icmp ne %struct._play* %2, null
  br i1 %3, label %4, label %17

; <label>:4                                       ; preds = %0
  %5 = load %struct._play** %1, align 8
  %6 = getelementptr inbounds %struct._play* %5, i32 0, i32 3
  %7 = load %struct._play** %6, align 8
  call void (...)* bitcast (void (%struct._play*)* @dump_play to void (...)*)(%struct._play* %7)
  %8 = load %struct._play** %1, align 8
  %9 = getelementptr inbounds %struct._play* %8, i32 0, i32 2
  %10 = load %struct._list** %9, align 8
  call void @dump_list(%struct._list* %10)
  %11 = load %struct._play** %1, align 8
  %12 = getelementptr inbounds %struct._play* %11, i32 0, i32 1
  %13 = load i32** %12, align 8
  %14 = bitcast i32* %13 to i8*
  call void @free(i8* %14)
  %15 = load %struct._play** %1, align 8
  %16 = bitcast %struct._play* %15 to i8*
  call void @free(i8* %16)
  br label %17

; <label>:17                                      ; preds = %4, %0
  ret void
}

define i32 @get_value(i32* %data) nounwind ssp {
  %1 = alloca i32*, align 8
  %search = alloca %struct._play*, align 8
  store i32* %data, i32** %1, align 8
  %2 = load %struct._play** @game_tree, align 8
  store %struct._play* %2, %struct._play** %search, align 8
  br label %3

; <label>:3                                       ; preds = %11, %0
  %4 = load %struct._play** %search, align 8
  %5 = getelementptr inbounds %struct._play* %4, i32 0, i32 1
  %6 = load i32** %5, align 8
  %7 = load i32** %1, align 8
  %8 = call i32 @equal_data(i32* %6, i32* %7)
  %9 = icmp ne i32 %8, 0
  %10 = xor i1 %9, true
  br i1 %10, label %11, label %15

; <label>:11                                      ; preds = %3
  %12 = load %struct._play** %search, align 8
  %13 = getelementptr inbounds %struct._play* %12, i32 0, i32 3
  %14 = load %struct._play** %13, align 8
  store %struct._play* %14, %struct._play** %search, align 8
  br label %3

; <label>:15                                      ; preds = %3
  %16 = load %struct._play** %search, align 8
  %17 = getelementptr inbounds %struct._play* %16, i32 0, i32 0
  %18 = load i32* %17, align 4
  ret i32 %18
}

define void @show_data(i32* %data) nounwind ssp {
  %1 = alloca i32*, align 8
  %counter = alloca i32, align 4
  store i32* %data, i32** %1, align 8
  store i32 0, i32* %counter, align 4
  br label %2

; <label>:2                                       ; preds = %19, %0
  %3 = load i32* %counter, align 4
  %4 = load i32* @ncol, align 4
  %5 = icmp ne i32 %3, %4
  br i1 %5, label %6, label %20

; <label>:6                                       ; preds = %2
  %7 = load i32* %counter, align 4
  %8 = add nsw i32 %7, 1
  store i32 %8, i32* %counter, align 4
  %9 = sext i32 %7 to i64
  %10 = load i32** %1, align 8
  %11 = getelementptr inbounds i32* %10, i64 %9
  %12 = load i32* %11
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str, i32 0, i32 0), i32 %12)
  %14 = load i32* %counter, align 4
  %15 = load i32* @ncol, align 4
  %16 = icmp ne i32 %14, %15
  br i1 %16, label %17, label %19

; <label>:17                                      ; preds = %6
  %18 = call i32 @putchar(i32 44)
  br label %19

; <label>:19                                      ; preds = %17, %6
  br label %2

; <label>:20                                      ; preds = %2
  ret void
}

declare i32 @printf(i8*, ...)

declare i32 @putchar(i32)

define void @show_move(i32* %data) nounwind ssp {
  %1 = alloca i32*, align 8
  store i32* %data, i32** %1, align 8
  %2 = call i32 @putchar(i32 40)
  %3 = load i32** %1, align 8
  call void @show_data(i32* %3)
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([3 x i8]* @.str1, i32 0, i32 0))
  ret void
}

define void @show_list(%struct._list* %list) nounwind ssp {
  %1 = alloca %struct._list*, align 8
  store %struct._list* %list, %struct._list** %1, align 8
  br label %2

; <label>:2                                       ; preds = %5, %0
  %3 = load %struct._list** %1, align 8
  %4 = icmp ne %struct._list* %3, null
  br i1 %4, label %5, label %12

; <label>:5                                       ; preds = %2
  %6 = load %struct._list** %1, align 8
  %7 = getelementptr inbounds %struct._list* %6, i32 0, i32 0
  %8 = load i32** %7, align 8
  call void @show_move(i32* %8)
  %9 = load %struct._list** %1, align 8
  %10 = getelementptr inbounds %struct._list* %9, i32 0, i32 1
  %11 = load %struct._list** %10, align 8
  store %struct._list* %11, %struct._list** %1, align 8
  br label %2

; <label>:12                                      ; preds = %2
  ret void
}

define void @show_play(%struct._play* %play) nounwind ssp {
  %1 = alloca %struct._play*, align 8
  store %struct._play* %play, %struct._play** %1, align 8
  br label %2

; <label>:2                                       ; preds = %5, %0
  %3 = load %struct._play** %1, align 8
  %4 = icmp ne %struct._play* %3, null
  br i1 %4, label %5, label %21

; <label>:5                                       ; preds = %2
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str2, i32 0, i32 0))
  %7 = load %struct._play** %1, align 8
  %8 = getelementptr inbounds %struct._play* %7, i32 0, i32 1
  %9 = load i32** %8, align 8
  call void @show_data(i32* %9)
  %10 = load %struct._play** %1, align 8
  %11 = getelementptr inbounds %struct._play* %10, i32 0, i32 0
  %12 = load i32* %11, align 4
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str3, i32 0, i32 0), i32 %12)
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str4, i32 0, i32 0))
  %15 = load %struct._play** %1, align 8
  %16 = getelementptr inbounds %struct._play* %15, i32 0, i32 2
  %17 = load %struct._list** %16, align 8
  call void @show_list(%struct._list* %17)
  %18 = load %struct._play** %1, align 8
  %19 = getelementptr inbounds %struct._play* %18, i32 0, i32 3
  %20 = load %struct._play** %19, align 8
  store %struct._play* %20, %struct._play** %1, align 8
  br label %2

; <label>:21                                      ; preds = %2
  ret void
}

define i32 @in_wanted(i32* %data) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32*, align 8
  %current = alloca %struct._list*, align 8
  store i32* %data, i32** %2, align 8
  %3 = load %struct._list** @wanted, align 8
  store %struct._list* %3, %struct._list** %current, align 8
  br label %4

; <label>:4                                       ; preds = %15, %0
  %5 = load %struct._list** %current, align 8
  %6 = icmp ne %struct._list* %5, null
  br i1 %6, label %7, label %19

; <label>:7                                       ; preds = %4
  %8 = load %struct._list** %current, align 8
  %9 = getelementptr inbounds %struct._list* %8, i32 0, i32 0
  %10 = load i32** %9, align 8
  %11 = load i32** %2, align 8
  %12 = call i32 @equal_data(i32* %10, i32* %11)
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %15

; <label>:14                                      ; preds = %7
  br label %19

; <label>:15                                      ; preds = %7
  %16 = load %struct._list** %current, align 8
  %17 = getelementptr inbounds %struct._list* %16, i32 0, i32 1
  %18 = load %struct._list** %17, align 8
  store %struct._list* %18, %struct._list** %current, align 8
  br label %4

; <label>:19                                      ; preds = %14, %4
  %20 = load %struct._list** %current, align 8
  %21 = icmp eq %struct._list* %20, null
  br i1 %21, label %22, label %23

; <label>:22                                      ; preds = %19
  store i32 0, i32* %1
  br label %24

; <label>:23                                      ; preds = %19
  store i32 1, i32* %1
  br label %24

; <label>:24                                      ; preds = %23, %22
  %25 = load i32* %1
  ret i32 %25
}

define i32* @make_data(i32 %row, i32 %col) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %count = alloca i32, align 4
  %new = alloca i32*, align 8
  store i32 %row, i32* %1, align 4
  store i32 %col, i32* %2, align 4
  %3 = load i32* @ncol, align 4
  %4 = sext i32 %3 to i64
  %5 = mul i64 %4, 4
  %6 = call i8* @malloc(i64 %5)
  %7 = bitcast i8* %6 to i32*
  store i32* %7, i32** %new, align 8
  store i32 0, i32* %count, align 4
  br label %8

; <label>:8                                       ; preds = %18, %0
  %9 = load i32* %count, align 4
  %10 = load i32* %2, align 4
  %11 = icmp ne i32 %9, %10
  br i1 %11, label %12, label %21

; <label>:12                                      ; preds = %8
  %13 = load i32* @nrow, align 4
  %14 = load i32* %count, align 4
  %15 = sext i32 %14 to i64
  %16 = load i32** %new, align 8
  %17 = getelementptr inbounds i32* %16, i64 %15
  store i32 %13, i32* %17
  br label %18

; <label>:18                                      ; preds = %12
  %19 = load i32* %count, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, i32* %count, align 4
  br label %8

; <label>:21                                      ; preds = %8
  br label %22

; <label>:22                                      ; preds = %32, %21
  %23 = load i32* %count, align 4
  %24 = load i32* @ncol, align 4
  %25 = icmp ne i32 %23, %24
  br i1 %25, label %26, label %35

; <label>:26                                      ; preds = %22
  %27 = load i32* %1, align 4
  %28 = load i32* %count, align 4
  %29 = sext i32 %28 to i64
  %30 = load i32** %new, align 8
  %31 = getelementptr inbounds i32* %30, i64 %29
  store i32 %27, i32* %31
  br label %32

; <label>:32                                      ; preds = %26
  %33 = load i32* %count, align 4
  %34 = add nsw i32 %33, 1
  store i32 %34, i32* %count, align 4
  br label %22

; <label>:35                                      ; preds = %22
  %36 = load i32** %new, align 8
  ret i32* %36
}

define %struct._list* @make_list(i32* %data, i32* %value, i32* %all) nounwind ssp {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32*, align 8
  %row = alloca i32, align 4
  %col = alloca i32, align 4
  %temp = alloca i32*, align 8
  %head = alloca %struct._list*, align 8
  %current = alloca %struct._list*, align 8
  store i32* %data, i32** %1, align 8
  store i32* %value, i32** %2, align 8
  store i32* %all, i32** %3, align 8
  %4 = load i32** %2, align 8
  store i32 1, i32* %4
  %5 = call i8* @malloc(i64 16)
  %6 = bitcast i8* %5 to %struct._list*
  store %struct._list* %6, %struct._list** %head, align 8
  %7 = load %struct._list** %head, align 8
  %8 = getelementptr inbounds %struct._list* %7, i32 0, i32 1
  store %struct._list* null, %struct._list** %8, align 8
  %9 = load %struct._list** %head, align 8
  store %struct._list* %9, %struct._list** %current, align 8
  store i32 0, i32* %row, align 4
  br label %10

; <label>:10                                      ; preds = %90, %0
  %11 = load i32* %row, align 4
  %12 = load i32* @nrow, align 4
  %13 = icmp ne i32 %11, %12
  br i1 %13, label %14, label %93

; <label>:14                                      ; preds = %10
  store i32 0, i32* %col, align 4
  br label %15

; <label>:15                                      ; preds = %86, %14
  %16 = load i32* %col, align 4
  %17 = load i32* @ncol, align 4
  %18 = icmp ne i32 %16, %17
  br i1 %18, label %19, label %89

; <label>:19                                      ; preds = %15
  %20 = load i32* %row, align 4
  %21 = load i32* %col, align 4
  %22 = call i32* @make_data(i32 %20, i32 %21)
  store i32* %22, i32** %temp, align 8
  %23 = load i32** %temp, align 8
  %24 = load i32** %1, align 8
  call void @melt_data(i32* %23, i32* %24)
  %25 = load i32** %temp, align 8
  %26 = load i32** %1, align 8
  %27 = call i32 @equal_data(i32* %25, i32* %26)
  %28 = icmp ne i32 %27, 0
  br i1 %28, label %74, label %29

; <label>:29                                      ; preds = %19
  %30 = call i8* @malloc(i64 16)
  %31 = bitcast i8* %30 to %struct._list*
  %32 = load %struct._list** %current, align 8
  %33 = getelementptr inbounds %struct._list* %32, i32 0, i32 1
  store %struct._list* %31, %struct._list** %33, align 8
  %34 = load i32** %temp, align 8
  %35 = call i32* (...)* bitcast (i32* (i32*)* @copy_data to i32* (...)*)(i32* %34)
  %36 = load %struct._list** %current, align 8
  %37 = getelementptr inbounds %struct._list* %36, i32 0, i32 1
  %38 = load %struct._list** %37, align 8
  %39 = getelementptr inbounds %struct._list* %38, i32 0, i32 0
  store i32* %35, i32** %39, align 8
  %40 = load %struct._list** %current, align 8
  %41 = getelementptr inbounds %struct._list* %40, i32 0, i32 1
  %42 = load %struct._list** %41, align 8
  %43 = getelementptr inbounds %struct._list* %42, i32 0, i32 1
  store %struct._list* null, %struct._list** %43, align 8
  %44 = load %struct._list** %current, align 8
  %45 = getelementptr inbounds %struct._list* %44, i32 0, i32 1
  %46 = load %struct._list** %45, align 8
  store %struct._list* %46, %struct._list** %current, align 8
  %47 = load i32** %2, align 8
  %48 = load i32* %47
  %49 = icmp eq i32 %48, 1
  br i1 %49, label %50, label %54

; <label>:50                                      ; preds = %29
  %51 = load i32** %temp, align 8
  %52 = call i32 @get_value(i32* %51)
  %53 = load i32** %2, align 8
  store i32 %52, i32* %53
  br label %54

; <label>:54                                      ; preds = %50, %29
  %55 = load i32** %3, align 8
  %56 = load i32* %55
  %57 = icmp ne i32 %56, 0
  br i1 %57, label %73, label %58

; <label>:58                                      ; preds = %54
  %59 = load i32** %2, align 8
  %60 = load i32* %59
  %61 = icmp eq i32 %60, 0
  br i1 %61, label %62, label %73

; <label>:62                                      ; preds = %58
  %63 = load i32* @ncol, align 4
  %64 = sub nsw i32 %63, 1
  store i32 %64, i32* %col, align 4
  %65 = load i32* @nrow, align 4
  %66 = sub nsw i32 %65, 1
  store i32 %66, i32* %row, align 4
  %67 = load i32** %temp, align 8
  %68 = call i32 @in_wanted(i32* %67)
  %69 = icmp ne i32 %68, 0
  br i1 %69, label %70, label %72

; <label>:70                                      ; preds = %62
  %71 = load i32** %3, align 8
  store i32 2, i32* %71
  br label %72

; <label>:72                                      ; preds = %70, %62
  br label %73

; <label>:73                                      ; preds = %72, %58, %54
  br label %83

; <label>:74                                      ; preds = %19
  %75 = load i32* %col, align 4
  %76 = icmp eq i32 %75, 0
  br i1 %76, label %77, label %80

; <label>:77                                      ; preds = %74
  %78 = load i32* @nrow, align 4
  %79 = sub nsw i32 %78, 1
  store i32 %79, i32* %row, align 4
  br label %80

; <label>:80                                      ; preds = %77, %74
  %81 = load i32* @ncol, align 4
  %82 = sub nsw i32 %81, 1
  store i32 %82, i32* %col, align 4
  br label %83

; <label>:83                                      ; preds = %80, %73
  %84 = load i32** %temp, align 8
  %85 = bitcast i32* %84 to i8*
  call void @free(i8* %85)
  br label %86

; <label>:86                                      ; preds = %83
  %87 = load i32* %col, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, i32* %col, align 4
  br label %15

; <label>:89                                      ; preds = %15
  br label %90

; <label>:90                                      ; preds = %89
  %91 = load i32* %row, align 4
  %92 = add nsw i32 %91, 1
  store i32 %92, i32* %row, align 4
  br label %10

; <label>:93                                      ; preds = %10
  %94 = load %struct._list** %head, align 8
  %95 = getelementptr inbounds %struct._list* %94, i32 0, i32 1
  %96 = load %struct._list** %95, align 8
  store %struct._list* %96, %struct._list** %current, align 8
  %97 = load %struct._list** %head, align 8
  %98 = bitcast %struct._list* %97 to i8*
  call void @free(i8* %98)
  %99 = load %struct._list** %current, align 8
  %100 = icmp ne %struct._list* %99, null
  br i1 %100, label %101, label %106

; <label>:101                                     ; preds = %93
  %102 = load i32** %2, align 8
  %103 = load i32* %102
  %104 = sub nsw i32 1, %103
  %105 = load i32** %2, align 8
  store i32 %104, i32* %105
  br label %106

; <label>:106                                     ; preds = %101, %93
  %107 = load %struct._list** %current, align 8
  ret %struct._list* %107
}

define %struct._play* @make_play(i32 %all) nounwind ssp {
  %1 = alloca i32, align 4
  %val = alloca i32, align 4
  %temp = alloca i32*, align 8
  %head = alloca %struct._play*, align 8
  %current = alloca %struct._play*, align 8
  store i32 %all, i32* %1, align 4
  %2 = call i8* @malloc(i64 32)
  %3 = bitcast i8* %2 to %struct._play*
  store %struct._play* %3, %struct._play** %head, align 8
  %4 = load %struct._play** %head, align 8
  store %struct._play* %4, %struct._play** %current, align 8
  store %struct._play* null, %struct._play** @game_tree, align 8
  %5 = call i32* @make_data(i32 0, i32 0)
  store i32* %5, i32** %temp, align 8
  %6 = load i32** %temp, align 8
  %7 = getelementptr inbounds i32* %6, i64 0
  %8 = load i32* %7
  %9 = add nsw i32 %8, -1
  store i32 %9, i32* %7
  br label %10

; <label>:10                                      ; preds = %63, %0
  %11 = load i32** %temp, align 8
  %12 = call i32 @next_data(i32* %11)
  %13 = icmp ne i32 %12, 0
  br i1 %13, label %14, label %64

; <label>:14                                      ; preds = %10
  %15 = load i32** %temp, align 8
  %16 = call i32 @valid_data(i32* %15)
  %17 = icmp ne i32 %16, 0
  br i1 %17, label %18, label %63

; <label>:18                                      ; preds = %14
  %19 = call i8* @malloc(i64 32)
  %20 = bitcast i8* %19 to %struct._play*
  %21 = load %struct._play** %current, align 8
  %22 = getelementptr inbounds %struct._play* %21, i32 0, i32 3
  store %struct._play* %20, %struct._play** %22, align 8
  %23 = load %struct._play** @game_tree, align 8
  %24 = icmp eq %struct._play* %23, null
  br i1 %24, label %25, label %29

; <label>:25                                      ; preds = %18
  %26 = load %struct._play** %current, align 8
  %27 = getelementptr inbounds %struct._play* %26, i32 0, i32 3
  %28 = load %struct._play** %27, align 8
  store %struct._play* %28, %struct._play** @game_tree, align 8
  br label %29

; <label>:29                                      ; preds = %25, %18
  %30 = load i32** %temp, align 8
  %31 = call i32* (...)* bitcast (i32* (i32*)* @copy_data to i32* (...)*)(i32* %30)
  %32 = load %struct._play** %current, align 8
  %33 = getelementptr inbounds %struct._play* %32, i32 0, i32 3
  %34 = load %struct._play** %33, align 8
  %35 = getelementptr inbounds %struct._play* %34, i32 0, i32 1
  store i32* %31, i32** %35, align 8
  %36 = load i32** %temp, align 8
  %37 = call %struct._list* @make_list(i32* %36, i32* %val, i32* %1)
  %38 = load %struct._play** %current, align 8
  %39 = getelementptr inbounds %struct._play* %38, i32 0, i32 3
  %40 = load %struct._play** %39, align 8
  %41 = getelementptr inbounds %struct._play* %40, i32 0, i32 2
  store %struct._list* %37, %struct._list** %41, align 8
  %42 = load i32* %val, align 4
  %43 = load %struct._play** %current, align 8
  %44 = getelementptr inbounds %struct._play* %43, i32 0, i32 3
  %45 = load %struct._play** %44, align 8
  %46 = getelementptr inbounds %struct._play* %45, i32 0, i32 0
  store i32 %42, i32* %46, align 4
  %47 = load %struct._play** %current, align 8
  %48 = getelementptr inbounds %struct._play* %47, i32 0, i32 3
  %49 = load %struct._play** %48, align 8
  %50 = getelementptr inbounds %struct._play* %49, i32 0, i32 3
  store %struct._play* null, %struct._play** %50, align 8
  %51 = load %struct._play** %current, align 8
  %52 = getelementptr inbounds %struct._play* %51, i32 0, i32 3
  %53 = load %struct._play** %52, align 8
  store %struct._play* %53, %struct._play** %current, align 8
  %54 = load i32* %1, align 4
  %55 = icmp eq i32 %54, 2
  br i1 %55, label %56, label %62

; <label>:56                                      ; preds = %29
  %57 = load i32** %temp, align 8
  %58 = bitcast i32* %57 to i8*
  call void @free(i8* %58)
  %59 = load i32* @nrow, align 4
  %60 = load i32* @ncol, align 4
  %61 = call i32* @make_data(i32 %59, i32 %60)
  store i32* %61, i32** %temp, align 8
  br label %62

; <label>:62                                      ; preds = %56, %29
  br label %63

; <label>:63                                      ; preds = %62, %14
  br label %10

; <label>:64                                      ; preds = %10
  %65 = load %struct._play** %head, align 8
  %66 = getelementptr inbounds %struct._play* %65, i32 0, i32 3
  %67 = load %struct._play** %66, align 8
  store %struct._play* %67, %struct._play** %current, align 8
  %68 = load %struct._play** %head, align 8
  %69 = bitcast %struct._play* %68 to i8*
  call void @free(i8* %69)
  %70 = load %struct._play** %current, align 8
  ret %struct._play* %70
}

define void @make_wanted(i32* %data) nounwind ssp {
  %1 = alloca i32*, align 8
  %row = alloca i32, align 4
  %col = alloca i32, align 4
  %temp = alloca i32*, align 8
  %head = alloca %struct._list*, align 8
  %current = alloca %struct._list*, align 8
  store i32* %data, i32** %1, align 8
  %2 = call i8* @malloc(i64 16)
  %3 = bitcast i8* %2 to %struct._list*
  store %struct._list* %3, %struct._list** %head, align 8
  %4 = load %struct._list** %head, align 8
  %5 = getelementptr inbounds %struct._list* %4, i32 0, i32 1
  store %struct._list* null, %struct._list** %5, align 8
  %6 = load %struct._list** %head, align 8
  store %struct._list* %6, %struct._list** %current, align 8
  store i32 0, i32* %row, align 4
  br label %7

; <label>:7                                       ; preds = %60, %0
  %8 = load i32* %row, align 4
  %9 = load i32* @nrow, align 4
  %10 = icmp ne i32 %8, %9
  br i1 %10, label %11, label %63

; <label>:11                                      ; preds = %7
  store i32 0, i32* %col, align 4
  br label %12

; <label>:12                                      ; preds = %56, %11
  %13 = load i32* %col, align 4
  %14 = load i32* @ncol, align 4
  %15 = icmp ne i32 %13, %14
  br i1 %15, label %16, label %59

; <label>:16                                      ; preds = %12
  %17 = load i32* %row, align 4
  %18 = load i32* %col, align 4
  %19 = call i32* @make_data(i32 %17, i32 %18)
  store i32* %19, i32** %temp, align 8
  %20 = load i32** %temp, align 8
  %21 = load i32** %1, align 8
  call void @melt_data(i32* %20, i32* %21)
  %22 = load i32** %temp, align 8
  %23 = load i32** %1, align 8
  %24 = call i32 @equal_data(i32* %22, i32* %23)
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %44, label %26

; <label>:26                                      ; preds = %16
  %27 = call i8* @malloc(i64 16)
  %28 = bitcast i8* %27 to %struct._list*
  %29 = load %struct._list** %current, align 8
  %30 = getelementptr inbounds %struct._list* %29, i32 0, i32 1
  store %struct._list* %28, %struct._list** %30, align 8
  %31 = load i32** %temp, align 8
  %32 = call i32* (...)* bitcast (i32* (i32*)* @copy_data to i32* (...)*)(i32* %31)
  %33 = load %struct._list** %current, align 8
  %34 = getelementptr inbounds %struct._list* %33, i32 0, i32 1
  %35 = load %struct._list** %34, align 8
  %36 = getelementptr inbounds %struct._list* %35, i32 0, i32 0
  store i32* %32, i32** %36, align 8
  %37 = load %struct._list** %current, align 8
  %38 = getelementptr inbounds %struct._list* %37, i32 0, i32 1
  %39 = load %struct._list** %38, align 8
  %40 = getelementptr inbounds %struct._list* %39, i32 0, i32 1
  store %struct._list* null, %struct._list** %40, align 8
  %41 = load %struct._list** %current, align 8
  %42 = getelementptr inbounds %struct._list* %41, i32 0, i32 1
  %43 = load %struct._list** %42, align 8
  store %struct._list* %43, %struct._list** %current, align 8
  br label %53

; <label>:44                                      ; preds = %16
  %45 = load i32* %col, align 4
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %47, label %50

; <label>:47                                      ; preds = %44
  %48 = load i32* @nrow, align 4
  %49 = sub nsw i32 %48, 1
  store i32 %49, i32* %row, align 4
  br label %50

; <label>:50                                      ; preds = %47, %44
  %51 = load i32* @ncol, align 4
  %52 = sub nsw i32 %51, 1
  store i32 %52, i32* %col, align 4
  br label %53

; <label>:53                                      ; preds = %50, %26
  %54 = load i32** %temp, align 8
  %55 = bitcast i32* %54 to i8*
  call void @free(i8* %55)
  br label %56

; <label>:56                                      ; preds = %53
  %57 = load i32* %col, align 4
  %58 = add nsw i32 %57, 1
  store i32 %58, i32* %col, align 4
  br label %12

; <label>:59                                      ; preds = %12
  br label %60

; <label>:60                                      ; preds = %59
  %61 = load i32* %row, align 4
  %62 = add nsw i32 %61, 1
  store i32 %62, i32* %row, align 4
  br label %7

; <label>:63                                      ; preds = %7
  %64 = load %struct._list** %head, align 8
  %65 = getelementptr inbounds %struct._list* %64, i32 0, i32 1
  %66 = load %struct._list** %65, align 8
  store %struct._list* %66, %struct._list** %current, align 8
  %67 = load %struct._list** %head, align 8
  %68 = bitcast %struct._list* %67 to i8*
  call void @free(i8* %68)
  %69 = load %struct._list** %current, align 8
  store %struct._list* %69, %struct._list** @wanted, align 8
  ret void
}

define i32* @get_good_move(%struct._list* %list) nounwind ssp {
  %1 = alloca i32*, align 8
  %2 = alloca %struct._list*, align 8
  store %struct._list* %list, %struct._list** %2, align 8
  %3 = load %struct._list** %2, align 8
  %4 = icmp eq %struct._list* %3, null
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  store i32* null, i32** %1
  br label %29

; <label>:6                                       ; preds = %0
  br label %7

; <label>:7                                       ; preds = %20, %6
  %8 = load %struct._list** %2, align 8
  %9 = getelementptr inbounds %struct._list* %8, i32 0, i32 1
  %10 = load %struct._list** %9, align 8
  %11 = icmp ne %struct._list* %10, null
  br i1 %11, label %12, label %18

; <label>:12                                      ; preds = %7
  %13 = load %struct._list** %2, align 8
  %14 = getelementptr inbounds %struct._list* %13, i32 0, i32 0
  %15 = load i32** %14, align 8
  %16 = call i32 @get_value(i32* %15)
  %17 = icmp ne i32 %16, 0
  br label %18

; <label>:18                                      ; preds = %12, %7
  %19 = phi i1 [ false, %7 ], [ %17, %12 ]
  br i1 %19, label %20, label %24

; <label>:20                                      ; preds = %18
  %21 = load %struct._list** %2, align 8
  %22 = getelementptr inbounds %struct._list* %21, i32 0, i32 1
  %23 = load %struct._list** %22, align 8
  store %struct._list* %23, %struct._list** %2, align 8
  br label %7

; <label>:24                                      ; preds = %18
  %25 = load %struct._list** %2, align 8
  %26 = getelementptr inbounds %struct._list* %25, i32 0, i32 0
  %27 = load i32** %26, align 8
  %28 = call i32* (...)* bitcast (i32* (i32*)* @copy_data to i32* (...)*)(i32* %27)
  store i32* %28, i32** %1
  br label %29

; <label>:29                                      ; preds = %24, %5
  %30 = load i32** %1
  ret i32* %30
}

define i32* @get_winning_move(%struct._play* %play) nounwind ssp {
  %1 = alloca %struct._play*, align 8
  %temp = alloca i32*, align 8
  store %struct._play* %play, %struct._play** %1, align 8
  br label %2

; <label>:2                                       ; preds = %7, %0
  %3 = load %struct._play** %1, align 8
  %4 = getelementptr inbounds %struct._play* %3, i32 0, i32 3
  %5 = load %struct._play** %4, align 8
  %6 = icmp ne %struct._play* %5, null
  br i1 %6, label %7, label %11

; <label>:7                                       ; preds = %2
  %8 = load %struct._play** %1, align 8
  %9 = getelementptr inbounds %struct._play* %8, i32 0, i32 3
  %10 = load %struct._play** %9, align 8
  store %struct._play* %10, %struct._play** %1, align 8
  br label %2

; <label>:11                                      ; preds = %2
  %12 = load %struct._play** %1, align 8
  %13 = getelementptr inbounds %struct._play* %12, i32 0, i32 2
  %14 = load %struct._list** %13, align 8
  %15 = call i32* @get_good_move(%struct._list* %14)
  store i32* %15, i32** %temp, align 8
  %16 = load i32** %temp, align 8
  ret i32* %16
}

define %struct._list* @where(i32* %data, %struct._play* %play) nounwind ssp {
  %1 = alloca i32*, align 8
  %2 = alloca %struct._play*, align 8
  store i32* %data, i32** %1, align 8
  store %struct._play* %play, %struct._play** %2, align 8
  br label %3

; <label>:3                                       ; preds = %11, %0
  %4 = load %struct._play** %2, align 8
  %5 = getelementptr inbounds %struct._play* %4, i32 0, i32 1
  %6 = load i32** %5, align 8
  %7 = load i32** %1, align 8
  %8 = call i32 @equal_data(i32* %6, i32* %7)
  %9 = icmp ne i32 %8, 0
  %10 = xor i1 %9, true
  br i1 %10, label %11, label %15

; <label>:11                                      ; preds = %3
  %12 = load %struct._play** %2, align 8
  %13 = getelementptr inbounds %struct._play* %12, i32 0, i32 3
  %14 = load %struct._play** %13, align 8
  store %struct._play* %14, %struct._play** %2, align 8
  br label %3

; <label>:15                                      ; preds = %3
  %16 = load %struct._play** %2, align 8
  %17 = getelementptr inbounds %struct._play* %16, i32 0, i32 2
  %18 = load %struct._list** %17, align 8
  ret %struct._list* %18
}

define void @get_real_move(i32* %data1, i32* %data2, i32* %row, i32* %col) nounwind ssp {
  %1 = alloca i32*, align 8
  %2 = alloca i32*, align 8
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  store i32* %data1, i32** %1, align 8
  store i32* %data2, i32** %2, align 8
  store i32* %row, i32** %3, align 8
  store i32* %col, i32** %4, align 8
  %5 = load i32** %4, align 8
  store i32 0, i32* %5
  br label %6

; <label>:6                                       ; preds = %20, %0
  %7 = load i32** %4, align 8
  %8 = load i32* %7
  %9 = sext i32 %8 to i64
  %10 = load i32** %1, align 8
  %11 = getelementptr inbounds i32* %10, i64 %9
  %12 = load i32* %11
  %13 = load i32** %4, align 8
  %14 = load i32* %13
  %15 = sext i32 %14 to i64
  %16 = load i32** %2, align 8
  %17 = getelementptr inbounds i32* %16, i64 %15
  %18 = load i32* %17
  %19 = icmp eq i32 %12, %18
  br i1 %19, label %20, label %24

; <label>:20                                      ; preds = %6
  %21 = load i32** %4, align 8
  %22 = load i32* %21
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %21
  br label %6

; <label>:24                                      ; preds = %6
  %25 = load i32** %4, align 8
  %26 = load i32* %25
  %27 = sext i32 %26 to i64
  %28 = load i32** %1, align 8
  %29 = getelementptr inbounds i32* %28, i64 %27
  %30 = load i32* %29
  %31 = load i32** %3, align 8
  store i32 %30, i32* %31
  ret void
}

define i32 @main() nounwind ssp {
  %1 = alloca i32, align 4
  %row = alloca i32, align 4
  %col = alloca i32, align 4
  %player = alloca i32, align 4
  %current = alloca i32*, align 8
  %temp = alloca i32*, align 8
  %tree = alloca %struct._play*, align 8
  store i32 0, i32* %1
  store i32 7, i32* @ncol, align 4
  store i32 8, i32* @nrow, align 4
  %2 = call %struct._play* @make_play(i32 1)
  store %struct._play* %2, %struct._play** %tree, align 8
  store i32 0, i32* %player, align 4
  %3 = load i32* @nrow, align 4
  %4 = load i32* @ncol, align 4
  %5 = call i32* @make_data(i32 %3, i32 %4)
  store i32* %5, i32** %current, align 8
  br label %6

; <label>:6                                       ; preds = %27, %0
  %7 = load i32** %current, align 8
  %8 = icmp ne i32* %7, null
  br i1 %8, label %9, label %29

; <label>:9                                       ; preds = %6
  %10 = load i32** %current, align 8
  %11 = load %struct._play** %tree, align 8
  %12 = call %struct._list* @where(i32* %10, %struct._play* %11)
  %13 = call i32* @get_good_move(%struct._list* %12)
  store i32* %13, i32** %temp, align 8
  %14 = load i32** %temp, align 8
  %15 = icmp ne i32* %14, null
  br i1 %15, label %16, label %27

; <label>:16                                      ; preds = %9
  %17 = load i32** %temp, align 8
  %18 = load i32** %current, align 8
  call void @get_real_move(i32* %17, i32* %18, i32* %row, i32* %col)
  %19 = load i32* %player, align 4
  %20 = load i32* %row, align 4
  %21 = load i32* %col, align 4
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([28 x i8]* @.str5, i32 0, i32 0), i32 %19, i32 %20, i32 %21)
  %23 = load i32* %player, align 4
  %24 = sub nsw i32 1, %23
  store i32 %24, i32* %player, align 4
  %25 = load i32** %current, align 8
  %26 = bitcast i32* %25 to i8*
  call void @free(i8* %26)
  br label %27

; <label>:27                                      ; preds = %16, %9
  %28 = load i32** %temp, align 8
  store i32* %28, i32** %current, align 8
  br label %6

; <label>:29                                      ; preds = %6
  %30 = load %struct._play** %tree, align 8
  call void (...)* bitcast (void (%struct._play*)* @dump_play to void (...)*)(%struct._play* %30)
  %31 = load i32* %player, align 4
  %32 = sub nsw i32 1, %31
  %33 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str6, i32 0, i32 0), i32 %32)
  ret i32 0
}
