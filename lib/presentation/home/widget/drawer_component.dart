import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileInfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ProfileInfoTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 34.h,
          width: 40.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(72.r),
            boxShadow: const [
              BoxShadow(
                blurRadius: 0,
                spreadRadius: 1,
                color: Colors.white,
                offset: Offset(0, 1),
              ),
              BoxShadow(
                blurRadius: 2,
                spreadRadius: 1,
                color: Color(0xFF373737),
                offset: Offset(2, 3),
              ),
            ],
          ),
          child: const Icon(Icons.person_outline, color: Colors.white),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              subtitle,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 8.sp,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
