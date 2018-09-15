; ModuleID = 'almabench.c.o'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64-apple-darwin10.0.0"

@amas = constant [8 x double] [double 6.023600e+06, double 4.085235e+05, double 3.289005e+05, double 3.098710e+06, double 1.047355e+03, double 3.498500e+03, double 2.286900e+04, double 1.931400e+04], align 16
@a = constant [8 x [3 x double]] [[3 x double] [double 0x3FD8C637FD3B6253, double 0.000000e+00, double 0.000000e+00], [3 x double] [double 0x3FE725849423E3E0, double 0.000000e+00, double 0.000000e+00], [3 x double] [double 0x3FF000011136AEF5, double 0.000000e+00, double 0.000000e+00], [3 x double] [double 0x3FF860FD96F0D223, double 3.000000e-10, double 0.000000e+00], [3 x double] [double 0x4014CF7737365089, double 1.913200e-06, double -3.900000e-09], [3 x double] [double 0x40231C1D0EBB7C0F, double -2.138960e-05, double 4.440000e-08], [3 x double] [double 0x403337EC14C35EFA, double -3.716000e-07, double 9.790000e-08], [3 x double] [double 0x403E1C425059FB17, double -1.663500e-06, double 6.860000e-08]], align 16
@dlm = constant [8 x [3 x double]] [[3 x double] [double 0x406F88076B035926, double 0x41F40BBCADEE3CB4, double -1.927890e+00], [3 x double] [double 0x4066BF5A874FEAFA, double 0x41DF6432F5157881, double 5.938100e-01], [3 x double] [double 0x40591DDA6DBF7622, double 0x41D34FC2F3B56502, double -2.044110e+00], [3 x double] [double 0x407636ED90F7B482, double 0x41C4890A4B784DFD, double 9.426400e-01], [3 x double] [double 0x40412CFE90EA1D96, double 0x419A0C7E6F1EA0BA, double -3.060378e+01], [3 x double] [double 0x404909E9B1DFE17D, double 0x4184FA9E14756430, double 7.561614e+01], [3 x double] [double 0x4073A0E14D09C902, double 0x416D6BA57E0EFDCA, double -1.750830e+00], [3 x double] [double 0x4073059422411D82, double 0x415E0127CD46B26C, double 2.110300e-01]], align 16
@e = constant [8 x [3 x double]] [[3 x double] [double 0x3FCA52242A37D430, double 2.040653e-04, double -2.834900e-06], [3 x double] [double 0x3F7BBCDE77820827, double -4.776521e-04, double 9.812700e-06], [3 x double] [double 0x3F911C1175CC9F7B, double -4.203654e-04, double -1.267340e-05], [3 x double] [double 0x3FB7E91AD74BF5B0, double 9.048438e-04, double -8.064100e-06], [3 x double] [double 0x3FA8D4B857E48742, double 0x3F5ABE2B9A18B7B5, double -4.713660e-05], [3 x double] [double 0x3FAC70CE5FA41E66, double 0xBF6C6594A86FD58E, double -6.436390e-05], [3 x double] [double 0x3FA7BF479022D287, double -2.729293e-04, double 7.891300e-06], [3 x double] [double 9.455747e-03, double 6.032630e-05, double 0.000000e+00]], align 16
@pi = constant [8 x [3 x double]] [[3 x double] [double 0x40535D310DE9F882, double 0x40B6571DAB9F559B, double -4.830160e+00], [3 x double] [double 0x40607209DADFB507, double 1.754864e+02, double 0xC07F27B59DDC1E79], [3 x double] [double 0x4059BBFD82CD2461, double 0x40C6AE2D2BD3C361, double 5.327577e+01], [3 x double] [double 0x407500F6B7DFD5BE, double 0x40CF363AC3222920, double -6.232800e+01], [3 x double] [double 0x402CA993F265B897, double 0x40BE4EC06AD2DCB1, double 0x40703F599ED7C6FC], [3 x double] [double 0x405743A9C7642D26, double 0x40D3EADFA415F45E, double 0x4067C84DFCE3150E], [3 x double] [double 0x4065A02B58283528, double 0x40A91F1FF04577D9, double -3.409288e+01], [3 x double] [double 0x40480F65305B6785, double 0x40906AE060FE4799, double 2.739717e+01]], align 16
@dinc = constant [8 x [3 x double]] [[3 x double] [double 0x401C051B1D92B7FE, double 0xC06AC83387160957, double 2.897700e-01], [3 x double] [double 0x400B28447E34386C, double -3.084437e+01, double -1.167836e+01], [3 x double] [double 0.000000e+00, double 0x407D5F90F51AC9B0, double -3.350530e+00], [3 x double] [double 0x3FFD987ACB2252BB, double 0xC072551355475A32, double -8.118300e+00], [3 x double] [double 0x3FF4DA2E7A10E830, double -7.155890e+01, double 1.195297e+01], [3 x double] [double 0x4003E939471E778F, double 9.185195e+01, double -1.766225e+01], [3 x double] [double 0x3FE8BE07677D67B5, double -6.072723e+01, double 1.257590e+00], [3 x double] [double 0x3FFC51B9CE9853F4, double 8.123330e+00, double 8.135000e-02]], align 16
@omega = constant [8 x [3 x double]] [[3 x double] [double 0x40482A5AB400A313, double 0xC0B1A3379F01B867, double -3.179892e+01], [3 x double] [double 0x40532B83CFF8FC2B, double 0xC0C38C3DA31A4BDC, double -5.132614e+01], [3 x double] [double 0x4065DBF10E4FF9E8, double 0xC0C0F3A29A804966, double 1.534191e+01], [3 x double] [double 0x4048C76F992A88EB, double 0xC0C4BE7350092CCF, double 0xC06CD25F84CAD57C], [3 x double] [double 0x40591DB8D838BBB3, double 0x40B8DA091DBCA969, double 0x4074685935FC3B4F], [3 x double] [double 0x405C6A9797E1B38F, double 0xC0C20C1986983516, double -6.623743e+01], [3 x double] [double 0x405280619982C872, double 0x40A4DA4CF80DC337, double 0x40623E1187E7C06E], [3 x double] [double 0x40607916FEBF632D, double 0xC06BBE2EDBB59DDC, double -7.872800e-01]], align 16
@kp = constant [8 x [9 x double]] [[9 x double] [double 6.961300e+04, double 7.564500e+04, double 8.830600e+04, double 5.989900e+04, double 1.574600e+04, double 7.108700e+04, double 1.421730e+05, double 3.086000e+03, double 0.000000e+00], [9 x double] [double 2.186300e+04, double 3.279400e+04, double 2.693400e+04, double 1.093100e+04, double 2.625000e+04, double 4.372500e+04, double 5.386700e+04, double 2.893900e+04, double 0.000000e+00], [9 x double] [double 1.600200e+04, double 2.186300e+04, double 3.200400e+04, double 1.093100e+04, double 1.452900e+04, double 1.636800e+04, double 1.531800e+04, double 3.279400e+04, double 0.000000e+00], [9 x double] [double 6.345000e+03, double 7.818000e+03, double 1.563600e+04, double 7.077000e+03, double 8.184000e+03, double 1.416300e+04, double 1.107000e+03, double 4.872000e+03, double 0.000000e+00], [9 x double] [double 1.760000e+03, double 1.454000e+03, double 1.167000e+03, double 8.800000e+02, double 2.870000e+02, double 2.640000e+03, double 1.900000e+01, double 2.047000e+03, double 1.454000e+03], [9 x double] [double 5.740000e+02, double 0.000000e+00, double 8.800000e+02, double 2.870000e+02, double 1.900000e+01, double 1.760000e+03, double 1.167000e+03, double 3.060000e+02, double 5.740000e+02], [9 x double] [double 2.040000e+02, double 0.000000e+00, double 1.770000e+02, double 1.265000e+03, double 4.000000e+00, double 3.850000e+02, double 2.000000e+02, double 2.080000e+02, double 2.040000e+02], [9 x double] [double 0.000000e+00, double 1.020000e+02, double 1.060000e+02, double 4.000000e+00, double 9.800000e+01, double 1.367000e+03, double 4.870000e+02, double 2.040000e+02, double 0.000000e+00]], align 16
@ca = constant [8 x [9 x double]] [[9 x double] [double 4.000000e+00, double -1.300000e+01, double 1.100000e+01, double -9.000000e+00, double -9.000000e+00, double -3.000000e+00, double -1.000000e+00, double 4.000000e+00, double 0.000000e+00], [9 x double] [double -1.560000e+02, double 5.900000e+01, double -4.200000e+01, double 6.000000e+00, double 1.900000e+01, double -2.000000e+01, double -1.000000e+01, double -1.200000e+01, double 0.000000e+00], [9 x double] [double 6.400000e+01, double -1.520000e+02, double 6.200000e+01, double -8.000000e+00, double 3.200000e+01, double -4.100000e+01, double 1.900000e+01, double -1.100000e+01, double 0.000000e+00], [9 x double] [double 1.240000e+02, double 6.210000e+02, double -1.450000e+02, double 2.080000e+02, double 5.400000e+01, double -5.700000e+01, double 3.000000e+01, double 1.500000e+01, double 0.000000e+00], [9 x double] [double -2.343700e+04, double -2.634000e+03, double 6.601000e+03, double 6.259000e+03, double -1.507000e+03, double -1.821000e+03, double 2.620000e+03, double -2.115000e+03, double -1.489000e+03], [9 x double] [double 6.291100e+04, double -1.199190e+05, double 7.933600e+04, double 1.781400e+04, double -2.424100e+04, double 1.206800e+04, double 8.306000e+03, double -4.893000e+03, double 8.902000e+03], [9 x double] [double 3.890610e+05, double -2.621250e+05, double -4.408800e+04, double 8.387000e+03, double -2.297600e+04, double -2.093000e+03, double -6.150000e+02, double -9.720000e+03, double 6.633000e+03], [9 x double] [double -4.122350e+05, double -1.570460e+05, double -3.143000e+04, double 3.781700e+04, double -9.740000e+03, double -1.300000e+01, double -7.449000e+03, double 9.644000e+03, double 0.000000e+00]], align 16
@sa = constant [8 x [9 x double]] [[9 x double] [double -2.900000e+01, double -1.000000e+00, double 9.000000e+00, double 6.000000e+00, double -6.000000e+00, double 5.000000e+00, double 4.000000e+00, double 0.000000e+00, double 0.000000e+00], [9 x double] [double -4.800000e+01, double -1.250000e+02, double -2.600000e+01, double -3.700000e+01, double 1.800000e+01, double -1.300000e+01, double -2.000000e+01, double -2.000000e+00, double 0.000000e+00], [9 x double] [double -1.500000e+02, double -4.600000e+01, double 6.800000e+01, double 5.400000e+01, double 1.400000e+01, double 2.400000e+01, double -2.800000e+01, double 2.200000e+01, double 0.000000e+00], [9 x double] [double -6.210000e+02, double 5.320000e+02, double -6.940000e+02, double -2.000000e+01, double 1.920000e+02, double -9.400000e+01, double 7.100000e+01, double -7.300000e+01, double 0.000000e+00], [9 x double] [double -1.461400e+04, double -1.982800e+04, double -5.869000e+03, double 1.881000e+03, double -4.372000e+03, double -2.255000e+03, double 7.820000e+02, double 9.300000e+02, double 9.130000e+02], [9 x double] [double 1.397370e+05, double 0.000000e+00, double 2.466700e+04, double 5.112300e+04, double -5.102000e+03, double 7.429000e+03, double -4.095000e+03, double -1.976000e+03, double -9.566000e+03], [9 x double] [double -1.380810e+05, double 0.000000e+00, double 3.720500e+04, double -4.903900e+04, double -4.190100e+04, double -3.387200e+04, double -2.703700e+04, double -1.247400e+04, double 1.879700e+04], [9 x double] [double 0.000000e+00, double 2.849200e+04, double 1.332360e+05, double 6.965400e+04, double 5.232200e+04, double -4.957700e+04, double -2.643000e+04, double -3.593000e+03, double 0.000000e+00]], align 16
@kq = constant [8 x [10 x double]] [[10 x double] [double 3.086000e+03, double 1.574600e+04, double 6.961300e+04, double 5.989900e+04, double 7.564500e+04, double 8.830600e+04, double 1.266100e+04, double 2.658000e+03, double 0.000000e+00, double 0.000000e+00], [10 x double] [double 2.186300e+04, double 3.279400e+04, double 1.093100e+04, double 7.300000e+01, double 4.387000e+03, double 2.693400e+04, double 1.473000e+03, double 2.157000e+03, double 0.000000e+00, double 0.000000e+00], [10 x double] [double 1.000000e+01, double 1.600200e+04, double 2.186300e+04, double 1.093100e+04, double 1.473000e+03, double 3.200400e+04, double 4.387000e+03, double 7.300000e+01, double 0.000000e+00, double 0.000000e+00], [10 x double] [double 1.000000e+01, double 6.345000e+03, double 7.818000e+03, double 1.107000e+03, double 1.563600e+04, double 7.077000e+03, double 8.184000e+03, double 5.320000e+02, double 1.000000e+01, double 0.000000e+00], [10 x double] [double 1.900000e+01, double 1.760000e+03, double 1.454000e+03, double 2.870000e+02, double 1.167000e+03, double 8.800000e+02, double 5.740000e+02, double 2.640000e+03, double 1.900000e+01, double 1.454000e+03], [10 x double] [double 1.900000e+01, double 5.740000e+02, double 2.870000e+02, double 3.060000e+02, double 1.760000e+03, double 1.200000e+01, double 3.100000e+01, double 3.800000e+01, double 1.900000e+01, double 5.740000e+02], [10 x double] [double 4.000000e+00, double 2.040000e+02, double 1.770000e+02, double 8.000000e+00, double 3.100000e+01, double 2.000000e+02, double 1.265000e+03, double 1.020000e+02, double 4.000000e+00, double 2.040000e+02], [10 x double] [double 4.000000e+00, double 1.020000e+02, double 1.060000e+02, double 8.000000e+00, double 9.800000e+01, double 1.367000e+03, double 4.870000e+02, double 2.040000e+02, double 4.000000e+00, double 1.020000e+02]], align 16
@cl = constant [8 x [10 x double]] [[10 x double] [double 2.100000e+01, double -9.500000e+01, double -1.570000e+02, double 4.100000e+01, double -5.000000e+00, double 4.200000e+01, double 2.300000e+01, double 3.000000e+01, double 0.000000e+00, double 0.000000e+00], [10 x double] [double -1.600000e+02, double -3.130000e+02, double -2.350000e+02, double 6.000000e+01, double -7.400000e+01, double -7.600000e+01, double -2.700000e+01, double 3.400000e+01, double 0.000000e+00, double 0.000000e+00], [10 x double] [double -3.250000e+02, double -3.220000e+02, double -7.900000e+01, double 2.320000e+02, double -5.200000e+01, double 9.700000e+01, double 5.500000e+01, double -4.100000e+01, double 0.000000e+00, double 0.000000e+00], [10 x double] [double 2.268000e+03, double -9.790000e+02, double 8.020000e+02, double 6.020000e+02, double -6.680000e+02, double -3.300000e+01, double 3.450000e+02, double 2.010000e+02, double -5.500000e+01, double 0.000000e+00], [10 x double] [double 7.610000e+03, double -4.997000e+03, double -7.689000e+03, double -5.841000e+03, double -2.617000e+03, double 1.115000e+03, double -7.480000e+02, double -6.070000e+02, double 6.074000e+03, double 3.540000e+02], [10 x double] [double -1.854900e+04, double 3.012500e+04, double 2.001200e+04, double -7.300000e+02, double 8.240000e+02, double 2.300000e+01, double 1.289000e+03, double -3.520000e+02, double -1.476700e+04, double -2.062000e+03], [10 x double] [double -1.352450e+05, double -1.459400e+04, double 4.197000e+03, double -4.030000e+03, double -5.630000e+03, double -2.898000e+03, double 2.540000e+03, double -3.060000e+02, double 2.939000e+03, double 1.986000e+03], [10 x double] [double 8.994800e+04, double 2.103000e+03, double 8.963000e+03, double 2.695000e+03, double 3.682000e+03, double 1.648000e+03, double 8.660000e+02, double -1.540000e+02, double -1.963000e+03, double -2.830000e+02]], align 16
@sl = constant [8 x [10 x double]] [[10 x double] [double -3.420000e+02, double 1.360000e+02, double -2.300000e+01, double 6.200000e+01, double 6.600000e+01, double -5.200000e+01, double -3.300000e+01, double 1.700000e+01, double 0.000000e+00, double 0.000000e+00], [10 x double] [double 5.240000e+02, double -1.490000e+02, double -3.500000e+01, double 1.170000e+02, double 1.510000e+02, double 1.220000e+02, double -7.100000e+01, double -6.200000e+01, double 0.000000e+00, double 0.000000e+00], [10 x double] [double -1.050000e+02, double -1.370000e+02, double 2.580000e+02, double 3.500000e+01, double -1.160000e+02, double -8.800000e+01, double -1.120000e+02, double -8.000000e+01, double 0.000000e+00, double 0.000000e+00], [10 x double] [double 8.540000e+02, double -2.050000e+02, double -9.360000e+02, double -2.400000e+02, double 1.400000e+02, double -3.410000e+02, double -9.700000e+01, double -2.320000e+02, double 5.360000e+02, double 0.000000e+00], [10 x double] [double -5.698000e+04, double 8.016000e+03, double 1.012000e+03, double 1.448000e+03, double -3.024000e+03, double -3.710000e+03, double 3.180000e+02, double 5.030000e+02, double 3.767000e+03, double 5.770000e+02], [10 x double] [double 1.386060e+05, double -1.347800e+04, double -4.964000e+03, double 1.441000e+03, double -1.319000e+03, double -1.482000e+03, double 4.270000e+02, double 1.236000e+03, double -9.167000e+03, double -1.918000e+03], [10 x double] [double 7.123400e+04, double -4.111600e+04, double 5.334000e+03, double -4.935000e+03, double -1.848000e+03, double 6.600000e+01, double 4.340000e+02, double -1.748000e+03, double 3.780000e+03, double -7.010000e+02], [10 x double] [double -4.764500e+04, double 1.164700e+04, double 2.166000e+03, double 3.194000e+03, double 6.790000e+02, double 0.000000e+00, double -2.440000e+02, double -4.190000e+02, double -2.531000e+03, double 4.800000e+01]], align 16
@.str = private constant [44 x i8] c"p = %d  position[0] = %g  position[1] = %g\0A\00"

define double @anpm(double %a) nounwind ssp {
  %1 = alloca double, align 8
  %w = alloca double, align 8
  store double %a, double* %1, align 8
  %2 = load double* %1, align 8
  %3 = call double @fmod(double %2, double 0x401921FB54442D18)
  store double %3, double* %w, align 8
  %4 = load double* %w, align 8
  %5 = call double @fabs(double %4)
  %6 = fcmp oge double %5, 0x400921FB54442D18
  br i1 %6, label %7, label %16

; <label>:7                                       ; preds = %0
  %8 = load double* %w, align 8
  %9 = load double* %1, align 8
  %10 = fcmp olt double %9, 0.000000e+00
  br i1 %10, label %11, label %12

; <label>:11                                      ; preds = %7
  br label %13

; <label>:12                                      ; preds = %7
  br label %13

; <label>:13                                      ; preds = %12, %11
  %14 = phi double [ 0xC01921FB54442D18, %11 ], [ 0x401921FB54442D18, %12 ]
  %15 = fsub double %8, %14
  store double %15, double* %w, align 8
  br label %16

; <label>:16                                      ; preds = %13, %0
  %17 = load double* %w, align 8
  ret double %17
}

declare double @fmod(double, double)

declare double @fabs(double)

define void @planetpv(double* %epoch, i32 %np, [3 x double]* %pv) nounwind ssp {
  %1 = alloca double*, align 8
  %2 = alloca i32, align 4
  %3 = alloca [3 x double]*, align 8
  %k = alloca i32, align 4
  %t = alloca double, align 8
  %da = alloca double, align 8
  %dl = alloca double, align 8
  %de = alloca double, align 8
  %dp = alloca double, align 8
  %di = alloca double, align 8
  %doh = alloca double, align 8
  %dmu = alloca double, align 8
  %arga = alloca double, align 8
  %argl = alloca double, align 8
  %am = alloca double, align 8
  %ae = alloca double, align 8
  %dae = alloca double, align 8
  %ae2 = alloca double, align 8
  %at = alloca double, align 8
  %r = alloca double, align 8
  %v = alloca double, align 8
  %si2 = alloca double, align 8
  %xq = alloca double, align 8
  %xp = alloca double, align 8
  %tl = alloca double, align 8
  %xsw = alloca double, align 8
  %xcw = alloca double, align 8
  %xm2 = alloca double, align 8
  %xf = alloca double, align 8
  %ci2 = alloca double, align 8
  %xms = alloca double, align 8
  %xmc = alloca double, align 8
  %xpxq2 = alloca double, align 8
  %x = alloca double, align 8
  %y = alloca double, align 8
  %z = alloca double, align 8
  store double* %epoch, double** %1, align 8
  store i32 %np, i32* %2, align 4
  store [3 x double]* %pv, [3 x double]** %3, align 8
  %4 = load double** %1, align 8
  %5 = getelementptr inbounds double* %4, i64 0
  %6 = load double* %5
  %7 = fsub double %6, 2.451545e+06
  %8 = load double** %1, align 8
  %9 = getelementptr inbounds double* %8, i64 1
  %10 = load double* %9
  %11 = fadd double %7, %10
  %12 = fdiv double %11, 3.652500e+05
  store double %12, double* %t, align 8
  %13 = load i32* %2, align 4
  %14 = sext i32 %13 to i64
  %15 = getelementptr inbounds [8 x [3 x double]]* @a, i32 0, i64 %14
  %16 = getelementptr inbounds [3 x double]* %15, i32 0, i64 0
  %17 = load double* %16
  %18 = load i32* %2, align 4
  %19 = sext i32 %18 to i64
  %20 = getelementptr inbounds [8 x [3 x double]]* @a, i32 0, i64 %19
  %21 = getelementptr inbounds [3 x double]* %20, i32 0, i64 1
  %22 = load double* %21
  %23 = load i32* %2, align 4
  %24 = sext i32 %23 to i64
  %25 = getelementptr inbounds [8 x [3 x double]]* @a, i32 0, i64 %24
  %26 = getelementptr inbounds [3 x double]* %25, i32 0, i64 2
  %27 = load double* %26
  %28 = load double* %t, align 8
  %29 = fmul double %27, %28
  %30 = fadd double %22, %29
  %31 = load double* %t, align 8
  %32 = fmul double %30, %31
  %33 = fadd double %17, %32
  store double %33, double* %da, align 8
  %34 = load i32* %2, align 4
  %35 = sext i32 %34 to i64
  %36 = getelementptr inbounds [8 x [3 x double]]* @dlm, i32 0, i64 %35
  %37 = getelementptr inbounds [3 x double]* %36, i32 0, i64 0
  %38 = load double* %37
  %39 = fmul double 3.600000e+03, %38
  %40 = load i32* %2, align 4
  %41 = sext i32 %40 to i64
  %42 = getelementptr inbounds [8 x [3 x double]]* @dlm, i32 0, i64 %41
  %43 = getelementptr inbounds [3 x double]* %42, i32 0, i64 1
  %44 = load double* %43
  %45 = load i32* %2, align 4
  %46 = sext i32 %45 to i64
  %47 = getelementptr inbounds [8 x [3 x double]]* @dlm, i32 0, i64 %46
  %48 = getelementptr inbounds [3 x double]* %47, i32 0, i64 2
  %49 = load double* %48
  %50 = load double* %t, align 8
  %51 = fmul double %49, %50
  %52 = fadd double %44, %51
  %53 = load double* %t, align 8
  %54 = fmul double %52, %53
  %55 = fadd double %39, %54
  %56 = fmul double %55, 0x3ED455A5B2FF8F9D
  store double %56, double* %dl, align 8
  %57 = load i32* %2, align 4
  %58 = sext i32 %57 to i64
  %59 = getelementptr inbounds [8 x [3 x double]]* @e, i32 0, i64 %58
  %60 = getelementptr inbounds [3 x double]* %59, i32 0, i64 0
  %61 = load double* %60
  %62 = load i32* %2, align 4
  %63 = sext i32 %62 to i64
  %64 = getelementptr inbounds [8 x [3 x double]]* @e, i32 0, i64 %63
  %65 = getelementptr inbounds [3 x double]* %64, i32 0, i64 1
  %66 = load double* %65
  %67 = load i32* %2, align 4
  %68 = sext i32 %67 to i64
  %69 = getelementptr inbounds [8 x [3 x double]]* @e, i32 0, i64 %68
  %70 = getelementptr inbounds [3 x double]* %69, i32 0, i64 2
  %71 = load double* %70
  %72 = load double* %t, align 8
  %73 = fmul double %71, %72
  %74 = fadd double %66, %73
  %75 = load double* %t, align 8
  %76 = fmul double %74, %75
  %77 = fadd double %61, %76
  store double %77, double* %de, align 8
  %78 = load i32* %2, align 4
  %79 = sext i32 %78 to i64
  %80 = getelementptr inbounds [8 x [3 x double]]* @pi, i32 0, i64 %79
  %81 = getelementptr inbounds [3 x double]* %80, i32 0, i64 0
  %82 = load double* %81
  %83 = fmul double 3.600000e+03, %82
  %84 = load i32* %2, align 4
  %85 = sext i32 %84 to i64
  %86 = getelementptr inbounds [8 x [3 x double]]* @pi, i32 0, i64 %85
  %87 = getelementptr inbounds [3 x double]* %86, i32 0, i64 1
  %88 = load double* %87
  %89 = load i32* %2, align 4
  %90 = sext i32 %89 to i64
  %91 = getelementptr inbounds [8 x [3 x double]]* @pi, i32 0, i64 %90
  %92 = getelementptr inbounds [3 x double]* %91, i32 0, i64 2
  %93 = load double* %92
  %94 = load double* %t, align 8
  %95 = fmul double %93, %94
  %96 = fadd double %88, %95
  %97 = load double* %t, align 8
  %98 = fmul double %96, %97
  %99 = fadd double %83, %98
  %100 = fmul double %99, 0x3ED455A5B2FF8F9D
  %101 = call double @anpm(double %100)
  store double %101, double* %dp, align 8
  %102 = load i32* %2, align 4
  %103 = sext i32 %102 to i64
  %104 = getelementptr inbounds [8 x [3 x double]]* @dinc, i32 0, i64 %103
  %105 = getelementptr inbounds [3 x double]* %104, i32 0, i64 0
  %106 = load double* %105
  %107 = fmul double 3.600000e+03, %106
  %108 = load i32* %2, align 4
  %109 = sext i32 %108 to i64
  %110 = getelementptr inbounds [8 x [3 x double]]* @dinc, i32 0, i64 %109
  %111 = getelementptr inbounds [3 x double]* %110, i32 0, i64 1
  %112 = load double* %111
  %113 = load i32* %2, align 4
  %114 = sext i32 %113 to i64
  %115 = getelementptr inbounds [8 x [3 x double]]* @dinc, i32 0, i64 %114
  %116 = getelementptr inbounds [3 x double]* %115, i32 0, i64 2
  %117 = load double* %116
  %118 = load double* %t, align 8
  %119 = fmul double %117, %118
  %120 = fadd double %112, %119
  %121 = load double* %t, align 8
  %122 = fmul double %120, %121
  %123 = fadd double %107, %122
  %124 = fmul double %123, 0x3ED455A5B2FF8F9D
  store double %124, double* %di, align 8
  %125 = load i32* %2, align 4
  %126 = sext i32 %125 to i64
  %127 = getelementptr inbounds [8 x [3 x double]]* @omega, i32 0, i64 %126
  %128 = getelementptr inbounds [3 x double]* %127, i32 0, i64 0
  %129 = load double* %128
  %130 = fmul double 3.600000e+03, %129
  %131 = load i32* %2, align 4
  %132 = sext i32 %131 to i64
  %133 = getelementptr inbounds [8 x [3 x double]]* @omega, i32 0, i64 %132
  %134 = getelementptr inbounds [3 x double]* %133, i32 0, i64 1
  %135 = load double* %134
  %136 = load i32* %2, align 4
  %137 = sext i32 %136 to i64
  %138 = getelementptr inbounds [8 x [3 x double]]* @omega, i32 0, i64 %137
  %139 = getelementptr inbounds [3 x double]* %138, i32 0, i64 2
  %140 = load double* %139
  %141 = load double* %t, align 8
  %142 = fmul double %140, %141
  %143 = fadd double %135, %142
  %144 = load double* %t, align 8
  %145 = fmul double %143, %144
  %146 = fadd double %130, %145
  %147 = fmul double %146, 0x3ED455A5B2FF8F9D
  %148 = call double @anpm(double %147)
  store double %148, double* %doh, align 8
  %149 = load double* %t, align 8
  %150 = fmul double 3.595362e-01, %149
  store double %150, double* %dmu, align 8
  store i32 0, i32* %k, align 4
  br label %151

; <label>:151                                     ; preds = %221, %0
  %152 = load i32* %k, align 4
  %153 = icmp slt i32 %152, 8
  br i1 %153, label %154, label %224

; <label>:154                                     ; preds = %151
  %155 = load i32* %k, align 4
  %156 = sext i32 %155 to i64
  %157 = load i32* %2, align 4
  %158 = sext i32 %157 to i64
  %159 = getelementptr inbounds [8 x [9 x double]]* @kp, i32 0, i64 %158
  %160 = getelementptr inbounds [9 x double]* %159, i32 0, i64 %156
  %161 = load double* %160
  %162 = load double* %dmu, align 8
  %163 = fmul double %161, %162
  store double %163, double* %arga, align 8
  %164 = load i32* %k, align 4
  %165 = sext i32 %164 to i64
  %166 = load i32* %2, align 4
  %167 = sext i32 %166 to i64
  %168 = getelementptr inbounds [8 x [10 x double]]* @kq, i32 0, i64 %167
  %169 = getelementptr inbounds [10 x double]* %168, i32 0, i64 %165
  %170 = load double* %169
  %171 = load double* %dmu, align 8
  %172 = fmul double %170, %171
  store double %172, double* %argl, align 8
  %173 = load double* %da, align 8
  %174 = load i32* %k, align 4
  %175 = sext i32 %174 to i64
  %176 = load i32* %2, align 4
  %177 = sext i32 %176 to i64
  %178 = getelementptr inbounds [8 x [9 x double]]* @ca, i32 0, i64 %177
  %179 = getelementptr inbounds [9 x double]* %178, i32 0, i64 %175
  %180 = load double* %179
  %181 = load double* %arga, align 8
  %182 = call double @cos(double %181)
  %183 = fmul double %180, %182
  %184 = load i32* %k, align 4
  %185 = sext i32 %184 to i64
  %186 = load i32* %2, align 4
  %187 = sext i32 %186 to i64
  %188 = getelementptr inbounds [8 x [9 x double]]* @sa, i32 0, i64 %187
  %189 = getelementptr inbounds [9 x double]* %188, i32 0, i64 %185
  %190 = load double* %189
  %191 = load double* %arga, align 8
  %192 = call double @sin(double %191)
  %193 = fmul double %190, %192
  %194 = fadd double %183, %193
  %195 = fmul double %194, 1.000000e-07
  %196 = fadd double %173, %195
  store double %196, double* %da, align 8
  %197 = load double* %dl, align 8
  %198 = load i32* %k, align 4
  %199 = sext i32 %198 to i64
  %200 = load i32* %2, align 4
  %201 = sext i32 %200 to i64
  %202 = getelementptr inbounds [8 x [10 x double]]* @cl, i32 0, i64 %201
  %203 = getelementptr inbounds [10 x double]* %202, i32 0, i64 %199
  %204 = load double* %203
  %205 = load double* %argl, align 8
  %206 = call double @cos(double %205)
  %207 = fmul double %204, %206
  %208 = load i32* %k, align 4
  %209 = sext i32 %208 to i64
  %210 = load i32* %2, align 4
  %211 = sext i32 %210 to i64
  %212 = getelementptr inbounds [8 x [10 x double]]* @sl, i32 0, i64 %211
  %213 = getelementptr inbounds [10 x double]* %212, i32 0, i64 %209
  %214 = load double* %213
  %215 = load double* %argl, align 8
  %216 = call double @sin(double %215)
  %217 = fmul double %214, %216
  %218 = fadd double %207, %217
  %219 = fmul double %218, 1.000000e-07
  %220 = fadd double %197, %219
  store double %220, double* %dl, align 8
  br label %221

; <label>:221                                     ; preds = %154
  %222 = load i32* %k, align 4
  %223 = add nsw i32 %222, 1
  store i32 %223, i32* %k, align 4
  br label %151

; <label>:224                                     ; preds = %151
  %225 = load i32* %2, align 4
  %226 = sext i32 %225 to i64
  %227 = getelementptr inbounds [8 x [9 x double]]* @kp, i32 0, i64 %226
  %228 = getelementptr inbounds [9 x double]* %227, i32 0, i64 8
  %229 = load double* %228
  %230 = load double* %dmu, align 8
  %231 = fmul double %229, %230
  store double %231, double* %arga, align 8
  %232 = load double* %da, align 8
  %233 = load double* %t, align 8
  %234 = load i32* %2, align 4
  %235 = sext i32 %234 to i64
  %236 = getelementptr inbounds [8 x [9 x double]]* @ca, i32 0, i64 %235
  %237 = getelementptr inbounds [9 x double]* %236, i32 0, i64 8
  %238 = load double* %237
  %239 = load double* %arga, align 8
  %240 = call double @cos(double %239)
  %241 = fmul double %238, %240
  %242 = load i32* %2, align 4
  %243 = sext i32 %242 to i64
  %244 = getelementptr inbounds [8 x [9 x double]]* @sa, i32 0, i64 %243
  %245 = getelementptr inbounds [9 x double]* %244, i32 0, i64 8
  %246 = load double* %245
  %247 = load double* %arga, align 8
  %248 = call double @sin(double %247)
  %249 = fmul double %246, %248
  %250 = fadd double %241, %249
  %251 = fmul double %233, %250
  %252 = fmul double %251, 1.000000e-07
  %253 = fadd double %232, %252
  store double %253, double* %da, align 8
  store i32 8, i32* %k, align 4
  br label %254

; <label>:254                                     ; preds = %293, %224
  %255 = load i32* %k, align 4
  %256 = icmp sle i32 %255, 9
  br i1 %256, label %257, label %296

; <label>:257                                     ; preds = %254
  %258 = load i32* %k, align 4
  %259 = sext i32 %258 to i64
  %260 = load i32* %2, align 4
  %261 = sext i32 %260 to i64
  %262 = getelementptr inbounds [8 x [10 x double]]* @kq, i32 0, i64 %261
  %263 = getelementptr inbounds [10 x double]* %262, i32 0, i64 %259
  %264 = load double* %263
  %265 = load double* %dmu, align 8
  %266 = fmul double %264, %265
  store double %266, double* %argl, align 8
  %267 = load double* %dl, align 8
  %268 = load double* %t, align 8
  %269 = load i32* %k, align 4
  %270 = sext i32 %269 to i64
  %271 = load i32* %2, align 4
  %272 = sext i32 %271 to i64
  %273 = getelementptr inbounds [8 x [10 x double]]* @cl, i32 0, i64 %272
  %274 = getelementptr inbounds [10 x double]* %273, i32 0, i64 %270
  %275 = load double* %274
  %276 = load double* %argl, align 8
  %277 = call double @cos(double %276)
  %278 = fmul double %275, %277
  %279 = load i32* %k, align 4
  %280 = sext i32 %279 to i64
  %281 = load i32* %2, align 4
  %282 = sext i32 %281 to i64
  %283 = getelementptr inbounds [8 x [10 x double]]* @sl, i32 0, i64 %282
  %284 = getelementptr inbounds [10 x double]* %283, i32 0, i64 %280
  %285 = load double* %284
  %286 = load double* %argl, align 8
  %287 = call double @sin(double %286)
  %288 = fmul double %285, %287
  %289 = fadd double %278, %288
  %290 = fmul double %268, %289
  %291 = fmul double %290, 1.000000e-07
  %292 = fadd double %267, %291
  store double %292, double* %dl, align 8
  br label %293

; <label>:293                                     ; preds = %257
  %294 = load i32* %k, align 4
  %295 = add nsw i32 %294, 1
  store i32 %295, i32* %k, align 4
  br label %254

; <label>:296                                     ; preds = %254
  %297 = load double* %dl, align 8
  %298 = call double @fmod(double %297, double 0x401921FB54442D18)
  store double %298, double* %dl, align 8
  %299 = load double* %dl, align 8
  %300 = load double* %dp, align 8
  %301 = fsub double %299, %300
  store double %301, double* %am, align 8
  %302 = load double* %am, align 8
  %303 = load double* %de, align 8
  %304 = load double* %am, align 8
  %305 = call double @sin(double %304)
  %306 = fmul double %303, %305
  %307 = fadd double %302, %306
  store double %307, double* %ae, align 8
  store i32 0, i32* %k, align 4
  br label %308

; <label>:308                                     ; preds = %335, %296
  %309 = load double* %am, align 8
  %310 = load double* %ae, align 8
  %311 = fsub double %309, %310
  %312 = load double* %de, align 8
  %313 = load double* %ae, align 8
  %314 = call double @sin(double %313)
  %315 = fmul double %312, %314
  %316 = fadd double %311, %315
  %317 = load double* %de, align 8
  %318 = load double* %ae, align 8
  %319 = call double @cos(double %318)
  %320 = fmul double %317, %319
  %321 = fsub double 1.000000e+00, %320
  %322 = fdiv double %316, %321
  store double %322, double* %dae, align 8
  %323 = load double* %ae, align 8
  %324 = load double* %dae, align 8
  %325 = fadd double %323, %324
  store double %325, double* %ae, align 8
  %326 = load i32* %k, align 4
  %327 = add nsw i32 %326, 1
  store i32 %327, i32* %k, align 4
  %328 = load i32* %k, align 4
  %329 = icmp sge i32 %328, 10
  br i1 %329, label %334, label %330

; <label>:330                                     ; preds = %308
  %331 = load double* %dae, align 8
  %332 = call double @fabs(double %331)
  %333 = fcmp olt double %332, 1.000000e-12
  br i1 %333, label %334, label %335

; <label>:334                                     ; preds = %330, %308
  br label %336

; <label>:335                                     ; preds = %330
  br label %308

; <label>:336                                     ; preds = %334
  %337 = load double* %ae, align 8
  %338 = fdiv double %337, 2.000000e+00
  store double %338, double* %ae2, align 8
  %339 = load double* %de, align 8
  %340 = fadd double 1.000000e+00, %339
  %341 = load double* %de, align 8
  %342 = fsub double 1.000000e+00, %341
  %343 = fdiv double %340, %342
  %344 = call double @sqrt(double %343)
  %345 = load double* %ae2, align 8
  %346 = call double @sin(double %345)
  %347 = fmul double %344, %346
  %348 = load double* %ae2, align 8
  %349 = call double @cos(double %348)
  %350 = call double @atan2(double %347, double %349)
  %351 = fmul double 2.000000e+00, %350
  store double %351, double* %at, align 8
  %352 = load double* %da, align 8
  %353 = load double* %de, align 8
  %354 = load double* %ae, align 8
  %355 = call double @cos(double %354)
  %356 = fmul double %353, %355
  %357 = fsub double 1.000000e+00, %356
  %358 = fmul double %352, %357
  store double %358, double* %r, align 8
  %359 = load i32* %2, align 4
  %360 = sext i32 %359 to i64
  %361 = getelementptr inbounds [8 x double]* @amas, i32 0, i64 %360
  %362 = load double* %361
  %363 = fdiv double 1.000000e+00, %362
  %364 = fadd double 1.000000e+00, %363
  %365 = load double* %da, align 8
  %366 = load double* %da, align 8
  %367 = fmul double %365, %366
  %368 = load double* %da, align 8
  %369 = fmul double %367, %368
  %370 = fdiv double %364, %369
  %371 = call double @sqrt(double %370)
  %372 = fmul double 0x3F919D6D51A6B69A, %371
  store double %372, double* %v, align 8
  %373 = load double* %di, align 8
  %374 = fdiv double %373, 2.000000e+00
  %375 = call double @sin(double %374)
  store double %375, double* %si2, align 8
  %376 = load double* %si2, align 8
  %377 = load double* %doh, align 8
  %378 = call double @cos(double %377)
  %379 = fmul double %376, %378
  store double %379, double* %xq, align 8
  %380 = load double* %si2, align 8
  %381 = load double* %doh, align 8
  %382 = call double @sin(double %381)
  %383 = fmul double %380, %382
  store double %383, double* %xp, align 8
  %384 = load double* %at, align 8
  %385 = load double* %dp, align 8
  %386 = fadd double %384, %385
  store double %386, double* %tl, align 8
  %387 = load double* %tl, align 8
  %388 = call double @sin(double %387)
  store double %388, double* %xsw, align 8
  %389 = load double* %tl, align 8
  %390 = call double @cos(double %389)
  store double %390, double* %xcw, align 8
  %391 = load double* %xp, align 8
  %392 = load double* %xcw, align 8
  %393 = fmul double %391, %392
  %394 = load double* %xq, align 8
  %395 = load double* %xsw, align 8
  %396 = fmul double %394, %395
  %397 = fsub double %393, %396
  %398 = fmul double 2.000000e+00, %397
  store double %398, double* %xm2, align 8
  %399 = load double* %da, align 8
  %400 = load double* %de, align 8
  %401 = load double* %de, align 8
  %402 = fmul double %400, %401
  %403 = fsub double 1.000000e+00, %402
  %404 = call double @sqrt(double %403)
  %405 = fdiv double %399, %404
  store double %405, double* %xf, align 8
  %406 = load double* %di, align 8
  %407 = fdiv double %406, 2.000000e+00
  %408 = call double @cos(double %407)
  store double %408, double* %ci2, align 8
  %409 = load double* %de, align 8
  %410 = load double* %dp, align 8
  %411 = call double @sin(double %410)
  %412 = fmul double %409, %411
  %413 = load double* %xsw, align 8
  %414 = fadd double %412, %413
  %415 = load double* %xf, align 8
  %416 = fmul double %414, %415
  store double %416, double* %xms, align 8
  %417 = load double* %de, align 8
  %418 = load double* %dp, align 8
  %419 = call double @cos(double %418)
  %420 = fmul double %417, %419
  %421 = load double* %xcw, align 8
  %422 = fadd double %420, %421
  %423 = load double* %xf, align 8
  %424 = fmul double %422, %423
  store double %424, double* %xmc, align 8
  %425 = load double* %xp, align 8
  %426 = fmul double 2.000000e+00, %425
  %427 = load double* %xq, align 8
  %428 = fmul double %426, %427
  store double %428, double* %xpxq2, align 8
  %429 = load double* %r, align 8
  %430 = load double* %xcw, align 8
  %431 = load double* %xm2, align 8
  %432 = load double* %xp, align 8
  %433 = fmul double %431, %432
  %434 = fsub double %430, %433
  %435 = fmul double %429, %434
  store double %435, double* %x, align 8
  %436 = load double* %r, align 8
  %437 = load double* %xsw, align 8
  %438 = load double* %xm2, align 8
  %439 = load double* %xq, align 8
  %440 = fmul double %438, %439
  %441 = fadd double %437, %440
  %442 = fmul double %436, %441
  store double %442, double* %y, align 8
  %443 = load double* %r, align 8
  %444 = load double* %xm2, align 8
  %445 = fsub double -0.000000e+00, %444
  %446 = load double* %ci2, align 8
  %447 = fmul double %445, %446
  %448 = fmul double %443, %447
  store double %448, double* %z, align 8
  %449 = load double* %x, align 8
  %450 = load [3 x double]** %3, align 8
  %451 = getelementptr inbounds [3 x double]* %450, i64 0
  %452 = getelementptr inbounds [3 x double]* %451, i32 0, i64 0
  store double %449, double* %452
  %453 = load double* %y, align 8
  %454 = fmul double %453, 0x3FED5C0357681EF3
  %455 = load double* %z, align 8
  %456 = fmul double %455, 0x3FD9752E50F4B399
  %457 = fsub double %454, %456
  %458 = load [3 x double]** %3, align 8
  %459 = getelementptr inbounds [3 x double]* %458, i64 0
  %460 = getelementptr inbounds [3 x double]* %459, i32 0, i64 1
  store double %457, double* %460
  %461 = load double* %y, align 8
  %462 = fmul double %461, 0x3FD9752E50F4B399
  %463 = load double* %z, align 8
  %464 = fmul double %463, 0x3FED5C0357681EF3
  %465 = fadd double %462, %464
  %466 = load [3 x double]** %3, align 8
  %467 = getelementptr inbounds [3 x double]* %466, i64 0
  %468 = getelementptr inbounds [3 x double]* %467, i32 0, i64 2
  store double %465, double* %468
  %469 = load double* %v, align 8
  %470 = load double* %xp, align 8
  %471 = fmul double 2.000000e+00, %470
  %472 = load double* %xp, align 8
  %473 = fmul double %471, %472
  %474 = fadd double -1.000000e+00, %473
  %475 = load double* %xms, align 8
  %476 = fmul double %474, %475
  %477 = load double* %xpxq2, align 8
  %478 = load double* %xmc, align 8
  %479 = fmul double %477, %478
  %480 = fadd double %476, %479
  %481 = fmul double %469, %480
  store double %481, double* %x, align 8
  %482 = load double* %v, align 8
  %483 = load double* %xq, align 8
  %484 = fmul double 2.000000e+00, %483
  %485 = load double* %xq, align 8
  %486 = fmul double %484, %485
  %487 = fsub double 1.000000e+00, %486
  %488 = load double* %xmc, align 8
  %489 = fmul double %487, %488
  %490 = load double* %xpxq2, align 8
  %491 = load double* %xms, align 8
  %492 = fmul double %490, %491
  %493 = fsub double %489, %492
  %494 = fmul double %482, %493
  store double %494, double* %y, align 8
  %495 = load double* %v, align 8
  %496 = load double* %ci2, align 8
  %497 = fmul double 2.000000e+00, %496
  %498 = load double* %xp, align 8
  %499 = load double* %xms, align 8
  %500 = fmul double %498, %499
  %501 = load double* %xq, align 8
  %502 = load double* %xmc, align 8
  %503 = fmul double %501, %502
  %504 = fadd double %500, %503
  %505 = fmul double %497, %504
  %506 = fmul double %495, %505
  store double %506, double* %z, align 8
  %507 = load double* %x, align 8
  %508 = load [3 x double]** %3, align 8
  %509 = getelementptr inbounds [3 x double]* %508, i64 1
  %510 = getelementptr inbounds [3 x double]* %509, i32 0, i64 0
  store double %507, double* %510
  %511 = load double* %y, align 8
  %512 = fmul double %511, 0x3FED5C0357681EF3
  %513 = load double* %z, align 8
  %514 = fmul double %513, 0x3FD9752E50F4B399
  %515 = fsub double %512, %514
  %516 = load [3 x double]** %3, align 8
  %517 = getelementptr inbounds [3 x double]* %516, i64 1
  %518 = getelementptr inbounds [3 x double]* %517, i32 0, i64 1
  store double %515, double* %518
  %519 = load double* %y, align 8
  %520 = fmul double %519, 0x3FD9752E50F4B399
  %521 = load double* %z, align 8
  %522 = fmul double %521, 0x3FED5C0357681EF3
  %523 = fadd double %520, %522
  %524 = load [3 x double]** %3, align 8
  %525 = getelementptr inbounds [3 x double]* %524, i64 1
  %526 = getelementptr inbounds [3 x double]* %525, i32 0, i64 2
  store double %523, double* %526
  ret void
}

declare double @cos(double) readnone

declare double @sin(double) readnone

declare double @atan2(double, double)

declare double @sqrt(double) readnone

define void @radecdist([3 x double]* %state, double* %rdd) nounwind ssp {
  %1 = alloca [3 x double]*, align 8
  %2 = alloca double*, align 8
  store [3 x double]* %state, [3 x double]** %1, align 8
  store double* %rdd, double** %2, align 8
  %3 = load [3 x double]** %1, align 8
  %4 = getelementptr inbounds [3 x double]* %3, i64 0
  %5 = getelementptr inbounds [3 x double]* %4, i32 0, i64 0
  %6 = load double* %5
  %7 = load [3 x double]** %1, align 8
  %8 = getelementptr inbounds [3 x double]* %7, i64 0
  %9 = getelementptr inbounds [3 x double]* %8, i32 0, i64 0
  %10 = load double* %9
  %11 = fmul double %6, %10
  %12 = load [3 x double]** %1, align 8
  %13 = getelementptr inbounds [3 x double]* %12, i64 0
  %14 = getelementptr inbounds [3 x double]* %13, i32 0, i64 1
  %15 = load double* %14
  %16 = load [3 x double]** %1, align 8
  %17 = getelementptr inbounds [3 x double]* %16, i64 0
  %18 = getelementptr inbounds [3 x double]* %17, i32 0, i64 1
  %19 = load double* %18
  %20 = fmul double %15, %19
  %21 = fadd double %11, %20
  %22 = load [3 x double]** %1, align 8
  %23 = getelementptr inbounds [3 x double]* %22, i64 0
  %24 = getelementptr inbounds [3 x double]* %23, i32 0, i64 2
  %25 = load double* %24
  %26 = load [3 x double]** %1, align 8
  %27 = getelementptr inbounds [3 x double]* %26, i64 0
  %28 = getelementptr inbounds [3 x double]* %27, i32 0, i64 2
  %29 = load double* %28
  %30 = fmul double %25, %29
  %31 = fadd double %21, %30
  %32 = call double @sqrt(double %31)
  %33 = load double** %2, align 8
  %34 = getelementptr inbounds double* %33, i64 2
  store double %32, double* %34
  %35 = load [3 x double]** %1, align 8
  %36 = getelementptr inbounds [3 x double]* %35, i64 0
  %37 = getelementptr inbounds [3 x double]* %36, i32 0, i64 1
  %38 = load double* %37
  %39 = load [3 x double]** %1, align 8
  %40 = getelementptr inbounds [3 x double]* %39, i64 0
  %41 = getelementptr inbounds [3 x double]* %40, i32 0, i64 0
  %42 = load double* %41
  %43 = call double @atan2(double %38, double %42)
  %44 = fmul double %43, 0x400E8EC8A4AEACC4
  %45 = load double** %2, align 8
  %46 = getelementptr inbounds double* %45, i64 0
  store double %44, double* %46
  %47 = load double** %2, align 8
  %48 = getelementptr inbounds double* %47, i64 0
  %49 = load double* %48
  %50 = fcmp olt double %49, 0.000000e+00
  br i1 %50, label %51, label %56

; <label>:51                                      ; preds = %0
  %52 = load double** %2, align 8
  %53 = getelementptr inbounds double* %52, i64 0
  %54 = load double* %53
  %55 = fadd double %54, 2.400000e+01
  store double %55, double* %53
  br label %56

; <label>:56                                      ; preds = %51, %0
  %57 = load [3 x double]** %1, align 8
  %58 = getelementptr inbounds [3 x double]* %57, i64 0
  %59 = getelementptr inbounds [3 x double]* %58, i32 0, i64 2
  %60 = load double* %59
  %61 = load double** %2, align 8
  %62 = getelementptr inbounds double* %61, i64 2
  %63 = load double* %62
  %64 = fdiv double %60, %63
  %65 = call double @asin(double %64)
  %66 = fmul double %65, 0x404CA5DC1A63C1F8
  %67 = load double** %2, align 8
  %68 = getelementptr inbounds double* %67, i64 1
  store double %66, double* %68
  ret void
}

declare double @asin(double)

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i8**, align 8
  store i32 0, i32* %1
  store i32 %argc, i32* %2, align 4
  store i8** %argv, i8*** %3, align 8
  call void @test()
  call void @bench(i32 1)
  ret i32 0
}

define internal void @test() nounwind ssp {
  %p = alloca i32, align 4
  %jd = alloca [2 x double], align 16
  %pv = alloca [2 x [3 x double]], align 16
  %position = alloca [3 x double], align 16
  %1 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 0
  store double 2.451545e+06, double* %1
  %2 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 1
  store double 0.000000e+00, double* %2
  store i32 0, i32* %p, align 4
  br label %3

; <label>:3                                       ; preds = %18, %0
  %4 = load i32* %p, align 4
  %5 = icmp slt i32 %4, 8
  br i1 %5, label %6, label %21

; <label>:6                                       ; preds = %3
  %7 = getelementptr inbounds [2 x double]* %jd, i32 0, i32 0
  %8 = load i32* %p, align 4
  %9 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  call void @planetpv(double* %7, i32 %8, [3 x double]* %9)
  %10 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  %11 = getelementptr inbounds [3 x double]* %position, i32 0, i32 0
  call void @radecdist([3 x double]* %10, double* %11)
  %12 = load i32* %p, align 4
  %13 = getelementptr inbounds [3 x double]* %position, i32 0, i64 0
  %14 = load double* %13
  %15 = getelementptr inbounds [3 x double]* %position, i32 0, i64 1
  %16 = load double* %15
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str, i32 0, i32 0), i32 %12, double %14, double %16)
  br label %18

; <label>:18                                      ; preds = %6
  %19 = load i32* %p, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, i32* %p, align 4
  br label %3

; <label>:21                                      ; preds = %3
  ret void
}

define internal void @bench(i32 %nloops) nounwind ssp {
  %1 = alloca i32, align 4
  %i = alloca i32, align 4
  %n = alloca i32, align 4
  %p = alloca i32, align 4
  %jd = alloca [2 x double], align 16
  %pv = alloca [2 x [3 x double]], align 16
  %position = alloca [3 x double], align 16
  store i32 %nloops, i32* %1, align 4
  store i32 0, i32* %i, align 4
  br label %2

; <label>:2                                       ; preds = %33, %0
  %3 = load i32* %i, align 4
  %4 = load i32* %1, align 4
  %5 = icmp slt i32 %3, %4
  br i1 %5, label %6, label %36

; <label>:6                                       ; preds = %2
  %7 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 0
  store double 2.451545e+06, double* %7
  %8 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 1
  store double 0.000000e+00, double* %8
  store i32 0, i32* %n, align 4
  br label %9

; <label>:9                                       ; preds = %29, %6
  %10 = load i32* %n, align 4
  %11 = icmp slt i32 %10, 36525
  br i1 %11, label %12, label %32

; <label>:12                                      ; preds = %9
  %13 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 0
  %14 = load double* %13
  %15 = fadd double %14, 1.000000e+00
  store double %15, double* %13
  store i32 0, i32* %p, align 4
  br label %16

; <label>:16                                      ; preds = %25, %12
  %17 = load i32* %p, align 4
  %18 = icmp slt i32 %17, 8
  br i1 %18, label %19, label %28

; <label>:19                                      ; preds = %16
  %20 = getelementptr inbounds [2 x double]* %jd, i32 0, i32 0
  %21 = load i32* %p, align 4
  %22 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  call void @planetpv(double* %20, i32 %21, [3 x double]* %22)
  %23 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  %24 = getelementptr inbounds [3 x double]* %position, i32 0, i32 0
  call void @radecdist([3 x double]* %23, double* %24)
  br label %25

; <label>:25                                      ; preds = %19
  %26 = load i32* %p, align 4
  %27 = add nsw i32 %26, 1
  store i32 %27, i32* %p, align 4
  br label %16

; <label>:28                                      ; preds = %16
  br label %29

; <label>:29                                      ; preds = %28
  %30 = load i32* %n, align 4
  %31 = add nsw i32 %30, 1
  store i32 %31, i32* %n, align 4
  br label %9

; <label>:32                                      ; preds = %9
  br label %33

; <label>:33                                      ; preds = %32
  %34 = load i32* %i, align 4
  %35 = add nsw i32 %34, 1
  store i32 %35, i32* %i, align 4
  br label %2

; <label>:36                                      ; preds = %2
  ret void
}

declare i32 @printf(i8*, ...)
