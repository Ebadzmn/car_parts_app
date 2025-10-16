import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              children: [
                SizedBox(height: 71.h),

                Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
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

                CustomTextField(
                  label: 'Email',
                  hintText: 'Please enter your email',
                ),

                SizedBox(height: 12),

                Row(
                  children: [
                    Icon(Icons.dangerous_rounded, color: Colors.yellow),
                    Text(
                      'You may receive notifications via email from us for \n security and login purposes.',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(color: Colors.white),
                        fontSize: 9.sp,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 18.h),

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
                    onPressed: () {},
                    child: Text(
                      'Send OTP',
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
