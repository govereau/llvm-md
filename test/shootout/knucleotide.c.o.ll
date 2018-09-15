; ModuleID = 'knucleotide.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.ht_ht = type { i32, %struct.ht_node**, i32, %struct.ht_node*, i32 }
%struct.ht_node = type { i8*, i32, %struct.ht_node* }
%struct.ssorter = type { i8*, i32 }

@.str = private constant [15 x i8] c"malloc ht_node\00"
@.str1 = private constant [14 x i8] c"strdup newkey\00"
@ht_prime_list = internal global [28 x i64] [i64 53, i64 97, i64 193, i64 389, i64 769, i64 1543, i64 3079, i64 6151, i64 12289, i64 24593, i64 49157, i64 98317, i64 196613, i64 393241, i64 786433, i64 1572869, i64 3145739, i64 6291469, i64 12582917, i64 25165843, i64 50331653, i64 100663319, i64 201326611, i64 402653189, i64 805306457, i64 1610612741, i64 3221225473, i64 4294967291], align 16
@.str2 = private constant [9 x i8] c"%s %.3f\0A\00"
@.str3 = private constant [2 x i8] c"\0A\00"
@.str4 = private constant [7 x i8] c"%d\09%s\0A\00"
@.str5 = private constant [30 x i8] c"Results/knucleotide-input.txt\00"
@.str6 = private constant [2 x i8] c"r\00"
@.str7 = private constant [4 x i8] c"GGT\00"
@.str8 = private constant [5 x i8] c"GGTA\00"
@.str9 = private constant [7 x i8] c"GGTATT\00"
@.str10 = private constant [13 x i8] c"GGTATTTTAATT\00"
@.str11 = private constant [19 x i8] c"GGTATTTTAATTTATAGT\00"

define i32 @ht_val(%struct.ht_node* %node) nounwind ssp {
  %1 = alloca %struct.ht_node*, align 8
  store %struct.ht_node* %node, %struct.ht_node** %1, align 8
  %2 = load %struct.ht_node** %1, align 8
  %3 = getelementptr inbounds %struct.ht_node* %2, i32 0, i32 1
  %4 = load i32* %3, align 4
  ret i32 %4
}

define i8* @ht_key(%struct.ht_node* %node) nounwind ssp {
  %1 = alloca %struct.ht_node*, align 8
  store %struct.ht_node* %node, %struct.ht_node** %1, align 8
  %2 = load %struct.ht_node** %1, align 8
  %3 = getelementptr inbounds %struct.ht_node* %2, i32 0, i32 0
  %4 = load i8** %3, align 8
  ret i8* %4
}

define i32 @ht_hashcode(%struct.ht_ht* %ht, i8* %key) nounwind ssp {
  %1 = alloca %struct.ht_ht*, align 8
  %2 = alloca i8*, align 8
  %val = alloca i64, align 8
  store %struct.ht_ht* %ht, %struct.ht_ht** %1, align 8
  store i8* %key, i8** %2, align 8
  store i64 0, i64* %val, align 8
  br label %3

; <label>:3                                       ; preds = %15, %0
  %4 = load i8** %2, align 8
  %5 = load i8* %4
  %6 = icmp ne i8 %5, 0
  br i1 %6, label %7, label %18

; <label>:7                                       ; preds = %3
  %8 = load i64* %val, align 8
  %9 = mul i64 5, %8
  %10 = load i8** %2, align 8
  %11 = load i8* %10
  %12 = sext i8 %11 to i32
  %13 = sext i32 %12 to i64
  %14 = add i64 %9, %13
  store i64 %14, i64* %val, align 8
  br label %15

; <label>:15                                      ; preds = %7
  %16 = load i8** %2, align 8
  %17 = getelementptr inbounds i8* %16, i32 1
  store i8* %17, i8** %2, align 8
  br label %3

; <label>:18                                      ; preds = %3
  %19 = load i64* %val, align 8
  %20 = load %struct.ht_ht** %1, align 8
  %21 = getelementptr inbounds %struct.ht_ht* %20, i32 0, i32 0
  %22 = load i32* %21, align 4
  %23 = sext i32 %22 to i64
  %24 = urem i64 %19, %23
  %25 = trunc i64 %24 to i32
  ret i32 %25
}

define %struct.ht_node* @ht_node_create(i8* %key) nounwind ssp {
  %1 = alloca i8*, align 8
  %newkey = alloca i8*, align 8
  %node = alloca %struct.ht_node*, align 8
  store i8* %key, i8** %1, align 8
  %2 = call i8* @malloc(i64 24)
  %3 = bitcast i8* %2 to %struct.ht_node*
  store %struct.ht_node* %3, %struct.ht_node** %node, align 8
  %4 = icmp eq %struct.ht_node* %3, null
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  call void @perror(i8* getelementptr inbounds ([15 x i8]* @.str, i32 0, i32 0))
  call void @exit(i32 1) noreturn
  unreachable

; <label>:6                                       ; preds = %0
  %7 = load i8** %1, align 8
  %8 = call i8* @strdup(i8* %7)
  store i8* %8, i8** %newkey, align 8
  %9 = icmp eq i8* %8, null
  br i1 %9, label %10, label %11

; <label>:10                                      ; preds = %6
  call void @perror(i8* getelementptr inbounds ([14 x i8]* @.str1, i32 0, i32 0))
  call void @exit(i32 1) noreturn
  unreachable

; <label>:11                                      ; preds = %6
  %12 = load i8** %newkey, align 8
  %13 = load %struct.ht_node** %node, align 8
  %14 = getelementptr inbounds %struct.ht_node* %13, i32 0, i32 0
  store i8* %12, i8** %14, align 8
  %15 = load %struct.ht_node** %node, align 8
  %16 = getelementptr inbounds %struct.ht_node* %15, i32 0, i32 1
  store i32 0, i32* %16, align 4
  %17 = load %struct.ht_node** %node, align 8
  %18 = getelementptr inbounds %struct.ht_node* %17, i32 0, i32 2
  store %struct.ht_node* null, %struct.ht_node** %18, align 8
  %19 = load %struct.ht_node** %node, align 8
  ret %struct.ht_node* %19
}

declare i8* @malloc(i64)

declare void @perror(i8*)

declare void @exit(i32) noreturn

declare i8* @strdup(i8*)

define %struct.ht_ht* @ht_create(i32 %size) nounwind ssp {
  %1 = alloca i32, align 4
  %i = alloca i32, align 4
  %ht = alloca %struct.ht_ht*, align 8
  store i32 %size, i32* %1, align 4
  store i32 0, i32* %i, align 4
  %2 = call i8* @malloc(i64 40)
  %3 = bitcast i8* %2 to %struct.ht_ht*
  store %struct.ht_ht* %3, %struct.ht_ht** %ht, align 8
  br label %4

; <label>:4                                       ; preds = %12, %0
  %5 = load i32* %i, align 4
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds [28 x i64]* @ht_prime_list, i32 0, i64 %6
  %8 = load i64* %7
  %9 = load i32* %1, align 4
  %10 = sext i32 %9 to i64
  %11 = icmp ult i64 %8, %10
  br i1 %11, label %12, label %15

; <label>:12                                      ; preds = %4
  %13 = load i32* %i, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, i32* %i, align 4
  br label %4

; <label>:15                                      ; preds = %4
  %16 = load i32* %i, align 4
  %17 = sext i32 %16 to i64
  %18 = getelementptr inbounds [28 x i64]* @ht_prime_list, i32 0, i64 %17
  %19 = load i64* %18
  %20 = trunc i64 %19 to i32
  %21 = load %struct.ht_ht** %ht, align 8
  %22 = getelementptr inbounds %struct.ht_ht* %21, i32 0, i32 0
  store i32 %20, i32* %22, align 4
  %23 = load %struct.ht_ht** %ht, align 8
  %24 = getelementptr inbounds %struct.ht_ht* %23, i32 0, i32 0
  %25 = load i32* %24, align 4
  %26 = sext i32 %25 to i64
  %27 = call i8* @calloc(i64 %26, i64 8)
  %28 = bitcast i8* %27 to %struct.ht_node**
  %29 = load %struct.ht_ht** %ht, align 8
  %30 = getelementptr inbounds %struct.ht_ht* %29, i32 0, i32 1
  store %struct.ht_node** %28, %struct.ht_node*** %30, align 8
  %31 = load %struct.ht_ht** %ht, align 8
  %32 = getelementptr inbounds %struct.ht_ht* %31, i32 0, i32 2
  store i32 0, i32* %32, align 4
  %33 = load %struct.ht_ht** %ht, align 8
  %34 = getelementptr inbounds %struct.ht_ht* %33, i32 0, i32 3
  store %struct.ht_node* null, %struct.ht_node** %34, align 8
  %35 = load %struct.ht_ht** %ht, align 8
  %36 = getelementptr inbounds %struct.ht_ht* %35, i32 0, i32 4
  store i32 0, i32* %36, align 4
  %37 = load %struct.ht_ht** %ht, align 8
  ret %struct.ht_ht* %37
}

declare i8* @calloc(i64, i64)

define void @ht_destroy(%struct.ht_ht* %ht) nounwind ssp {
  %1 = alloca %struct.ht_ht*, align 8
  %cur = alloca %struct.ht_node*, align 8
  %next = alloca %struct.ht_node*, align 8
  %i = alloca i32, align 4
  store %struct.ht_ht* %ht, %struct.ht_ht** %1, align 8
  store i32 0, i32* %i, align 4
  br label %2

; <label>:2                                       ; preds = %30, %0
  %3 = load i32* %i, align 4
  %4 = load %struct.ht_ht** %1, align 8
  %5 = getelementptr inbounds %struct.ht_ht* %4, i32 0, i32 0
  %6 = load i32* %5, align 4
  %7 = icmp slt i32 %3, %6
  br i1 %7, label %8, label %33

; <label>:8                                       ; preds = %2
  %9 = load i32* %i, align 4
  %10 = sext i32 %9 to i64
  %11 = load %struct.ht_ht** %1, align 8
  %12 = getelementptr inbounds %struct.ht_ht* %11, i32 0, i32 1
  %13 = load %struct.ht_node*** %12, align 8
  %14 = getelementptr inbounds %struct.ht_node** %13, i64 %10
  %15 = load %struct.ht_node** %14
  store %struct.ht_node* %15, %struct.ht_node** %next, align 8
  br label %16

; <label>:16                                      ; preds = %19, %8
  %17 = load %struct.ht_node** %next, align 8
  %18 = icmp ne %struct.ht_node* %17, null
  br i1 %18, label %19, label %29

; <label>:19                                      ; preds = %16
  %20 = load %struct.ht_node** %next, align 8
  store %struct.ht_node* %20, %struct.ht_node** %cur, align 8
  %21 = load %struct.ht_node** %next, align 8
  %22 = getelementptr inbounds %struct.ht_node* %21, i32 0, i32 2
  %23 = load %struct.ht_node** %22, align 8
  store %struct.ht_node* %23, %struct.ht_node** %next, align 8
  %24 = load %struct.ht_node** %cur, align 8
  %25 = getelementptr inbounds %struct.ht_node* %24, i32 0, i32 0
  %26 = load i8** %25, align 8
  call void @free(i8* %26)
  %27 = load %struct.ht_node** %cur, align 8
  %28 = bitcast %struct.ht_node* %27 to i8*
  call void @free(i8* %28)
  br label %16

; <label>:29                                      ; preds = %16
  br label %30

; <label>:30                                      ; preds = %29
  %31 = load i32* %i, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, i32* %i, align 4
  br label %2

; <label>:33                                      ; preds = %2
  %34 = load %struct.ht_ht** %1, align 8
  %35 = getelementptr inbounds %struct.ht_ht* %34, i32 0, i32 1
  %36 = load %struct.ht_node*** %35, align 8
  %37 = bitcast %struct.ht_node** %36 to i8*
  call void @free(i8* %37)
  %38 = load %struct.ht_ht** %1, align 8
  %39 = bitcast %struct.ht_ht* %38 to i8*
  call void @free(i8* %39)
  ret void
}

declare void @free(i8*)

define %struct.ht_node* @ht_find(%struct.ht_ht* %ht, i8* %key) nounwind ssp {
  %1 = alloca %struct.ht_node*, align 8
  %2 = alloca %struct.ht_ht*, align 8
  %3 = alloca i8*, align 8
  %hash_code = alloca i32, align 4
  %node = alloca %struct.ht_node*, align 8
  store %struct.ht_ht* %ht, %struct.ht_ht** %2, align 8
  store i8* %key, i8** %3, align 8
  %4 = load %struct.ht_ht** %2, align 8
  %5 = load i8** %3, align 8
  %6 = call i32 @ht_hashcode(%struct.ht_ht* %4, i8* %5)
  store i32 %6, i32* %hash_code, align 4
  %7 = load i32* %hash_code, align 4
  %8 = sext i32 %7 to i64
  %9 = load %struct.ht_ht** %2, align 8
  %10 = getelementptr inbounds %struct.ht_ht* %9, i32 0, i32 1
  %11 = load %struct.ht_node*** %10, align 8
  %12 = getelementptr inbounds %struct.ht_node** %11, i64 %8
  %13 = load %struct.ht_node** %12
  store %struct.ht_node* %13, %struct.ht_node** %node, align 8
  br label %14

; <label>:14                                      ; preds = %26, %0
  %15 = load %struct.ht_node** %node, align 8
  %16 = icmp ne %struct.ht_node* %15, null
  br i1 %16, label %17, label %30

; <label>:17                                      ; preds = %14
  %18 = load i8** %3, align 8
  %19 = load %struct.ht_node** %node, align 8
  %20 = getelementptr inbounds %struct.ht_node* %19, i32 0, i32 0
  %21 = load i8** %20, align 8
  %22 = call i32 @strcmp(i8* %18, i8* %21)
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %24, label %26

; <label>:24                                      ; preds = %17
  %25 = load %struct.ht_node** %node, align 8
  store %struct.ht_node* %25, %struct.ht_node** %1
  br label %31

; <label>:26                                      ; preds = %17
  %27 = load %struct.ht_node** %node, align 8
  %28 = getelementptr inbounds %struct.ht_node* %27, i32 0, i32 2
  %29 = load %struct.ht_node** %28, align 8
  store %struct.ht_node* %29, %struct.ht_node** %node, align 8
  br label %14

; <label>:30                                      ; preds = %14
  store %struct.ht_node* null, %struct.ht_node** %1
  br label %31

; <label>:31                                      ; preds = %30, %24
  %32 = load %struct.ht_node** %1
  ret %struct.ht_node* %32
}

declare i32 @strcmp(i8*, i8*)

define %struct.ht_node* @ht_find_new(%struct.ht_ht* %ht, i8* %key) nounwind ssp {
  %1 = alloca %struct.ht_node*, align 8
  %2 = alloca %struct.ht_ht*, align 8
  %3 = alloca i8*, align 8
  %hash_code = alloca i32, align 4
  %prev = alloca %struct.ht_node*, align 8
  %node = alloca %struct.ht_node*, align 8
  store %struct.ht_ht* %ht, %struct.ht_ht** %2, align 8
  store i8* %key, i8** %3, align 8
  %4 = load %struct.ht_ht** %2, align 8
  %5 = load i8** %3, align 8
  %6 = call i32 @ht_hashcode(%struct.ht_ht* %4, i8* %5)
  store i32 %6, i32* %hash_code, align 4
  store %struct.ht_node* null, %struct.ht_node** %prev, align 8
  %7 = load i32* %hash_code, align 4
  %8 = sext i32 %7 to i64
  %9 = load %struct.ht_ht** %2, align 8
  %10 = getelementptr inbounds %struct.ht_ht* %9, i32 0, i32 1
  %11 = load %struct.ht_node*** %10, align 8
  %12 = getelementptr inbounds %struct.ht_node** %11, i64 %8
  %13 = load %struct.ht_node** %12
  store %struct.ht_node* %13, %struct.ht_node** %node, align 8
  br label %14

; <label>:14                                      ; preds = %26, %0
  %15 = load %struct.ht_node** %node, align 8
  %16 = icmp ne %struct.ht_node* %15, null
  br i1 %16, label %17, label %31

; <label>:17                                      ; preds = %14
  %18 = load i8** %3, align 8
  %19 = load %struct.ht_node** %node, align 8
  %20 = getelementptr inbounds %struct.ht_node* %19, i32 0, i32 0
  %21 = load i8** %20, align 8
  %22 = call i32 @strcmp(i8* %18, i8* %21)
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %24, label %26

; <label>:24                                      ; preds = %17
  %25 = load %struct.ht_node** %node, align 8
  store %struct.ht_node* %25, %struct.ht_node** %1
  br label %52

; <label>:26                                      ; preds = %17
  %27 = load %struct.ht_node** %node, align 8
  store %struct.ht_node* %27, %struct.ht_node** %prev, align 8
  %28 = load %struct.ht_node** %node, align 8
  %29 = getelementptr inbounds %struct.ht_node* %28, i32 0, i32 2
  %30 = load %struct.ht_node** %29, align 8
  store %struct.ht_node* %30, %struct.ht_node** %node, align 8
  br label %14

; <label>:31                                      ; preds = %14
  %32 = load %struct.ht_ht** %2, align 8
  %33 = getelementptr inbounds %struct.ht_ht* %32, i32 0, i32 4
  %34 = load i32* %33, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, i32* %33, align 4
  %36 = load %struct.ht_node** %prev, align 8
  %37 = icmp ne %struct.ht_node* %36, null
  br i1 %37, label %38, label %43

; <label>:38                                      ; preds = %31
  %39 = load i8** %3, align 8
  %40 = call %struct.ht_node* @ht_node_create(i8* %39)
  %41 = load %struct.ht_node** %prev, align 8
  %42 = getelementptr inbounds %struct.ht_node* %41, i32 0, i32 2
  store %struct.ht_node* %40, %struct.ht_node** %42, align 8
  store %struct.ht_node* %40, %struct.ht_node** %1
  br label %52

; <label>:43                                      ; preds = %31
  %44 = load i8** %3, align 8
  %45 = call %struct.ht_node* @ht_node_create(i8* %44)
  %46 = load i32* %hash_code, align 4
  %47 = sext i32 %46 to i64
  %48 = load %struct.ht_ht** %2, align 8
  %49 = getelementptr inbounds %struct.ht_ht* %48, i32 0, i32 1
  %50 = load %struct.ht_node*** %49, align 8
  %51 = getelementptr inbounds %struct.ht_node** %50, i64 %47
  store %struct.ht_node* %45, %struct.ht_node** %51
  store %struct.ht_node* %45, %struct.ht_node** %1
  br label %52

; <label>:52                                      ; preds = %43, %38, %24
  %53 = load %struct.ht_node** %1
  ret %struct.ht_node* %53
}

define %struct.ht_node* @ht_next(%struct.ht_ht* %ht) nounwind ssp {
  %1 = alloca %struct.ht_node*, align 8
  %2 = alloca %struct.ht_ht*, align 8
  %index = alloca i64, align 8
  %node = alloca %struct.ht_node*, align 8
  store %struct.ht_ht* %ht, %struct.ht_ht** %2, align 8
  %3 = load %struct.ht_ht** %2, align 8
  %4 = getelementptr inbounds %struct.ht_ht* %3, i32 0, i32 3
  %5 = load %struct.ht_node** %4, align 8
  store %struct.ht_node* %5, %struct.ht_node** %node, align 8
  %6 = load %struct.ht_node** %node, align 8
  %7 = icmp ne %struct.ht_node* %6, null
  br i1 %7, label %8, label %15

; <label>:8                                       ; preds = %0
  %9 = load %struct.ht_node** %node, align 8
  %10 = getelementptr inbounds %struct.ht_node* %9, i32 0, i32 2
  %11 = load %struct.ht_node** %10, align 8
  %12 = load %struct.ht_ht** %2, align 8
  %13 = getelementptr inbounds %struct.ht_ht* %12, i32 0, i32 3
  store %struct.ht_node* %11, %struct.ht_node** %13, align 8
  %14 = load %struct.ht_node** %node, align 8
  store %struct.ht_node* %14, %struct.ht_node** %1
  br label %57

; <label>:15                                      ; preds = %0
  br label %16

; <label>:16                                      ; preds = %54, %15
  %17 = load %struct.ht_ht** %2, align 8
  %18 = getelementptr inbounds %struct.ht_ht* %17, i32 0, i32 2
  %19 = load i32* %18, align 4
  %20 = load %struct.ht_ht** %2, align 8
  %21 = getelementptr inbounds %struct.ht_ht* %20, i32 0, i32 0
  %22 = load i32* %21, align 4
  %23 = icmp slt i32 %19, %22
  br i1 %23, label %24, label %55

; <label>:24                                      ; preds = %16
  %25 = load %struct.ht_ht** %2, align 8
  %26 = getelementptr inbounds %struct.ht_ht* %25, i32 0, i32 2
  %27 = load i32* %26, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, i32* %26, align 4
  %29 = sext i32 %27 to i64
  store i64 %29, i64* %index, align 8
  %30 = load i64* %index, align 8
  %31 = load %struct.ht_ht** %2, align 8
  %32 = getelementptr inbounds %struct.ht_ht* %31, i32 0, i32 1
  %33 = load %struct.ht_node*** %32, align 8
  %34 = getelementptr inbounds %struct.ht_node** %33, i64 %30
  %35 = load %struct.ht_node** %34
  %36 = icmp ne %struct.ht_node* %35, null
  br i1 %36, label %37, label %54

; <label>:37                                      ; preds = %24
  %38 = load i64* %index, align 8
  %39 = load %struct.ht_ht** %2, align 8
  %40 = getelementptr inbounds %struct.ht_ht* %39, i32 0, i32 1
  %41 = load %struct.ht_node*** %40, align 8
  %42 = getelementptr inbounds %struct.ht_node** %41, i64 %38
  %43 = load %struct.ht_node** %42
  %44 = getelementptr inbounds %struct.ht_node* %43, i32 0, i32 2
  %45 = load %struct.ht_node** %44, align 8
  %46 = load %struct.ht_ht** %2, align 8
  %47 = getelementptr inbounds %struct.ht_ht* %46, i32 0, i32 3
  store %struct.ht_node* %45, %struct.ht_node** %47, align 8
  %48 = load i64* %index, align 8
  %49 = load %struct.ht_ht** %2, align 8
  %50 = getelementptr inbounds %struct.ht_ht* %49, i32 0, i32 1
  %51 = load %struct.ht_node*** %50, align 8
  %52 = getelementptr inbounds %struct.ht_node** %51, i64 %48
  %53 = load %struct.ht_node** %52
  store %struct.ht_node* %53, %struct.ht_node** %1
  br label %57

; <label>:54                                      ; preds = %24
  br label %16

; <label>:55                                      ; preds = %16
  br label %56

; <label>:56                                      ; preds = %55
  store %struct.ht_node* null, %struct.ht_node** %1
  br label %57

; <label>:57                                      ; preds = %56, %37, %8
  %58 = load %struct.ht_node** %1
  ret %struct.ht_node* %58
}

define %struct.ht_node* @ht_first(%struct.ht_ht* %ht) nounwind ssp {
  %1 = alloca %struct.ht_ht*, align 8
  store %struct.ht_ht* %ht, %struct.ht_ht** %1, align 8
  %2 = load %struct.ht_ht** %1, align 8
  %3 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 2
  store i32 0, i32* %3, align 4
  %4 = load %struct.ht_ht** %1, align 8
  %5 = getelementptr inbounds %struct.ht_ht* %4, i32 0, i32 3
  store %struct.ht_node* null, %struct.ht_node** %5, align 8
  %6 = load %struct.ht_ht** %1, align 8
  %7 = call %struct.ht_node* @ht_next(%struct.ht_ht* %6)
  ret %struct.ht_node* %7
}

define i32 @ht_count(%struct.ht_ht* %ht) nounwind ssp {
  %1 = alloca %struct.ht_ht*, align 8
  store %struct.ht_ht* %ht, %struct.ht_ht** %1, align 8
  %2 = load %struct.ht_ht** %1, align 8
  %3 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 4
  %4 = load i32* %3, align 4
  ret i32 %4
}

define i64 @hash_table_size(i32 %fl, i64 %buflen) nounwind ssp {
  %1 = alloca i64, align 8
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  %maxsize1 = alloca i64, align 8
  %maxsize2 = alloca i64, align 8
  store i32 %fl, i32* %2, align 4
  store i64 %buflen, i64* %3, align 8
  %4 = load i64* %3, align 8
  %5 = load i32* %2, align 4
  %6 = sext i32 %5 to i64
  %7 = sub nsw i64 %4, %6
  store i64 %7, i64* %maxsize1, align 8
  store i64 4, i64* %maxsize2, align 8
  br label %8

; <label>:8                                       ; preds = %18, %0
  %9 = load i32* %2, align 4
  %10 = add nsw i32 %9, -1
  store i32 %10, i32* %2, align 4
  %11 = icmp sgt i32 %10, 0
  br i1 %11, label %12, label %16

; <label>:12                                      ; preds = %8
  %13 = load i64* %maxsize2, align 8
  %14 = load i64* %maxsize1, align 8
  %15 = icmp slt i64 %13, %14
  br label %16

; <label>:16                                      ; preds = %12, %8
  %17 = phi i1 [ false, %8 ], [ %15, %12 ]
  br i1 %17, label %18, label %21

; <label>:18                                      ; preds = %16
  %19 = load i64* %maxsize2, align 8
  %20 = mul nsw i64 %19, 4
  store i64 %20, i64* %maxsize2, align 8
  br label %8

; <label>:21                                      ; preds = %16
  %22 = load i64* %maxsize1, align 8
  %23 = load i64* %maxsize2, align 8
  %24 = icmp slt i64 %22, %23
  br i1 %24, label %25, label %27

; <label>:25                                      ; preds = %21
  %26 = load i64* %maxsize1, align 8
  store i64 %26, i64* %1
  br label %29

; <label>:27                                      ; preds = %21
  %28 = load i64* %maxsize2, align 8
  store i64 %28, i64* %1
  br label %29

; <label>:29                                      ; preds = %27, %25
  %30 = load i64* %1
  ret i64 %30
}

define %struct.ht_ht* @generate_frequencies(i32 %fl, i8* %buffer, i64 %buflen) nounwind ssp {
  %1 = alloca %struct.ht_ht*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i8*, align 8
  %4 = alloca i64, align 8
  %ht = alloca %struct.ht_ht*, align 8
  %reader = alloca i8*, align 8
  %i = alloca i64, align 8
  %nulled = alloca i8, align 1
  store i32 %fl, i32* %2, align 4
  store i8* %buffer, i8** %3, align 8
  store i64 %buflen, i64* %4, align 8
  %5 = load i32* %2, align 4
  %6 = sext i32 %5 to i64
  %7 = load i64* %4, align 8
  %8 = icmp sgt i64 %6, %7
  br i1 %8, label %9, label %10

; <label>:9                                       ; preds = %0
  store %struct.ht_ht* null, %struct.ht_ht** %1
  br label %53

; <label>:10                                      ; preds = %0
  %11 = load i32* %2, align 4
  %12 = load i64* %4, align 8
  %13 = call i64 @hash_table_size(i32 %11, i64 %12)
  %14 = trunc i64 %13 to i32
  %15 = call %struct.ht_ht* @ht_create(i32 %14)
  store %struct.ht_ht* %15, %struct.ht_ht** %ht, align 8
  store i64 0, i64* %i, align 8
  br label %16

; <label>:16                                      ; preds = %48, %10
  %17 = load i64* %i, align 8
  %18 = load i64* %4, align 8
  %19 = load i32* %2, align 4
  %20 = sext i32 %19 to i64
  %21 = sub nsw i64 %18, %20
  %22 = add nsw i64 %21, 1
  %23 = icmp slt i64 %17, %22
  br i1 %23, label %24, label %51

; <label>:24                                      ; preds = %16
  %25 = load i64* %i, align 8
  %26 = load i8** %3, align 8
  %27 = getelementptr inbounds i8* %26, i64 %25
  store i8* %27, i8** %reader, align 8
  %28 = load i32* %2, align 4
  %29 = sext i32 %28 to i64
  %30 = load i8** %reader, align 8
  %31 = getelementptr inbounds i8* %30, i64 %29
  %32 = load i8* %31
  store i8 %32, i8* %nulled, align 1
  %33 = load i32* %2, align 4
  %34 = sext i32 %33 to i64
  %35 = load i8** %reader, align 8
  %36 = getelementptr inbounds i8* %35, i64 %34
  store i8 0, i8* %36
  %37 = load %struct.ht_ht** %ht, align 8
  %38 = load i8** %reader, align 8
  %39 = call %struct.ht_node* @ht_find_new(%struct.ht_ht* %37, i8* %38)
  %40 = getelementptr inbounds %struct.ht_node* %39, i32 0, i32 1
  %41 = load i32* %40, align 4
  %42 = add nsw i32 %41, 1
  store i32 %42, i32* %40, align 4
  %43 = load i8* %nulled, align 1
  %44 = load i32* %2, align 4
  %45 = sext i32 %44 to i64
  %46 = load i8** %reader, align 8
  %47 = getelementptr inbounds i8* %46, i64 %45
  store i8 %43, i8* %47
  br label %48

; <label>:48                                      ; preds = %24
  %49 = load i64* %i, align 8
  %50 = add nsw i64 %49, 1
  store i64 %50, i64* %i, align 8
  br label %16

; <label>:51                                      ; preds = %16
  %52 = load %struct.ht_ht** %ht, align 8
  store %struct.ht_ht* %52, %struct.ht_ht** %1
  br label %53

; <label>:53                                      ; preds = %51, %9
  %54 = load %struct.ht_ht** %1
  ret %struct.ht_ht* %54
}

define void @write_frequencies(i32 %fl, i8* %buffer, i64 %buflen) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i8*, align 8
  %3 = alloca i64, align 8
  %ht = alloca %struct.ht_ht*, align 8
  %total = alloca i64, align 8
  %i = alloca i64, align 8
  %j = alloca i64, align 8
  %size = alloca i64, align 8
  %nd = alloca %struct.ht_node*, align 8
  %s = alloca %struct.__sbuf*, align 8
  %tmp = alloca %struct.__sbuf, align 8
  store i32 %fl, i32* %1, align 4
  store i8* %buffer, i8** %2, align 8
  store i64 %buflen, i64* %3, align 8
  %4 = load i32* %1, align 4
  %5 = load i8** %2, align 8
  %6 = load i64* %3, align 8
  %7 = call %struct.ht_ht* @generate_frequencies(i32 %4, i8* %5, i64 %6)
  store %struct.ht_ht* %7, %struct.ht_ht** %ht, align 8
  store i64 0, i64* %total, align 8
  store i64 0, i64* %size, align 8
  %8 = load %struct.ht_ht** %ht, align 8
  %9 = call %struct.ht_node* @ht_first(%struct.ht_ht* %8)
  store %struct.ht_node* %9, %struct.ht_node** %nd, align 8
  br label %10

; <label>:10                                      ; preds = %22, %0
  %11 = load %struct.ht_node** %nd, align 8
  %12 = icmp ne %struct.ht_node* %11, null
  br i1 %12, label %13, label %25

; <label>:13                                      ; preds = %10
  %14 = load i64* %total, align 8
  %15 = load %struct.ht_node** %nd, align 8
  %16 = getelementptr inbounds %struct.ht_node* %15, i32 0, i32 1
  %17 = load i32* %16, align 4
  %18 = sext i32 %17 to i64
  %19 = add nsw i64 %14, %18
  store i64 %19, i64* %total, align 8
  %20 = load i64* %size, align 8
  %21 = add nsw i64 %20, 1
  store i64 %21, i64* %size, align 8
  br label %22

; <label>:22                                      ; preds = %13
  %23 = load %struct.ht_ht** %ht, align 8
  %24 = call %struct.ht_node* @ht_next(%struct.ht_ht* %23)
  store %struct.ht_node* %24, %struct.ht_node** %nd, align 8
  br label %10

; <label>:25                                      ; preds = %10
  %26 = load i64* %size, align 8
  %27 = call i8* @calloc(i64 %26, i64 16)
  %28 = bitcast i8* %27 to %struct.__sbuf*
  store %struct.__sbuf* %28, %struct.__sbuf** %s, align 8
  store i64 0, i64* %i, align 8
  %29 = load %struct.ht_ht** %ht, align 8
  %30 = call %struct.ht_node* @ht_first(%struct.ht_ht* %29)
  store %struct.ht_node* %30, %struct.ht_node** %nd, align 8
  br label %31

; <label>:31                                      ; preds = %50, %25
  %32 = load %struct.ht_node** %nd, align 8
  %33 = icmp ne %struct.ht_node* %32, null
  br i1 %33, label %34, label %53

; <label>:34                                      ; preds = %31
  %35 = load %struct.ht_node** %nd, align 8
  %36 = getelementptr inbounds %struct.ht_node* %35, i32 0, i32 0
  %37 = load i8** %36, align 8
  %38 = load i64* %i, align 8
  %39 = load %struct.__sbuf** %s, align 8
  %40 = getelementptr inbounds %struct.__sbuf* %39, i64 %38
  %41 = getelementptr inbounds %struct.__sbuf* %40, i32 0, i32 0
  store i8* %37, i8** %41, align 8
  %42 = load %struct.ht_node** %nd, align 8
  %43 = getelementptr inbounds %struct.ht_node* %42, i32 0, i32 1
  %44 = load i32* %43, align 4
  %45 = load i64* %i, align 8
  %46 = add nsw i64 %45, 1
  store i64 %46, i64* %i, align 8
  %47 = load %struct.__sbuf** %s, align 8
  %48 = getelementptr inbounds %struct.__sbuf* %47, i64 %45
  %49 = getelementptr inbounds %struct.__sbuf* %48, i32 0, i32 1
  store i32 %44, i32* %49, align 4
  br label %50

; <label>:50                                      ; preds = %34
  %51 = load %struct.ht_ht** %ht, align 8
  %52 = call %struct.ht_node* @ht_next(%struct.ht_ht* %51)
  store %struct.ht_node* %52, %struct.ht_node** %nd, align 8
  br label %31

; <label>:53                                      ; preds = %31
  store i64 0, i64* %i, align 8
  br label %54

; <label>:54                                      ; preds = %150, %53
  %55 = load i64* %i, align 8
  %56 = load i64* %size, align 8
  %57 = sub nsw i64 %56, 1
  %58 = icmp slt i64 %55, %57
  br i1 %58, label %59, label %153

; <label>:59                                      ; preds = %54
  %60 = load i64* %i, align 8
  %61 = add nsw i64 %60, 1
  store i64 %61, i64* %j, align 8
  br label %62

; <label>:62                                      ; preds = %146, %59
  %63 = load i64* %j, align 8
  %64 = load i64* %size, align 8
  %65 = icmp slt i64 %63, %64
  br i1 %65, label %66, label %149

; <label>:66                                      ; preds = %62
  %67 = load i64* %i, align 8
  %68 = load %struct.__sbuf** %s, align 8
  %69 = getelementptr inbounds %struct.__sbuf* %68, i64 %67
  %70 = getelementptr inbounds %struct.__sbuf* %69, i32 0, i32 1
  %71 = load i32* %70, align 4
  %72 = load i64* %j, align 8
  %73 = load %struct.__sbuf** %s, align 8
  %74 = getelementptr inbounds %struct.__sbuf* %73, i64 %72
  %75 = getelementptr inbounds %struct.__sbuf* %74, i32 0, i32 1
  %76 = load i32* %75, align 4
  %77 = icmp slt i32 %71, %76
  br i1 %77, label %78, label %145

; <label>:78                                      ; preds = %66
  %79 = bitcast %struct.__sbuf* %tmp to i8*
  %80 = load i64* %i, align 8
  %81 = load %struct.__sbuf** %s, align 8
  %82 = getelementptr inbounds %struct.__sbuf* %81, i64 %80
  %83 = bitcast %struct.__sbuf* %82 to i8*
  %84 = call i8* @__memcpy_chk(i8* %79, i8* %83, i64 16, i64 16)
  %85 = load i64* %i, align 8
  %86 = load %struct.__sbuf** %s, align 8
  %87 = getelementptr inbounds %struct.__sbuf* %86, i64 %85
  %88 = bitcast %struct.__sbuf* %87 to i8*
  %89 = call i64 @llvm.objectsize.i64(i8* %88, i1 false)
  %90 = icmp ne i64 %89, -1
  br i1 %90, label %91, label %106

; <label>:91                                      ; preds = %78
  %92 = load i64* %i, align 8
  %93 = load %struct.__sbuf** %s, align 8
  %94 = getelementptr inbounds %struct.__sbuf* %93, i64 %92
  %95 = bitcast %struct.__sbuf* %94 to i8*
  %96 = load i64* %j, align 8
  %97 = load %struct.__sbuf** %s, align 8
  %98 = getelementptr inbounds %struct.__sbuf* %97, i64 %96
  %99 = bitcast %struct.__sbuf* %98 to i8*
  %100 = load i64* %i, align 8
  %101 = load %struct.__sbuf** %s, align 8
  %102 = getelementptr inbounds %struct.__sbuf* %101, i64 %100
  %103 = bitcast %struct.__sbuf* %102 to i8*
  %104 = call i64 @llvm.objectsize.i64(i8* %103, i1 false)
  %105 = call i8* @__memcpy_chk(i8* %95, i8* %99, i64 16, i64 %104)
  br label %116

; <label>:106                                     ; preds = %78
  %107 = load i64* %i, align 8
  %108 = load %struct.__sbuf** %s, align 8
  %109 = getelementptr inbounds %struct.__sbuf* %108, i64 %107
  %110 = bitcast %struct.__sbuf* %109 to i8*
  %111 = load i64* %j, align 8
  %112 = load %struct.__sbuf** %s, align 8
  %113 = getelementptr inbounds %struct.__sbuf* %112, i64 %111
  %114 = bitcast %struct.__sbuf* %113 to i8*
  %115 = call i8* @__inline_memcpy_chk(i8* %110, i8* %114, i64 16)
  br label %116

; <label>:116                                     ; preds = %106, %91
  %117 = phi i8* [ %105, %91 ], [ %115, %106 ]
  %118 = load i64* %j, align 8
  %119 = load %struct.__sbuf** %s, align 8
  %120 = getelementptr inbounds %struct.__sbuf* %119, i64 %118
  %121 = bitcast %struct.__sbuf* %120 to i8*
  %122 = call i64 @llvm.objectsize.i64(i8* %121, i1 false)
  %123 = icmp ne i64 %122, -1
  br i1 %123, label %124, label %136

; <label>:124                                     ; preds = %116
  %125 = load i64* %j, align 8
  %126 = load %struct.__sbuf** %s, align 8
  %127 = getelementptr inbounds %struct.__sbuf* %126, i64 %125
  %128 = bitcast %struct.__sbuf* %127 to i8*
  %129 = bitcast %struct.__sbuf* %tmp to i8*
  %130 = load i64* %j, align 8
  %131 = load %struct.__sbuf** %s, align 8
  %132 = getelementptr inbounds %struct.__sbuf* %131, i64 %130
  %133 = bitcast %struct.__sbuf* %132 to i8*
  %134 = call i64 @llvm.objectsize.i64(i8* %133, i1 false)
  %135 = call i8* @__memcpy_chk(i8* %128, i8* %129, i64 16, i64 %134)
  br label %143

; <label>:136                                     ; preds = %116
  %137 = load i64* %j, align 8
  %138 = load %struct.__sbuf** %s, align 8
  %139 = getelementptr inbounds %struct.__sbuf* %138, i64 %137
  %140 = bitcast %struct.__sbuf* %139 to i8*
  %141 = bitcast %struct.__sbuf* %tmp to i8*
  %142 = call i8* @__inline_memcpy_chk(i8* %140, i8* %141, i64 16)
  br label %143

; <label>:143                                     ; preds = %136, %124
  %144 = phi i8* [ %135, %124 ], [ %142, %136 ]
  br label %145

; <label>:145                                     ; preds = %143, %66
  br label %146

; <label>:146                                     ; preds = %145
  %147 = load i64* %j, align 8
  %148 = add nsw i64 %147, 1
  store i64 %148, i64* %j, align 8
  br label %62

; <label>:149                                     ; preds = %62
  br label %150

; <label>:150                                     ; preds = %149
  %151 = load i64* %i, align 8
  %152 = add nsw i64 %151, 1
  store i64 %152, i64* %i, align 8
  br label %54

; <label>:153                                     ; preds = %54
  store i64 0, i64* %i, align 8
  br label %154

; <label>:154                                     ; preds = %176, %153
  %155 = load i64* %i, align 8
  %156 = load i64* %size, align 8
  %157 = icmp slt i64 %155, %156
  br i1 %157, label %158, label %179

; <label>:158                                     ; preds = %154
  %159 = load i64* %i, align 8
  %160 = load %struct.__sbuf** %s, align 8
  %161 = getelementptr inbounds %struct.__sbuf* %160, i64 %159
  %162 = getelementptr inbounds %struct.__sbuf* %161, i32 0, i32 0
  %163 = load i8** %162, align 8
  %164 = load i64* %i, align 8
  %165 = load %struct.__sbuf** %s, align 8
  %166 = getelementptr inbounds %struct.__sbuf* %165, i64 %164
  %167 = getelementptr inbounds %struct.__sbuf* %166, i32 0, i32 1
  %168 = load i32* %167, align 4
  %169 = sitofp i32 %168 to float
  %170 = fmul float 1.000000e+02, %169
  %171 = load i64* %total, align 8
  %172 = sitofp i64 %171 to float
  %173 = fdiv float %170, %172
  %174 = fpext float %173 to double
  %175 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i32 0, i32 0), i8* %163, double %174)
  br label %176

; <label>:176                                     ; preds = %158
  %177 = load i64* %i, align 8
  %178 = add nsw i64 %177, 1
  store i64 %178, i64* %i, align 8
  br label %154

; <label>:179                                     ; preds = %154
  %180 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str3, i32 0, i32 0))
  %181 = load %struct.ht_ht** %ht, align 8
  call void @ht_destroy(%struct.ht_ht* %181)
  %182 = load %struct.__sbuf** %s, align 8
  %183 = bitcast %struct.__sbuf* %182 to i8*
  call void @free(i8* %183)
  ret void
}

declare i8* @__memcpy_chk(i8*, i8*, i64, i64) nounwind

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

define internal i8* @__inline_memcpy_chk(i8* %__dest, i8* %__src, i64 %__len) nounwind inlinehint ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  %3 = alloca i64, align 8
  store i8* %__dest, i8** %1, align 8
  store i8* %__src, i8** %2, align 8
  store i64 %__len, i64* %3, align 8
  %4 = load i8** %1, align 8
  %5 = load i8** %2, align 8
  %6 = load i64* %3, align 8
  %7 = load i8** %1, align 8
  %8 = call i64 @llvm.objectsize.i64(i8* %7, i1 false)
  %9 = call i8* @__memcpy_chk(i8* %4, i8* %5, i64 %6, i64 %8)
  ret i8* %9
}

declare i32 @printf(i8*, ...)

define void @write_count(i8* %searchFor, i8* %buffer, i64 %buflen) nounwind ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i8*, align 8
  %3 = alloca i64, align 8
  %ht = alloca %struct.ht_ht*, align 8
  store i8* %searchFor, i8** %1, align 8
  store i8* %buffer, i8** %2, align 8
  store i64 %buflen, i64* %3, align 8
  %4 = load i8** %1, align 8
  %5 = call i64 @strlen(i8* %4)
  %6 = trunc i64 %5 to i32
  %7 = load i8** %2, align 8
  %8 = load i64* %3, align 8
  %9 = call %struct.ht_ht* @generate_frequencies(i32 %6, i8* %7, i64 %8)
  store %struct.ht_ht* %9, %struct.ht_ht** %ht, align 8
  %10 = load %struct.ht_ht** %ht, align 8
  %11 = load i8** %1, align 8
  %12 = call %struct.ht_node* @ht_find_new(%struct.ht_ht* %10, i8* %11)
  %13 = getelementptr inbounds %struct.ht_node* %12, i32 0, i32 1
  %14 = load i32* %13, align 4
  %15 = load i8** %1, align 8
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str4, i32 0, i32 0), i32 %14, i8* %15)
  %17 = load %struct.ht_ht** %ht, align 8
  call void @ht_destroy(%struct.ht_ht* %17)
  ret void
}

declare i64 @strlen(i8*)

define i32 @main() nounwind ssp {
  %1 = alloca i32, align 4
  %c = alloca i8, align 1
  %line = alloca i8*, align 8
  %buffer = alloca i8*, align 8
  %tmp = alloca i8*, align 8
  %x = alloca i8*, align 8
  %i = alloca i32, align 4
  %linelen = alloca i32, align 4
  %nothree = alloca i32, align 4
  %buflen = alloca i64, align 8
  %seqlen = alloca i64, align 8
  %f = alloca %struct.__sFILE*, align 8
  store i32 0, i32* %1
  %2 = call i8* @malloc(i64 256)
  store i8* %2, i8** %line, align 8
  %3 = load i8** %line, align 8
  %4 = icmp ne i8* %3, null
  br i1 %4, label %6, label %5

; <label>:5                                       ; preds = %0
  store i32 2, i32* %1
  br label %162

; <label>:6                                       ; preds = %0
  store i64 0, i64* %seqlen, align 8
  store i32 1, i32* %nothree, align 4
  %7 = call %struct.__sFILE* @"\01_fopen"(i8* getelementptr inbounds ([30 x i8]* @.str5, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8]* @.str6, i32 0, i32 0))
  store %struct.__sFILE* %7, %struct.__sFILE** %f, align 8
  %8 = load %struct.__sFILE** %f, align 8
  %9 = icmp eq %struct.__sFILE* %8, null
  br i1 %9, label %10, label %11

; <label>:10                                      ; preds = %6
  store i32 2, i32* %1
  br label %162

; <label>:11                                      ; preds = %6
  br label %12

; <label>:12                                      ; preds = %41, %11
  %13 = load i32* %nothree, align 4
  %14 = icmp ne i32 %13, 0
  br i1 %14, label %15, label %20

; <label>:15                                      ; preds = %12
  %16 = load i8** %line, align 8
  %17 = load %struct.__sFILE** %f, align 8
  %18 = call i8* @fgets(i8* %16, i32 255, %struct.__sFILE* %17)
  %19 = icmp ne i8* %18, null
  br label %20

; <label>:20                                      ; preds = %15, %12
  %21 = phi i1 [ false, %12 ], [ %19, %15 ]
  br i1 %21, label %22, label %42

; <label>:22                                      ; preds = %20
  %23 = load i8** %line, align 8
  %24 = getelementptr inbounds i8* %23, i64 0
  %25 = load i8* %24
  %26 = sext i8 %25 to i32
  %27 = icmp eq i32 %26, 62
  br i1 %27, label %28, label %41

; <label>:28                                      ; preds = %22
  %29 = load i8** %line, align 8
  %30 = getelementptr inbounds i8* %29, i64 1
  %31 = load i8* %30
  %32 = sext i8 %31 to i32
  %33 = icmp eq i32 %32, 84
  br i1 %33, label %34, label %41

; <label>:34                                      ; preds = %28
  %35 = load i8** %line, align 8
  %36 = getelementptr inbounds i8* %35, i64 2
  %37 = load i8* %36
  %38 = sext i8 %37 to i32
  %39 = icmp eq i32 %38, 72
  br i1 %39, label %40, label %41

; <label>:40                                      ; preds = %34
  store i32 0, i32* %nothree, align 4
  br label %41

; <label>:41                                      ; preds = %40, %34, %28, %22
  br label %12

; <label>:42                                      ; preds = %20
  %43 = load i8** %line, align 8
  call void @free(i8* %43)
  store i64 10240, i64* %buflen, align 8
  %44 = load i64* %buflen, align 8
  %45 = add nsw i64 %44, 1
  %46 = call i8* @malloc(i64 %45)
  store i8* %46, i8** %buffer, align 8
  %47 = load i8** %buffer, align 8
  %48 = icmp ne i8* %47, null
  br i1 %48, label %50, label %49

; <label>:49                                      ; preds = %42
  store i32 2, i32* %1
  br label %162

; <label>:50                                      ; preds = %42
  %51 = load i8** %buffer, align 8
  store i8* %51, i8** %x, align 8
  br label %52

; <label>:52                                      ; preds = %121, %50
  %53 = load i8** %x, align 8
  %54 = load %struct.__sFILE** %f, align 8
  %55 = call i8* @fgets(i8* %53, i32 255, %struct.__sFILE* %54)
  %56 = icmp ne i8* %55, null
  br i1 %56, label %57, label %122

; <label>:57                                      ; preds = %52
  %58 = load i8** %x, align 8
  %59 = call i64 @strlen(i8* %58)
  %60 = trunc i64 %59 to i32
  store i32 %60, i32* %linelen, align 4
  %61 = load i32* %linelen, align 4
  %62 = icmp ne i32 %61, 0
  br i1 %62, label %63, label %121

; <label>:63                                      ; preds = %57
  %64 = load i32* %linelen, align 4
  %65 = sub nsw i32 %64, 1
  %66 = sext i32 %65 to i64
  %67 = load i8** %x, align 8
  %68 = getelementptr inbounds i8* %67, i64 %66
  %69 = load i8* %68
  %70 = sext i8 %69 to i32
  %71 = icmp eq i32 %70, 10
  br i1 %71, label %72, label %75

; <label>:72                                      ; preds = %63
  %73 = load i32* %linelen, align 4
  %74 = add nsw i32 %73, -1
  store i32 %74, i32* %linelen, align 4
  br label %75

; <label>:75                                      ; preds = %72, %63
  %76 = load i8** %x, align 8
  %77 = getelementptr inbounds i8* %76, i64 0
  %78 = load i8* %77
  store i8 %78, i8* %c, align 1
  %79 = load i8* %c, align 1
  %80 = sext i8 %79 to i32
  %81 = icmp eq i32 %80, 62
  br i1 %81, label %82, label %83

; <label>:82                                      ; preds = %75
  br label %122

; <label>:83                                      ; preds = %75
  %84 = load i8* %c, align 1
  %85 = sext i8 %84 to i32
  %86 = icmp ne i32 %85, 59
  br i1 %86, label %87, label %119

; <label>:87                                      ; preds = %83
  %88 = load i64* %seqlen, align 8
  %89 = load i32* %linelen, align 4
  %90 = sext i32 %89 to i64
  %91 = add nsw i64 %88, %90
  store i64 %91, i64* %seqlen, align 8
  %92 = load i64* %seqlen, align 8
  %93 = add nsw i64 %92, 512
  %94 = load i64* %buflen, align 8
  %95 = icmp sge i64 %93, %94
  br i1 %95, label %96, label %111

; <label>:96                                      ; preds = %87
  %97 = load i64* %buflen, align 8
  %98 = add nsw i64 %97, 10240
  store i64 %98, i64* %buflen, align 8
  %99 = load i8** %buffer, align 8
  %100 = load i64* %buflen, align 8
  %101 = add nsw i64 %100, 1
  %102 = call i8* @realloc(i8* %99, i64 %101)
  store i8* %102, i8** %tmp, align 8
  %103 = load i8** %tmp, align 8
  %104 = icmp eq i8* %103, null
  br i1 %104, label %105, label %106

; <label>:105                                     ; preds = %96
  store i32 2, i32* %1
  br label %162

; <label>:106                                     ; preds = %96
  %107 = load i8** %tmp, align 8
  store i8* %107, i8** %buffer, align 8
  %108 = load i64* %seqlen, align 8
  %109 = load i8** %buffer, align 8
  %110 = getelementptr inbounds i8* %109, i64 %108
  store i8* %110, i8** %x, align 8
  br label %116

; <label>:111                                     ; preds = %87
  %112 = load i32* %linelen, align 4
  %113 = sext i32 %112 to i64
  %114 = load i8** %x, align 8
  %115 = getelementptr inbounds i8* %114, i64 %113
  store i8* %115, i8** %x, align 8
  br label %116

; <label>:116                                     ; preds = %111, %106
  %117 = load i8** %x, align 8
  %118 = getelementptr inbounds i8* %117, i64 0
  store i8 0, i8* %118
  br label %119

; <label>:119                                     ; preds = %116, %83
  br label %120

; <label>:120                                     ; preds = %119
  br label %121

; <label>:121                                     ; preds = %120, %57
  br label %52

; <label>:122                                     ; preds = %82, %52
  store i32 0, i32* %i, align 4
  br label %123

; <label>:123                                     ; preds = %141, %122
  %124 = load i32* %i, align 4
  %125 = sext i32 %124 to i64
  %126 = load i64* %seqlen, align 8
  %127 = icmp slt i64 %125, %126
  br i1 %127, label %128, label %144

; <label>:128                                     ; preds = %123
  %129 = load i32* %i, align 4
  %130 = sext i32 %129 to i64
  %131 = load i8** %buffer, align 8
  %132 = getelementptr inbounds i8* %131, i64 %130
  %133 = load i8* %132
  %134 = sext i8 %133 to i32
  %135 = call i32 @toupper(i32 %134)
  %136 = trunc i32 %135 to i8
  %137 = load i32* %i, align 4
  %138 = sext i32 %137 to i64
  %139 = load i8** %buffer, align 8
  %140 = getelementptr inbounds i8* %139, i64 %138
  store i8 %136, i8* %140
  br label %141

; <label>:141                                     ; preds = %128
  %142 = load i32* %i, align 4
  %143 = add nsw i32 %142, 1
  store i32 %143, i32* %i, align 4
  br label %123

; <label>:144                                     ; preds = %123
  %145 = load i8** %buffer, align 8
  %146 = load i64* %seqlen, align 8
  call void @write_frequencies(i32 1, i8* %145, i64 %146)
  %147 = load i8** %buffer, align 8
  %148 = load i64* %seqlen, align 8
  call void @write_frequencies(i32 2, i8* %147, i64 %148)
  %149 = load i8** %buffer, align 8
  %150 = load i64* %seqlen, align 8
  call void @write_count(i8* getelementptr inbounds ([4 x i8]* @.str7, i32 0, i32 0), i8* %149, i64 %150)
  %151 = load i8** %buffer, align 8
  %152 = load i64* %seqlen, align 8
  call void @write_count(i8* getelementptr inbounds ([5 x i8]* @.str8, i32 0, i32 0), i8* %151, i64 %152)
  %153 = load i8** %buffer, align 8
  %154 = load i64* %seqlen, align 8
  call void @write_count(i8* getelementptr inbounds ([7 x i8]* @.str9, i32 0, i32 0), i8* %153, i64 %154)
  %155 = load i8** %buffer, align 8
  %156 = load i64* %seqlen, align 8
  call void @write_count(i8* getelementptr inbounds ([13 x i8]* @.str10, i32 0, i32 0), i8* %155, i64 %156)
  %157 = load i8** %buffer, align 8
  %158 = load i64* %seqlen, align 8
  call void @write_count(i8* getelementptr inbounds ([19 x i8]* @.str11, i32 0, i32 0), i8* %157, i64 %158)
  %159 = load i8** %buffer, align 8
  call void @free(i8* %159)
  %160 = load %struct.__sFILE** %f, align 8
  %161 = call i32 @fclose(%struct.__sFILE* %160)
  store i32 0, i32* %1
  br label %162

; <label>:162                                     ; preds = %144, %105, %49, %10, %5
  %163 = load i32* %1
  ret i32 %163
}

declare %struct.__sFILE* @"\01_fopen"(i8*, i8*)

declare i8* @fgets(i8*, i32, %struct.__sFILE*)

declare i8* @realloc(i8*, i64)

define internal i32 @toupper(i32 %_c) nounwind inlinehint ssp {
  %1 = alloca i32, align 4
  store i32 %_c, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = call i32 @__toupper(i32 %2)
  ret i32 %3
}

declare i32 @fclose(%struct.__sFILE*)

declare i32 @__toupper(i32)
