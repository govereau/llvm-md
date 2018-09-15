; ModuleID = 'mandelbrot.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }

@.str = private constant [10 x i8] c"P4\0A%d %d\0A\00"
@__stdoutp = external global %struct.__sFILE*

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %w = alloca i32, align 4
  %h = alloca i32, align 4
  %bit_num = alloca i32, align 4
  %byte_acc = alloca i8, align 1
  %i = alloca i32, align 4
  %iter = alloca i32, align 4
  %x = alloca double, align 8
  %y = alloca double, align 8
  %limit = alloca double, align 8
  %Zr = alloca double, align 8
  %Zi = alloca double, align 8
  %Cr = alloca double, align 8
  %Ci = alloca double, align 8
  %Tr = alloca double, align 8
  %Ti = alloca double, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  store i32 0, i32* %bit_num, align 4
  store i8 0, i8* %byte_acc, align 1
  store i32 50, i32* %iter, align 4
  store double 2.000000e+00, double* %limit, align 8
  %4 = load i32* %2, align 4
  %5 = icmp slt i32 %4, 2
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %0
  store i32 3000, i32* %h, align 4
  store i32 3000, i32* %w, align 4
  br label %12

; <label>:7                                       ; preds = %0
  %8 = load i8*** %3, align 8
  %9 = getelementptr inbounds i8** %8, i64 1
  %10 = load i8** %9
  %11 = call i32 @atoi(i8* %10)
  store i32 %11, i32* %h, align 4
  store i32 %11, i32* %w, align 4
  br label %12

; <label>:12                                      ; preds = %7, %6
  %13 = load i32* %w, align 4
  %14 = load i32* %h, align 4
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 %13, i32 %14)
  store double 0.000000e+00, double* %y, align 8
  br label %16

; <label>:16                                      ; preds = %126, %12
  %17 = load double* %y, align 8
  %18 = load i32* %h, align 4
  %19 = sitofp i32 %18 to double
  %20 = fcmp olt double %17, %19
  br i1 %20, label %21, label %129

; <label>:21                                      ; preds = %16
  store double 0.000000e+00, double* %x, align 8
  br label %22

; <label>:22                                      ; preds = %122, %21
  %23 = load double* %x, align 8
  %24 = load i32* %w, align 4
  %25 = sitofp i32 %24 to double
  %26 = fcmp olt double %23, %25
  br i1 %26, label %27, label %125

; <label>:27                                      ; preds = %22
  store double 0.000000e+00, double* %Ti, align 8
  store double 0.000000e+00, double* %Tr, align 8
  store double 0.000000e+00, double* %Zi, align 8
  store double 0.000000e+00, double* %Zr, align 8
  %28 = load double* %x, align 8
  %29 = fmul double 2.000000e+00, %28
  %30 = load i32* %w, align 4
  %31 = sitofp i32 %30 to double
  %32 = fdiv double %29, %31
  %33 = fsub double %32, 1.500000e+00
  store double %33, double* %Cr, align 8
  %34 = load double* %y, align 8
  %35 = fmul double 2.000000e+00, %34
  %36 = load i32* %h, align 4
  %37 = sitofp i32 %36 to double
  %38 = fdiv double %35, %37
  %39 = fsub double %38, 1.000000e+00
  store double %39, double* %Ci, align 8
  store i32 0, i32* %i, align 4
  br label %40

; <label>:40                                      ; preds = %72, %27
  %41 = load i32* %i, align 4
  %42 = load i32* %iter, align 4
  %43 = icmp slt i32 %41, %42
  br i1 %43, label %44, label %52

; <label>:44                                      ; preds = %40
  %45 = load double* %Tr, align 8
  %46 = load double* %Ti, align 8
  %47 = fadd double %45, %46
  %48 = load double* %limit, align 8
  %49 = load double* %limit, align 8
  %50 = fmul double %48, %49
  %51 = fcmp ole double %47, %50
  br label %52

; <label>:52                                      ; preds = %44, %40
  %53 = phi i1 [ false, %40 ], [ %51, %44 ]
  br i1 %53, label %54, label %75

; <label>:54                                      ; preds = %52
  %55 = load double* %Zr, align 8
  %56 = fmul double 2.000000e+00, %55
  %57 = load double* %Zi, align 8
  %58 = fmul double %56, %57
  %59 = load double* %Ci, align 8
  %60 = fadd double %58, %59
  store double %60, double* %Zi, align 8
  %61 = load double* %Tr, align 8
  %62 = load double* %Ti, align 8
  %63 = fsub double %61, %62
  %64 = load double* %Cr, align 8
  %65 = fadd double %63, %64
  store double %65, double* %Zr, align 8
  %66 = load double* %Zr, align 8
  %67 = load double* %Zr, align 8
  %68 = fmul double %66, %67
  store double %68, double* %Tr, align 8
  %69 = load double* %Zi, align 8
  %70 = load double* %Zi, align 8
  %71 = fmul double %69, %70
  store double %71, double* %Ti, align 8
  br label %72

; <label>:72                                      ; preds = %54
  %73 = load i32* %i, align 4
  %74 = add nsw i32 %73, 1
  store i32 %74, i32* %i, align 4
  br label %40

; <label>:75                                      ; preds = %52
  %76 = load i8* %byte_acc, align 1
  %77 = sext i8 %76 to i32
  %78 = shl i32 %77, 1
  %79 = trunc i32 %78 to i8
  store i8 %79, i8* %byte_acc, align 1
  %80 = load double* %Tr, align 8
  %81 = load double* %Ti, align 8
  %82 = fadd double %80, %81
  %83 = load double* %limit, align 8
  %84 = load double* %limit, align 8
  %85 = fmul double %83, %84
  %86 = fcmp ole double %82, %85
  br i1 %86, label %87, label %92

; <label>:87                                      ; preds = %75
  %88 = load i8* %byte_acc, align 1
  %89 = sext i8 %88 to i32
  %90 = or i32 %89, 1
  %91 = trunc i32 %90 to i8
  store i8 %91, i8* %byte_acc, align 1
  br label %92

; <label>:92                                      ; preds = %87, %75
  %93 = load i32* %bit_num, align 4
  %94 = add nsw i32 %93, 1
  store i32 %94, i32* %bit_num, align 4
  %95 = load i32* %bit_num, align 4
  %96 = icmp eq i32 %95, 8
  br i1 %96, label %97, label %102

; <label>:97                                      ; preds = %92
  %98 = load i8* %byte_acc, align 1
  %99 = sext i8 %98 to i32
  %100 = load %struct.__sFILE** @__stdoutp, align 8
  %101 = call i32 @putc(i32 %99, %struct.__sFILE* %100)
  store i8 0, i8* %byte_acc, align 1
  store i32 0, i32* %bit_num, align 4
  br label %121

; <label>:102                                     ; preds = %92
  %103 = load double* %x, align 8
  %104 = load i32* %w, align 4
  %105 = sub nsw i32 %104, 1
  %106 = sitofp i32 %105 to double
  %107 = fcmp oeq double %103, %106
  br i1 %107, label %108, label %120

; <label>:108                                     ; preds = %102
  %109 = load i32* %w, align 4
  %110 = srem i32 %109, 8
  %111 = sub nsw i32 8, %110
  %112 = load i8* %byte_acc, align 1
  %113 = sext i8 %112 to i32
  %114 = shl i32 %113, %111
  %115 = trunc i32 %114 to i8
  store i8 %115, i8* %byte_acc, align 1
  %116 = load i8* %byte_acc, align 1
  %117 = sext i8 %116 to i32
  %118 = load %struct.__sFILE** @__stdoutp, align 8
  %119 = call i32 @putc(i32 %117, %struct.__sFILE* %118)
  store i8 0, i8* %byte_acc, align 1
  store i32 0, i32* %bit_num, align 4
  br label %120

; <label>:120                                     ; preds = %108, %102
  br label %121

; <label>:121                                     ; preds = %120, %97
  br label %122

; <label>:122                                     ; preds = %121
  %123 = load double* %x, align 8
  %124 = fadd double %123, 1.000000e+00
  store double %124, double* %x, align 8
  br label %22

; <label>:125                                     ; preds = %22
  br label %126

; <label>:126                                     ; preds = %125
  %127 = load double* %y, align 8
  %128 = fadd double %127, 1.000000e+00
  store double %128, double* %y, align 8
  br label %16

; <label>:129                                     ; preds = %16
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)

declare i32 @putc(i32, %struct.__sFILE*)
