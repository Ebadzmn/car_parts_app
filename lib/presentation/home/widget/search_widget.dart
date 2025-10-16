import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class searchWidget extends StatelessWidget {
  const searchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white, size: 24.sp),
          hintText: 'Search for make, model & products',
          hintStyle: GoogleFonts.montserrat(
            color: Colors.grey,
            fontSize: 12.sp,
          ),

          filled: true,
          fillColor: Color(0xFF373737),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
      ),
    );
  }
}
