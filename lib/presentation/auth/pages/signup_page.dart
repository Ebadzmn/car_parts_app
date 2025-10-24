import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isChecked = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 34.h),
              Image.asset(AssetsPath.logo),
              Padding(
                padding: EdgeInsets.all(18.sp),
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Full Name',
                      hintText: 'Please enter your full name',
                    ),
                  
                    CustomTextField(
                      label: 'Email',
                      hintText: 'Please enter your email address',
                    ),
                    

                    CustomTextField(
                      label: 'Address (Optional)',
                      hintText: 'Please enter your Address',
                    ),
                    

                    CustomTextField(
                      label: 'Password',
                      hintText: 'Please enter your Password',
                    ),
                

                    CustomTextField(
                      label: 'Confirm Password',
                      hintText: 'Please enter your Confirm Password',
                    ),
                   

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: isChecked, onChanged: (bool) {}),
                            Text(
                              'By creating an account or signing you agree to our \n Terms and Conditions',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9.sp,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 12.r),

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
                        onPressed: () {
                          context.push(AppRoutes.OtpPage);
                        },
                        child: Text(
                          'Sign Up',
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
                                  const SnackBar(
                                    content: Text('Sign Up tapped!'),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 60.h),
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
