import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageUploadDesign extends StatelessWidget {
  const ImageUploadDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // dark background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUploadSection(
                title: 'Main Picture Upload',
                icon: Icons.upload_rounded,
              ),
              SizedBox(height: 24.h),
              _buildUploadSection(
                title: 'Sub Picture Upload',
                icon: Icons.upload_rounded,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUploadSection({required String title, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 120.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white24, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 45.h,
                width: 45.h,
                decoration: const BoxDecoration(
                  color: Color(0xFF2D5F3A),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: Colors.greenAccent, size: 24.sp),
              ),
              SizedBox(height: 8.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Click here ',
                      style: GoogleFonts.inter(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextSpan(
                      text: 'to upload or drop media here',
                      style: GoogleFonts.inter(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
