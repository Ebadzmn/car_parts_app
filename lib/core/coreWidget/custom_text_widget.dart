import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class customTextWidget extends StatelessWidget {
  const customTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextField(
        decoration: InputDecoration(
          labelText: 'Enter your text',
          labelStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w300,
              fontSize: 13.sp,
            ),
          ),
          hintText: 'Type something',
          hintStyle: GoogleFonts.montserrat(),
          filled: true,
          fillColor: Color(0xFF383838),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 22,
            horizontal: 20,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.white, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(
              color: Colors.white, // 🔹 Border color when focused
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
