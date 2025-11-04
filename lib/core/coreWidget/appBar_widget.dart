import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class Appbar_widget extends StatelessWidget {
  final String title;
  const Appbar_widget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
             
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 0,
                  spreadRadius: 1,
                  offset: Offset(0, 1),
                  color: Colors.grey,
                ),
                    
                BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 1,
                  offset: Offset(2, 2),
                  color: Color(0xFF373737),
                ),
              ],
            ),
            child: Center(
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
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
