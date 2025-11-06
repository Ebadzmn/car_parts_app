import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpPage extends StatelessWidget {
  final String email;
  OtpPage({super.key, required this.email});

  final TextEditingController _otpController = TextEditingController();
  
  final ValueNotifier<String?> errorMessage = ValueNotifier(null);

  void _verifyOtp(BuildContext context) {

    final otp = _otpController.text;
  
    

    if (otp.isEmpty) {
      errorMessage.value = 'Please enter the OTP code';
    } else if (otp.length != 6) {
      errorMessage.value = 'OTP must be 6 digits';
    } else {
      errorMessage.value = null;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('OTP Verified Successfully ✅')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
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
              SizedBox(height: 6.h),
              Text(
                'A six digit code has been sent to your email',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.sp),

              // OTP Input Field
              PinCodeTextField(
                appContext: context,
                controller: _otpController,
                length: 6,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                enableActiveFill: true,
                autoDisposeControllers: false,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 40.h,
                  fieldWidth: 40.w,
                  inactiveColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.transparent,
                  activeColor: Colors.transparent,
                ),
                animationDuration: const Duration(milliseconds: 200),
                onChanged: (value) {
                  if (value.length == 6) {
                    errorMessage.value = null;
                  }
                },
              ),

              // Error Message
              ValueListenableBuilder<String?>(
                valueListenable: errorMessage,
                builder: (context, message, _) {
                  if (message == null) return const SizedBox.shrink();
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.red, fontSize: 12.sp),
                    ),
                  );
                },
              ),

              SizedBox(height: 20.h),

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
                  onPressed: () => _verifyOtp(context),
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
                  text: "Already have an account? ",
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  children: [
                    TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Login tapped!'),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}