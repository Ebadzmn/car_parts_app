import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/presentation/home/pages/main_screen.dart';
import 'package:car_parts_app/core/utils/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car_parts_app/presentation/userProfile/bloc/user_profile_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // ✅ Drawer Open Button (Custom Hamburger)
              Builder(
                builder: (context) => InkWell(
                  onTap: () {
                    MainScreen.scaffoldKey.currentState?.openDrawer();
                  },
                  borderRadius: BorderRadius.circular(8.r),
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 2.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          height: 2.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Container(
                          height: 2.h,
                          width: 24.w,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 16.w),

              // Profile Avatar and Greeting
              BlocBuilder<UserProfileBloc, UserProfileState>(
                builder: (context, state) {
                  String imageUrl = '';
                  String userName = 'Hi User';

                  if (state is UserLoaded) {
                    imageUrl = state.profileEntity.image;
                    userName = state.profileEntity.name.isNotEmpty
                        ? 'Hi ${state.profileEntity.name.split(' ').first}'
                        : 'Hi User';
                  }

                  return Row(
                    children: [
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.2),
                          image: (imageUrl.isNotEmpty)
                              ? DecorationImage(
                                  image: NetworkImage(imageUrl),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: (imageUrl.isEmpty)
                            ? Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 24.sp,
                              )
                            : null,
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        userName,
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),

          // Right side notification icon
          Builder(
            builder: (context) => IconButton(
              onPressed: () async {
                if (!await hasAuthToken()) {
                  await redirectToLogin(
                    context,
                    intendedLocation: AppRoutes.NotificationScreen,
                  );
                  return;
                }

                context.push(AppRoutes.NotificationScreen);
              },
              icon: Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
