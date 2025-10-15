import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnbBtnWidget extends StatelessWidget {
  final VoidCallback? onNext;
  final VoidCallback? onBack;
  final bool isLast;
  final PageController pageController;

  const OnbBtnWidget({
    super.key,
    this.onNext,
    this.onBack,
    this.isLast = false,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Back Button
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF5BB349), width: 4),
              ),
            ),
            Positioned(
              bottom: 1,
              left: 0,
              right: 14,
              top: 0,
              child: Container(
                width: 140,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF5BB349), width: 3),
                ),
              ),
            ),
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: Colors.green, size: 32),
            ),
          ],
        ),

        // Next / Get Started Button
        Container(
          height: 40.h,
          width: 130.w,
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(66.sp),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
            onPressed: onNext,
            child: Text(
              isLast ? 'Get Started' : 'Next',
              style: GoogleFonts.inter(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
