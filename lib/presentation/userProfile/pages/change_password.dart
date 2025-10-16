import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.sp),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),

                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0,
                            spreadRadius: 1,
                            offset: Offset(0, 1),
                            color: Colors.grey,
                          ),

                          BoxShadow(
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(2, 2),
                            color: Color(0xFF373737),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'Change Password',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

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
                    Icons.password_rounded,
                    size: 42.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Change Password',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 26.h),

                CustomTextField(
                  label: 'Enter current password',
                  hintText: 'Please enter current password',
                ),

                SizedBox(height: 12.h),

                CustomTextField(
                  label: 'Enter New Passwordr',
                  hintText: 'Please enter your new password',
                ),

                SizedBox(height: 12.h),
                CustomTextField(
                  label: 'Confirm New Password',
                  hintText: 'Please re-enter your password',
                ),

                SizedBox(height: 12.h),

                SizedBox(height: 36.h),

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
                      'Update',
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
