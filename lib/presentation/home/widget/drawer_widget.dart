import 'package:car_parts_app/core/config/app_color.dart';
import 'package:car_parts_app/presentation/home/widget/drawer_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300.w,
      backgroundColor: AppColor.primary,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(child: Icon(Icons.person, size: 32)),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Nickesha',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 24.sp,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'ebad3e@gmail.com',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.white,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileInfoTile(
                      icon: Icons.person_outline,
                      title: 'User Profile',
                      subtitle: 'Change profile image, name or password',
                    ),

                    SizedBox(height: 20.h),

                    ProfileInfoTile(
                      icon: Icons.privacy_tip_outlined,
                      title: 'Privacy Policy',
                      subtitle: 'Manage your data and permissions.',
                    ),

                    SizedBox(height: 20.h),

                    ProfileInfoTile(
                      icon: Icons.person_outline,
                      title: 'Terms & Conditions',
                      subtitle: 'Read terms & conditions before use',
                    ),

                    SizedBox(height: 20.h),

                    ProfileInfoTile(
                      icon: Icons.person_outline,
                      title: 'About',
                      subtitle: 'Learn more about our app and mission.',
                    ),

                    SizedBox(height: 20.h),

                    ProfileInfoTile(
                      icon: Icons.person_outline,
                      title: 'FAQ',
                      subtitle: 'Find answers to common questions.',
                    ),

                    SizedBox(height: 20.h),

                    ProfileInfoTile(
                      icon: Icons.person_outline,
                      title: 'Rating',
                      subtitle: 'Share your feedback and rate us.',
                    ),

                    SizedBox(height: 70.h),

                    Container(
                      height: 40.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.white, width: 2.w),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout_outlined, color: Colors.white),
                          SizedBox(width: 6.w),
                          Text(
                            'Logout',
                            style: GoogleFonts.montserrat(
                              textStyle: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
