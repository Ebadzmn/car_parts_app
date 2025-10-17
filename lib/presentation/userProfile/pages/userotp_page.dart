import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class UserotpPage extends StatelessWidget {
  const UserotpPage({super.key});

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
                        'A six digits code has sanded to your email',
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

                      Text(
                        'Code expires in: 02:59',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
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
                              text: '  Resend',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  // Action when clicked
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Sign Up tapped!'),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
