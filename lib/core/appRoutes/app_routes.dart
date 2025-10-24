import 'package:car_parts_app/presentation/auth/pages/login_page.dart';
import 'package:car_parts_app/presentation/auth/pages/otp_page.dart';
import 'package:car_parts_app/presentation/auth/pages/signup_page.dart';
import 'package:car_parts_app/presentation/details/pages/car_details_page.dart';
import 'package:car_parts_app/presentation/home/pages/home_page.dart';
import 'package:car_parts_app/presentation/home/pages/steppar_wids.dart';
import 'package:car_parts_app/presentation/onboard/pages/onboard_page.dart';
import 'package:car_parts_app/presentation/onboard/pages/onboardv2.dart';
import 'package:car_parts_app/presentation/splash/page/splash_screen.dart';
import 'package:car_parts_app/presentation/uploadProduct/pages/custom_stepper_page.dart';
import 'package:car_parts_app/presentation/uploadProduct/pages/step_forms.dart';
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
}


final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.OnboardPage,
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
    child: const LoginPage(),
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
    child: const SignupPage(),
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
    child: const OtpPage(),
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

