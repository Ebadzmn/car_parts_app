import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeBasicInfo extends StatelessWidget {
  const ChangeBasicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
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
                      'Basic Information Change',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 51.h),

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
                    Icons.person_outline,
                    size: 42.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  'Basic Information',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: 16.h),

                Column(
                  children: [
                    CustomTextField(
                      label: 'Full Name',
                      hintText: 'Enter your full name',
                    ),

                    SizedBox(height: 12.h),

                    CustomTextField(
                      label: 'Email',
                      hintText: 'Enter your email address',
                    ),
                    SizedBox(height: 12.h),
                    CustomTextField(
                      label: 'Address',
                      hintText: 'Enter your full Address',
                    ),

                    SizedBox(height: 12.h),

                    CustomTextField(
                      label: 'WhatsApp Number',
                      hintText: 'Enter your WhatsApp Number',
                    ),

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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
