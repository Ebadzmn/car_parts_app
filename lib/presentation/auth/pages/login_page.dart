import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
   LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ValueNotifier<bool> isChecked = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsPath.logo),
            Padding(
              padding: EdgeInsets.all(18.sp),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: emailController,
                      label: 'Email',
                      hintText: 'Please enter your email address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                   
                    CustomTextField(
                      controller: passwordController,
                      label: 'Password',
                      hintText: 'Please enter your Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                
                
                    ValueListenableBuilder<bool>(valueListenable: isChecked, builder: (context , value , child) {
                      return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(value: value, onChanged: (newValue) {
                              isChecked.value = newValue ?? false;
                            }),
                            Text(
                              'Remember Me',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            context.push(AppRoutes.forgetPassword);
                          },
                          child: Text(
                            'Forget Password',
                            style: GoogleFonts.montserrat(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    );
                    }),
                
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
                          if (_formKey.currentState!.validate()) {
                            context.push(AppRoutes.homeScreen);
                          }
                        },
                        child: Text(
                          'Login',
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
                        text: "Don't have an account? ",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(color: Colors.white),
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: const TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.push(AppRoutes.RegisterPage);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
