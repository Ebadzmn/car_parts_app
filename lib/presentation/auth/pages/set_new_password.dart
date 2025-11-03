import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SetnewPassword extends StatelessWidget {
  SetnewPassword({super.key});

  // 🔹 Controllers
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  // 🔹 ValueNotifier for error messages
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  // 🔹 Validation Function
  void _validateAndSubmit(BuildContext context) {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      errorMessage.value = 'Please fill in both password fields';
    } else if (password.length < 8) {
      errorMessage.value = 'Password must be at least 8 characters long';
    } else if (password != confirmPassword) {
      errorMessage.value = 'Passwords do not match';
    } else {
      errorMessage.value = null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password set successfully ✅')),
      );
      context.push(AppRoutes.LoginPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.sp),
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
                  controller: passwordController,
                  label: 'Password',
                  hintText: 'Please enter your password',
                  obscureText: true,
                ),
                SizedBox(height: 12.h),

                // 🔹 Confirm Password Field
                CustomTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  hintText: 'Please re-enter your password',
                  obscureText: true,
                ),

                SizedBox(height: 10.h),

                // 🔹 Error Message (auto updates)
                ValueListenableBuilder<String?>(
                  valueListenable: errorMessage,
                  builder: (context, message, _) {
                    if (message == null) return const SizedBox.shrink();
                    return Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.redAccent, fontSize: 12.sp),
                      ),
                    );
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
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () => _validateAndSubmit(context),
                    child: Text(
                      'Set Password',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}