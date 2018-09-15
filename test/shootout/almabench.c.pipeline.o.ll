; ModuleID = 'almabench.c.pipeline.o'
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
  %12 = getelementptr inbounds [3 x double]* %9, i32 0, i64 1
  %13 = load double* %12
  %14 = getelementptr inbounds [3 x double]* %9, i32 0, i64 2
  %15 = load double* %14
  %16 = fmul double %15, %7
  %17 = fadd double %13, %16
  %18 = fmul double %17, %7
  %19 = fadd double %11, %18
  %20 = getelementptr inbounds [8 x [3 x double]]* @dlm, i32 0, i64 %8
  %21 = getelementptr inbounds [3 x double]* %20, i32 0, i64 0
  %22 = load double* %21
  %23 = fmul double 3.600000e+03, %22
  %24 = getelementptr inbounds [3 x double]* %20, i32 0, i64 1
  %25 = load double* %24
  %26 = getelementptr inbounds [3 x double]* %20, i32 0, i64 2
  %27 = load double* %26
  %28 = fmul double %27, %7
  %29 = fadd double %25, %28
  %30 = fmul double %29, %7
  %31 = fadd double %23, %30
  %32 = fmul double %31, 0x3ED455A5B2FF8F9D
  %33 = getelementptr inbounds [8 x [3 x double]]* @e, i32 0, i64 %8
  %34 = getelementptr inbounds [3 x double]* %33, i32 0, i64 0
  %35 = load double* %34
  %36 = getelementptr inbounds [3 x double]* %33, i32 0, i64 1
  %37 = load double* %36
  %38 = getelementptr inbounds [3 x double]* %33, i32 0, i64 2
  %39 = load double* %38
  %40 = fmul double %39, %7
  %41 = fadd double %37, %40
  %42 = fmul double %41, %7
  %43 = fadd double %35, %42
  %44 = getelementptr inbounds [8 x [3 x double]]* @pi, i32 0, i64 %8
  %45 = getelementptr inbounds [3 x double]* %44, i32 0, i64 0
  %46 = load double* %45
  %47 = fmul double 3.600000e+03, %46
  %48 = getelementptr inbounds [3 x double]* %44, i32 0, i64 1
  %49 = load double* %48
  %50 = getelementptr inbounds [3 x double]* %44, i32 0, i64 2
  %51 = load double* %50
  %52 = fmul double %51, %7
  %53 = fadd double %49, %52
  %54 = fmul double %53, %7
  %55 = fadd double %47, %54
  %56 = fmul double %55, 0x3ED455A5B2FF8F9D
  %57 = call double @anpm(double %56)
  %58 = getelementptr inbounds [8 x [3 x double]]* @dinc, i32 0, i64 %8
  %59 = getelementptr inbounds [3 x double]* %58, i32 0, i64 0
  %60 = load double* %59
  %61 = fmul double 3.600000e+03, %60
  %62 = getelementptr inbounds [3 x double]* %58, i32 0, i64 1
  %63 = load double* %62
  %64 = getelementptr inbounds [3 x double]* %58, i32 0, i64 2
  %65 = load double* %64
  %66 = fmul double %65, %7
  %67 = fadd double %63, %66
  %68 = fmul double %67, %7
  %69 = fadd double %61, %68
  %70 = fmul double %69, 0x3ED455A5B2FF8F9D
  %71 = getelementptr inbounds [8 x [3 x double]]* @omega, i32 0, i64 %8
  %72 = getelementptr inbounds [3 x double]* %71, i32 0, i64 0
  %73 = load double* %72
  %74 = fmul double 3.600000e+03, %73
  %75 = getelementptr inbounds [3 x double]* %71, i32 0, i64 1
  %76 = load double* %75
  %77 = getelementptr inbounds [3 x double]* %71, i32 0, i64 2
  %78 = load double* %77
  %79 = fmul double %78, %7
  %80 = fadd double %76, %79
  %81 = fmul double %80, %7
  %82 = fadd double %74, %81
  %83 = fmul double %82, 0x3ED455A5B2FF8F9D
  %84 = call double @anpm(double %83)
  %85 = fmul double 3.595362e-01, %7
  %86 = getelementptr inbounds [8 x [9 x double]]* @kp, i32 0, i64 %8
  %87 = getelementptr inbounds [8 x [10 x double]]* @kq, i32 0, i64 %8
  %88 = getelementptr inbounds [8 x [9 x double]]* @ca, i32 0, i64 %8
  %89 = getelementptr inbounds [8 x [9 x double]]* @sa, i32 0, i64 %8
  %90 = getelementptr inbounds [8 x [10 x double]]* @cl, i32 0, i64 %8
  %91 = getelementptr inbounds [8 x [10 x double]]* @sl, i32 0, i64 %8
  br label %92

; <label>:92                                      ; preds = %94, %0
  %da.0 = phi double [ %19, %0 ], [ %112, %94 ]
  %dl.0 = phi double [ %32, %0 ], [ %123, %94 ]
  %k.0 = phi i32 [ 0, %0 ], [ %124, %94 ]
  %93 = icmp slt i32 %k.0, 8
  br i1 %93, label %94, label %125

; <label>:94                                      ; preds = %92
  %95 = sext i32 %k.0 to i64
  %96 = getelementptr inbounds [9 x double]* %86, i32 0, i64 %95
  %97 = load double* %96
  %98 = fmul double %97, %85
  %99 = getelementptr inbounds [10 x double]* %87, i32 0, i64 %95
  %100 = load double* %99
  %101 = fmul double %100, %85
  %102 = getelementptr inbounds [9 x double]* %88, i32 0, i64 %95
  %103 = load double* %102
  %104 = call double @cos(double %98)
  %105 = fmul double %103, %104
  %106 = getelementptr inbounds [9 x double]* %89, i32 0, i64 %95
  %107 = load double* %106
  %108 = call double @sin(double %98)
  %109 = fmul double %107, %108
  %110 = fadd double %105, %109
  %111 = fmul double %110, 1.000000e-07
  %112 = fadd double %da.0, %111
  %113 = getelementptr inbounds [10 x double]* %90, i32 0, i64 %95
  %114 = load double* %113
  %115 = call double @cos(double %101)
  %116 = fmul double %114, %115
  %117 = getelementptr inbounds [10 x double]* %91, i32 0, i64 %95
  %118 = load double* %117
  %119 = call double @sin(double %101)
  %120 = fmul double %118, %119
  %121 = fadd double %116, %120
  %122 = fmul double %121, 1.000000e-07
  %123 = fadd double %dl.0, %122
  %124 = add nsw i32 %k.0, 1
  br label %92

; <label>:125                                     ; preds = %92
  %dl.0.lcssa = phi double [ %dl.0, %92 ]
  %da.0.lcssa = phi double [ %da.0, %92 ]
  %126 = getelementptr inbounds [8 x [9 x double]]* @kp, i32 0, i64 %8
  %127 = getelementptr inbounds [9 x double]* %126, i32 0, i64 8
  %128 = load double* %127
  %129 = fmul double %128, %85
  %130 = getelementptr inbounds [8 x [9 x double]]* @ca, i32 0, i64 %8
  %131 = getelementptr inbounds [9 x double]* %130, i32 0, i64 8
  %132 = load double* %131
  %133 = call double @cos(double %129)
  %134 = fmul double %132, %133
  %135 = getelementptr inbounds [8 x [9 x double]]* @sa, i32 0, i64 %8
  %136 = getelementptr inbounds [9 x double]* %135, i32 0, i64 8
  %137 = load double* %136
  %138 = call double @sin(double %129)
  %139 = fmul double %137, %138
  %140 = fadd double %134, %139
  %141 = fmul double %7, %140
  %142 = fmul double %141, 1.000000e-07
  %143 = fadd double %da.0.lcssa, %142
  %144 = getelementptr inbounds [8 x [10 x double]]* @kq, i32 0, i64 %8
  %145 = getelementptr inbounds [8 x [10 x double]]* @cl, i32 0, i64 %8
  %146 = getelementptr inbounds [8 x [10 x double]]* @sl, i32 0, i64 %8
  br label %147

; <label>:147                                     ; preds = %149, %125
  %dl.1 = phi double [ %dl.0.lcssa, %125 ], [ %165, %149 ]
  %k.1 = phi i32 [ 8, %125 ], [ %166, %149 ]
  %148 = icmp sle i32 %k.1, 9
  br i1 %148, label %149, label %167

; <label>:149                                     ; preds = %147
  %150 = sext i32 %k.1 to i64
  %151 = getelementptr inbounds [10 x double]* %144, i32 0, i64 %150
  %152 = load double* %151
  %153 = fmul double %152, %85
  %154 = getelementptr inbounds [10 x double]* %145, i32 0, i64 %150
  %155 = load double* %154
  %156 = call double @cos(double %153)
  %157 = fmul double %155, %156
  %158 = getelementptr inbounds [10 x double]* %146, i32 0, i64 %150
  %159 = load double* %158
  %160 = call double @sin(double %153)
  %161 = fmul double %159, %160
  %162 = fadd double %157, %161
  %163 = fmul double %7, %162
  %164 = fmul double %163, 1.000000e-07
  %165 = fadd double %dl.1, %164
  %166 = add nsw i32 %k.1, 1
  br label %147

; <label>:167                                     ; preds = %147
  %dl.1.lcssa = phi double [ %dl.1, %147 ]
  %168 = call double @fmod(double %dl.1.lcssa, double 0x401921FB54442D18)
  %169 = fsub double %168, %57
  %170 = call double @sin(double %169)
  %171 = fmul double %43, %170
  %172 = fadd double %169, %171
  br label %173

; <label>:173                                     ; preds = %288, %167
  %k.2 = phi i32 [ 0, %167 ], [ %183, %288 ]
  %ae.0 = phi double [ %172, %167 ], [ %182, %288 ]
  %174 = fsub double %169, %ae.0
  %175 = call double @sin(double %ae.0)
  %176 = fmul double %43, %175
  %177 = fadd double %174, %176
  %178 = call double @cos(double %ae.0)
  %179 = fmul double %43, %178
  %180 = fsub double 1.000000e+00, %179
  %181 = fdiv double %177, %180
  %182 = fadd double %ae.0, %181
  %183 = add nsw i32 %k.2, 1
  %184 = icmp sge i32 %183, 10
  br i1 %184, label %188, label %185

; <label>:185                                     ; preds = %173
  %186 = call double @fabs(double %181)
  %187 = fcmp olt double %186, 1.000000e-12
  br i1 %187, label %188, label %288

; <label>:188                                     ; preds = %185, %173
  %.lcssa = phi double [ %182, %185 ], [ %182, %173 ]
  %189 = fdiv double %.lcssa, 2.000000e+00
  %190 = fadd double 1.000000e+00, %43
  %191 = fsub double 1.000000e+00, %43
  %192 = fdiv double %190, %191
  %193 = call double @sqrt(double %192)
  %194 = call double @sin(double %189)
  %195 = fmul double %193, %194
  %196 = call double @cos(double %189)
  %197 = call double @atan2(double %195, double %196)
  %198 = fmul double 2.000000e+00, %197
  %199 = call double @cos(double %.lcssa)
  %200 = fmul double %43, %199
  %201 = fsub double 1.000000e+00, %200
  %202 = fmul double %143, %201
  %203 = getelementptr inbounds [8 x double]* @amas, i32 0, i64 %8
  %204 = load double* %203
  %205 = fdiv double 1.000000e+00, %204
  %206 = fadd double 1.000000e+00, %205
  %207 = fmul double %143, %143
  %208 = fmul double %207, %143
  %209 = fdiv double %206, %208
  %210 = call double @sqrt(double %209)
  %211 = fmul double 0x3F919D6D51A6B69A, %210
  %212 = fdiv double %70, 2.000000e+00
  %213 = call double @sin(double %212)
  %214 = call double @cos(double %84)
  %215 = fmul double %213, %214
  %216 = call double @sin(double %84)
  %217 = fmul double %213, %216
  %218 = fadd double %198, %57
  %219 = call double @sin(double %218)
  %220 = call double @cos(double %218)
  %221 = fmul double %217, %220
  %222 = fmul double %215, %219
  %223 = fsub double %221, %222
  %224 = fmul double 2.000000e+00, %223
  %225 = fmul double %43, %43
  %226 = fsub double 1.000000e+00, %225
  %227 = call double @sqrt(double %226)
  %228 = fdiv double %143, %227
  %229 = call double @cos(double %212)
  %230 = call double @sin(double %57)
  %231 = fmul double %43, %230
  %232 = fadd double %231, %219
  %233 = fmul double %232, %228
  %234 = call double @cos(double %57)
  %235 = fmul double %43, %234
  %236 = fadd double %235, %220
  %237 = fmul double %236, %228
  %238 = fmul double 2.000000e+00, %217
  %239 = fmul double %238, %215
  %240 = fmul double %224, %217
  %241 = fsub double %220, %240
  %242 = fmul double %202, %241
  %243 = fmul double %224, %215
  %244 = fadd double %219, %243
  %245 = fmul double %202, %244
  %246 = fsub double -0.000000e+00, %224
  %247 = fmul double %246, %229
  %248 = fmul double %202, %247
  %249 = getelementptr inbounds [3 x double]* %pv, i64 0
  %250 = getelementptr inbounds [3 x double]* %249, i32 0, i64 0
  store double %242, double* %250
  %251 = fmul double %245, 0x3FED5C0357681EF3
  %252 = fmul double %248, 0x3FD9752E50F4B399
  %253 = fsub double %251, %252
  %254 = getelementptr inbounds [3 x double]* %249, i32 0, i64 1
  store double %253, double* %254
  %255 = fmul double %245, 0x3FD9752E50F4B399
  %256 = fmul double %248, 0x3FED5C0357681EF3
  %257 = fadd double %255, %256
  %258 = getelementptr inbounds [3 x double]* %249, i32 0, i64 2
  store double %257, double* %258
  %259 = fmul double %238, %217
  %260 = fadd double -1.000000e+00, %259
  %261 = fmul double %260, %233
  %262 = fmul double %239, %237
  %263 = fadd double %261, %262
  %264 = fmul double %211, %263
  %265 = fmul double 2.000000e+00, %215
  %266 = fmul double %265, %215
  %267 = fsub double 1.000000e+00, %266
  %268 = fmul double %267, %237
  %269 = fmul double %239, %233
  %270 = fsub double %268, %269
  %271 = fmul double %211, %270
  %272 = fmul double 2.000000e+00, %229
  %273 = fmul double %217, %233
  %274 = fmul double %215, %237
  %275 = fadd double %273, %274
  %276 = fmul double %272, %275
  %277 = fmul double %211, %276
  %278 = getelementptr inbounds [3 x double]* %pv, i64 1
  %279 = getelementptr inbounds [3 x double]* %278, i32 0, i64 0
  store double %264, double* %279
  %280 = fmul double %271, 0x3FED5C0357681EF3
  %281 = fmul double %277, 0x3FD9752E50F4B399
  %282 = fsub double %280, %281
  %283 = getelementptr inbounds [3 x double]* %278, i32 0, i64 1
  store double %282, double* %283
  %284 = fmul double %271, 0x3FD9752E50F4B399
  %285 = fmul double %277, 0x3FED5C0357681EF3
  %286 = fadd double %284, %285
  %287 = getelementptr inbounds [3 x double]* %278, i32 0, i64 2
  store double %286, double* %287
  ret void

; <label>:288                                     ; preds = %185
  br label %173
}

declare double @cos(double) readnone

declare double @sin(double) readnone

declare double @atan2(double, double)

declare double @sqrt(double) readnone

define void @radecdist([3 x double]* %state, double* %rdd) nounwind ssp {
  %1 = getelementptr inbounds [3 x double]* %state, i64 0
  %2 = getelementptr inbounds [3 x double]* %1, i32 0, i64 0
  %3 = load double* %2
  %4 = fmul double %3, %3
  %5 = getelementptr inbounds [3 x double]* %1, i32 0, i64 1
  %6 = load double* %5
  %7 = fmul double %6, %6
  %8 = fadd double %4, %7
  %9 = getelementptr inbounds [3 x double]* %1, i32 0, i64 2
  %10 = load double* %9
  %11 = fmul double %10, %10
  %12 = fadd double %8, %11
  %13 = call double @sqrt(double %12)
  %14 = getelementptr inbounds double* %rdd, i64 2
  store double %13, double* %14
  %15 = load double* %5
  %16 = load double* %2
  %17 = call double @atan2(double %15, double %16)
  %18 = fmul double %17, 0x400E8EC8A4AEACC4
  %19 = getelementptr inbounds double* %rdd, i64 0
  store double %18, double* %19
  %20 = fcmp olt double %18, 0.000000e+00
  br i1 %20, label %21, label %23

; <label>:21                                      ; preds = %0
  %22 = fadd double %18, 2.400000e+01
  store double %22, double* %19
  br label %23

; <label>:23                                      ; preds = %21, %0
  %24 = load double* %9
  %25 = load double* %14
  %26 = fdiv double %24, %25
  %27 = call double @asin(double %26)
  %28 = fmul double %27, 0x404CA5DC1A63C1F8
  %29 = getelementptr inbounds double* %rdd, i64 1
  store double %28, double* %29
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
  %3 = getelementptr inbounds [2 x double]* %jd, i32 0, i32 0
  %4 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  %5 = getelementptr inbounds [3 x double]* %position, i32 0, i32 0
  %6 = getelementptr inbounds [3 x double]* %position, i32 0, i64 0
  %7 = getelementptr inbounds [3 x double]* %position, i32 0, i64 1
  br label %8

; <label>:8                                       ; preds = %10, %0
  %p.0 = phi i32 [ 0, %0 ], [ %14, %10 ]
  %9 = icmp slt i32 %p.0, 8
  br i1 %9, label %10, label %15

; <label>:10                                      ; preds = %8
  call void @planetpv(double* %3, i32 %p.0, [3 x double]* %4)
  call void @radecdist([3 x double]* %4, double* %5)
  %11 = load double* %6
  %12 = load double* %7
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str, i32 0, i32 0), i32 %p.0, double %11, double %12)
  %14 = add nsw i32 %p.0, 1
  br label %8

; <label>:15                                      ; preds = %8
  ret void
}

define internal void @bench(i32 %nloops) nounwind ssp {
; <label>:0
  %jd = alloca [2 x double], align 16
  %pv = alloca [2 x [3 x double]], align 16
  %position = alloca [3 x double], align 16
  %1 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 0
  %2 = getelementptr inbounds [2 x double]* %jd, i32 0, i64 1
  %3 = getelementptr inbounds [2 x double]* %jd, i32 0, i32 0
  %4 = getelementptr inbounds [2 x [3 x double]]* %pv, i32 0, i32 0
  %5 = getelementptr inbounds [3 x double]* %position, i32 0, i32 0
  br label %6

; <label>:6                                       ; preds = %20, %0
  %i.0 = phi i32 [ 0, %0 ], [ %21, %20 ]
  %7 = icmp slt i32 %i.0, %nloops
  br i1 %7, label %8, label %22

; <label>:8                                       ; preds = %6
  store double 2.451545e+06, double* %1
  store double 0.000000e+00, double* %2
  br label %9

; <label>:9                                       ; preds = %18, %8
  %n.0 = phi i32 [ 0, %8 ], [ %19, %18 ]
  %10 = icmp slt i32 %n.0, 36525
  br i1 %10, label %11, label %20

; <label>:11                                      ; preds = %9
  %12 = load double* %1
  %13 = fadd double %12, 1.000000e+00
  store double %13, double* %1
  br label %14

; <label>:14                                      ; preds = %16, %11
  %p.0 = phi i32 [ 0, %11 ], [ %17, %16 ]
  %15 = icmp slt i32 %p.0, 8
  br i1 %15, label %16, label %18

; <label>:16                                      ; preds = %14
  call void @planetpv(double* %3, i32 %p.0, [3 x double]* %4)
  call void @radecdist([3 x double]* %4, double* %5)
  %17 = add nsw i32 %p.0, 1
  br label %14

; <label>:18                                      ; preds = %14
  %19 = add nsw i32 %n.0, 1
  br label %9

; <label>:20                                      ; preds = %9
  %21 = add nsw i32 %i.0, 1
  br label %6

; <label>:22                                      ; preds = %6
  ret void
}

declare i32 @printf(i8*, ...)
