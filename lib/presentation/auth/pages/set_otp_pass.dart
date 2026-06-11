import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/presentation/auth/controllers/forget_password_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SetOtpPass extends StatelessWidget {
  final String email;

  SetOtpPass({super.key, required this.email});

  final ForgetPasswordController controller = Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ---------- Icon ----------
              Container(
                height: 60.h,
                width: 60.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0,
                      spreadRadius: 3,
                      offset: Offset(-1, 1),
                      color: Colors.white,
                    ),
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 3,
                      offset: Offset(1, 2),
                      color: Color(0xFF373737),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 42.sp,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 12.h),
              Text(
                'Please check your email',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
              Text(
                'A six-digit code has been sent to your email',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 30.h),

              // ---------- OTP FIELD ----------
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: controller.otpController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                enableActiveFill: true,
                autoDisposeControllers: false,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 45.h,
                  fieldWidth: 45.w,
                  inactiveColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  activeColor: Colors.amber,
                ),
                animationDuration: const Duration(milliseconds: 200),
                onChanged: (_) {},
                onCompleted: (value) {},
              ),

              // ---------- Timer Text ----------
              Obx(() {
                final isExpired = controller.isExpired.value;
                final formattedTime = controller.formattedTime;
                
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isExpired ? Colors.redAccent : Colors.amber,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 18.sp,
                        color: isExpired ? Colors.redAccent : Colors.amber,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        isExpired
                            ? 'Code expired!'
                            : 'Code expires in: $formattedTime',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: isExpired ? Colors.redAccent : Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              SizedBox(height: 18.h),

              // ---------- Continue Button ----------
              SizedBox(
                height: 44.h,
                width: double.infinity,
                child: Obx(() {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    onPressed: controller.isLoading.value 
                        ? null 
                        : () => controller.verifyOtp(context, email, controller.otpController.text.trim()),
                    child: controller.isLoading.value
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 16.h,
                                width: 16.h,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Verifying...',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          )
                        : Text(
                            'Continue',
                            style: GoogleFonts.montserrat(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  );
                }),
              ),

              SizedBox(height: 12.h),

              // ---------- Back to Login ----------
              GestureDetector(
                onTap: () => context.go(AppRoutes.LoginPage),
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.white, width: 2.w),
                  ),
                  child: Center(
                    child: Text(
                      'Back to login',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // ---------- Resend OTP ----------
              Obx(() {
                final isExpired = controller.isExpired.value;
                return RichText(
                  text: TextSpan(
                    text: "Didn’t receive any code?",
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    children: [
                      TextSpan(
                        text: isExpired ? '  Resend' : '  Wait...',
                        style: TextStyle(
                          color: isExpired ? Colors.amber : Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                        recognizer: isExpired
                            ? (TapGestureRecognizer()..onTap = () => controller.resendOtp(context))
                            : null,
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
