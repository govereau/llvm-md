; ModuleID = 'perlin.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@.str = private constant [6 x i8] c"%.4e\0A\00"
@p = internal global [512 x i32] zeroinitializer, align 16
@permutation = internal global [256 x i32] [i32 151, i32 160, i32 137, i32 91, i32 90, i32 15, i32 131, i32 13, i32 201, i32 95, i32 96, i32 53, i32 194, i32 233, i32 7, i32 225, i32 140, i32 36, i32 103, i32 30, i32 69, i32 142, i32 8, i32 99, i32 37, i32 240, i32 21, i32 10, i32 23, i32 190, i32 6, i32 148, i32 247, i32 120, i32 234, i32 75, i32 0, i32 26, i32 197, i32 62, i32 94, i32 252, i32 219, i32 203, i32 117, i32 35, i32 11, i32 32, i32 57, i32 177, i32 33, i32 88, i32 237, i32 149, i32 56, i32 87, i32 174, i32 20, i32 125, i32 136, i32 171, i32 168, i32 68, i32 175, i32 74, i32 165, i32 71, i32 134, i32 139, i32 48, i32 27, i32 166, i32 77, i32 146, i32 158, i32 231, i32 83, i32 111, i32 229, i32 122, i32 60, i32 211, i32 133, i32 230, i32 220, i32 105, i32 92, i32 41, i32 55, i32 46, i32 245, i32 40, i32 244, i32 102, i32 143, i32 54, i32 65, i32 25, i32 63, i32 161, i32 1, i32 216, i32 80, i32 73, i32 209, i32 76, i32 132, i32 187, i32 208, i32 89, i32 18, i32 169, i32 200, i32 196, i32 135, i32 130, i32 116, i32 188, i32 159, i32 86, i32 164, i32 100, i32 109, i32 198, i32 173, i32 186, i32 3, i32 64, i32 52, i32 217, i32 226, i32 250, i32 124, i32 123, i32 5, i32 202, i32 38, i32 147, i32 118, i32 126, i32 255, i32 82, i32 85, i32 212, i32 207, i32 206, i32 59, i32 227, i32 47, i32 16, i32 58, i32 17, i32 182, i32 189, i32 28, i32 42, i32 223, i32 183, i32 170, i32 213, i32 119, i32 248, i32 152, i32 2, i32 44, i32 154, i32 163, i32 70, i32 221, i32 153, i32 101, i32 155, i32 167, i32 43, i32 172, i32 9, i32 129, i32 22, i32 39, i32 253, i32 19, i32 98, i32 108, i32 110, i32 79, i32 113, i32 224, i32 232, i32 178, i32 185, i32 112, i32 104, i32 218, i32 246, i32 97, i32 228, i32 251, i32 34, i32 242, i32 193, i32 238, i32 210, i32 144, i32 12, i32 191, i32 179, i32 162, i32 241, i32 81, i32 51, i32 145, i32 235, i32 249, i32 14, i32 239, i32 107, i32 49, i32 192, i32 214, i32 31, i32 181, i32 199, i32 106, i32 157, i32 184, i32 84, i32 204, i32 176, i32 115, i32 121, i32 50, i32 45, i32 127, i32 4, i32 150, i32 254, i32 138, i32 236, i32 205, i32 93, i32 222, i32 114, i32 67, i32 29, i32 24, i32 72, i32 243, i32 141, i32 128, i32 195, i32 78, i32 66, i32 215, i32 61, i32 156, i32 180], align 16

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  %x = alloca double, align 8
  %y = alloca double, align 8
  %z = alloca double, align 8
  %sum = alloca double, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  call void @init()
  store double 0.000000e+00, double* %sum, align 8
  store double -1.135257e+04, double* %x, align 8
  br label %4

; <label>:4                                       ; preds = %30, %0
  %5 = load double* %x, align 8
  %6 = fcmp olt double %5, 2.356157e+04
  br i1 %6, label %7, label %33

; <label>:7                                       ; preds = %4
  store double -3.461235e+02, double* %y, align 8
  br label %8

; <label>:8                                       ; preds = %26, %7
  %9 = load double* %y, align 8
  %10 = fcmp olt double %9, 1.241240e+02
  br i1 %10, label %11, label %29

; <label>:11                                      ; preds = %8
  store double -1.562350e+02, double* %z, align 8
  br label %12

; <label>:12                                      ; preds = %22, %11
  %13 = load double* %y, align 8
  %14 = fcmp olt double %13, 2.323450e+01
  br i1 %14, label %15, label %25

; <label>:15                                      ; preds = %12
  %16 = load double* %x, align 8
  %17 = load double* %y, align 8
  %18 = load double* %z, align 8
  %19 = call double @noise(double %16, double %17, double %18)
  %20 = load double* %sum, align 8
  %21 = fadd double %20, %19
  store double %21, double* %sum, align 8
  br label %22

; <label>:22                                      ; preds = %15
  %23 = load double* %y, align 8
  %24 = fadd double %23, 2.450000e+00
  store double %24, double* %y, align 8
  br label %12

; <label>:25                                      ; preds = %12
  br label %26

; <label>:26                                      ; preds = %25
  %27 = load double* %y, align 8
  %28 = fadd double %27, 1.432500e+00
  store double %28, double* %y, align 8
  br label %8

; <label>:29                                      ; preds = %8
  br label %30

; <label>:30                                      ; preds = %29
  %31 = load double* %x, align 8
  %32 = fadd double %31, 1.235000e-01
  store double %32, double* %x, align 8
  br label %4

; <label>:33                                      ; preds = %4
  %34 = load double* %sum, align 8
  %35 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0), double %34)
  ret i32 0
}

define internal void @init() nounwind ssp {
  %i = alloca i32, align 4
  store i32 0, i32* %i, align 4
  store i32 0, i32* %i, align 4
  br label %1

; <label>:1                                       ; preds = %16, %0
  %2 = load i32* %i, align 4
  %3 = icmp slt i32 %2, 256
  br i1 %3, label %4, label %19

; <label>:4                                       ; preds = %1
  %5 = load i32* %i, align 4
  %6 = sext i32 %5 to i64
  %7 = getelementptr inbounds [256 x i32]* @permutation, i32 0, i64 %6
  %8 = load i32* %7
  %9 = load i32* %i, align 4
  %10 = sext i32 %9 to i64
  %11 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %10
  store i32 %8, i32* %11
  %12 = load i32* %i, align 4
  %13 = add nsw i32 256, %12
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %14
  store i32 %8, i32* %15
  br label %16

; <label>:16                                      ; preds = %4
  %17 = load i32* %i, align 4
  %18 = add nsw i32 %17, 1
  store i32 %18, i32* %i, align 4
  br label %1

; <label>:19                                      ; preds = %1
  ret void
}

define internal double @noise(double %x, double %y, double %z) nounwind ssp {
  %1 = alloca double, align 8
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  %X = alloca i32, align 4
  %Y = alloca i32, align 4
  %Z = alloca i32, align 4
  %u = alloca double, align 8
  %v = alloca double, align 8
  %w = alloca double, align 8
  %A = alloca i32, align 4
  %AA = alloca i32, align 4
  %AB = alloca i32, align 4
  %B = alloca i32, align 4
  %BA = alloca i32, align 4
  %BB = alloca i32, align 4
  store double %x, double* %1, align 8
  store double %y, double* %2, align 8
  store double %z, double* %3, align 8
  %4 = load double* %1, align 8
  %5 = call double @floor(double %4)
  %6 = fptosi double %5 to i32
  %7 = and i32 %6, 255
  store i32 %7, i32* %X, align 4
  %8 = load double* %2, align 8
  %9 = call double @floor(double %8)
  %10 = fptosi double %9 to i32
  %11 = and i32 %10, 255
  store i32 %11, i32* %Y, align 4
  %12 = load double* %3, align 8
  %13 = call double @floor(double %12)
  %14 = fptosi double %13 to i32
  %15 = and i32 %14, 255
  store i32 %15, i32* %Z, align 4
  %16 = load double* %1, align 8
  %17 = call double @floor(double %16)
  %18 = load double* %1, align 8
  %19 = fsub double %18, %17
  store double %19, double* %1, align 8
  %20 = load double* %2, align 8
  %21 = call double @floor(double %20)
  %22 = load double* %2, align 8
  %23 = fsub double %22, %21
  store double %23, double* %2, align 8
  %24 = load double* %3, align 8
  %25 = call double @floor(double %24)
  %26 = load double* %3, align 8
  %27 = fsub double %26, %25
  store double %27, double* %3, align 8
  %28 = load double* %1, align 8
  %29 = call double @fade(double %28)
  store double %29, double* %u, align 8
  %30 = load double* %2, align 8
  %31 = call double @fade(double %30)
  store double %31, double* %v, align 8
  %32 = load double* %3, align 8
  %33 = call double @fade(double %32)
  store double %33, double* %w, align 8
  %34 = load i32* %X, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %35
  %37 = load i32* %36
  %38 = load i32* %Y, align 4
  %39 = add nsw i32 %37, %38
  store i32 %39, i32* %A, align 4
  %40 = load i32* %A, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %41
  %43 = load i32* %42
  %44 = load i32* %Z, align 4
  %45 = add nsw i32 %43, %44
  store i32 %45, i32* %AA, align 4
  %46 = load i32* %A, align 4
  %47 = add nsw i32 %46, 1
  %48 = sext i32 %47 to i64
  %49 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %48
  %50 = load i32* %49
  %51 = load i32* %Z, align 4
  %52 = add nsw i32 %50, %51
  store i32 %52, i32* %AB, align 4
  %53 = load i32* %X, align 4
  %54 = add nsw i32 %53, 1
  %55 = sext i32 %54 to i64
  %56 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %55
  %57 = load i32* %56
  %58 = load i32* %Y, align 4
  %59 = add nsw i32 %57, %58
  store i32 %59, i32* %B, align 4
  %60 = load i32* %B, align 4
  %61 = sext i32 %60 to i64
  %62 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %61
  %63 = load i32* %62
  %64 = load i32* %Z, align 4
  %65 = add nsw i32 %63, %64
  store i32 %65, i32* %BA, align 4
  %66 = load i32* %B, align 4
  %67 = add nsw i32 %66, 1
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %68
  %70 = load i32* %69
  %71 = load i32* %Z, align 4
  %72 = add nsw i32 %70, %71
  store i32 %72, i32* %BB, align 4
  %73 = load double* %w, align 8
  %74 = load double* %v, align 8
  %75 = load double* %u, align 8
  %76 = load i32* %AA, align 4
  %77 = sext i32 %76 to i64
  %78 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %77
  %79 = load i32* %78
  %80 = load double* %1, align 8
  %81 = load double* %2, align 8
  %82 = load double* %3, align 8
  %83 = call double @grad(i32 %79, double %80, double %81, double %82)
  %84 = load i32* %BA, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %85
  %87 = load i32* %86
  %88 = load double* %1, align 8
  %89 = fsub double %88, 1.000000e+00
  %90 = load double* %2, align 8
  %91 = load double* %3, align 8
  %92 = call double @grad(i32 %87, double %89, double %90, double %91)
  %93 = call double @lerp(double %75, double %83, double %92)
  %94 = load double* %u, align 8
  %95 = load i32* %AB, align 4
  %96 = sext i32 %95 to i64
  %97 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %96
  %98 = load i32* %97
  %99 = load double* %1, align 8
  %100 = load double* %2, align 8
  %101 = fsub double %100, 1.000000e+00
  %102 = load double* %3, align 8
  %103 = call double @grad(i32 %98, double %99, double %101, double %102)
  %104 = load i32* %BB, align 4
  %105 = sext i32 %104 to i64
  %106 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %105
  %107 = load i32* %106
  %108 = load double* %1, align 8
  %109 = fsub double %108, 1.000000e+00
  %110 = load double* %2, align 8
  %111 = fsub double %110, 1.000000e+00
  %112 = load double* %3, align 8
  %113 = call double @grad(i32 %107, double %109, double %111, double %112)
  %114 = call double @lerp(double %94, double %103, double %113)
  %115 = call double @lerp(double %74, double %93, double %114)
  %116 = load double* %v, align 8
  %117 = load double* %u, align 8
  %118 = load i32* %AA, align 4
  %119 = add nsw i32 %118, 1
  %120 = sext i32 %119 to i64
  %121 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %120
  %122 = load i32* %121
  %123 = load double* %1, align 8
  %124 = load double* %2, align 8
  %125 = load double* %3, align 8
  %126 = fsub double %125, 1.000000e+00
  %127 = call double @grad(i32 %122, double %123, double %124, double %126)
  %128 = load i32* %BA, align 4
  %129 = add nsw i32 %128, 1
  %130 = sext i32 %129 to i64
  %131 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %130
  %132 = load i32* %131
  %133 = load double* %1, align 8
  %134 = fsub double %133, 1.000000e+00
  %135 = load double* %2, align 8
  %136 = load double* %3, align 8
  %137 = fsub double %136, 1.000000e+00
  %138 = call double @grad(i32 %132, double %134, double %135, double %137)
  %139 = call double @lerp(double %117, double %127, double %138)
  %140 = load double* %u, align 8
  %141 = load i32* %AB, align 4
  %142 = add nsw i32 %141, 1
  %143 = sext i32 %142 to i64
  %144 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %143
  %145 = load i32* %144
  %146 = load double* %1, align 8
  %147 = load double* %2, align 8
  %148 = fsub double %147, 1.000000e+00
  %149 = load double* %3, align 8
  %150 = fsub double %149, 1.000000e+00
  %151 = call double @grad(i32 %145, double %146, double %148, double %150)
  %152 = load i32* %BB, align 4
  %153 = add nsw i32 %152, 1
  %154 = sext i32 %153 to i64
  %155 = getelementptr inbounds [512 x i32]* @p, i32 0, i64 %154
  %156 = load i32* %155
  %157 = load double* %1, align 8
  %158 = fsub double %157, 1.000000e+00
  %159 = load double* %2, align 8
  %160 = fsub double %159, 1.000000e+00
  %161 = load double* %3, align 8
  %162 = fsub double %161, 1.000000e+00
  %163 = call double @grad(i32 %156, double %158, double %160, double %162)
  %164 = call double @lerp(double %140, double %151, double %163)
  %165 = call double @lerp(double %116, double %139, double %164)
  %166 = call double @lerp(double %73, double %115, double %165)
  ret double %166
}

declare i32 @printf(i8*, ...)

declare double @floor(double)

define internal double @fade(double %t) nounwind ssp {
  %1 = alloca double, align 8
  store double %t, double* %1, align 8
  %2 = load double* %1, align 8
  %3 = load double* %1, align 8
  %4 = fmul double %2, %3
  %5 = load double* %1, align 8
  %6 = fmul double %4, %5
  %7 = load double* %1, align 8
  %8 = load double* %1, align 8
  %9 = fmul double %8, 6.000000e+00
  %10 = fsub double %9, 1.500000e+01
  %11 = fmul double %7, %10
  %12 = fadd double %11, 1.000000e+01
  %13 = fmul double %6, %12
  ret double %13
}

define internal double @lerp(double %t, double %a, double %b) nounwind ssp {
  %1 = alloca double, align 8
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  store double %t, double* %1, align 8
  store double %a, double* %2, align 8
  store double %b, double* %3, align 8
  %4 = load double* %2, align 8
  %5 = load double* %1, align 8
  %6 = load double* %3, align 8
  %7 = load double* %2, align 8
  %8 = fsub double %6, %7
  %9 = fmul double %5, %8
  %10 = fadd double %4, %9
  ret double %10
}

define internal double @grad(i32 %hash, double %x, double %y, double %z) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca double, align 8
  %3 = alloca double, align 8
  %4 = alloca double, align 8
  %h = alloca i32, align 4
  %u = alloca double, align 8
  %v = alloca double, align 8
  store i32 %hash, i32* %1, align 4
  store double %x, double* %2, align 8
  store double %y, double* %3, align 8
  store double %z, double* %4, align 8
  %5 = load i32* %1, align 4
  %6 = and i32 %5, 15
  store i32 %6, i32* %h, align 4
  %7 = load i32* %h, align 4
  %8 = icmp slt i32 %7, 8
  %9 = load double* %2, align 8
  %10 = load double* %3, align 8
  %11 = select i1 %8, double %9, double %10
  store double %11, double* %u, align 8
  %12 = load i32* %h, align 4
  %13 = icmp slt i32 %12, 4
  br i1 %13, label %14, label %16

; <label>:14                                      ; preds = %0
  %15 = load double* %3, align 8
  br label %27

; <label>:16                                      ; preds = %0
  %17 = load i32* %h, align 4
  %18 = icmp eq i32 %17, 12
  br i1 %18, label %22, label %19

; <label>:19                                      ; preds = %16
  %20 = load i32* %h, align 4
  %21 = icmp eq i32 %20, 14
  br label %22

; <label>:22                                      ; preds = %19, %16
  %23 = phi i1 [ true, %16 ], [ %21, %19 ]
  %24 = load double* %2, align 8
  %25 = load double* %4, align 8
  %26 = select i1 %23, double %24, double %25
  br label %27

; <label>:27                                      ; preds = %22, %14
  %28 = phi double [ %15, %14 ], [ %26, %22 ]
  store double %28, double* %v, align 8
  %29 = load i32* %h, align 4
  %30 = and i32 %29, 1
  %31 = icmp eq i32 %30, 0
  br i1 %31, label %32, label %34

; <label>:32                                      ; preds = %27
  %33 = load double* %u, align 8
  br label %37

; <label>:34                                      ; preds = %27
  %35 = load double* %u, align 8
  %36 = fsub double -0.000000e+00, %35
  br label %37

; <label>:37                                      ; preds = %34, %32
  %38 = phi double [ %33, %32 ], [ %36, %34 ]
  %39 = load i32* %h, align 4
  %40 = and i32 %39, 2
  %41 = icmp eq i32 %40, 0
  br i1 %41, label %42, label %44

; <label>:42                                      ; preds = %37
  %43 = load double* %v, align 8
  br label %47

; <label>:44                                      ; preds = %37
  %45 = load double* %v, align 8
  %46 = fsub double -0.000000e+00, %45
  br label %47

; <label>:47                                      ; preds = %44, %42
  %48 = phi double [ %43, %42 ], [ %46, %44 ]
  %49 = fadd double %38, %48
  ret double %49
}
