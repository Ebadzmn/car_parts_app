import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // ✅ Drawer Open Button
            Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // opens the drawer
                },
                icon: SvgPicture.asset(
                  AssetsPath.appbarIcon,
                  height: 24.h,
                  width: 24.w,
                ),
              ),
            ),

            SizedBox(width: 12.w),

            const CircleAvatar(child: Icon(Icons.person)),

            SizedBox(width: 8.w),

            Text(
              'Hi Nick',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        // Right side icon
        IconButton(
          onPressed: () {
            context.push(AppRoutes.NotificationScreen);
          },
          icon: SvgPicture.asset(
            AssetsPath.notificationIcon,
            height: 22.h,
            width: 22.w,
          ),
        ),
      ],
    );
  }
}
