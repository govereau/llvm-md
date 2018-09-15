; ModuleID = 'mandelbrot.c.m2r.o'
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
  br label %9

; <label>:9                                       ; preds = %79, %7
  %y.0 = phi double [ 0.000000e+00, %7 ], [ %80, %79 ]
  %byte_acc.1 = phi i8 [ 0, %7 ], [ %byte_acc.0, %79 ]
  %bit_num.1 = phi i32 [ 0, %7 ], [ %bit_num.0, %79 ]
  %10 = sitofp i32 %h.0 to double
  %11 = fcmp olt double %y.0, %10
  br i1 %11, label %12, label %81

; <label>:12                                      ; preds = %9
  br label %13

; <label>:13                                      ; preds = %76, %12
  %x.0 = phi double [ 0.000000e+00, %12 ], [ %77, %76 ]
  %byte_acc.0 = phi i8 [ %byte_acc.1, %12 ], [ %byte_acc.3, %76 ]
  %bit_num.0 = phi i32 [ %bit_num.1, %12 ], [ %bit_num.2, %76 ]
  %14 = sitofp i32 %w.0 to double
  %15 = fcmp olt double %x.0, %14
  br i1 %15, label %16, label %78

; <label>:16                                      ; preds = %13
  %17 = fmul double 2.000000e+00, %x.0
  %18 = sitofp i32 %w.0 to double
  %19 = fdiv double %17, %18
  %20 = fsub double %19, 1.500000e+00
  %21 = fmul double 2.000000e+00, %y.0
  %22 = sitofp i32 %h.0 to double
  %23 = fdiv double %21, %22
  %24 = fsub double %23, 1.000000e+00
  br label %25

; <label>:25                                      ; preds = %41, %16
  %Zr.0 = phi double [ 0.000000e+00, %16 ], [ %38, %41 ]
  %i.0 = phi i32 [ 0, %16 ], [ %42, %41 ]
  %Zi.0 = phi double [ 0.000000e+00, %16 ], [ %36, %41 ]
  %Tr.0 = phi double [ 0.000000e+00, %16 ], [ %39, %41 ]
  %Ti.0 = phi double [ 0.000000e+00, %16 ], [ %40, %41 ]
  %26 = icmp slt i32 %i.0, 50
  br i1 %26, label %27, label %31

; <label>:27                                      ; preds = %25
  %28 = fadd double %Tr.0, %Ti.0
  %29 = fmul double 2.000000e+00, 2.000000e+00
  %30 = fcmp ole double %28, %29
  br label %31

; <label>:31                                      ; preds = %27, %25
  %32 = phi i1 [ false, %25 ], [ %30, %27 ]
  br i1 %32, label %33, label %43

; <label>:33                                      ; preds = %31
  %34 = fmul double 2.000000e+00, %Zr.0
  %35 = fmul double %34, %Zi.0
  %36 = fadd double %35, %24
  %37 = fsub double %Tr.0, %Ti.0
  %38 = fadd double %37, %20
  %39 = fmul double %38, %38
  %40 = fmul double %36, %36
  br label %41

; <label>:41                                      ; preds = %33
  %42 = add nsw i32 %i.0, 1
  br label %25

; <label>:43                                      ; preds = %31
  %44 = sext i8 %byte_acc.0 to i32
  %45 = shl i32 %44, 1
  %46 = trunc i32 %45 to i8
  %47 = fadd double %Tr.0, %Ti.0
  %48 = fmul double 2.000000e+00, 2.000000e+00
  %49 = fcmp ole double %47, %48
  br i1 %49, label %50, label %54

; <label>:50                                      ; preds = %43
  %51 = sext i8 %46 to i32
  %52 = or i32 %51, 1
  %53 = trunc i32 %52 to i8
  br label %54

; <label>:54                                      ; preds = %50, %43
  %byte_acc.2 = phi i8 [ %53, %50 ], [ %46, %43 ]
  %55 = add nsw i32 %bit_num.0, 1
  %56 = icmp eq i32 %55, 8
  br i1 %56, label %57, label %61

; <label>:57                                      ; preds = %54
  %58 = sext i8 %byte_acc.2 to i32
  %59 = load %struct.__sFILE** @__stdoutp, align 8
  %60 = call i32 @putc(i32 %58, %struct.__sFILE* %59)
  br label %75

; <label>:61                                      ; preds = %54
  %62 = sub nsw i32 %w.0, 1
  %63 = sitofp i32 %62 to double
  %64 = fcmp oeq double %x.0, %63
  br i1 %64, label %65, label %74

; <label>:65                                      ; preds = %61
  %66 = srem i32 %w.0, 8
  %67 = sub nsw i32 8, %66
  %68 = sext i8 %byte_acc.2 to i32
  %69 = shl i32 %68, %67
  %70 = trunc i32 %69 to i8
  %71 = sext i8 %70 to i32
  %72 = load %struct.__sFILE** @__stdoutp, align 8
  %73 = call i32 @putc(i32 %71, %struct.__sFILE* %72)
  br label %74

; <label>:74                                      ; preds = %65, %61
  %byte_acc.4 = phi i8 [ 0, %65 ], [ %byte_acc.2, %61 ]
  %bit_num.3 = phi i32 [ 0, %65 ], [ %55, %61 ]
  br label %75

; <label>:75                                      ; preds = %74, %57
  %byte_acc.3 = phi i8 [ 0, %57 ], [ %byte_acc.4, %74 ]
  %bit_num.2 = phi i32 [ 0, %57 ], [ %bit_num.3, %74 ]
  br label %76

; <label>:76                                      ; preds = %75
  %77 = fadd double %x.0, 1.000000e+00
  br label %13

; <label>:78                                      ; preds = %13
  br label %79

; <label>:79                                      ; preds = %78
  %80 = fadd double %y.0, 1.000000e+00
  br label %9

; <label>:81                                      ; preds = %9
  ret i32 0
}

declare i32 @atoi(i8*)

declare i32 @printf(i8*, ...)

declare i32 @putc(i32, %struct.__sFILE*)
