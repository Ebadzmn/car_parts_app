import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:car_parts_app/presentation/auth/controllers/forget_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SetnewPassword extends StatelessWidget {
  SetnewPassword({super.key});

  final ForgetPasswordController controller = Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.sp),
            child: Form(
              key: controller.formKeyResetPass,
              child: Column(
                children: [
                  SizedBox(height: 50.h),

                  // 🔹 Password Icon
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0,
                          spreadRadius: 3,
                          offset: const Offset(-1, 1),
                          color: Colors.white,
                        ),
                        const BoxShadow(
                          blurRadius: 1,
                          spreadRadius: 3,
                          offset: Offset(1, 2),
                          color: Color(0xFF373737),
                        ),
                      ],
                    ),
                    child: Icon(Icons.password_rounded, size: 42.sp, color: Colors.white),
                  ),
                  SizedBox(height: 10.h),

                  Text(
                    'Set new password',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 26.h),

                  // 🔹 Password Field
                  CustomTextField(
                    controller: controller.newPasswordController,
                    label: 'Password',
                    hintText: 'Please enter your password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password can’t be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12.h),

                  // 🔹 Confirm Password Field
                  CustomTextField(
                    controller: controller.confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Please re-enter your password',
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm Password can’t be empty';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 14.h),

                  Row(
                    children: [
                      const Icon(Icons.warning_amber_rounded, color: Colors.yellow),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          'Your password must be at least 8 characters long.\nInclude multiple words to make it more secure.',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(color: Colors.white, fontSize: 9.sp),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // 🔹 Submit Button
                  Container(
                    height: 44.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.amber,
                    ),
                    child: Obx(() {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        onPressed: controller.isLoading.value ? null : () => controller.resetPassword(context),
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
                                    'Setting Password...',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 16.sp,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              )
                            : Text(
                                'Set Password',
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