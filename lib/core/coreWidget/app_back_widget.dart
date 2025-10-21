import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBackWidget extends StatelessWidget {
  final String title;

  const AppBackWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            height: 30.h,
            width: 30.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.r),
              boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                  spreadRadius: 1,
                  offset: const Offset(0, 1),
                  color: Colors.grey,
                ),
                BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: const Offset(2, 2),
                  color: const Color(0xFF373737),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.green,
              ),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
