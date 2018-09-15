; ModuleID = 'almabench.c.m2r.o'
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
; <label>:0
  %1 = call double @fmod(double %a, double 0x401921FB54442D18)
  %2 = call double @fabs(double %1)
  %3 = fcmp oge double %2, 0x400921FB54442D18
  br i1 %3, label %4, label %11

; <label>:4                                       ; preds = %0
  %5 = fcmp olt double %a, 0.000000e+00
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %4
  br label %8

; <label>:7                                       ; preds = %4
  br label %8

; <label>:8                                       ; preds = %7, %6
  %9 = phi double [ 0xC01921FB54442D18, %6 ], [ 0x401921FB54442D18, %7 ]
  %10 = fsub double %1, %9
  br label %11

; <label>:11                                      ; preds = %8, %0
  %w.0 = phi double [ %10, %8 ], [ %1, %0 ]
  ret double %w.0
}

declare double @fmod(double, double)

declare double @fabs(double)

define void @planetpv(double* %epoch, i32 %np, [3 x double]* %pv) nounwind ssp {
; <label>:0
  %1 = getelementptr inbounds double* %epoch, i64 0
  %2 = load double* %1
  %3 = fsub double %2, 2.451545e+06
  %4 = getelementptr inbounds double* %epoch, i64 1
  %5 = load double* %4
  %6 = fadd double %3, %5
  %7 = fdiv double %6, 3.652500e+05
  %8 = sext i32 %np to i64
  %9 = getelementptr inbounds [8 x [3 x double]]* @a, i32 0, i64 %8
  %10 = getelementptr inbounds [3 x double]* %9, i32 0, i64 0
  %11 = load double* %10
  %12 = sext i32 %np to i64
  %13 = getelementptr inbounds [8 x [3 x double]]* @a, i32 0, i64 %12
  %14 = getelementptr inbounds [3 x double]* %13, i32 0, i64 1
  %15 = load double* %14
  %16 = sext i32 %np to i64
  %17 = getelementptr inbounds [8 x [3 x double]]* @a, i32 0, i64 %16
  %18 = getelementptr inbounds [3 x double]* %17, i32 0, i64 2
  %19 = load double* %18
  %20 = fmul double %19, %7
  %21 = fadd double %15, %20
  %22 = fmul double %21, %7
  %23 = fadd double %11, %22
  %24 = sext i32 %np to i64
  %25 = getelementptr inbounds [8 x [3 x double]]* @dlm, i32 0, i64 %24
  %26 = getelementptr inbounds [3 x double]* %25, i32 0, i64 0
  %27 = load double* %26
  %28 = fmul double 3.600000e+03, %27
  %29 = sext i32 %np to i64
  %30 = getelementptr inbounds [8 x [3 x double]]* @dlm, i32 0, i64 %29
  %31 = getelementptr inbounds [3 x double]* %30, i32 0, i64 1
  %32 = load double* %31
  %33 = sext i32 %np to i64
  %34 = getelementptr inbounds [8 x [3 x double]]* @dlm, i32 0, i64 %33
  %35 = getelementptr inbounds [3 x double]* %34, i32 0, i64 2
  %36 = load double* %35
  %37 = fmul double %36, %7
  %38 = fadd double %32, %37
  %39 = fmul double %38, %7
  %40 = fadd double %28, %39
  %41 = fmul double %40, 0x3ED455A5B2FF8F9D
  %42 = sext i32 %np to i64
  %43 = getelementptr inbounds [8 x [3 x double]]* @e, i32 0, i64 %42
  %44 = getelementptr inbounds [3 x double]* %43, i32 0, i64 0
  %45 = load double* %44
  %46 = sext i32 %np to i64
  %47 = getelementptr inbounds [8 x [3 x double]]* @e, i32 0, i64 %46
  %48 = getelementptr inbounds [3 x double]* %47, i32 0, i64 1
  %49 = load double* %48
  %50 = sext i32 %np to i64
  %51 = getelementptr inbounds [8 x [3 x double]]* @e, i32 0, i64 %50
  %52 = getelementptr inbounds [3 x double]* %51, i32 0, i64 2
  %53 = load double* %52
  %54 = fmul double %53, %7
  %55 = fadd double %49, %54
  %56 = fmul double %55, %7
  %57 = fadd double %45, %56
  %58 = sext i32 %np to i64
  %59 = getelementptr inbounds [8 x [3 x double]]* @pi, i32 0, i64 %58
  %60 = getelementptr inbounds [3 x double]* %59, i32 0, i64 0
  %61 = load double* %60
  %62 = fmul double 3.600000e+03, %61
  %63 = sext i32 %np to i64
  %64 = getelementptr inbounds [8 x [3 x double]]* @pi, i32 0, i64 %63
  %65 = getelementptr inbounds [3 x double]* %64, i32 0, i64 1
  %66 = load double* %65
  %67 = sext i32 %np to i64
  %68 = getelementptr inbounds [8 x [3 x double]]* @pi, i32 0, i64 %67
  %69 = getelementptr inbounds [3 x double]* %68, i32 0, i64 2
  %70 = load double* %69
  %71 = fmul double %70, %7
  %72 = fadd double %66, %71
  %73 = fmul double %72, %7
  %74 = fadd double %62, %73
  %75 = fmul double %74, 0x3ED455A5B2FF8F9D
  %76 = call double @anpm(double %75)
  %77 = sext i32 %np to i64
  %78 = getelementptr inbounds [8 x [3 x double]]* @dinc, i32 0, i64 %77
  %79 = getelementptr inbounds [3 x double]* %78, i32 0, i64 0
  %80 = load double* %79
  %81 = fmul double 3.600000e+03, %80
  %82 = sext i32 %np to i64
  %83 = getelementptr inbounds [8 x [3 x double]]* @dinc, i32 0, i64 %82
  %84 = getelementptr inbounds [3 x double]* %83, i32 0, i64 1
  %85 = load double* %84
  %86 = sext i32 %np to i64
  %87 = getelementptr inbounds [8 x [3 x double]]* @dinc, i32 0, i64 %86
  %88 = getelementptr inbounds [3 x double]* %87, i32 0, i64 2
  %89 = load double* %88
  %90 = fmul double %89, %7
  %91 = fadd double %85, %90
  %92 = fmul double %91, %7
  %93 = fadd double %81, %92
  %94 = fmul double %93, 0x3ED455A5B2FF8F9D
  %95 = sext i32 %np to i64
  %96 = getelementptr inbounds [8 x [3 x double]]* @omega, i32 0, i64 %95
  %97 = getelementptr inbounds [3 x double]* %96, i32 0, i64 0
  %98 = load double* %97
  %99 = fmul double 3.600000e+03, %98
  %100 = sext i32 %np to i64
  %101 = getelementptr inbounds [8 x [3 x double]]* @omega, i32 0, i64 %100
  %102 = getelementptr inbounds [3 x double]* %101, i32 0, i64 1
  %103 = load double* %102
  %104 = sext i32 %np to i64
  %105 = getelementptr inbounds [8 x [3 x double]]* @omega, i32 0, i64 %104
  %106 = getelementptr inbounds [3 x double]* %105, i32 0, i64 2
  %107 = load double* %106
  %108 = fmul double %107, %7
  %109 = fadd double %103, %108
  %110 = fmul double %109, %7
  %111 = fadd double %99, %110
  %112 = fmul double %111, 0x3ED455A5B2FF8F9D
  %113 = call double @anpm(double %112)
  %114 = fmul double 3.595362e-01, %7
  br label %115

; <label>:115                                     ; preds = %164, %0
  %da.0 = phi double [ %23, %0 ], [ %146, %164 ]
  %dl.0 = phi double [ %41, %0 ], [ %163, %164 ]
  %k.0 = phi i32 [ 0, %0 ], [ %165, %164 ]
  %116 = icmp slt i32 %k.0, 8
  br i1 %116, label %117, label %166

; <label>:117                                     ; preds = %115
  %118 = sext i32 %k.0 to i64
  %119 = sext i32 %np to i64
  %120 = getelementptr inbounds [8 x [9 x double]]* @kp, i32 0, i64 %119
  %121 = getelementptr inbounds [9 x double]* %120, i32 0, i64 %118
  %122 = load double* %121
  %123 = fmul double %122, %114
  %124 = sext i32 %k.0 to i64
  %125 = sext i32 %np to i64
  %126 = getelementptr inbounds [8 x [10 x double]]* @kq, i32 0, i64 %125
  %127 = getelementptr inbounds [10 x double]* %126, i32 0, i64 %124
  %128 = load double* %127
  %129 = fmul double %128, %114
  %130 = sext i32 %k.0 to i64
  %131 = sext i32 %np to i64
  %132 = getelementptr inbounds [8 x [9 x double]]* @ca, i32 0, i64 %131
  %133 = getelementptr inbounds [9 x double]* %132, i32 0, i64 %130
  %134 = load double* %133
  %135 = call double @cos(double %123)
  %136 = fmul double %134, %135
  %137 = sext i32 %k.0 to i64
  %138 = sext i32 %np to i64
  %139 = getelementptr inbounds [8 x [9 x double]]* @sa, i32 0, i64 %138
  %140 = getelementptr inbounds [9 x double]* %139, i32 0, i64 %137
  %141 = load double* %140
  %142 = call double @sin(double %123)
  %143 = fmul double %141, %142
  %144 = fadd double %136, %143
  %145 = fmul double %144, 1.000000e-07
  %146 = fadd double %da.0, %145
  %147 = sext i32 %k.0 to i64
  %148 = sext i32 %np to i64
  %149 = getelementptr inbounds [8 x [10 x double]]* @cl, i32 0, i64 %148
  %150 = getelementptr inbounds [10 x double]* %149, i32 0, i64 %147
  %151 = load double* %150
  %152 = call double @cos(double %129)
  %153 = fmul double %151, %152
  %154 = sext i32 %k.0 to i64
  %155 = sext i32 %np to i64
  %156 = getelementptr inbounds [8 x [10 x double]]* @sl, i32 0, i64 %155
  %157 = getelementptr inbounds [10 x double]* %156, i32 0, i64 %154
  %158 = load double* %157
  %159 = call double @sin(double %129)
  %160 = fmul double %158, %159
  %161 = fadd double %153, %160
  %162 = fmul double %161, 1.000000e-07
  %163 = fadd double %dl.0, %162
  br label %164

; <label>:164                                     ; preds = %117
  %165 = add nsw i32 %k.0, 1
  br label %115

; <label>:166                                     ; preds = %115
  %167 = sext i32 %np to i64
  %168 = getelementptr inbounds [8 x [9 x double]]* @kp, i32 0, i64 %167
  %169 = getelementptr inbounds [9 x double]* %168, i32 0, i64 8
  %170 = load double* %169
  %171 = fmul double %170, %114
  %172 = sext i32 %np to i64
  %173 = getelementptr inbounds [8 x [9 x double]]* @ca, i32 0, i64 %172
  %174 = getelementptr inbounds [9 x double]* %173, i32 0, i64 8
  %175 = load double* %174
  %176 = call double @cos(double %171)
  %177 = fmul double %175, %176
  %178 = sext i32 %np to i64
  %179 = getelementptr inbounds [8 x [9 x double]]* @sa, i32 0, i64 %178
  %180 = getelementptr inbounds [9 x double]* %179, i32 0, i64 8
  %181 = load double* %180
  %182 = call double @sin(double %171)
  %183 = fmul double %181, %182
  %184 = fadd double %177, %183
  %185 = fmul double %7, %184
  %186 = fmul double %185, 1.000000e-07
  %187 = fadd double %da.0, %186
  br label %188

; <label>:188                                     ; preds = %215, %166
  %dl.1 = phi double [ %dl.0, %166 ], [ %214, %215 ]
  %k.1 = phi i32 [ 8, %166 ], [ %216, %215 ]
  %189 = icmp sle i32 %k.1, 9
  br i1 %189, label %190, label %217

; <label>:190                                     ; preds = %188
  %191 = sext i32 %k.1 to i64
  %192 = sext i32 %np to i64
  %193 = getelementptr inbounds [8 x [10 x double]]* @kq, i32 0, i64 %192
  %194 = getelementptr inbounds [10 x double]* %193, i32 0, i64 %191
  %195 = load double* %194
  %196 = fmul double %195, %114
  %197 = sext i32 %k.1 to i64
  %198 = sext i32 %np to i64
  %199 = getelementptr inbounds [8 x [10 x double]]* @cl, i32 0, i64 %198
  %200 = getelementptr inbounds [10 x double]* %199, i32 0, i64 %197
  %201 = load double* %200
  %202 = call double @cos(double %196)
  %203 = fmul double %201, %202
  %204 = sext i32 %k.1 to i64
  %205 = sext i32 %np to i64
  %206 = getelementptr inbounds [8 x [10 x double]]* @sl, i32 0, i64 %205
  %207 = getelementptr inbounds [10 x double]* %206, i32 0, i64 %204
  %208 = load double* %207
  %209 = call double @sin(double %196)
  %210 = fmul double %208, %209
  %211 = fadd double %203, %210
  %212 = fmul double %7, %211
  %213 = fmul double %212, 1.000000e-07
  %214 = fadd double %dl.1, %213
  br label %215

; <label>:215                                     ; preds = %190
  %216 = add nsw i32 %k.1, 1
  br label %188

; <label>:217                                     ; preds = %188
  %218 = call double @fmod(double %dl.1, double 0x401921FB54442D18)
  %219 = fsub double %218, %76
  %220 = call double @sin(double %219)
  %221 = fmul double %57, %220
  %222 = fadd double %219, %221
  br label %223

; <label>:223                                     ; preds = %239, %217
  %k.2 = phi i32 [ 0, %217 ], [ %233, %239 ]
  %ae.0 = phi double [ %222, %217 ], [ %232, %239 ]
  %224 = fsub double %219, %ae.0
  %225 = call double @sin(double %ae.0)
  %226 = fmul double %57, %225
  %227 = fadd double %224, %226
  %228 = call double @cos(double %ae.0)
  %229 = fmul double %57, %228
  %230 = fsub double 1.000000e+00, %229
  %231 = fdiv double %227, %230
  %232 = fadd double %ae.0, %231
  %233 = add nsw i32 %k.2, 1
  %234 = icmp sge i32 %233, 10
  br i1 %234, label %238, label %235

; <label>:235                                     ; preds = %223
  %236 = call double @fabs(double %231)
  %237 = fcmp olt double %236, 1.000000e-12
  br i1 %237, label %238, label %239

; <label>:238                                     ; preds = %235, %223
  br label %240

; <label>:239                                     ; preds = %235
  br label %223

; <label>:240                                     ; preds = %238
  %241 = fdiv double %232, 2.000000e+00
  %242 = fadd double 1.000000e+00, %57
  %243 = fsub double 1.000000e+00, %57
  %244 = fdiv double %242, %243
  %245 = call double @sqrt(double %244)
  %246 = call double @sin(double %241)
  %247 = fmul double %245, %246
  %248 = call double @cos(double %241)
  %249 = call double @atan2(double %247, double %248)
  %250 = fmul double 2.000000e+00, %249
  %251 = call double @cos(double %232)
  %252 = fmul double %57, %251
  %253 = fsub double 1.000000e+00, %252
  %254 = fmul double %187, %253
  %255 = sext i32 %np to i64
  %256 = getelementptr inbounds [8 x double]* @amas, i32 0, i64 %255
  %257 = load double* %256
  %258 = fdiv double 1.000000e+00, %257
  %259 = fadd double 1.000000e+00, %258
  %260 = fmul double %187, %187
  %261 = fmul double %260, %187
  %262 = fdiv double %259, %261
  %263 = call double @sqrt(double %262)
  %264 = fmul double 0x3F919D6D51A6B69A, %263
  %265 = fdiv double %94, 2.000000e+00
  %266 = call double @sin(double %265)
  %267 = call double @cos(double %113)
  %268 = fmul double %266, %267
  %269 = call double @sin(double %113)
  %270 = fmul double %266, %269
  %271 = fadd double %250, %76
  %272 = call double @sin(double %271)
  %273 = call double @cos(double %271)
  %274 = fmul double %270, %273
  %275 = fmul double %268, %272
  %276 = fsub double %274, %275
  %277 = fmul double 2.000000e+00, %276
  %278 = fmul double %57, %57
  %279 = fsub double 1.000000e+00, %278
  %280 = call double @sqrt(double %279)
  %281 = fdiv double %187, %280
  %282 = fdiv double %94, 2.000000e+00
  %283 = call double @cos(double %282)
  %284 = call double @sin(double %76)
  %285 = fmul double %57, %284
  %286 = fadd double %285, %272
  %287 = fmul double %286, %281
  %288 = call double @cos(double %76)
  %289 = fmul double %57, %288
  %290 = fadd double %289, %273
  %291 = fmul double %290, %281
  %292 = fmul double 2.000000e+00, %270
  %293 = fmul double %292, %268
  %294 = fmul double %277, %270
  %295 = fsub double %273, %294
  %296 = fmul double %254, %295
  %297 = fmul double %277, %268
  %298 = fadd double %272, %297
  %299 = fmul double %254, %298
  %300 = fsub double -0.000000e+00, %277
  %301 = fmul double %300, %283
  %302 = fmul double %254, %301
  %303 = getelementptr inbounds [3 x double]* %pv, i64 0
  %304 = getelementptr inbounds [3 x double]* %303, i32 0, i64 0
  store double %296, double* %304
  %305 = fmul double %299, 0x3FED5C0357681EF3
  %306 = fmul double %302, 0x3FD9752E50F4B399
  %307 = fsub double %305, %306
  %308 = getelementptr inbounds [3 x double]* %pv, i64 0
  %309 = getelementptr inbounds [3 x double]* %308, i32 0, i64 1
  store double %307, double* %309
  %310 = fmul double %299, 0x3FD9752E50F4B399
  %311 = fmul double %302, 0x3FED5C0357681EF3
  %312 = fadd double %310, %311
  %313 = getelementptr inbounds [3 x double]* %pv, i64 0
  %314 = getelementptr inbounds [3 x double]* %313, i32 0, i64 2
  store double %312, double* %314
  %315 = fmul double 2.000000e+00, %270
  %316 = fmul double %315, %270
  %317 = fadd double -1.000000e+00, %316
  %318 = fmul double %317, %287
  %319 = fmul double %293, %291
  %320 = fadd double %318, %319
  %321 = fmul double %264, %320
  %322 = fmul double 2.000000e+00, %268
  %323 = fmul double %322, %268
  %324 = fsub double 1.000000e+00, %323
  %325 = fmul double %324, %291
  %326 = fmul double %293, %287
  %327 = fsub double %325, %326
  %328 = fmul double %264, %327
  %329 = fmul double 2.000000e+00, %283
  %330 = fmul double %270, %287
  %331 = fmul double %268, %291
  %332 = fadd double %330, %331
  %333 = fmul double %329, %332
  %334 = fmul double %264, %333
  %335 = getelementptr inbounds [3 x double]* %pv, i64 1
  %336 = getelementptr inbounds [3 x double]* %335, i32 0, i64 0
  store double %321, double* %336
  %337 = fmul double %328, 0x3FED5C0357681EF3
  %338 = fmul double %334, 0x3FD9752E50F4B399
  %339 = fsub double %337, %338
  %340 = getelementptr inbounds [3 x double]* %pv, i64 1
  %341 = getelementptr inbounds [3 x double]* %340, i32 0, i64 1
  store double %339, double* %341
  %342 = fmul double %328, 0x3FD9752E50F4B399
  %343 = fmul double %334, 0x3FED5C0357681EF3
  %344 = fadd double %342, %343
  %345 = getelementptr inbounds [3 x double]* %pv, i64 1
  %346 = getelementptr inbounds [3 x double]* %345, i32 0, i64 2
  store double %344, double* %346
  ret void
}

declare double @cos(double) readnone

declare double @sin(double) readnone

declare double @atan2(double, double)

declare double @sqrt(double) readnone

define void @radecdist([3 x double]* %state, double* %rdd) nounwind ssp {
  %1 = getelementptr inbounds [3 x double]* %state, i64 0
  %2 = getelementptr inbounds [3 x double]* %1, i32 0, i64 0
  %3 = load double* %2
  %4 = getelementptr inbounds [3 x double]* %state, i64 0
  %5 = getelementptr inbounds [3 x double]* %4, i32 0, i64 0
  %6 = load double* %5
  %7 = fmul double %3, %6
  %8 = getelementptr inbounds [3 x double]* %state, i64 0
  %9 = getelementptr inbounds [3 x double]* %8, i32 0, i64 1
  %10 = load double* %9
  %11 = getelementptr inbounds [3 x double]* %state, i64 0
  %12 = getelementptr inbounds [3 x double]* %11, i32 0, i64 1
  %13 = load double* %12
  %14 = fmul double %10, %13
  %15 = fadd double %7, %14
  %16 = getelementptr inbounds [3 x double]* %state, i64 0
  %17 = getelementptr inbounds [3 x double]* %16, i32 0, i64 2
  %18 = load double* %17
  %19 = getelementptr inbounds [3 x double]* %state, i64 0
  %20 = getelementptr inbounds [3 x double]* %19, i32 0, i64 2
  %21 = load double* %20
  %22 = fmul double %18, %21
  %23 = fadd double %15, %22
  %24 = call double @sqrt(double %23)
  %25 = getelementptr inbounds double* %rdd, i64 2
  store double %24, double* %25
  %26 = getelementptr inbounds [3 x double]* %state, i64 0
  %27 = getelementptr inbounds [3 x double]* %26, i32 0, i64 1
  %28 = load double* %27
  %29 = getelementptr inbounds [3 x double]* %state, i64 0
  %30 = getelementptr inbounds [3 x double]* %29, i32 0, i64 0
  %31 = load double* %30
  %32 = call double @atan2(double %28, double %31)
  %33 = fmul double %32, 0x400E8EC8A4AEACC4
  %34 = getelementptr inbounds double* %rdd, i64 0
  store double %33, double* %34
  %35 = getelementptr inbounds double* %rdd, i64 0
  %36 = load double* %35
  %37 = fcmp olt double %36, 0.000000e+00
  br i1 %37, label %38, label %42

; <label>:38                                      ; preds = %0
  %39 = getelementptr inbounds double* %rdd, i64 0
  %40 = load double* %39
  %41 = fadd double %40, 2.400000e+01
  store double %41, double* %39
  br label %42

; <label>:42                                      ; preds = %38, %0
  %43 = getelementptr inbounds [3 x double]* %state, i64 0
  %44 = getelementptr inbounds [3 x double]* %43, i32 0, i64 2
  %45 = load double* %44
  %46 = getelementptr inbounds double* %rdd, i64 2
  %47 = load double* %46
  %48 = fdiv double %45, %47
  %49 = call double @asin(double %48)
  %50 = fmul double %49, 0x404CA5DC1A63C1F8
  %51 = getelementptr inbounds double* %rdd, i64 1
  store double %50, double* %51
  ret void
}

declare double @asin(double)

define i32 @main(i32 %argc, i8** %argv) nounwind ssp {
  call void @test()
  call void @bench(i32 1)
  ret i32 0
}

define internal void @test() nounwind ssp {
; <label>:0
  %jd = alloca [2 x double], align 16
  %pv = alloca [2 x [3 x double]], align 16
  %position = alloca [3 x double], align 16
  %1 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 0
  store double 2.451545e+06, double* %1
  %2 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 1
  store double 0.000000e+00, double* %2
  br label %3

; <label>:3                                       ; preds = %15, %0
  %p.0 = phi i32 [ 0, %0 ], [ %16, %15 ]
  %4 = icmp slt i32 %p.0, 8
  br i1 %4, label %5, label %17

; <label>:5                                       ; preds = %3
  %6 = getelementptr inbounds [2 x double]* %jd, i32 0, i32 0
  %7 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  call void @planetpv(double* %6, i32 %p.0, [3 x double]* %7)
  %8 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  %9 = getelementptr inbounds [3 x double]* %position, i32 0, i32 0
  call void @radecdist([3 x double]* %8, double* %9)
  %10 = getelementptr inbounds [3 x double]* %position, i32 0, i64 0
  %11 = load double* %10
  %12 = getelementptr inbounds [3 x double]* %position, i32 0, i64 1
  %13 = load double* %12
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str, i32 0, i32 0), i32 %p.0, double %11, double %13)
  br label %15

; <label>:15                                      ; preds = %5
  %16 = add nsw i32 %p.0, 1
  br label %3

; <label>:17                                      ; preds = %3
  ret void
}

define internal void @bench(i32 %nloops) nounwind ssp {
; <label>:0
  %jd = alloca [2 x double], align 16
  %pv = alloca [2 x [3 x double]], align 16
  %position = alloca [3 x double], align 16
  br label %1

; <label>:1                                       ; preds = %25, %0
  %i.0 = phi i32 [ 0, %0 ], [ %26, %25 ]
  %2 = icmp slt i32 %i.0, %nloops
  br i1 %2, label %3, label %27

; <label>:3                                       ; preds = %1
  %4 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 0
  store double 2.451545e+06, double* %4
  %5 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 1
  store double 0.000000e+00, double* %5
  br label %6

; <label>:6                                       ; preds = %22, %3
  %n.0 = phi i32 [ 0, %3 ], [ %23, %22 ]
  %7 = icmp slt i32 %n.0, 36525
  br i1 %7, label %8, label %24

; <label>:8                                       ; preds = %6
  %9 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 0
  %10 = load double* %9
  %11 = fadd double %10, 1.000000e+00
  store double %11, double* %9
  br label %12

; <label>:12                                      ; preds = %19, %8
  %p.0 = phi i32 [ 0, %8 ], [ %20, %19 ]
  %13 = icmp slt i32 %p.0, 8
  br i1 %13, label %14, label %21

; <label>:14                                      ; preds = %12
  %15 = getelementptr inbounds [2 x double]* %jd, i32 0, i32 0
  %16 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  call void @planetpv(double* %15, i32 %p.0, [3 x double]* %16)
  %17 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  %18 = getelementptr inbounds [3 x double]* %position, i32 0, i32 0
  call void @radecdist([3 x double]* %17, double* %18)
  br label %19

; <label>:19                                      ; preds = %14
  %20 = add nsw i32 %p.0, 1
  br label %12

; <label>:21                                      ; preds = %12
  br label %22

; <label>:22                                      ; preds = %21
  %23 = add nsw i32 %n.0, 1
  br label %6

; <label>:24                                      ; preds = %6
  br label %25

; <label>:25                                      ; preds = %24
  %26 = add nsw i32 %i.0, 1
  br label %1

; <label>:27                                      ; preds = %1
  ret void
}

declare i32 @printf(i8*, ...)
