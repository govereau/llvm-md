; ModuleID = 'nsievebits.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [22 x i8] c"Primes up to %8u %8u\0A\00"

define i32 @main(i32 %ac, i8** %av) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %n = alloca i32, align 4
  store i32 0, i32* %1
  store i32 %ac, i32* %2, align 4
  store i8** %av, i8*** %3, align 8
  %4 = load i32* %2, align 4
  %5 = icmp slt i32 %4, 2
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %0
  br label %12

; <label>:7                                       ; preds = %0
  %8 = load i8*** %3, align 8
  %9 = getelementptr inbounds i8** %8, i64 1
  %10 = load i8** %9
  %11 = call i32 @atoi(i8* %10)
  br label %12

; <label>:12                                      ; preds = %7, %6
  %13 = phi i32 [ 9, %6 ], [ %11, %7 ]
  store i32 %13, i32* %n, align 4
  %14 = load i32* %n, align 4
  call void @test(i32 %14)
  %15 = load i32* %n, align 4
  %16 = icmp uge i32 %15, 1
  br i1 %16, label %17, label %20

; <label>:17                                      ; preds = %12
  %18 = load i32* %n, align 4
  %19 = sub i32 %18, 1
  call void @test(i32 %19)
  br label %20

; <label>:20                                      ; preds = %17, %12
  %21 = load i32* %n, align 4
  %22 = icmp uge i32 %21, 2
  br i1 %22, label %23, label %26

; <label>:23                                      ; preds = %20
  %24 = load i32* %n, align 4
  %25 = sub i32 %24, 2
  call void @test(i32 %25)
  br label %26

; <label>:26                                      ; preds = %23, %20
  call void @exit(i32 0) noreturn
  unreachable
                                                  ; No predecessors!
  %28 = load i32* %1
  ret i32 %28
}

declare i32 @atoi(i8*)

define internal void @test(i32 %n) nounwind ssp {
  %1 = alloca i32, align 4
  %count = alloca i32, align 4
  %m = alloca i32, align 4
  store i32 %n, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = shl i32 1, %2
  %4 = mul nsw i32 %3, 10000
  store i32 %4, i32* %m, align 4
  %5 = load i32* %m, align 4
  %6 = call i32 @nsieve(i32 %5)
  store i32 %6, i32* %count, align 4
  %7 = load i32* %m, align 4
  %8 = load i32* %count, align 4
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str, i32 0, i32 0), i32 %7, i32 %8)
  ret void
}

declare void @exit(i32) noreturn

define internal i32 @nsieve(i32 %m) nounwind ssp {
  %1 = alloca i32, align 4
  %count = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %a = alloca i32*, align 8
  store i32 %m, i32* %1, align 4
  %2 = load i32* %1, align 4
  %3 = zext i32 %2 to i64
  %4 = udiv i64 %3, 32
  %5 = mul i64 %4, 4
  %6 = call i8* @malloc(i64 %5)
  %7 = bitcast i8* %6 to i32*
  store i32* %7, i32** %a, align 8
  %8 = load i32** %a, align 8
  %9 = bitcast i32* %8 to i8*
  %10 = call i64 @llvm.objectsize.i64(i8* %9, i1 false)
  %11 = icmp ne i64 %10, -1
  br i1 %11, label %12, label %23

; <label>:12                                      ; preds = %0
  %13 = load i32** %a, align 8
  %14 = bitcast i32* %13 to i8*
  %15 = load i32* %1, align 4
  %16 = zext i32 %15 to i64
  %17 = udiv i64 %16, 32
  %18 = mul i64 %17, 4
  %19 = load i32** %a, align 8
  %20 = bitcast i32* %19 to i8*
  %21 = call i64 @llvm.objectsize.i64(i8* %20, i1 false)
  %22 = call i8* @__memset_chk(i8* %14, i32 255, i64 %18, i64 %21)
  br label %31

; <label>:23                                      ; preds = %0
  %24 = load i32** %a, align 8
  %25 = bitcast i32* %24 to i8*
  %26 = load i32* %1, align 4
  %27 = zext i32 %26 to i64
  %28 = udiv i64 %27, 32
  %29 = mul i64 %28, 4
  %30 = call i8* @__inline_memset_chk(i8* %25, i32 255, i64 %29)
  br label %31

; <label>:31                                      ; preds = %23, %12
  %32 = phi i8* [ %22, %12 ], [ %30, %23 ]
  store i32 0, i32* %count, align 4
  store i32 2, i32* %i, align 4
  br label %33

; <label>:33                                      ; preds = %81, %31
  %34 = load i32* %i, align 4
  %35 = load i32* %1, align 4
  %36 = icmp ult i32 %34, %35
  br i1 %36, label %37, label %84

; <label>:37                                      ; preds = %33
  %38 = load i32* %i, align 4
  %39 = zext i32 %38 to i64
  %40 = udiv i64 %39, 32
  %41 = load i32** %a, align 8
  %42 = getelementptr inbounds i32* %41, i64 %40
  %43 = load i32* %42
  %44 = load i32* %i, align 4
  %45 = zext i32 %44 to i64
  %46 = urem i64 %45, 32
  %47 = trunc i64 %46 to i32
  %48 = shl i32 1, %47
  %49 = and i32 %43, %48
  %50 = icmp ne i32 %49, 0
  br i1 %50, label %51, label %80

; <label>:51                                      ; preds = %37
  %52 = load i32* %i, align 4
  %53 = load i32* %i, align 4
  %54 = add i32 %52, %53
  store i32 %54, i32* %j, align 4
  br label %55

; <label>:55                                      ; preds = %73, %51
  %56 = load i32* %j, align 4
  %57 = load i32* %1, align 4
  %58 = icmp ult i32 %56, %57
  br i1 %58, label %59, label %77

; <label>:59                                      ; preds = %55
  %60 = load i32* %j, align 4
  %61 = zext i32 %60 to i64
  %62 = urem i64 %61, 32
  %63 = trunc i64 %62 to i32
  %64 = shl i32 1, %63
  %65 = xor i32 %64, -1
  %66 = load i32* %j, align 4
  %67 = zext i32 %66 to i64
  %68 = udiv i64 %67, 32
  %69 = load i32** %a, align 8
  %70 = getelementptr inbounds i32* %69, i64 %68
  %71 = load i32* %70
  %72 = and i32 %71, %65
  store i32 %72, i32* %70
  br label %73

; <label>:73                                      ; preds = %59
  %74 = load i32* %i, align 4
  %75 = load i32* %j, align 4
  %76 = add i32 %75, %74
  store i32 %76, i32* %j, align 4
  br label %55

; <label>:77                                      ; preds = %55
  %78 = load i32* %count, align 4
  %79 = add i32 %78, 1
  store i32 %79, i32* %count, align 4
  br label %80

; <label>:80                                      ; preds = %77, %37
  br label %81

; <label>:81                                      ; preds = %80
  %82 = load i32* %i, align 4
  %83 = add i32 %82, 1
  store i32 %83, i32* %i, align 4
  br label %33

; <label>:84                                      ; preds = %33
  %85 = load i32* %count, align 4
  ret i32 %85
}

declare i32 @printf(i8*, ...)

declare i8* @malloc(i64)

declare i64 @llvm.objectsize.i64(i8*, i1) nounwind readonly

declare i8* @__memset_chk(i8*, i32, i64, i64) nounwind

define internal i8* @__inline_memset_chk(i8* %__dest, i32 %__val, i64 %__len) nounwind inlinehint ssp {
  %1 = alloca i8*, align 8
  %2 = alloca i32, align 4
  %3 = alloca i64, align 8
  store i8* %__dest, i8** %1, align 8
  store i32 %__val, i32* %2, align 4
  store i64 %__len, i64* %3, align 8
  %4 = load i8** %1, align 8
  %5 = load i32* %2, align 4
  %6 = load i64* %3, align 8
  %7 = load i8** %1, align 8
  %8 = call i64 @llvm.objectsize.i64(i8* %7, i1 false)
  %9 = call i8* @__memset_chk(i8* %4, i32 %5, i64 %6, i64 %8)
  ret i8* %9
}
