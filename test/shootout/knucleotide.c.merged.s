; ModuleID = 'knucleotide.c.m2r.o'
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
  %1 = getelementptr inbounds %struct.ht_node* %node, i32 0, i32 1
  %2 = load i32* %1, align 4
  ret i32 %2
}

define i8* @ht_key(%struct.ht_node* %node) nounwind ssp {
  %1 = getelementptr inbounds %struct.ht_node* %node, i32 0, i32 0
  %2 = load i8** %1, align 8
  ret i8* %2
}

define i32 @ht_hashcode(%struct.ht_ht* %ht, i8* %key) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %10, %0
  %.0 = phi i8* [ %key, %0 ], [ %11, %10 ]
  %val.0 = phi i64 [ 0, %0 ], [ %9, %10 ]
  %2 = load i8* %.0
  %3 = icmp ne i8 %2, 0
  br i1 %3, label %4, label %12

; <label>:4                                       ; preds = %1
  %5 = mul i64 5, %val.0
  %6 = load i8* %.0
  %7 = sext i8 %6 to i32
  %8 = sext i32 %7 to i64
  %9 = add i64 %5, %8
  br label %10

; <label>:10                                      ; preds = %4
  %11 = getelementptr inbounds i8* %.0, i32 1
  br label %1

; <label>:12                                      ; preds = %1
  %13 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 0
  %14 = load i32* %13, align 4
  %15 = sext i32 %14 to i64
  %16 = urem i64 %val.0, %15
  %17 = trunc i64 %16 to i32
  ret i32 %17
}

define %struct.ht_node* @ht_node_create(i8* %key) nounwind ssp {
  %1 = call i8* @malloc(i64 24)
  %2 = bitcast i8* %1 to %struct.ht_node*
  %3 = icmp eq %struct.ht_node* %2, null
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  call void @perror(i8* getelementptr inbounds ([15 x i8]* @.str, i32 0, i32 0))
  call void @exit(i32 1) noreturn
  unreachable

; <label>:5                                       ; preds = %0
  %6 = call i8* @strdup(i8* %key)
  %7 = icmp eq i8* %6, null
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %5
  call void @perror(i8* getelementptr inbounds ([14 x i8]* @.str1, i32 0, i32 0))
  call void @exit(i32 1) noreturn
  unreachable

; <label>:9                                       ; preds = %5
  %10 = getelementptr inbounds %struct.ht_node* %2, i32 0, i32 0
  store i8* %6, i8** %10, align 8
  %11 = getelementptr inbounds %struct.ht_node* %2, i32 0, i32 1
  store i32 0, i32* %11, align 4
  %12 = getelementptr inbounds %struct.ht_node* %2, i32 0, i32 2
  store %struct.ht_node* null, %struct.ht_node** %12, align 8
  ret %struct.ht_node* %2
}

declare i8* @malloc(i64)

declare void @perror(i8*)

declare void @exit(i32) noreturn

declare i8* @strdup(i8*)

define %struct.ht_ht* @ht_create(i32 %size) nounwind ssp {
; <label>:0
  %1 = call i8* @malloc(i64 40)
  %2 = bitcast i8* %1 to %struct.ht_ht*
  br label %3

; <label>:3                                       ; preds = %9, %0
  %i.0 = phi i32 [ 0, %0 ], [ %10, %9 ]
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds [28 x i64]* @ht_prime_list, i32 0, i64 %4
  %6 = load i64* %5
  %7 = sext i32 %size to i64
  %8 = icmp ult i64 %6, %7
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %3
  %10 = add nsw i32 %i.0, 1
  br label %3

; <label>:11                                      ; preds = %3
  %12 = sext i32 %i.0 to i64
  %13 = getelementptr inbounds [28 x i64]* @ht_prime_list, i32 0, i64 %12
  %14 = load i64* %13
  %15 = trunc i64 %14 to i32
  %16 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 0
  store i32 %15, i32* %16, align 4
  %17 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 0
  %18 = load i32* %17, align 4
  %19 = sext i32 %18 to i64
  %20 = call i8* @calloc(i64 %19, i64 8)
  %21 = bitcast i8* %20 to %struct.ht_node**
  %22 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 1
  store %struct.ht_node** %21, %struct.ht_node*** %22, align 8
  %23 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 2
  store i32 0, i32* %23, align 4
  %24 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 3
  store %struct.ht_node* null, %struct.ht_node** %24, align 8
  %25 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 4
  store i32 0, i32* %25, align 4
  ret %struct.ht_ht* %2
}

declare i8* @calloc(i64, i64)

define void @ht_destroy(%struct.ht_ht* %ht) nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %20, %0
  %i.0 = phi i32 [ 0, %0 ], [ %21, %20 ]
  %2 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 0
  %3 = load i32* %2, align 4
  %4 = icmp slt i32 %i.0, %3
  br i1 %4, label %5, label %22

; <label>:5                                       ; preds = %1
  %6 = sext i32 %i.0 to i64
  %7 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  %8 = load %struct.ht_node*** %7, align 8
  %9 = getelementptr inbounds %struct.ht_node** %8, i64 %6
  %10 = load %struct.ht_node** %9
  br label %11

; <label>:11                                      ; preds = %13, %5
  %next.0 = phi %struct.ht_node* [ %10, %5 ], [ %15, %13 ]
  %12 = icmp ne %struct.ht_node* %next.0, null
  br i1 %12, label %13, label %19

; <label>:13                                      ; preds = %11
  %14 = getelementptr inbounds %struct.ht_node* %next.0, i32 0, i32 2
  %15 = load %struct.ht_node** %14, align 8
  %16 = getelementptr inbounds %struct.ht_node* %next.0, i32 0, i32 0
  %17 = load i8** %16, align 8
  call void @free(i8* %17)
  %18 = bitcast %struct.ht_node* %next.0 to i8*
  call void @free(i8* %18)
  br label %11

; <label>:19                                      ; preds = %11
  br label %20

; <label>:20                                      ; preds = %19
  %21 = add nsw i32 %i.0, 1
  br label %1

; <label>:22                                      ; preds = %1
  %23 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  %24 = load %struct.ht_node*** %23, align 8
  %25 = bitcast %struct.ht_node** %24 to i8*
  call void @free(i8* %25)
  %26 = bitcast %struct.ht_ht* %ht to i8*
  call void @free(i8* %26)
  ret void
}

declare void @free(i8*)

define %struct.ht_node* @ht_find(%struct.ht_ht* %ht, i8* %key) nounwind ssp {
; <label>:0
  %1 = call i32 @ht_hashcode(%struct.ht_ht* %ht, i8* %key)
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  %4 = load %struct.ht_node*** %3, align 8
  %5 = getelementptr inbounds %struct.ht_node** %4, i64 %2
  %6 = load %struct.ht_node** %5
  br label %7

; <label>:7                                       ; preds = %15, %0
  %node.0 = phi %struct.ht_node* [ %6, %0 ], [ %17, %15 ]
  %8 = icmp ne %struct.ht_node* %node.0, null
  br i1 %8, label %9, label %18

; <label>:9                                       ; preds = %7
  %10 = getelementptr inbounds %struct.ht_node* %node.0, i32 0, i32 0
  %11 = load i8** %10, align 8
  %12 = call i32 @strcmp(i8* %key, i8* %11)
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %15

; <label>:14                                      ; preds = %9
  br label %19

; <label>:15                                      ; preds = %9
  %16 = getelementptr inbounds %struct.ht_node* %node.0, i32 0, i32 2
  %17 = load %struct.ht_node** %16, align 8
  br label %7

; <label>:18                                      ; preds = %7
  br label %19

; <label>:19                                      ; preds = %18, %14
  %.0 = phi %struct.ht_node* [ %node.0, %14 ], [ null, %18 ]
  ret %struct.ht_node* %.0
}

declare i32 @strcmp(i8*, i8*)

define %struct.ht_node* @ht_find_new(%struct.ht_ht* %ht, i8* %key) nounwind ssp {
; <label>:0
  %1 = call i32 @ht_hashcode(%struct.ht_ht* %ht, i8* %key)
  %2 = sext i32 %1 to i64
  %3 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  %4 = load %struct.ht_node*** %3, align 8
  %5 = getelementptr inbounds %struct.ht_node** %4, i64 %2
  %6 = load %struct.ht_node** %5
  br label %7

; <label>:7                                       ; preds = %15, %0
  %prev.0 = phi %struct.ht_node* [ null, %0 ], [ %node.0, %15 ]
  %node.0 = phi %struct.ht_node* [ %6, %0 ], [ %17, %15 ]
  %8 = icmp ne %struct.ht_node* %node.0, null
  br i1 %8, label %9, label %18

; <label>:9                                       ; preds = %7
  %10 = getelementptr inbounds %struct.ht_node* %node.0, i32 0, i32 0
  %11 = load i8** %10, align 8
  %12 = call i32 @strcmp(i8* %key, i8* %11)
  %13 = icmp eq i32 %12, 0
  br i1 %13, label %14, label %15

; <label>:14                                      ; preds = %9
  br label %32

; <label>:15                                      ; preds = %9
  %16 = getelementptr inbounds %struct.ht_node* %node.0, i32 0, i32 2
  %17 = load %struct.ht_node** %16, align 8
  br label %7

; <label>:18                                      ; preds = %7
  %19 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 4
  %20 = load i32* %19, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %19, align 4
  %22 = icmp ne %struct.ht_node* %prev.0, null
  br i1 %22, label %23, label %26

; <label>:23                                      ; preds = %18
  %24 = call %struct.ht_node* @ht_node_create(i8* %key)
  %25 = getelementptr inbounds %struct.ht_node* %prev.0, i32 0, i32 2
  store %struct.ht_node* %24, %struct.ht_node** %25, align 8
  br label %32

; <label>:26                                      ; preds = %18
  %27 = call %struct.ht_node* @ht_node_create(i8* %key)
  %28 = sext i32 %1 to i64
  %29 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  %30 = load %struct.ht_node*** %29, align 8
  %31 = getelementptr inbounds %struct.ht_node** %30, i64 %28
  store %struct.ht_node* %27, %struct.ht_node** %31
  br label %32

; <label>:32                                      ; preds = %26, %23, %14
  %.0 = phi %struct.ht_node* [ %node.0, %14 ], [ %24, %23 ], [ %27, %26 ]
  ret %struct.ht_node* %.0
}

define %struct.ht_node* @ht_next(%struct.ht_ht* %ht) nounwind ssp {
  %1 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 3
  %2 = load %struct.ht_node** %1, align 8
  %3 = icmp ne %struct.ht_node* %2, null
  br i1 %3, label %4, label %8

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.ht_node* %2, i32 0, i32 2
  %6 = load %struct.ht_node** %5, align 8
  %7 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 3
  store %struct.ht_node* %6, %struct.ht_node** %7, align 8
  br label %40

; <label>:8                                       ; preds = %0
  br label %9

; <label>:9                                       ; preds = %37, %8
  %10 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 2
  %11 = load i32* %10, align 4
  %12 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 0
  %13 = load i32* %12, align 4
  %14 = icmp slt i32 %11, %13
  br i1 %14, label %15, label %38

; <label>:15                                      ; preds = %9
  %16 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 2
  %17 = load i32* %16, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, i32* %16, align 4
  %19 = sext i32 %17 to i64
  %20 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  %21 = load %struct.ht_node*** %20, align 8
  %22 = getelementptr inbounds %struct.ht_node** %21, i64 %19
  %23 = load %struct.ht_node** %22
  %24 = icmp ne %struct.ht_node* %23, null
  br i1 %24, label %25, label %37

; <label>:25                                      ; preds = %15
  %26 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  %27 = load %struct.ht_node*** %26, align 8
  %28 = getelementptr inbounds %struct.ht_node** %27, i64 %19
  %29 = load %struct.ht_node** %28
  %30 = getelementptr inbounds %struct.ht_node* %29, i32 0, i32 2
  %31 = load %struct.ht_node** %30, align 8
  %32 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 3
  store %struct.ht_node* %31, %struct.ht_node** %32, align 8
  %33 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  %34 = load %struct.ht_node*** %33, align 8
  %35 = getelementptr inbounds %struct.ht_node** %34, i64 %19
  %36 = load %struct.ht_node** %35
  br label %40

; <label>:37                                      ; preds = %15
  br label %9

; <label>:38                                      ; preds = %9
  br label %39

; <label>:39                                      ; preds = %38
  br label %40

; <label>:40                                      ; preds = %39, %25, %4
  %.0 = phi %struct.ht_node* [ %2, %4 ], [ %36, %25 ], [ null, %39 ]
  ret %struct.ht_node* %.0
}

define %struct.ht_node* @ht_first(%struct.ht_ht* %ht) nounwind ssp {
  %1 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 2
  store i32 0, i32* %1, align 4
  %2 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 3
  store %struct.ht_node* null, %struct.ht_node** %2, align 8
  %3 = call %struct.ht_node* @ht_next(%struct.ht_ht* %ht)
  ret %struct.ht_node* %3
}

define i32 @ht_count(%struct.ht_ht* %ht) nounwind ssp {
  %1 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 4
  %2 = load i32* %1, align 4
  ret i32 %2
}

define i64 @hash_table_size(i32 %fl, i64 %buflen) nounwind ssp {
; <label>:0
  %1 = sext i32 %fl to i64
  %2 = sub nsw i64 %buflen, %1
  br label %3

; <label>:3                                       ; preds = %10, %0
  %maxsize2.0 = phi i64 [ 4, %0 ], [ %11, %10 ]
  %.01 = phi i32 [ %fl, %0 ], [ %4, %10 ]
  %4 = add nsw i32 %.01, -1
  %5 = icmp sgt i32 %4, 0
  br i1 %5, label %6, label %8

; <label>:6                                       ; preds = %3
  %7 = icmp slt i64 %maxsize2.0, %2
  br label %8

; <label>:8                                       ; preds = %6, %3
  %9 = phi i1 [ false, %3 ], [ %7, %6 ]
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %8
  %11 = mul nsw i64 %maxsize2.0, 4
  br label %3

; <label>:12                                      ; preds = %8
  %13 = icmp slt i64 %2, %maxsize2.0
  br i1 %13, label %14, label %15

; <label>:14                                      ; preds = %12
  br label %16

; <label>:15                                      ; preds = %12
  br label %16

; <label>:16                                      ; preds = %15, %14
  %.0 = phi i64 [ %2, %14 ], [ %maxsize2.0, %15 ]
  ret i64 %.0
}

define %struct.ht_ht* @generate_frequencies(i32 %fl, i8* %buffer, i64 %buflen) nounwind ssp {
  %1 = sext i32 %fl to i64
  %2 = icmp sgt i64 %1, %buflen
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  br label %29

; <label>:4                                       ; preds = %0
  %5 = call i64 @hash_table_size(i32 %fl, i64 %buflen)
  %6 = trunc i64 %5 to i32
  %7 = call %struct.ht_ht* @ht_create(i32 %6)
  br label %8

; <label>:8                                       ; preds = %26, %4
  %i.0 = phi i64 [ 0, %4 ], [ %27, %26 ]
  %9 = sext i32 %fl to i64
  %10 = sub nsw i64 %buflen, %9
  %11 = add nsw i64 %10, 1
  %12 = icmp slt i64 %i.0, %11
  br i1 %12, label %13, label %28

; <label>:13                                      ; preds = %8
  %14 = getelementptr inbounds i8* %buffer, i64 %i.0
  %15 = sext i32 %fl to i64
  %16 = getelementptr inbounds i8* %14, i64 %15
  %17 = load i8* %16
  %18 = sext i32 %fl to i64
  %19 = getelementptr inbounds i8* %14, i64 %18
  store i8 0, i8* %19
  %20 = call %struct.ht_node* @ht_find_new(%struct.ht_ht* %7, i8* %14)
  %21 = getelementptr inbounds %struct.ht_node* %20, i32 0, i32 1
  %22 = load i32* %21, align 4
  %23 = add nsw i32 %22, 1
  store i32 %23, i32* %21, align 4
  %24 = sext i32 %fl to i64
  %25 = getelementptr inbounds i8* %14, i64 %24
  store i8 %17, i8* %25
  br label %26

; <label>:26                                      ; preds = %13
  %27 = add nsw i64 %i.0, 1
  br label %8

; <label>:28                                      ; preds = %8
  br label %29

; <label>:29                                      ; preds = %28, %3
  %.0 = phi %struct.ht_ht* [ null, %3 ], [ %7, %28 ]
  ret %struct.ht_ht* %.0
}

define void @write_frequencies(i32 %fl, i8* %buffer, i64 %buflen) nounwind ssp {
; <label>:0
  %tmp = alloca %struct.__sbuf, align 8
  %1 = call %struct.ht_ht* @generate_frequencies(i32 %fl, i8* %buffer, i64 %buflen)
  %2 = call %struct.ht_node* @ht_first(%struct.ht_ht* %1)
  br label %3

; <label>:3                                       ; preds = %11, %0
  %total.0 = phi i64 [ 0, %0 ], [ %9, %11 ]
  %size.0 = phi i64 [ 0, %0 ], [ %10, %11 ]
  %nd.0 = phi %struct.ht_node* [ %2, %0 ], [ %12, %11 ]
  %4 = icmp ne %struct.ht_node* %nd.0, null
  br i1 %4, label %5, label %13

; <label>:5                                       ; preds = %3
  %6 = getelementptr inbounds %struct.ht_node* %nd.0, i32 0, i32 1
  %7 = load i32* %6, align 4
  %8 = sext i32 %7 to i64
  %9 = add nsw i64 %total.0, %8
  %10 = add nsw i64 %size.0, 1
  br label %11

; <label>:11                                      ; preds = %5
  %12 = call %struct.ht_node* @ht_next(%struct.ht_ht* %1)
  br label %3

; <label>:13                                      ; preds = %3
  %14 = call i8* @calloc(i64 %size.0, i64 16)
  %15 = bitcast i8* %14 to %struct.__sbuf*
  %16 = call %struct.ht_node* @ht_first(%struct.ht_ht* %1)
  br label %17

; <label>:17                                      ; preds = %29, %13
  %i.0 = phi i64 [ 0, %13 ], [ %26, %29 ]
  %nd.1 = phi %struct.ht_node* [ %16, %13 ], [ %30, %29 ]
  %18 = icmp ne %struct.ht_node* %nd.1, null
  br i1 %18, label %19, label %31

; <label>:19                                      ; preds = %17
  %20 = getelementptr inbounds %struct.ht_node* %nd.1, i32 0, i32 0
  %21 = load i8** %20, align 8
  %22 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.0
  %23 = getelementptr inbounds %struct.__sbuf* %22, i32 0, i32 0
  store i8* %21, i8** %23, align 8
  %24 = getelementptr inbounds %struct.ht_node* %nd.1, i32 0, i32 1
  %25 = load i32* %24, align 4
  %26 = add nsw i64 %i.0, 1
  %27 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.0
  %28 = getelementptr inbounds %struct.__sbuf* %27, i32 0, i32 1
  store i32 %25, i32* %28, align 4
  br label %29

; <label>:29                                      ; preds = %19
  %30 = call %struct.ht_node* @ht_next(%struct.ht_ht* %1)
  br label %17

; <label>:31                                      ; preds = %17
  br label %32

; <label>:32                                      ; preds = %96, %31
  %i.1 = phi i64 [ 0, %31 ], [ %97, %96 ]
  %33 = sub nsw i64 %size.0, 1
  %34 = icmp slt i64 %i.1, %33
  br i1 %34, label %35, label %98

; <label>:35                                      ; preds = %32
  %36 = add nsw i64 %i.1, 1
  br label %37

; <label>:37                                      ; preds = %93, %35
  %j.0 = phi i64 [ %36, %35 ], [ %94, %93 ]
  %38 = icmp slt i64 %j.0, %size.0
  br i1 %38, label %39, label %95

; <label>:39                                      ; preds = %37
  %40 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.1
  %41 = getelementptr inbounds %struct.__sbuf* %40, i32 0, i32 1
  %42 = load i32* %41, align 4
  %43 = getelementptr inbounds %struct.__sbuf* %15, i64 %j.0
  %44 = getelementptr inbounds %struct.__sbuf* %43, i32 0, i32 1
  %45 = load i32* %44, align 4
  %46 = icmp slt i32 %42, %45
  br i1 %46, label %47, label %92

; <label>:47                                      ; preds = %39
  %48 = bitcast %struct.__sbuf* %tmp to i8*
  %49 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.1
  %50 = bitcast %struct.__sbuf* %49 to i8*
  %51 = call i8* @__memcpy_chk(i8* %48, i8* %50, i64 16, i64 16)
  %52 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.1
  %53 = bitcast %struct.__sbuf* %52 to i8*
  %54 = call i64 @llvm.objectsize.i64(i8* %53, i1 false)
  %55 = icmp ne i64 %54, -1
  br i1 %55, label %56, label %65

; <label>:56                                      ; preds = %47
  %57 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.1
  %58 = bitcast %struct.__sbuf* %57 to i8*
  %59 = getelementptr inbounds %struct.__sbuf* %15, i64 %j.0
  %60 = bitcast %struct.__sbuf* %59 to i8*
  %61 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.1
  %62 = bitcast %struct.__sbuf* %61 to i8*
  %63 = call i64 @llvm.objectsize.i64(i8* %62, i1 false)
  %64 = call i8* @__memcpy_chk(i8* %58, i8* %60, i64 16, i64 %63)
  br label %71

; <label>:65                                      ; preds = %47
  %66 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.1
  %67 = bitcast %struct.__sbuf* %66 to i8*
  %68 = getelementptr inbounds %struct.__sbuf* %15, i64 %j.0
  %69 = bitcast %struct.__sbuf* %68 to i8*
  %70 = call i8* @__inline_memcpy_chk(i8* %67, i8* %69, i64 16)
  br label %71

; <label>:71                                      ; preds = %65, %56
  %72 = phi i8* [ %64, %56 ], [ %70, %65 ]
  %73 = getelementptr inbounds %struct.__sbuf* %15, i64 %j.0
  %74 = bitcast %struct.__sbuf* %73 to i8*
  %75 = call i64 @llvm.objectsize.i64(i8* %74, i1 false)
  %76 = icmp ne i64 %75, -1
  br i1 %76, label %77, label %85

; <label>:77                                      ; preds = %71
  %78 = getelementptr inbounds %struct.__sbuf* %15, i64 %j.0
  %79 = bitcast %struct.__sbuf* %78 to i8*
  %80 = bitcast %struct.__sbuf* %tmp to i8*
  %81 = getelementptr inbounds %struct.__sbuf* %15, i64 %j.0
  %82 = bitcast %struct.__sbuf* %81 to i8*
  %83 = call i64 @llvm.objectsize.i64(i8* %82, i1 false)
  %84 = call i8* @__memcpy_chk(i8* %79, i8* %80, i64 16, i64 %83)
  br label %90

; <label>:85                                      ; preds = %71
  %86 = getelementptr inbounds %struct.__sbuf* %15, i64 %j.0
  %87 = bitcast %struct.__sbuf* %86 to i8*
  %88 = bitcast %struct.__sbuf* %tmp to i8*
  %89 = call i8* @__inline_memcpy_chk(i8* %87, i8* %88, i64 16)
  br label %90

; <label>:90                                      ; preds = %85, %77
  %91 = phi i8* [ %84, %77 ], [ %89, %85 ]
  br label %92

; <label>:92                                      ; preds = %90, %39
  br label %93

; <label>:93                                      ; preds = %92
  %94 = add nsw i64 %j.0, 1
  br label %37

; <label>:95                                      ; preds = %37
  br label %96

; <label>:96                                      ; preds = %95
  %97 = add nsw i64 %i.1, 1
  br label %32

; <label>:98                                      ; preds = %32
  br label %99

; <label>:99                                      ; preds = %114, %98
  %i.2 = phi i64 [ 0, %98 ], [ %115, %114 ]
  %100 = icmp slt i64 %i.2, %size.0
  br i1 %100, label %101, label %116

; <label>:101                                     ; preds = %99
  %102 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.2
  %103 = getelementptr inbounds %struct.__sbuf* %102, i32 0, i32 0
  %104 = load i8** %103, align 8
  %105 = getelementptr inbounds %struct.__sbuf* %15, i64 %i.2
  %106 = getelementptr inbounds %struct.__sbuf* %105, i32 0, i32 1
  %107 = load i32* %106, align 4
  %108 = sitofp i32 %107 to float
  %109 = fmul float 1.000000e+02, %108
  %110 = sitofp i64 %total.0 to float
  %111 = fdiv float %109, %110
  %112 = fpext float %111 to double
  %113 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i32 0, i32 0), i8* %104, double %112)
  br label %114

; <label>:114                                     ; preds = %101
  %115 = add nsw i64 %i.2, 1
  br label %99

; <label>:116                                     ; preds = %99
  %117 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str3, i32 0, i32 0))
  call void @ht_destroy(%struct.ht_ht* %1)
  %118 = bitcast %struct.__sbuf* %15 to i8*
  call void @free(i8* %118)
  ret void
}

declare i8* @__memcpy_chk(i8*, i8*, i64, i64) nounwind

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

define internal i8* @__inline_memcpy_chk(i8* %__dest, i8* %__src, i64 %__len) nounwind inlinehint ssp {
  %1 = call i64 @llvm.objectsize.i64(i8* %__dest, i1 false)
  %2 = call i8* @__memcpy_chk(i8* %__dest, i8* %__src, i64 %__len, i64 %1)
  ret i8* %2
}

declare i32 @printf(i8*, ...)

define void @write_count(i8* %searchFor, i8* %buffer, i64 %buflen) nounwind ssp {
  %1 = call i64 @strlen(i8* %searchFor)
  %2 = trunc i64 %1 to i32
  %3 = call %struct.ht_ht* @generate_frequencies(i32 %2, i8* %buffer, i64 %buflen)
  %4 = call %struct.ht_node* @ht_find_new(%struct.ht_ht* %3, i8* %searchFor)
  %5 = getelementptr inbounds %struct.ht_node* %4, i32 0, i32 1
  %6 = load i32* %5, align 4
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str4, i32 0, i32 0), i32 %6, i8* %searchFor)
  call void @ht_destroy(%struct.ht_ht* %3)
  ret void
}

declare i64 @strlen(i8*)

define i32 @main() nounwind ssp {
  %1 = call i8* @malloc(i64 256)
  %2 = icmp ne i8* %1, null
  br i1 %2, label %4, label %3

; <label>:3                                       ; preds = %0
  br label %102

; <label>:4                                       ; preds = %0
  %5 = call %struct.__sFILE* @"\01_fopen"(i8* getelementptr inbounds ([30 x i8]* @.str5, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8]* @.str6, i32 0, i32 0))
  %6 = icmp eq %struct.__sFILE* %5, null
  br i1 %6, label %7, label %8

; <label>:7                                       ; preds = %4
  br label %102

; <label>:8                                       ; preds = %4
  br label %9

; <label>:9                                       ; preds = %32, %8
  %nothree.1 = phi i32 [ 1, %8 ], [ %nothree.0, %32 ]
  %10 = icmp ne i32 %nothree.1, 0
  br i1 %10, label %11, label %14

; <label>:11                                      ; preds = %9
  %12 = call i8* @fgets(i8* %1, i32 255, %struct.__sFILE* %5)
  %13 = icmp ne i8* %12, null
  br label %14

; <label>:14                                      ; preds = %11, %9
  %15 = phi i1 [ false, %9 ], [ %13, %11 ]
  br i1 %15, label %16, label %33

; <label>:16                                      ; preds = %14
  %17 = getelementptr inbounds i8* %1, i64 0
  %18 = load i8* %17
  %19 = sext i8 %18 to i32
  %20 = icmp eq i32 %19, 62
  br i1 %20, label %21, label %32

; <label>:21                                      ; preds = %16
  %22 = getelementptr inbounds i8* %1, i64 1
  %23 = load i8* %22
  %24 = sext i8 %23 to i32
  %25 = icmp eq i32 %24, 84
  br i1 %25, label %26, label %32

; <label>:26                                      ; preds = %21
  %27 = getelementptr inbounds i8* %1, i64 2
  %28 = load i8* %27
  %29 = sext i8 %28 to i32
  %30 = icmp eq i32 %29, 72
  br i1 %30, label %31, label %32

; <label>:31                                      ; preds = %26
  br label %32

; <label>:32                                      ; preds = %31, %26, %21, %16
  %nothree.0 = phi i32 [ 0, %31 ], [ %nothree.1, %26 ], [ %nothree.1, %21 ], [ %nothree.1, %16 ]
  br label %9

; <label>:33                                      ; preds = %14
  call void @free(i8* %1)
  %34 = add nsw i64 10240, 1
  %35 = call i8* @malloc(i64 %34)
  %36 = icmp ne i8* %35, null
  br i1 %36, label %38, label %37

; <label>:37                                      ; preds = %33
  br label %102

; <label>:38                                      ; preds = %33
  br label %39

; <label>:39                                      ; preds = %84, %38
  %x.3 = phi i8* [ %35, %38 ], [ %x.2, %84 ]
  %buffer.3 = phi i8* [ %35, %38 ], [ %buffer.2, %84 ]
  %buflen.3 = phi i64 [ 10240, %38 ], [ %buflen.2, %84 ]
  %seqlen.2 = phi i64 [ 0, %38 ], [ %seqlen.1, %84 ]
  %40 = call i8* @fgets(i8* %x.3, i32 255, %struct.__sFILE* %5)
  %41 = icmp ne i8* %40, null
  br i1 %41, label %42, label %85

; <label>:42                                      ; preds = %39
  %43 = call i64 @strlen(i8* %x.3)
  %44 = trunc i64 %43 to i32
  %45 = icmp ne i32 %44, 0
  br i1 %45, label %46, label %84

; <label>:46                                      ; preds = %42
  %47 = sub nsw i32 %44, 1
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds i8* %x.3, i64 %48
  %50 = load i8* %49
  %51 = sext i8 %50 to i32
  %52 = icmp eq i32 %51, 10
  br i1 %52, label %53, label %55

; <label>:53                                      ; preds = %46
  %54 = add nsw i32 %44, -1
  br label %55

; <label>:55                                      ; preds = %53, %46
  %linelen.0 = phi i32 [ %54, %53 ], [ %44, %46 ]
  %56 = getelementptr inbounds i8* %x.3, i64 0
  %57 = load i8* %56
  %58 = sext i8 %57 to i32
  %59 = icmp eq i32 %58, 62
  br i1 %59, label %60, label %61

; <label>:60                                      ; preds = %55
  br label %85

; <label>:61                                      ; preds = %55
  %62 = sext i8 %57 to i32
  %63 = icmp ne i32 %62, 59
  br i1 %63, label %64, label %82

; <label>:64                                      ; preds = %61
  %65 = sext i32 %linelen.0 to i64
  %66 = add nsw i64 %seqlen.2, %65
  %67 = add nsw i64 %66, 512
  %68 = icmp sge i64 %67, %buflen.3
  br i1 %68, label %69, label %77

; <label>:69                                      ; preds = %64
  %70 = add nsw i64 %buflen.3, 10240
  %71 = add nsw i64 %70, 1
  %72 = call i8* @realloc(i8* %buffer.3, i64 %71)
  %73 = icmp eq i8* %72, null
  br i1 %73, label %74, label %75

; <label>:74                                      ; preds = %69
  br label %102

; <label>:75                                      ; preds = %69
  %76 = getelementptr inbounds i8* %72, i64 %66
  br label %80

; <label>:77                                      ; preds = %64
  %78 = sext i32 %linelen.0 to i64
  %79 = getelementptr inbounds i8* %x.3, i64 %78
  br label %80

; <label>:80                                      ; preds = %77, %75
  %x.0 = phi i8* [ %76, %75 ], [ %79, %77 ]
  %buffer.0 = phi i8* [ %72, %75 ], [ %buffer.3, %77 ]
  %buflen.0 = phi i64 [ %70, %75 ], [ %buflen.3, %77 ]
  %81 = getelementptr inbounds i8* %x.0, i64 0
  store i8 0, i8* %81
  br label %82

; <label>:82                                      ; preds = %80, %61
  %x.1 = phi i8* [ %x.0, %80 ], [ %x.3, %61 ]
  %buffer.1 = phi i8* [ %buffer.0, %80 ], [ %buffer.3, %61 ]
  %buflen.1 = phi i64 [ %buflen.0, %80 ], [ %buflen.3, %61 ]
  %seqlen.0 = phi i64 [ %66, %80 ], [ %seqlen.2, %61 ]
  br label %83

; <label>:83                                      ; preds = %82
  br label %84

; <label>:84                                      ; preds = %83, %42
  %x.2 = phi i8* [ %x.1, %83 ], [ %x.3, %42 ]
  %buffer.2 = phi i8* [ %buffer.1, %83 ], [ %buffer.3, %42 ]
  %buflen.2 = phi i64 [ %buflen.1, %83 ], [ %buflen.3, %42 ]
  %seqlen.1 = phi i64 [ %seqlen.0, %83 ], [ %seqlen.2, %42 ]
  br label %39

; <label>:85                                      ; preds = %60, %39
  br label %86

; <label>:86                                      ; preds = %98, %85
  %i.0 = phi i32 [ 0, %85 ], [ %99, %98 ]
  %87 = sext i32 %i.0 to i64
  %88 = icmp slt i64 %87, %seqlen.2
  br i1 %88, label %89, label %100

; <label>:89                                      ; preds = %86
  %90 = sext i32 %i.0 to i64
  %91 = getelementptr inbounds i8* %buffer.3, i64 %90
  %92 = load i8* %91
  %93 = sext i8 %92 to i32
  %94 = call i32 @toupper(i32 %93)
  %95 = trunc i32 %94 to i8
  %96 = sext i32 %i.0 to i64
  %97 = getelementptr inbounds i8* %buffer.3, i64 %96
  store i8 %95, i8* %97
  br label %98

; <label>:98                                      ; preds = %89
  %99 = add nsw i32 %i.0, 1
  br label %86

; <label>:100                                     ; preds = %86
  call void @write_frequencies(i32 1, i8* %buffer.3, i64 %seqlen.2)
  call void @write_frequencies(i32 2, i8* %buffer.3, i64 %seqlen.2)
  call void @write_count(i8* getelementptr inbounds ([4 x i8]* @.str7, i32 0, i32 0), i8* %buffer.3, i64 %seqlen.2)
  call void @write_count(i8* getelementptr inbounds ([5 x i8]* @.str8, i32 0, i32 0), i8* %buffer.3, i64 %seqlen.2)
  call void @write_count(i8* getelementptr inbounds ([7 x i8]* @.str9, i32 0, i32 0), i8* %buffer.3, i64 %seqlen.2)
  call void @write_count(i8* getelementptr inbounds ([13 x i8]* @.str10, i32 0, i32 0), i8* %buffer.3, i64 %seqlen.2)
  call void @write_count(i8* getelementptr inbounds ([19 x i8]* @.str11, i32 0, i32 0), i8* %buffer.3, i64 %seqlen.2)
  call void @free(i8* %buffer.3)
  %101 = call i32 @fclose(%struct.__sFILE* %5)
  br label %102

; <label>:102                                     ; preds = %100, %74, %37, %7, %3
  %.0 = phi i32 [ 2, %7 ], [ 0, %100 ], [ 2, %74 ], [ 2, %37 ], [ 2, %3 ]
  ret i32 %.0
}

declare %struct.__sFILE* @"\01_fopen"(i8*, i8*)

declare i8* @fgets(i8*, i32, %struct.__sFILE*)

declare i8* @realloc(i8*, i64)

define internal i32 @toupper(i32 %_c) nounwind inlinehint ssp {
  %1 = call i32 @__toupper(i32 %_c)
  ret i32 %1
}

declare i32 @fclose(%struct.__sFILE*)

declare i32 @__toupper(i32)
