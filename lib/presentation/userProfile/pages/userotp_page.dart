import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UserotpPage extends StatefulWidget {
  const UserotpPage({super.key});

  @override
  State<UserotpPage> createState() => _UserotpPageState();
}

class _UserotpPageState extends State<UserotpPage> {
  int _secondsRemaining = 180;
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
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        setState(() {
          _isExpired = true;
        });
        timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void _resendOtp() {
    if (!_isExpired) {
      return;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('OTP Resent!')));
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),

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
                    SizedBox(width: 10.w),
                    Text(
                      'Basic Information Change',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 120.h),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 60.h,
                        width: 60.w,
                        decoration: BoxDecoration(
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
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
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

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.w,
                          vertical: 10.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: _isExpired ? Colors.redAccent : Colors.amber,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 18.sp,
                              color: _isExpired
                                  ? Colors.redAccent
                                  : Colors.amber,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              _isExpired
                                  ? 'Code expired!'
                                  : 'Code expires in: $_formattedTime',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: _isExpired
                                      ? Colors.redAccent
                                      : Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
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

                      SizedBox(height: 12.h),

                      RichText(
                        text: TextSpan(
                          text: "Don’t receive any code?",
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                            ),
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
                                  ? (TapGestureRecognizer()..onTap = _resendOtp)
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
