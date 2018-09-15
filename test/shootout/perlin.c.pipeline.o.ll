; ModuleID = 'perlin.c.pipeline.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [6 x i8] c"%.4e\0A\00"
@p = internal global [512 x i32] zeroinitializer, align 16
@permutation = internal global [256 x i32] [i32 151, i32 160, i32 137, i32 91, i32 90, i32 15, i32 131, i32 13, i32 201, i32 95, i32 96, i32 53, i32 194, i32 233, i32 7, i32 225, i32 140, i32 36, i32 103, i32 30, i32 69, i32 142, i32 8, i32 99, i32 37, i32 240, i32 21, i32 10, i32 23, i32 190, i32 6, i32 148, i32 247, i32 120, i32 234, i32 75, i32 0, i32 26, i32 197, i32 62, i32 94, i32 252, i32 219, i32 203, i32 117, i32 35, i32 11, i32 32, i32 57, i32 177, i32 33, i32 88, i32 237, i32 149, i32 56, i32 87, i32 174, i32 20, i32 125, i32 136, i32 171, i32 168, i32 68, i32 175, i32 74, i32 165, i32 71, i32 134, i32 139, i32 48, i32 27, i32 166, i32 77, i32 146, i32 158, i32 231, i32 83, i32 111, i32 229, i32 122, i32 60, i32 211, i32 133, i32 230, i32 220, i32 105, i32 92, i32 41, i32 55, i32 46, i32 245, i32 40, i32 244, i32 102, i32 143, i32 54, i32 65, i32 25, i32 63, i32 161, i32 1, i32 216, i32 80, i32 73, i32 209, i32 76, i32 132, i32 187, i32 208, i32 89, i32 18, i32 169, i32 200, i32 196, i32 135, i32 130, i32 116, i32 188, i32 159, i32 86, i32 164, i32 100, i32 109, i32 198, i32 173, i32 186, i32 3, i32 64, i32 52, i32 217, i32 226, i32 250, i32 124, i32 123, i32 5, i32 202, i32 38, i32 147, i32 118, i32 126, i32 255, i32 82, i32 85, i32 212, i32 207, i32 206, i32 59, i32 227, i32 47, i32 16, i32 58, i32 17, i32 182, i32 189, i32 28, i32 42, i32 223, i32 183, i32 170, i32 213, i32 119, i32 248, i32 152, i32 2, i32 44, i32 154, i32 163, i32 70, i32 221, i32 153, i32 101, i32 155, i32 167, i32 43, i32 172, i32 9, i32 129, i32 22, i32 39, i32 253, i32 19, i32 98, i32 108, i32 110, i32 79, i32 113, i32 224, i32 232, i32 178, i32 185, i32 112, i32 104, i32 218, i32 246, i32 97, i32 228, i32 251, i32 34, i32 242, i32 193, i32 238, i32 210, i32 144, i32 12, i32 191, i32 179, i32 162, i32 241, i32 81, i32 51, i32 145, i32 235, i32 249, i32 14, i32 239, i32 107, i32 49, i32 192, i32 214, i32 31, i32 181, i32 199, i32 106, i32 157, i32 184, i32 84, i32 204, i32 176, i32 115, i32 121, i32 50, i32 45, i32 127, i32 4, i32 150, i32 254, i32 138, i32 236, i32 205, i32 93, i32 222, i32 114, i32 67, i32 29, i32 24, i32 72, i32 243, i32 141, i32 128, i32 195, i32 78, i32 66, i32 215, i32 61, i32 156, i32 180], align 16

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
; <label>:0
  call void @init()
  br label %1

; <label>:1                                       ; preds = %15, %0
  %x.0 = phi double [ -1.135257e+04, %0 ], [ %16, %15 ]
  %sum.2 = phi double [ 0.000000e+00, %0 ], [ %sum.1.lcssa, %15 ]
  %2 = fcmp olt double %x.0, 2.356157e+04
  br i1 %2, label %3, label %17

; <label>:3                                       ; preds = %1
  br label %4

; <label>:4                                       ; preds = %13, %3
  %y.1 = phi double [ -3.461235e+02, %3 ], [ %14, %13 ]
  %sum.1 = phi double [ %sum.2, %3 ], [ %sum.0.lcssa, %13 ]
  %5 = fcmp olt double %y.1, 1.241240e+02
  br i1 %5, label %6, label %15

; <label>:6                                       ; preds = %4
  br label %7

; <label>:7                                       ; preds = %9, %6
  %y.0 = phi double [ %y.1, %6 ], [ %12, %9 ]
  %sum.0 = phi double [ %sum.1, %6 ], [ %11, %9 ]
  %8 = fcmp olt double %y.0, 2.323450e+01
  br i1 %8, label %9, label %13

; <label>:9                                       ; preds = %7
  %10 = call double @noise(double %x.0, double %y.0, double -1.562350e+02)
  %11 = fadd double %sum.0, %10
  %12 = fadd double %y.0, 2.450000e+00
  br label %7

; <label>:13                                      ; preds = %7
  %sum.0.lcssa = phi double [ %sum.0, %7 ]
  %y.0.lcssa = phi double [ %y.0, %7 ]
  %14 = fadd double %y.0.lcssa, 1.432500e+00
  br label %4

; <label>:15                                      ; preds = %4
  %sum.1.lcssa = phi double [ %sum.1, %4 ]
  %16 = fadd double %x.0, 1.235000e-01
  br label %1

; <label>:17                                      ; preds = %1
  %sum.2.lcssa = phi double [ %sum.2, %1 ]
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0), double %sum.2.lcssa)
  ret i32 0
}

define internal void @init() nounwind ssp {
; <label>:0
  br label %1

; <label>:1                                       ; preds = %3, %0
  %i.0 = phi i32 [ 0, %0 ], [ %11, %3 ]
  %2 = icmp slt i32 %i.0, 256
  br i1 %2, label %3, label %12

; <label>:3                                       ; preds = %1
  %4 = sext i32 %i.0 to i64
  %5 = getelementptr inbounds [256 x i32]* @permutation, i32 0, i64 %4
  %6 = load i32* %5
  %7 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %4
  store i32 %6, i32* %7
  %8 = add nsw i32 256, %i.0
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %9
  store i32 %6, i32* %10
  %11 = add nsw i32 %i.0, 1
  br label %1

; <label>:12                                      ; preds = %1
  ret void
}

define internal double @noise(double %x, double %y, double %z) nounwind ssp {
  %1 = call double @floor(double %x)
  %2 = fptosi double %1 to i32
  %3 = and i32 %2, 255
  %4 = call double @floor(double %y)
  %5 = fptosi double %4 to i32
  %6 = and i32 %5, 255
  %7 = call double @floor(double %z)
  %8 = fptosi double %7 to i32
  %9 = and i32 %8, 255
  %10 = call double @floor(double %x)
  %11 = fsub double %x, %10
  %12 = call double @floor(double %y)
  %13 = fsub double %y, %12
  %14 = call double @floor(double %z)
  %15 = fsub double %z, %14
  %16 = call double @fade(double %11)
  %17 = call double @fade(double %13)
  %18 = call double @fade(double %15)
  %19 = sext i32 %3 to i64
  %20 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %19
  %21 = load i32* %20
  %22 = add nsw i32 %21, %6
  %23 = sext i32 %22 to i64
  %24 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %23
  %25 = load i32* %24
  %26 = add nsw i32 %25, %9
  %27 = add nsw i32 %22, 1
  %28 = sext i32 %27 to i64
  %29 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %28
  %30 = load i32* %29
  %31 = add nsw i32 %30, %9
  %32 = add nsw i32 %3, 1
  %33 = sext i32 %32 to i64
  %34 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %33
  %35 = load i32* %34
  %36 = add nsw i32 %35, %6
  %37 = sext i32 %36 to i64
  %38 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %37
  %39 = load i32* %38
  %40 = add nsw i32 %39, %9
  %41 = add nsw i32 %36, 1
  %42 = sext i32 %41 to i64
  %43 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %42
  %44 = load i32* %43
  %45 = add nsw i32 %44, %9
  %46 = sext i32 %26 to i64
  %47 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %46
  %48 = load i32* %47
  %49 = call double @grad(i32 %48, double %11, double %13, double %15)
  %50 = sext i32 %40 to i64
  %51 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %50
  %52 = load i32* %51
  %53 = fsub double %11, 1.000000e+00
  %54 = call double @grad(i32 %52, double %53, double %13, double %15)
  %55 = call double @lerp(double %16, double %49, double %54)
  %56 = sext i32 %31 to i64
  %57 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %56
  %58 = load i32* %57
  %59 = fsub double %13, 1.000000e+00
  %60 = call double @grad(i32 %58, double %11, double %59, double %15)
  %61 = sext i32 %45 to i64
  %62 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %61
  %63 = load i32* %62
  %64 = call double @grad(i32 %63, double %53, double %59, double %15)
  %65 = call double @lerp(double %16, double %60, double %64)
  %66 = call double @lerp(double %17, double %55, double %65)
  %67 = add nsw i32 %26, 1
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %68
  %70 = load i32* %69
  %71 = fsub double %15, 1.000000e+00
  %72 = call double @grad(i32 %70, double %11, double %13, double %71)
  %73 = add nsw i32 %40, 1
  %74 = sext i32 %73 to i64
  %75 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %74
  %76 = load i32* %75
  %77 = call double @grad(i32 %76, double %53, double %13, double %71)
  %78 = call double @lerp(double %16, double %72, double %77)
  %79 = add nsw i32 %31, 1
  %80 = sext i32 %79 to i64
  %81 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %80
  %82 = load i32* %81
  %83 = call double @grad(i32 %82, double %11, double %59, double %71)
  %84 = add nsw i32 %45, 1
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %85
  %87 = load i32* %86
  %88 = call double @grad(i32 %87, double %53, double %59, double %71)
  %89 = call double @lerp(double %16, double %83, double %88)
  %90 = call double @lerp(double %17, double %78, double %89)
  %91 = call double @lerp(double %18, double %66, double %90)
  ret double %91
}

declare i32 @printf(i8*, ...)

declare double @floor(double)

define internal double @fade(double %t) nounwind ssp {
  %1 = fmul double %t, %t
  %2 = fmul double %1, %t
  %3 = fmul double %t, 6.000000e+00
  %4 = fsub double %3, 1.500000e+01
  %5 = fmul double %t, %4
  %6 = fadd double %5, 1.000000e+01
  %7 = fmul double %2, %6
  ret double %7
}

define internal double @lerp(double %t, double %a, double %b) nounwind ssp {
  %1 = fsub double %b, %a
  %2 = fmul double %t, %1
  %3 = fadd double %a, %2
  ret double %3
}

define internal double @grad(i32 %hash, double %x, double %y, double %z) nounwind ssp {
  %1 = and i32 %hash, 15
  %2 = icmp slt i32 %1, 8
  %3 = select i1 %2, double %x, double %y
  %4 = icmp slt i32 %1, 4
  br i1 %4, label %5, label %6

; <label>:5                                       ; preds = %0
  br label %13

; <label>:6                                       ; preds = %0
  %7 = icmp eq i32 %1, 12
  br i1 %7, label %10, label %8

; <label>:8                                       ; preds = %6
  %9 = icmp eq i32 %1, 14
  br label %10

; <label>:10                                      ; preds = %8, %6
  %11 = phi i1 [ true, %6 ], [ %9, %8 ]
  %12 = select i1 %11, double %x, double %z
  br label %13

; <label>:13                                      ; preds = %10, %5
  %14 = phi double [ %y, %5 ], [ %12, %10 ]
  %15 = and i32 %1, 1
  %16 = icmp eq i32 %15, 0
  br i1 %16, label %17, label %18

; <label>:17                                      ; preds = %13
  br label %20

; <label>:18                                      ; preds = %13
  %19 = fsub double -0.000000e+00, %3
  br label %20

; <label>:20                                      ; preds = %18, %17
  %21 = phi double [ %3, %17 ], [ %19, %18 ]
  %22 = and i32 %1, 2
  %23 = icmp eq i32 %22, 0
  br i1 %23, label %24, label %25

; <label>:24                                      ; preds = %20
  br label %27

; <label>:25                                      ; preds = %20
  %26 = fsub double -0.000000e+00, %14
  br label %27

; <label>:27                                      ; preds = %25, %24
  %28 = phi double [ %14, %24 ], [ %26, %25 ]
  %29 = fadd double %21, %28
  ret double %29
}
