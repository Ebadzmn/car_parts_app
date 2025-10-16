import 'package:car_parts_app/core/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = 1.sh;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    'User Profile',
                    style: GoogleFonts.montserrat(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 100.h),

              SizedBox(height: 100.h, width: 100.w, child: CircleAvatar()),
              SizedBox(height: 14.h),
              Container(
                height: 28.h,
                width: 120.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColor.secondary,
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Center(
                  child: Text(
                    'Change Photo',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 42.h),

              Container(
                height: screenHeight > 1000 ? 260.h : 200.h,
                width: 400.w,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColor.secondary,
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Profile',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 18.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Basic Information',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Update Basic Information',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_back_ios, color: Colors.white),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Contact',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'Update contact information',
                                style: GoogleFonts.montserrat(
                                  fontSize: 10.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.arrow_back_ios, color: Colors.white),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Change Password',
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Icon(Icons.arrow_back_ios, color: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
