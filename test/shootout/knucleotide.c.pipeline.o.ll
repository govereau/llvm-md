; ModuleID = 'knucleotide.c.pipeline.o'
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

; <label>:1                                       ; preds = %4, %0
  %.0 = phi i8* [ %key, %0 ], [ %9, %4 ]
  %val.0 = phi i64 [ 0, %0 ], [ %8, %4 ]
  %2 = load i8* %.0
  %3 = icmp ne i8 %2, 0
  br i1 %3, label %4, label %10

; <label>:4                                       ; preds = %1
  %5 = mul i64 5, %val.0
  %6 = sext i8 %2 to i32
  %7 = sext i32 %6 to i64
  %8 = add i64 %5, %7
  %9 = getelementptr inbounds i8* %.0, i32 1
  br label %1

; <label>:10                                      ; preds = %1
  %val.0.lcssa = phi i64 [ %val.0, %1 ]
  %11 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 0
  %12 = load i32* %11, align 4
  %13 = sext i32 %12 to i64
  %14 = urem i64 %val.0.lcssa, %13
  %15 = trunc i64 %14 to i32
  ret i32 %15
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
  %3 = sext i32 %size to i64
  br label %4

; <label>:4                                       ; preds = %9, %0
  %i.0 = phi i32 [ 0, %0 ], [ %10, %9 ]
  %5 = sext i32 %i.0 to i64
  %6 = getelementptr inbounds [28 x i64]* @ht_prime_list, i32 0, i64 %5
  %7 = load i64* %6
  %8 = icmp ult i64 %7, %3
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %4
  %10 = add nsw i32 %i.0, 1
  br label %4

; <label>:11                                      ; preds = %4
  %.lcssa = phi i64 [ %7, %4 ]
  %12 = trunc i64 %.lcssa to i32
  %13 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 0
  store i32 %12, i32* %13, align 4
  %14 = sext i32 %12 to i64
  %15 = call i8* @calloc(i64 %14, i64 8)
  %16 = bitcast i8* %15 to %struct.ht_node**
  %17 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 1
  store %struct.ht_node** %16, %struct.ht_node*** %17, align 8
  %18 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 2
  store i32 0, i32* %18, align 4
  %19 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 3
  store %struct.ht_node* null, %struct.ht_node** %19, align 8
  %20 = getelementptr inbounds %struct.ht_ht* %2, i32 0, i32 4
  store i32 0, i32* %20, align 4
  ret %struct.ht_ht* %2
}

declare i8* @calloc(i64, i64)

define void @ht_destroy(%struct.ht_ht* %ht) nounwind ssp {
; <label>:0
  %1 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 0
  %2 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  br label %3

; <label>:3                                       ; preds = %19, %0
  %i.0 = phi i32 [ 0, %0 ], [ %20, %19 ]
  %4 = load i32* %1, align 4
  %5 = icmp slt i32 %i.0, %4
  br i1 %5, label %6, label %21

; <label>:6                                       ; preds = %3
  %7 = sext i32 %i.0 to i64
  %8 = load %struct.ht_node*** %2, align 8
  %9 = getelementptr inbounds %struct.ht_node** %8, i64 %7
  %10 = load %struct.ht_node** %9
  br label %11

; <label>:11                                      ; preds = %13, %6
  %next.0 = phi %struct.ht_node* [ %10, %6 ], [ %15, %13 ]
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
  %20 = add nsw i32 %i.0, 1
  br label %3

; <label>:21                                      ; preds = %3
  %22 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  %23 = load %struct.ht_node*** %22, align 8
  %24 = bitcast %struct.ht_node** %23 to i8*
  call void @free(i8* %24)
  %25 = bitcast %struct.ht_ht* %ht to i8*
  call void @free(i8* %25)
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
  %node.0.lcssa1 = phi %struct.ht_node* [ %node.0, %9 ]
  br label %19

; <label>:15                                      ; preds = %9
  %16 = getelementptr inbounds %struct.ht_node* %node.0, i32 0, i32 2
  %17 = load %struct.ht_node** %16, align 8
  br label %7

; <label>:18                                      ; preds = %7
  %node.0.lcssa = phi %struct.ht_node* [ %node.0, %7 ]
  br label %19

; <label>:19                                      ; preds = %18, %14
  %.0 = phi %struct.ht_node* [ %node.0.lcssa1, %14 ], [ null, %18 ]
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
  %node.0.lcssa2 = phi %struct.ht_node* [ %node.0, %9 ]
  %prev.0.lcssa1 = phi %struct.ht_node* [ %prev.0, %9 ]
  br label %30

; <label>:15                                      ; preds = %9
  %16 = getelementptr inbounds %struct.ht_node* %node.0, i32 0, i32 2
  %17 = load %struct.ht_node** %16, align 8
  br label %7

; <label>:18                                      ; preds = %7
  %node.0.lcssa = phi %struct.ht_node* [ %node.0, %7 ]
  %prev.0.lcssa = phi %struct.ht_node* [ %prev.0, %7 ]
  %19 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 4
  %20 = load i32* %19, align 4
  %21 = add nsw i32 %20, 1
  store i32 %21, i32* %19, align 4
  %22 = icmp ne %struct.ht_node* %prev.0.lcssa, null
  br i1 %22, label %23, label %26

; <label>:23                                      ; preds = %18
  %24 = call %struct.ht_node* @ht_node_create(i8* %key)
  %25 = getelementptr inbounds %struct.ht_node* %prev.0.lcssa, i32 0, i32 2
  store %struct.ht_node* %24, %struct.ht_node** %25, align 8
  br label %30

; <label>:26                                      ; preds = %18
  %27 = call %struct.ht_node* @ht_node_create(i8* %key)
  %28 = load %struct.ht_node*** %3, align 8
  %29 = getelementptr inbounds %struct.ht_node** %28, i64 %2
  store %struct.ht_node* %27, %struct.ht_node** %29
  br label %30

; <label>:30                                      ; preds = %26, %23, %14
  %.0 = phi %struct.ht_node* [ %node.0.lcssa2, %14 ], [ %24, %23 ], [ %27, %26 ]
  ret %struct.ht_node* %.0
}

define %struct.ht_node* @ht_next(%struct.ht_ht* %ht) nounwind ssp {
  %1 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 3
  %2 = load %struct.ht_node** %1, align 8
  %3 = icmp ne %struct.ht_node* %2, null
  br i1 %3, label %4, label %7

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.ht_node* %2, i32 0, i32 2
  %6 = load %struct.ht_node** %5, align 8
  store %struct.ht_node* %6, %struct.ht_node** %1, align 8
  br label %27

; <label>:7                                       ; preds = %0
  %.phi.trans.insert = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 2
  %.pre = load i32* %.phi.trans.insert, align 4
  %8 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 0
  %9 = getelementptr inbounds %struct.ht_ht* %ht, i32 0, i32 1
  br label %10

; <label>:10                                      ; preds = %25, %7
  %11 = phi i32 [ %15, %25 ], [ %.pre, %7 ]
  %12 = load i32* %8, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %26

; <label>:14                                      ; preds = %10
  %15 = add nsw i32 %11, 1
  store i32 %15, i32* %.phi.trans.insert, align 4
  %16 = sext i32 %11 to i64
  %17 = load %struct.ht_node*** %9, align 8
  %18 = getelementptr inbounds %struct.ht_node** %17, i64 %16
  %19 = load %struct.ht_node** %18
  %20 = icmp ne %struct.ht_node* %19, null
  br i1 %20, label %21, label %25

; <label>:21                                      ; preds = %14
  %.lcssa1 = phi %struct.ht_node* [ %19, %14 ]
  %.lcssa = phi %struct.ht_node** [ %18, %14 ]
  %22 = getelementptr inbounds %struct.ht_node* %.lcssa1, i32 0, i32 2
  %23 = load %struct.ht_node** %22, align 8
  store %struct.ht_node* %23, %struct.ht_node** %1, align 8
  %24 = load %struct.ht_node** %.lcssa
  br label %27

; <label>:25                                      ; preds = %14
  br label %10

; <label>:26                                      ; preds = %10
  br label %27

; <label>:27                                      ; preds = %26, %21, %4
  %.0 = phi %struct.ht_node* [ %2, %4 ], [ %24, %21 ], [ null, %26 ]
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
  %maxsize2.0.lcssa = phi i64 [ %maxsize2.0, %8 ]
  %13 = icmp slt i64 %2, %maxsize2.0.lcssa
  br i1 %13, label %14, label %15

; <label>:14                                      ; preds = %12
  br label %16

; <label>:15                                      ; preds = %12
  br label %16

; <label>:16                                      ; preds = %15, %14
  %.0 = phi i64 [ %2, %14 ], [ %maxsize2.0.lcssa, %15 ]
  ret i64 %.0
}

define %struct.ht_ht* @generate_frequencies(i32 %fl, i8* %buffer, i64 %buflen) nounwind ssp {
  %1 = sext i32 %fl to i64
  %2 = icmp sgt i64 %1, %buflen
  br i1 %2, label %3, label %4

; <label>:3                                       ; preds = %0
  br label %22

; <label>:4                                       ; preds = %0
  %5 = call i64 @hash_table_size(i32 %fl, i64 %buflen)
  %6 = trunc i64 %5 to i32
  %7 = call %struct.ht_ht* @ht_create(i32 %6)
  %8 = sub nsw i64 %buflen, %1
  %9 = add nsw i64 %8, 1
  br label %10

; <label>:10                                      ; preds = %12, %4
  %i.0 = phi i64 [ 0, %4 ], [ %20, %12 ]
  %11 = icmp slt i64 %i.0, %9
  br i1 %11, label %12, label %21

; <label>:12                                      ; preds = %10
  %13 = getelementptr inbounds i8* %buffer, i64 %i.0
  %14 = getelementptr inbounds i8* %13, i64 %1
  %15 = load i8* %14
  store i8 0, i8* %14
  %16 = call %struct.ht_node* @ht_find_new(%struct.ht_ht* %7, i8* %13)
  %17 = getelementptr inbounds %struct.ht_node* %16, i32 0, i32 1
  %18 = load i32* %17, align 4
  %19 = add nsw i32 %18, 1
  store i32 %19, i32* %17, align 4
  store i8 %15, i8* %14
  %20 = add nsw i64 %i.0, 1
  br label %10

; <label>:21                                      ; preds = %10
  br label %22

; <label>:22                                      ; preds = %21, %3
  %.0 = phi %struct.ht_ht* [ null, %3 ], [ %7, %21 ]
  ret %struct.ht_ht* %.0
}

define void @write_frequencies(i32 %fl, i8* %buffer, i64 %buflen) nounwind ssp {
; <label>:0
  %tmp = alloca %struct.__sbuf, align 8
  %1 = call %struct.ht_ht* @generate_frequencies(i32 %fl, i8* %buffer, i64 %buflen)
  %2 = call %struct.ht_node* @ht_first(%struct.ht_ht* %1)
  br label %3

; <label>:3                                       ; preds = %5, %0
  %total.0 = phi i64 [ 0, %0 ], [ %9, %5 ]
  %size.0 = phi i64 [ 0, %0 ], [ %10, %5 ]
  %nd.0 = phi %struct.ht_node* [ %2, %0 ], [ %11, %5 ]
  %4 = icmp ne %struct.ht_node* %nd.0, null
  br i1 %4, label %5, label %12

; <label>:5                                       ; preds = %3
  %6 = getelementptr inbounds %struct.ht_node* %nd.0, i32 0, i32 1
  %7 = load i32* %6, align 4
  %8 = sext i32 %7 to i64
  %9 = add nsw i64 %total.0, %8
  %10 = add nsw i64 %size.0, 1
  %11 = call %struct.ht_node* @ht_next(%struct.ht_ht* %1)
  br label %3

; <label>:12                                      ; preds = %3
  %size.0.lcssa = phi i64 [ %size.0, %3 ]
  %total.0.lcssa = phi i64 [ %total.0, %3 ]
  %13 = call i8* @calloc(i64 %size.0.lcssa, i64 16)
  %14 = bitcast i8* %13 to %struct.__sbuf*
  %15 = call %struct.ht_node* @ht_first(%struct.ht_ht* %1)
  br label %16

; <label>:16                                      ; preds = %18, %12
  %i.0 = phi i64 [ 0, %12 ], [ %25, %18 ]
  %nd.1 = phi %struct.ht_node* [ %15, %12 ], [ %27, %18 ]
  %17 = icmp ne %struct.ht_node* %nd.1, null
  br i1 %17, label %18, label %28

; <label>:18                                      ; preds = %16
  %19 = getelementptr inbounds %struct.ht_node* %nd.1, i32 0, i32 0
  %20 = load i8** %19, align 8
  %21 = getelementptr inbounds %struct.__sbuf* %14, i64 %i.0
  %22 = getelementptr inbounds %struct.__sbuf* %21, i32 0, i32 0
  store i8* %20, i8** %22, align 8
  %23 = getelementptr inbounds %struct.ht_node* %nd.1, i32 0, i32 1
  %24 = load i32* %23, align 4
  %25 = add nsw i64 %i.0, 1
  %26 = getelementptr inbounds %struct.__sbuf* %21, i32 0, i32 1
  store i32 %24, i32* %26, align 4
  %27 = call %struct.ht_node* @ht_next(%struct.ht_ht* %1)
  br label %16

; <label>:28                                      ; preds = %16
  %29 = sub nsw i64 %size.0.lcssa, 1
  %30 = bitcast %struct.__sbuf* %tmp to i8*
  br label %31

; <label>:31                                      ; preds = %67, %28
  %i.1 = phi i64 [ 0, %28 ], [ %34, %67 ]
  %32 = icmp slt i64 %i.1, %29
  br i1 %32, label %33, label %68

; <label>:33                                      ; preds = %31
  %34 = add nsw i64 %i.1, 1
  %35 = getelementptr inbounds %struct.__sbuf* %14, i64 %i.1
  %36 = getelementptr inbounds %struct.__sbuf* %35, i32 0, i32 1
  %37 = bitcast %struct.__sbuf* %35 to i8*
  br label %38

; <label>:38                                      ; preds = %65, %33
  %j.0 = phi i64 [ %34, %33 ], [ %66, %65 ]
  %39 = icmp slt i64 %j.0, %size.0.lcssa
  br i1 %39, label %40, label %67

; <label>:40                                      ; preds = %38
  %41 = load i32* %36, align 4
  %42 = getelementptr inbounds %struct.__sbuf* %14, i64 %j.0
  %43 = getelementptr inbounds %struct.__sbuf* %42, i32 0, i32 1
  %44 = load i32* %43, align 4
  %45 = icmp slt i32 %41, %44
  br i1 %45, label %46, label %65

; <label>:46                                      ; preds = %40
  %47 = call i8* @__memcpy_chk(i8* %30, i8* %37, i64 16, i64 16)
  %48 = call i64 @llvm.objectsize.i64(i8* %37, i1 false)
  %49 = icmp ne i64 %48, -1
  br i1 %49, label %50, label %53

; <label>:50                                      ; preds = %46
  %51 = bitcast %struct.__sbuf* %42 to i8*
  %52 = call i8* @__memcpy_chk(i8* %37, i8* %51, i64 16, i64 %48)
  br label %56

; <label>:53                                      ; preds = %46
  %54 = bitcast %struct.__sbuf* %42 to i8*
  %55 = call i8* @__inline_memcpy_chk(i8* %37, i8* %54, i64 16)
  br label %56

; <label>:56                                      ; preds = %53, %50
  %57 = bitcast %struct.__sbuf* %42 to i8*
  %58 = call i64 @llvm.objectsize.i64(i8* %57, i1 false)
  %59 = icmp ne i64 %58, -1
  br i1 %59, label %60, label %62

; <label>:60                                      ; preds = %56
  %61 = call i8* @__memcpy_chk(i8* %57, i8* %30, i64 16, i64 %58)
  br label %64

; <label>:62                                      ; preds = %56
  %63 = call i8* @__inline_memcpy_chk(i8* %57, i8* %30, i64 16)
  br label %64

; <label>:64                                      ; preds = %62, %60
  br label %65

; <label>:65                                      ; preds = %64, %40
  %66 = add nsw i64 %j.0, 1
  br label %38

; <label>:67                                      ; preds = %38
  br label %31

; <label>:68                                      ; preds = %31
  %69 = sitofp i64 %total.0.lcssa to float
  br label %70

; <label>:70                                      ; preds = %72, %68
  %i.2 = phi i64 [ 0, %68 ], [ %83, %72 ]
  %71 = icmp slt i64 %i.2, %size.0.lcssa
  br i1 %71, label %72, label %84

; <label>:72                                      ; preds = %70
  %73 = getelementptr inbounds %struct.__sbuf* %14, i64 %i.2
  %74 = getelementptr inbounds %struct.__sbuf* %73, i32 0, i32 0
  %75 = load i8** %74, align 8
  %76 = getelementptr inbounds %struct.__sbuf* %73, i32 0, i32 1
  %77 = load i32* %76, align 4
  %78 = sitofp i32 %77 to float
  %79 = fmul float 1.000000e+02, %78
  %80 = fdiv float %79, %69
  %81 = fpext float %80 to double
  %82 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i32 0, i32 0), i8* %75, double %81)
  %83 = add nsw i64 %i.2, 1
  br label %70

; <label>:84                                      ; preds = %70
  %85 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([2 x i8]* @.str3, i32 0, i32 0))
  call void @ht_destroy(%struct.ht_ht* %1)
  %86 = bitcast %struct.__sbuf* %14 to i8*
  call void @free(i8* %86)
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
  br label %94

; <label>:4                                       ; preds = %0
  %5 = call %struct.__sFILE* @"\01_fopen"(i8* getelementptr inbounds ([30 x i8]* @.str5, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8]* @.str6, i32 0, i32 0))
  %6 = icmp eq %struct.__sFILE* %5, null
  br i1 %6, label %7, label %8

; <label>:7                                       ; preds = %4
  br label %94

; <label>:8                                       ; preds = %4
  %9 = getelementptr inbounds i8* %1, i64 0
  %10 = getelementptr inbounds i8* %1, i64 1
  %11 = getelementptr inbounds i8* %1, i64 2
  br label %12

; <label>:12                                      ; preds = %32, %8
  %nothree.1 = phi i32 [ 1, %8 ], [ %nothree.0, %32 ]
  %13 = icmp ne i32 %nothree.1, 0
  br i1 %13, label %14, label %17

; <label>:14                                      ; preds = %12
  %15 = call i8* @fgets(i8* %1, i32 255, %struct.__sFILE* %5)
  %16 = icmp ne i8* %15, null
  br label %17

; <label>:17                                      ; preds = %14, %12
  %18 = phi i1 [ false, %12 ], [ %16, %14 ]
  br i1 %18, label %19, label %33

; <label>:19                                      ; preds = %17
  %20 = load i8* %9
  %21 = sext i8 %20 to i32
  %22 = icmp eq i32 %21, 62
  br i1 %22, label %23, label %32

; <label>:23                                      ; preds = %19
  %24 = load i8* %10
  %25 = sext i8 %24 to i32
  %26 = icmp eq i32 %25, 84
  br i1 %26, label %27, label %32

; <label>:27                                      ; preds = %23
  %28 = load i8* %11
  %29 = sext i8 %28 to i32
  %30 = icmp eq i32 %29, 72
  br i1 %30, label %31, label %32

; <label>:31                                      ; preds = %27
  br label %32

; <label>:32                                      ; preds = %31, %27, %23, %19
  %nothree.0 = phi i32 [ 0, %31 ], [ %nothree.1, %27 ], [ %nothree.1, %23 ], [ %nothree.1, %19 ]
  br label %12

; <label>:33                                      ; preds = %17
  call void @free(i8* %1)
  %34 = call i8* @malloc(i64 10241)
  %35 = icmp ne i8* %34, null
  br i1 %35, label %37, label %36

; <label>:36                                      ; preds = %33
  br label %94

; <label>:37                                      ; preds = %33
  br label %38

; <label>:38                                      ; preds = %80, %37
  %x.3 = phi i8* [ %34, %37 ], [ %x.2, %80 ]
  %buffer.3 = phi i8* [ %34, %37 ], [ %buffer.2, %80 ]
  %buflen.3 = phi i64 [ 10240, %37 ], [ %buflen.2, %80 ]
  %seqlen.2 = phi i64 [ 0, %37 ], [ %seqlen.1, %80 ]
  %39 = call i8* @fgets(i8* %x.3, i32 255, %struct.__sFILE* %5)
  %40 = icmp ne i8* %39, null
  br i1 %40, label %41, label %.loopexit

; <label>:41                                      ; preds = %38
  %42 = call i64 @strlen(i8* %x.3)
  %43 = trunc i64 %42 to i32
  %44 = icmp ne i32 %43, 0
  br i1 %44, label %45, label %80

; <label>:45                                      ; preds = %41
  %46 = sub nsw i32 %43, 1
  %47 = sext i32 %46 to i64
  %48 = getelementptr inbounds i8* %x.3, i64 %47
  %49 = load i8* %48
  %50 = sext i8 %49 to i32
  %51 = icmp eq i32 %50, 10
  br i1 %51, label %52, label %54

; <label>:52                                      ; preds = %45
  %53 = add nsw i32 %43, -1
  br label %54

; <label>:54                                      ; preds = %52, %45
  %linelen.0 = phi i32 [ %53, %52 ], [ %43, %45 ]
  %55 = getelementptr inbounds i8* %x.3, i64 0
  %56 = load i8* %55
  %57 = sext i8 %56 to i32
  %58 = icmp eq i32 %57, 62
  br i1 %58, label %59, label %60

; <label>:59                                      ; preds = %54
  %seqlen.2.lcssa4 = phi i64 [ %seqlen.2, %54 ]
  %buffer.3.lcssa1 = phi i8* [ %buffer.3, %54 ]
  br label %81

; <label>:60                                      ; preds = %54
  %61 = icmp ne i32 %57, 59
  br i1 %61, label %62, label %79

; <label>:62                                      ; preds = %60
  %63 = sext i32 %linelen.0 to i64
  %64 = add nsw i64 %seqlen.2, %63
  %65 = add nsw i64 %64, 512
  %66 = icmp sge i64 %65, %buflen.3
  br i1 %66, label %67, label %75

; <label>:67                                      ; preds = %62
  %68 = add nsw i64 %buflen.3, 10240
  %69 = add nsw i64 %68, 1
  %70 = call i8* @realloc(i8* %buffer.3, i64 %69)
  %71 = icmp eq i8* %70, null
  br i1 %71, label %72, label %73

; <label>:72                                      ; preds = %67
  %seqlen.2.lcssa5 = phi i64 [ %seqlen.2, %67 ]
  %buffer.3.lcssa2 = phi i8* [ %buffer.3, %67 ]
  br label %94

; <label>:73                                      ; preds = %67
  %74 = getelementptr inbounds i8* %70, i64 %64
  br label %77

; <label>:75                                      ; preds = %62
  %76 = getelementptr inbounds i8* %x.3, i64 %63
  br label %77

; <label>:77                                      ; preds = %75, %73
  %x.0 = phi i8* [ %74, %73 ], [ %76, %75 ]
  %buffer.0 = phi i8* [ %70, %73 ], [ %buffer.3, %75 ]
  %buflen.0 = phi i64 [ %68, %73 ], [ %buflen.3, %75 ]
  %78 = getelementptr inbounds i8* %x.0, i64 0
  store i8 0, i8* %78
  br label %79

; <label>:79                                      ; preds = %77, %60
  %x.1 = phi i8* [ %x.0, %77 ], [ %x.3, %60 ]
  %buffer.1 = phi i8* [ %buffer.0, %77 ], [ %buffer.3, %60 ]
  %buflen.1 = phi i64 [ %buflen.0, %77 ], [ %buflen.3, %60 ]
  %seqlen.0 = phi i64 [ %64, %77 ], [ %seqlen.2, %60 ]
  br label %80

; <label>:80                                      ; preds = %79, %41
  %x.2 = phi i8* [ %x.1, %79 ], [ %x.3, %41 ]
  %buffer.2 = phi i8* [ %buffer.1, %79 ], [ %buffer.3, %41 ]
  %buflen.2 = phi i64 [ %buflen.1, %79 ], [ %buflen.3, %41 ]
  %seqlen.1 = phi i64 [ %seqlen.0, %79 ], [ %seqlen.2, %41 ]
  br label %38

.loopexit:                                        ; preds = %38
  %seqlen.2.lcssa = phi i64 [ %seqlen.2, %38 ]
  %buffer.3.lcssa = phi i8* [ %buffer.3, %38 ]
  br label %81

; <label>:81                                      ; preds = %.loopexit, %59
  %seqlen.26 = phi i64 [ %seqlen.2.lcssa, %.loopexit ], [ %seqlen.2.lcssa4, %59 ]
  %buffer.33 = phi i8* [ %buffer.3.lcssa, %.loopexit ], [ %buffer.3.lcssa1, %59 ]
  br label %82

; <label>:82                                      ; preds = %85, %81
  %i.0 = phi i32 [ 0, %81 ], [ %91, %85 ]
  %83 = sext i32 %i.0 to i64
  %84 = icmp slt i64 %83, %seqlen.26
  br i1 %84, label %85, label %92

; <label>:85                                      ; preds = %82
  %86 = getelementptr inbounds i8* %buffer.33, i64 %83
  %87 = load i8* %86
  %88 = sext i8 %87 to i32
  %89 = call i32 @toupper(i32 %88)
  %90 = trunc i32 %89 to i8
  store i8 %90, i8* %86
  %91 = add nsw i32 %i.0, 1
  br label %82

; <label>:92                                      ; preds = %82
  call void @write_frequencies(i32 1, i8* %buffer.33, i64 %seqlen.26)
  call void @write_frequencies(i32 2, i8* %buffer.33, i64 %seqlen.26)
  call void @write_count(i8* getelementptr inbounds ([4 x i8]* @.str7, i32 0, i32 0), i8* %buffer.33, i64 %seqlen.26)
  call void @write_count(i8* getelementptr inbounds ([5 x i8]* @.str8, i32 0, i32 0), i8* %buffer.33, i64 %seqlen.26)
  call void @write_count(i8* getelementptr inbounds ([7 x i8]* @.str9, i32 0, i32 0), i8* %buffer.33, i64 %seqlen.26)
  call void @write_count(i8* getelementptr inbounds ([13 x i8]* @.str10, i32 0, i32 0), i8* %buffer.33, i64 %seqlen.26)
  call void @write_count(i8* getelementptr inbounds ([19 x i8]* @.str11, i32 0, i32 0), i8* %buffer.33, i64 %seqlen.26)
  call void @free(i8* %buffer.33)
  %93 = call i32 @fclose(%struct.__sFILE* %5)
  br label %94

; <label>:94                                      ; preds = %92, %72, %36, %7, %3
  %.0 = phi i32 [ 2, %7 ], [ 0, %92 ], [ 2, %72 ], [ 2, %36 ], [ 2, %3 ]
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
