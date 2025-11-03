import 'dart:async';
import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SetOtpPass extends StatefulWidget {
  const SetOtpPass({super.key});

  @override
  State<SetOtpPass> createState() => _SetOtpPassState();
}

class _SetOtpPassState extends State<SetOtpPass> {
  final TextEditingController _otpController = TextEditingController();
  int _secondsRemaining = 180; // 3 minutes = 180 seconds
  Timer? _timer;
  bool _isExpired = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 180;
    _isExpired = false;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        setState(() => _isExpired = true);
        timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _verifyOtp() {
    final otp = _otpController.text.trim();
    if (otp.isEmpty || otp.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit OTP'),
          backgroundColor: Colors.redAccent,
        ),
        
      );
    } else {
      // ✅ OTP verify logic এখানে লিখো (API call etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP Verified Successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      context.push(AppRoutes.set_new_password);
    }
  }

  @override
  void dispose() {
    _otpController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ---------- Icon ----------
              Container(
                height: 60.h,
                width: 60.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0,
                      spreadRadius: 3,
                      offset: Offset(-1, 1),
                      color: Colors.white,
                    ),
                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 3,
                      offset: Offset(1, 2),
                      color: Color(0xFF373737),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.person_outline,
                  size: 42.sp,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 12.h),
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
                'A six-digit code has been sent to your email',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(color: Colors.white),
                ),
              ),

              SizedBox(height: 30.h),

              // ---------- OTP FIELD ----------
              PinCodeTextField(
                appContext: context,
                length: 6,
                controller: _otpController,
                keyboardType: TextInputType.number,
                animationType: AnimationType.fade,
                enableActiveFill: true,
                autoDisposeControllers: false,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 45.h,
                  fieldWidth: 45.w,
                  inactiveColor: Colors.white,
                  activeFillColor: Colors.white,
                  selectedFillColor: Colors.transparent,
                  inactiveFillColor: Colors.transparent,
                  activeColor: Colors.amber,
                ),
                animationDuration: const Duration(milliseconds: 200),
                onChanged: (_) {},
                onCompleted: (value) {},
              ),

              // ---------- Timer Text ----------
              Text(
                _isExpired
                    ? 'Code expired!'
                    : 'Code expires in: $_formattedTime',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                    color: _isExpired ? Colors.red : Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              SizedBox(height: 18.h),

              // ---------- Continue Button ----------
              SizedBox(
                height: 44.h,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: _verifyOtp,
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

              // ---------- Back to Login ----------
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 40.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.white, width: 2.w),
                  ),
                  child: Center(
                    child: Text(
                      'Back to login',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              // ---------- Resend OTP ----------
              RichText(
                text: TextSpan(
                  text: "Didn’t receive any code?",
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                  children: [
                    TextSpan(
                      text: _isExpired ? '  Resend' : '  Wait...',
                      style: TextStyle(
                        color: _isExpired ? Colors.amber : Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      recognizer: _isExpired
                          ? (TapGestureRecognizer()
                            ..onTap = () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('OTP Resent!'),
                                  backgroundColor: Colors.amber,
                                ),
                              );
                              _startTimer();
                            })
                          : null,
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