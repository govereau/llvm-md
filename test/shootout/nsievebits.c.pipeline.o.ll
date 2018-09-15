; ModuleID = 'nsievebits.c.pipeline.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [22 x i8] c"Primes up to %8u %8u\0A\00"

define i32 @main(i32 %ac, i8** %av) nounwind ssp {
  %1 = icmp slt i32 %ac, 2
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  br label %7

; <label>:3                                       ; preds = %0
  %4 = getelementptr inbounds i8** %av, i64 1
  %5 = load i8** %4
  %6 = call i32 @atoi(i8* %5)
  br label %7

; <label>:7                                       ; preds = %3, %2
  %8 = phi i32 [ 9, %2 ], [ %6, %3 ]
  call void @test(i32 %8)
  %9 = icmp uge i32 %8, 1
  br i1 %9, label %10, label %12

; <label>:10                                      ; preds = %7
  %11 = sub i32 %8, 1
  call void @test(i32 %11)
  br label %12

; <label>:12                                      ; preds = %10, %7
  %13 = icmp uge i32 %8, 2
  br i1 %13, label %14, label %16

; <label>:14                                      ; preds = %12
  %15 = sub i32 %8, 2
  call void @test(i32 %15)
  br label %16

; <label>:16                                      ; preds = %14, %12
  call void @exit(i32 0) noreturn
  unreachable
                                                  ; No predecessors!
  ret i32 0
}

declare i32 @atoi(i8*)

define internal void @test(i32 %n) nounwind ssp {
  %1 = shl i32 1, %n
  %2 = mul nsw i32 %1, 10000
  %3 = call i32 @nsieve(i32 %2)
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str, i32 0, i32 0), i32 %2, i32 %3)
  ret void
}

declare void @exit(i32) noreturn

define internal i32 @nsieve(i32 %m) nounwind ssp {
  %1 = zext i32 %m to i64
  %2 = udiv i64 %1, 32
  %3 = mul i64 %2, 4
  %4 = call i8* @malloc(i64 %3)
  %5 = bitcast i8* %4 to i32*
  %6 = bitcast i32* %5 to i8*
  %7 = call i64 @llvm.objectsize.i64(i8* %6, i1 false)
  %8 = icmp ne i64 %7, -1
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %0
  %10 = call i8* @__memset_chk(i8* %6, i32 255, i64 %3, i64 %7)
  br label %13

; <label>:11                                      ; preds = %0
  %12 = call i8* @__inline_memset_chk(i8* %6, i32 255, i64 %3)
  br label %13

; <label>:13                                      ; preds = %11, %9
  br label %14

; <label>:14                                      ; preds = %43, %13
  %i.0 = phi i32 [ 2, %13 ], [ %44, %43 ]
  %count.1 = phi i32 [ 0, %13 ], [ %count.0, %43 ]
  %15 = icmp ult i32 %i.0, %m
  br i1 %15, label %16, label %45

; <label>:16                                      ; preds = %14
  %17 = zext i32 %i.0 to i64
  %18 = udiv i64 %17, 32
  %19 = getelementptr inbounds i32* %5, i64 %18
  %20 = load i32* %19
  %21 = urem i64 %17, 32
  %22 = trunc i64 %21 to i32
  %23 = shl i32 1, %22
  %24 = and i32 %20, %23
  %25 = icmp ne i32 %24, 0
  br i1 %25, label %26, label %43

; <label>:26                                      ; preds = %16
  %27 = add i32 %i.0, %i.0
  br label %28

; <label>:28                                      ; preds = %30, %26
  %j.0 = phi i32 [ %27, %26 ], [ %40, %30 ]
  %29 = icmp ult i32 %j.0, %m
  br i1 %29, label %30, label %41

; <label>:30                                      ; preds = %28
  %31 = zext i32 %j.0 to i64
  %32 = urem i64 %31, 32
  %33 = trunc i64 %32 to i32
  %34 = shl i32 1, %33
  %35 = xor i32 %34, -1
  %36 = udiv i64 %31, 32
  %37 = getelementptr inbounds i32* %5, i64 %36
  %38 = load i32* %37
  %39 = and i32 %38, %35
  store i32 %39, i32* %37
  %40 = add i32 %j.0, %i.0
  br label %28

; <label>:41                                      ; preds = %28
  %42 = add i32 %count.1, 1
  br label %43

; <label>:43                                      ; preds = %41, %16
  %count.0 = phi i32 [ %42, %41 ], [ %count.1, %16 ]
  %44 = add i32 %i.0, 1
  br label %14

; <label>:45                                      ; preds = %14
  %count.1.lcssa = phi i32 [ %count.1, %14 ]
  ret i32 %count.1.lcssa
}

declare i32 @printf(i8*, ...)

declare i8* @malloc(i64)

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

declare i8* @__memset_chk(i8*, i32, i64, i64) nounwind

define internal i8* @__inline_memset_chk(i8* %__dest, i32 %__val, i64 %__len) nounwind inlinehint ssp {
  %1 = call i64 @llvm.objectsize.i64(i8* %__dest, i1 false)
  %2 = call i8* @__memset_chk(i8* %__dest, i32 %__val, i64 %__len, i64 %1)
  ret i8* %2
}
