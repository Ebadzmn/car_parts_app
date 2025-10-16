import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please check your email',
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                color: Colors.white,
              ),
            ),

            Text(
              'A six digits code has sanded to your email',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 30.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                // controller: _otpController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                // errorAnimationController: _errorController,
                enableActiveFill: true,
                autoDisposeControllers: false,
                // pastedTextStyle: TextStyle(
                //   color: theme.colorScheme.primary,
                //   fontWeight: FontWeight.bold,
                // ),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 40.h,
                  fieldWidth: 40.w,
                  inactiveColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  activeColor: Colors.transparent,

                  // inactiveColor: Colors.grey.shade400,
                ),
                animationDuration: const Duration(milliseconds: 200),
                onChanged: (value) {
                  // optional: live changes handled by controller listener
                },
                onCompleted: (value) {
                  // User typed all 6 chars - automatically verify or enable button
                },
              ),
            ),

            Text(
              'Code expires in: 02:59',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(color: Colors.white),
              ),
            ),

            SizedBox(height: 18.h),

            Container(
              height: 44.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.amber,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                onPressed: () {},
                child: Text(
                  'Continue',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            RichText(
              text: TextSpan(
                text: "Already have an account?",
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.white),
                ),
                children: [
                  TextSpan(
                    text: 'Login ',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // Action when clicked
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sign Up tapped!')),
                        );
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
