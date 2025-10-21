import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StepForms extends StatelessWidget {
  final int step;
  final Function(Map<String, dynamic>) onChanged;

  const StepForms({super.key, required this.step, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    switch (step) {
      case 1:
        return StepOneForm(onChanged: onChanged);
      case 2:
        return StepTwoForm(onChanged: onChanged);
      case 3:
        return StepThreeForm(onChanged: onChanged);
      default:
        return const SizedBox.shrink();
    }
  }
}

class StepOneForm extends StatelessWidget {
  final Function(Map<String, dynamic>) onChanged;
  const StepOneForm({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(label: 'Full Name', hintText: 'Enter your full name'),
        CustomTextField(label: 'Email', hintText: 'Enter your email'),

        CustomTextField(
          label: 'Phone Number',
          hintText: 'Enter your phone number',
        ),

        CustomTextField(label: 'Full Name', hintText: 'Enter your full name'),
      ],
    );
  }
}

class StepTwoForm extends StatelessWidget {
  final Function(Map<String, dynamic>) onChanged;
  const StepTwoForm({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          label: 'Description',
          hintText: 'Enter your product description',
          maxLines: 6,
        ),
      ],
    );
  }
}

class StepThreeForm extends StatelessWidget {
  final Function(Map<String, dynamic>) onChanged;
  const StepThreeForm({super.key, required this.onChanged});

  Widget _buildUploadBox(String title) {
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
            color: const Color(0xFF363636),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.white24, width: 1.w),
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
                child: Icon(
                  Icons.upload_rounded,
                  color: Colors.greenAccent,
                  size: 24.sp,
                ),
              ),
              SizedBox(height: 8.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Click here ',
                      style: GoogleFonts.inter(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    TextSpan(
                      text: 'to upload or drop media here',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 14.sp,
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUploadBox('Main Picture Upload'),
        SizedBox(height: 16.h),
        _buildUploadBox('Sub Picture Upload'),
      ],
    );
  }
}
