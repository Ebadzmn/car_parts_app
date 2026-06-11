import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:car_parts_app/presentation/auth/controllers/forget_password_controller.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  final ForgetPasswordController controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // background color added for contrast
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Form(
              key: controller.formKeyForgetPass,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 71.h),

                  // ---------- Email Icon ----------
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
                      Icons.email_outlined,
                      size: 42.sp,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 6.h),
                  Text(
                    'Forget Password',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 26.h),

                  // ---------- Email Field ----------
                  CustomTextField(
                    controller: controller.emailController,
                    label: 'Email',
                    hintText: 'Please enter your email',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email can’t be empty';
                      } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.yellow, size: 18),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          'You may receive notifications via email from us for security and login purposes.',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(color: Colors.white),
                            fontSize: 9.sp,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 18.h),

                  // ---------- Send OTP Button ----------
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
                        onPressed: controller.isLoading.value ? null : () => controller.sendOtp(context),
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
                                    'Sending...',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Send OTP',
                                style: GoogleFonts.montserrat(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}