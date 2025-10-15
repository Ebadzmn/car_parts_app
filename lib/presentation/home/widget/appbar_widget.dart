import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
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
            SvgPicture.asset(AssetsPath.appbarIcon),
            SizedBox(width: 12.w),
            CircleAvatar(child: Icon(Icons.person)),
            SizedBox(width: 8.w),
            Text(
              'HI Nick',
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
        SvgPicture.asset(AssetsPath.notificationIcon),
      ],
    );
  }
}
