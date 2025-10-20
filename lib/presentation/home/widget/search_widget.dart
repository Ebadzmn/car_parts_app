import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // takes full available width
      height: 56.h, // responsive height
      child: TextField(
        textAlign: TextAlign.start,
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 14.sp, // responsive text
        ),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Icon(
              Icons.search,
              color: Colors.white,
              size: 22.sp, // responsive icon size
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 40.h,
          ),
          hintText: 'Search for make, model & products',
          hintStyle: GoogleFonts.montserrat(
            color: Colors.grey.shade400,
            fontSize: 13.sp, // responsive hint text
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 14.h,
            horizontal: 16.w,
          ),
          filled: true,
          fillColor: const Color(0xFF373737),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.grey.shade700, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(color: Colors.yellow, width: 1.2.w),
          ),
        ),
      ),
    );
  }
}
