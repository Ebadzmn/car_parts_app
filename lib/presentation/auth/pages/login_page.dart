import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/coreWidget/custom_loading_dialog.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:car_parts_app/data/model/auth/sign_In_model.dart';
import 'package:car_parts_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:car_parts_app/presentation/userProfile/bloc/user_profile_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final isChecked = ValueNotifier(false);

    Future<void> handleBackNavigation() async {
      if (context.canPop()) {
        context.pop();
      } else {
        context.go(AppRoutes.MainScreen);
      }
    }


    void signIn() {
      if (!formKey.currentState!.validate()) return;

      context.read<AuthBloc>().add(
            SignInEvent(
              signInModel: SignInModel(
                email: emailController.text.trim(),
                password: passwordController.text,
              ),
            ),
          );
    }

    return WillPopScope(
      onWillPop: () async {
        await handleBackNavigation();
        return false;
      },
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showCustomLoadingDialog(context, message: 'Logging in...');
          } else {
            // Dismiss the loading dialog
            if (Navigator.canPop(context)) Navigator.pop(context);

            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is SignInSuccess) {
              context.read<UserProfileBloc>().add(const GetUserProfileEvent());

              final from = Uri.decodeComponent(
                GoRouterState.of(context).uri.queryParameters['from'] ?? '',
              );

              if (from.isNotEmpty) {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop(); // Close login page
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final rootContext = rootNavigatorKey.currentContext;
                  if (rootContext != null) {
                    rootContext.push(from);
                  }
                });
              } else {
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop(); // Close login page
                } else {
                  context.go(AppRoutes.MainScreen);
                }
              }
            }
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(18.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: handleBackNavigation,
                      icon: const Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: Colors.white,
                      ),
                    ),
                    Center(
                      child: Image.asset(
                        AssetsPath.newLogo,
                        width: 150.w,
                        height: 150.h,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: emailController,
                            label: 'Email',
                            hintText: 'Please enter your email address',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address';
                              } else if (!RegExp(
                                r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                              ).hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          CustomTextField(
                            controller: passwordController,
                            label: 'Password',
                            hintText: 'Please enter your Password',
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: isChecked,
                            builder: (context, value, child) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: value,
                                        onChanged: (newValue) {
                                          isChecked.value = newValue ?? false;
                                        },
                                      ),
                                      Text(
                                        'Remember Me',
                                        style: GoogleFonts.montserrat(
                                          textStyle: const TextStyle(
                                            color: Colors.white,
                                          ),
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
                            },
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
                              onPressed: signIn,
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
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                  ),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
