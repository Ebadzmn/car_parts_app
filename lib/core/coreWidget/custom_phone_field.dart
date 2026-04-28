import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomPhoneField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final Function(PhoneNumber)? onChanged;

  const CustomPhoneField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Label Text
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 6.h),
            child: Text(
              label,
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          /// IntlPhoneField
          IntlPhoneField(
            controller: controller,
            dropdownTextStyle: GoogleFonts.montserrat(
              fontSize: 12.sp,
              color: Colors.white,
            ),
            style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.white),
            dropdownIcon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
            initialCountryCode: 'AE',
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.montserrat(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              filled: true,
              fillColor: const Color(0xFF383838),

              /// Responsive padding
              contentPadding: EdgeInsets.symmetric(
                vertical: 14.h,
                horizontal: 12.w,
              ),

              /// Border styles
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: Colors.white, width: 1.2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: Colors.white, width: 1.8),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: Colors.red, width: 1.2),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(color: Colors.red, width: 1.8),
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
