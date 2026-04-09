import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:car_parts_app/core/config/assets_path.dart';

class CustomLoadingDialog extends StatelessWidget {
  final String message;

  const CustomLoadingDialog({super.key, this.message = 'Logging in...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: Colors.amber.withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 65.w,
                  height: 65.w,
                  child: const CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                  ),
                ),
                Image.asset(
                  AssetsPath.newLogo,
                  width: 35.w,
                  height: 35.h,
                ).animate(onPlay: (controller) => controller.repeat())
                 .shimmer(duration: 1500.ms, color: Colors.amber.withOpacity(0.5))
                 .scaleXY(end: 1.1, duration: 750.ms)
                 .then(delay: 750.ms)
                 .scaleXY(end: 1 / 1.1),
              ],
            ),
            SizedBox(height: 24.h),
            Material(
              color: Colors.transparent,
              child: Text(
                message,
                style: GoogleFonts.montserrat(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ).animate(onPlay: (controller) => controller.repeat())
               .fadeIn(duration: 800.ms)
               .then(delay: 800.ms)
               .fadeOut(duration: 800.ms),
            ),
          ],
        ),
      ).animate().scale(duration: 300.ms, curve: Curves.easeOutBack).fadeIn(),
    );
  }
}

Future<void> showCustomLoadingDialog(BuildContext context, {String message = 'Logging in...'}) async {
  if (Navigator.canPop(context)) return;
  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.7),
    builder: (_) => CustomLoadingDialog(message: message),
  );
}
