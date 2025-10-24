import 'package:car_parts_app/presentation/auth/pages/forget_password.dart';
import 'package:car_parts_app/presentation/auth/pages/login_page.dart';
import 'package:car_parts_app/presentation/auth/pages/otp_page.dart';
import 'package:car_parts_app/presentation/auth/pages/set_new_password.dart';
import 'package:car_parts_app/presentation/auth/pages/set_otp_pass.dart';
import 'package:car_parts_app/presentation/auth/pages/signup_page.dart';
import 'package:car_parts_app/presentation/details/pages/car_details_page.dart';
import 'package:car_parts_app/presentation/home/pages/home_page.dart';
import 'package:car_parts_app/presentation/onboard/pages/onboardv2.dart';
import 'package:car_parts_app/presentation/splash/page/splash_screen.dart';
import 'package:car_parts_app/presentation/uploadProduct/pages/custom_stepper_page.dart';
import 'package:car_parts_app/presentation/userProfile/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splashScreen = '/splash-screen';
  static const String homeScreen = '/home-screen';
  static const String detailsScreen = '/details-screen';
  static const String reportScreen = '/report-screen';
  static const String userProfileScreen = '/user-profile-screen';
   static const String uploadProductScreen = '/upload-product-screen';
   static const String LoginPage = '/login-page';
   static const String RegisterPage = '/register-page';
   static const String OtpPage = '/otp-page'; 
   static const String OnboardPage = '/onboard-page'; 
   static const String set_new_password = '/set-new-password'; 
   static const String forgetPassword = '/forget-password'; 
   static const String setOtpPassword = '/set-otp-password'; 
}


final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.setOtpPassword,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),

        GoRoute(
      path: AppRoutes.OnboardPage,
      builder: (context, state) => const Onboardv2(),
    ),

    GoRoute(
      path: AppRoutes.homeScreen,
      builder: (context, state) => const HomePage(),
    ),

    GoRoute(
  path: AppRoutes.detailsScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: CarDetailsPage(carImages: []),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

 GoRoute(
  path: AppRoutes.userProfileScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: const UserProfile(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

GoRoute(
  path: AppRoutes.uploadProductScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: const CustomHorizontalStepperPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

GoRoute(
  path: AppRoutes.LoginPage,
  pageBuilder: (context, state) => CustomTransitionPage(
    child:  LoginPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

GoRoute(
  path: AppRoutes.RegisterPage,
  pageBuilder: (context, state) => CustomTransitionPage(
    child:  SignupPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

GoRoute(
  path: AppRoutes.OtpPage,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: OtpPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

GoRoute(
  path: AppRoutes.set_new_password,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: SetnewPassword(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

GoRoute(
  path: AppRoutes.forgetPassword,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: ForgetPassword(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

GoRoute(
  path: AppRoutes.setOtpPassword,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: SetOtpPass(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),
  ],
);

