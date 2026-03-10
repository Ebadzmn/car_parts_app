import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/app_color.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/data/data_source/local/auth_local_datasource.dart';
import 'package:car_parts_app/presentation/home/widget/drawer_component.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_parts_app/presentation/userProfile/bloc/user_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  /// Shows a confirmation dialog and performs logout if confirmed.
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColor.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
          side: const BorderSide(color: Colors.grey),
        ),
        title: Text(
          'Logout',
          style: GoogleFonts.montserrat(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            color: Colors.grey.shade300,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () async {
              // Close the dialog first
              Navigator.of(dialogContext).pop();

              // Perform logout
              await _performLogout(context);
            },
            child: Text(
              'Logout',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Clears all stored auth data and navigates to login.
  Future<void> _performLogout(BuildContext context) async {
    try {
      final authLocal = sl<AuthLocalDatasource>();
      await authLocal.clearToken();
      await authLocal.clearRefreshToken();
    } catch (e) {
      debugPrint('Logout: failed to clear tokens – $e');
    }

    if (context.mounted) {
      context.go(AppRoutes.LoginPage);
    }
  }

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
                BlocBuilder<UserProfileBloc, UserProfileState>(
                  builder: (context, state) {
                    String imageUrl = '';
                    String userName = 'Nickesha';
                    String userEmail = 'ebad3e@gmail.com';

                    if (state is UserLoaded) {
                      imageUrl = state.profileEntity.image;
                      userName = state.profileEntity.name.isNotEmpty
                          ? state.profileEntity.name
                          : 'Nickesha';
                      userEmail = state.profileEntity.email.isNotEmpty
                          ? state.profileEntity.email
                          : 'ebad3e@gmail.com';
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100.w,
                          width: 100.w,
                          child: CircleAvatar(
                            backgroundImage: imageUrl.isNotEmpty
                                ? NetworkImage(imageUrl)
                                : null,
                            child: imageUrl.isEmpty
                                ? Icon(Icons.person, size: 32)
                                : null,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          userName,
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
                          userEmail,
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
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
                    GestureDetector(
                      onTap: () => context.push(AppRoutes.userProfileScreen),
                      child: ProfileInfoTile(
                        icon: Icons.person_outline,
                        title: 'User Profile',
                        subtitle: 'Change profile image, name or password',
                      ),
                    ),

                    SizedBox(height: 20.h),

                    GestureDetector(
                      onTap: () => context.push(AppRoutes.PrivacyPolicyScreen),
                      child: ProfileInfoTile(
                        icon: Icons.privacy_tip_outlined,
                        title: 'Privacy Policy',
                        subtitle: 'Manage your data and permissions.',
                      ),
                    ),

                    SizedBox(height: 20.h),

                    GestureDetector(
                      onTap: () =>
                          context.push(AppRoutes.TearmsConditionScreen),
                      child: ProfileInfoTile(
                        icon: Icons.person_outline,
                        title: 'Terms & Conditions',
                        subtitle: 'Read terms & conditions before use',
                      ),
                    ),

                    SizedBox(height: 20.h),

                    GestureDetector(
                      onTap: () => context.push(AppRoutes.AboutScreen),
                      child: ProfileInfoTile(
                        icon: Icons.person_outline,
                        title: 'About',
                        subtitle: 'Learn more about our app and mission.',
                      ),
                    ),

                    SizedBox(height: 20.h),

                    GestureDetector(
                      onTap: () => context.push(AppRoutes.FaqsPage),
                      child: ProfileInfoTile(
                        icon: Icons.person_outline,
                        title: 'FAQ',
                        subtitle: 'Find answers to common questions.',
                      ),
                    ),

                    SizedBox(height: 20.h),

                    ProfileInfoTile(
                      icon: Icons.person_outline,
                      title: 'Rating',
                      subtitle: 'Share your feedback and rate us.',
                    ),

                    SizedBox(height: 70.h),

                    GestureDetector(
                      onTap: () => _showLogoutDialog(context),
                      child: Container(
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
