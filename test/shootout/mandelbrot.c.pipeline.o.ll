; ModuleID = 'mandelbrot.c.pipeline.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }

@.str = private constant [10 x i8] c"P4\0A%d %d\0A\00"
@__stdoutp = external global %struct.__sFILE*

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = icmp slt i32 %argc, 2
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  br label %7

; <label>:3                                       ; preds = %0
  %4 = getelementptr inbounds i8** %argv, i64 1
  %5 = load i8** %4
  %6 = call i32 @atoi(i8* %5)
  br label %7

; <label>:7                                       ; preds = %3, %2
  %h.0 = phi i32 [ 3000, %2 ], [ %6, %3 ]
  %w.0 = phi i32 [ 3000, %2 ], [ %6, %3 ]
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i32 0, i32 0), i32 %w.0, i32 %h.0)
  %9 = sitofp i32 %h.0 to double
  %10 = sitofp i32 %w.0 to double
  %11 = sub nsw i32 %w.0, 1
  %12 = sitofp i32 %11 to double
  %13 = srem i32 %w.0, 8
  %14 = sub nsw i32 8, %13
  br label %15

; <label>:15                                      ; preds = %72, %7
  %y.0 = phi double [ 0.000000e+00, %7 ], [ %73, %72 ]
  %byte_acc.1 = phi i8 [ 0, %7 ], [ %byte_acc.0.lcssa, %72 ]
  %bit_num.1 = phi i32 [ 0, %7 ], [ %bit_num.0.lcssa, %72 ]
  %16 = fcmp olt double %y.0, %9
  br i1 %16, label %17, label %74

; <label>:17                                      ; preds = %15
  %18 = fmul double 2.000000e+00, %y.0
  %19 = fdiv double %18, %9
  %20 = fsub double %19, 1.000000e+00
  br label %21

; <label>:21                                      ; preds = %70, %17
  %x.0 = phi double [ 0.000000e+00, %17 ], [ %71, %70 ]
  %byte_acc.0 = phi i8 [ %byte_acc.1, %17 ], [ %byte_acc.3, %70 ]
  %bit_num.0 = phi i32 [ %bit_num.1, %17 ], [ %bit_num.2, %70 ]
  %22 = fcmp olt double %x.0, %10
  br i1 %22, label %23, label %72

; <label>:23                                      ; preds = %21
  %24 = fmul double 2.000000e+00, %x.0
  %25 = fdiv double %24, %10
  %26 = fsub double %25, 1.500000e+00
  br label %27

; <label>:27                                      ; preds = %34, %23
  %Zr.0 = phi double [ 0.000000e+00, %23 ], [ %39, %34 ]
  %i.0 = phi i32 [ 0, %23 ], [ %42, %34 ]
  %Zi.0 = phi double [ 0.000000e+00, %23 ], [ %37, %34 ]
  %Tr.0 = phi double [ 0.000000e+00, %23 ], [ %40, %34 ]
  %Ti.0 = phi double [ 0.000000e+00, %23 ], [ %41, %34 ]
  %28 = icmp slt i32 %i.0, 50
  br i1 %28, label %29, label %32

; <label>:29                                      ; preds = %27
  %30 = fadd double %Tr.0, %Ti.0
  %31 = fcmp ole double %30, 4.000000e+00
  br label %32

; <label>:32                                      ; preds = %29, %27
  %33 = phi i1 [ false, %27 ], [ %31, %29 ]
  br i1 %33, label %34, label %43

; <label>:34                                      ; preds = %32
  %35 = fmul double 2.000000e+00, %Zr.0
  %36 = fmul double %35, %Zi.0
  %37 = fadd double %36, %20
  %38 = fsub double %Tr.0, %Ti.0
  %39 = fadd double %38, %26
  %40 = fmul double %39, %39
  %41 = fmul double %37, %37
  %42 = add nsw i32 %i.0, 1
  br label %27

; <label>:43                                      ; preds = %32
  %Ti.0.lcssa = phi double [ %Ti.0, %32 ]
  %Tr.0.lcssa = phi double [ %Tr.0, %32 ]
  %44 = sext i8 %byte_acc.0 to i32
  %45 = shl i32 %44, 1
  %46 = trunc i32 %45 to i8
  %47 = fadd double %Tr.0.lcssa, %Ti.0.lcssa
  %48 = fcmp ole double %47, 4.000000e+00
  br i1 %48, label %49, label %53

; <label>:49                                      ; preds = %43
  %50 = sext i8 %46 to i32
  %51 = or i32 %50, 1
  %52 = trunc i32 %51 to i8
  br label %53

; <label>:53                                      ; preds = %49, %43
  %byte_acc.2 = phi i8 [ %52, %49 ], [ %46, %43 ]
  %54 = add nsw i32 %bit_num.0, 1
  %55 = icmp eq i32 %54, 8
  br i1 %55, label %56, label %60

; <label>:56                                      ; preds = %53
  %57 = sext i8 %byte_acc.2 to i32
  %58 = load %struct.__sFILE** @__stdoutp, align 8
  %59 = call i32 @putc(i32 %57, %struct.__sFILE* %58)
  br label %70

; <label>:60                                      ; preds = %53
  %61 = fcmp oeq double %x.0, %12
  br i1 %61, label %62, label %69

; <label>:62                                      ; preds = %60
  %63 = sext i8 %byte_acc.2 to i32
  %64 = shl i32 %63, %14
  %65 = trunc i32 %64 to i8
  %66 = sext i8 %65 to i32
  %67 = load %struct.__sFILE** @__stdoutp, align 8
  %68 = call i32 @putc(i32 %66, %struct.__sFILE* %67)
  br label %69

; <label>:69                                      ; preds = %62, %60
  %byte_acc.4 = phi i8 [ 0, %62 ], [ %byte_acc.2, %60 ]
  %bit_num.3 = phi i32 [ 0, %62 ], [ %54, %60 ]
  br label %70

; <label>:70                                      ; preds = %69, %56
  %byte_acc.3 = phi i8 [ 0, %56 ], [ %byte_acc.4, %69 ]
  %bit_num.2 = phi i32 [ 0, %56 ], [ %bit_num.3, %69 ]
  %71 = fadd double %x.0, 1.000000e+00
  br label %21

; <label>:72                                      ; preds = %21
  %bit_num.0.lcssa = phi i32 [ %bit_num.0, %21 ]
  %byte_acc.0.lcssa = phi i8 [ %byte_acc.0, %21 ]
  %73 = fadd double %y.0, 1.000000e+00
  br label %15

; <label>:74                                      ; preds = %15
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)

declare i32 @putc(i32, %struct.__sFILE*)
