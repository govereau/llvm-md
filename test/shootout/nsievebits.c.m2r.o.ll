; ModuleID = 'nsievebits.c.m2r.o'
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
  br i1 %8, label %9, label %17

; <label>:9                                       ; preds = %0
  %10 = bitcast i32* %5 to i8*
  %11 = zext i32 %m to i64
  %12 = udiv i64 %11, 32
  %13 = mul i64 %12, 4
  %14 = bitcast i32* %5 to i8*
  %15 = call i64 @llvm.objectsize.i64(i8* %14, i1 false)
  %16 = call i8* @__memset_chk(i8* %10, i32 255, i64 %13, i64 %15)
  br label %23

; <label>:17                                      ; preds = %0
  %18 = bitcast i32* %5 to i8*
  %19 = zext i32 %m to i64
  %20 = udiv i64 %19, 32
  %21 = mul i64 %20, 4
  %22 = call i8* @__inline_memset_chk(i8* %18, i32 255, i64 %21)
  br label %23

; <label>:23                                      ; preds = %17, %9
  %24 = phi i8* [ %16, %9 ], [ %22, %17 ]
  br label %25

; <label>:25                                      ; preds = %58, %23
  %i.0 = phi i32 [ 2, %23 ], [ %59, %58 ]
  %count.1 = phi i32 [ 0, %23 ], [ %count.0, %58 ]
  %26 = icmp ult i32 %i.0, %m
  br i1 %26, label %27, label %60

; <label>:27                                      ; preds = %25
  %28 = zext i32 %i.0 to i64
  %29 = udiv i64 %28, 32
  %30 = getelementptr inbounds i32* %5, i64 %29
  %31 = load i32* %30
  %32 = zext i32 %i.0 to i64
  %33 = urem i64 %32, 32
  %34 = trunc i64 %33 to i32
  %35 = shl i32 1, %34
  %36 = and i32 %31, %35
  %37 = icmp ne i32 %36, 0
  br i1 %37, label %38, label %57

; <label>:38                                      ; preds = %27
  %39 = add i32 %i.0, %i.0
  br label %40

; <label>:40                                      ; preds = %53, %38
  %j.0 = phi i32 [ %39, %38 ], [ %54, %53 ]
  %41 = icmp ult i32 %j.0, %m
  br i1 %41, label %42, label %55

; <label>:42                                      ; preds = %40
  %43 = zext i32 %j.0 to i64
  %44 = urem i64 %43, 32
  %45 = trunc i64 %44 to i32
  %46 = shl i32 1, %45
  %47 = xor i32 %46, -1
  %48 = zext i32 %j.0 to i64
  %49 = udiv i64 %48, 32
  %50 = getelementptr inbounds i32* %5, i64 %49
  %51 = load i32* %50
  %52 = and i32 %51, %47
  store i32 %52, i32* %50
  br label %53

; <label>:53                                      ; preds = %42
  %54 = add i32 %j.0, %i.0
  br label %40

; <label>:55                                      ; preds = %40
  %56 = add i32 %count.1, 1
  br label %57

; <label>:57                                      ; preds = %55, %27
  %count.0 = phi i32 [ %56, %55 ], [ %count.1, %27 ]
  br label %58

; <label>:58                                      ; preds = %57
  %59 = add i32 %i.0, 1
  br label %25

; <label>:60                                      ; preds = %25
  ret i32 %count.1
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
