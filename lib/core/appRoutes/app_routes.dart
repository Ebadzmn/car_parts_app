import 'package:car_parts_app/data/model/product/product_details_model.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/presentation/about/about_page.dart';
import 'package:car_parts_app/presentation/auth/pages/forget_password.dart';
import 'package:car_parts_app/presentation/auth/pages/login_page.dart';
import 'package:car_parts_app/presentation/auth/pages/otp_page.dart';
import 'package:car_parts_app/presentation/auth/pages/set_new_password.dart';
import 'package:car_parts_app/presentation/auth/pages/set_otp_pass.dart';
import 'package:car_parts_app/presentation/auth/pages/signup_page.dart';
import 'package:car_parts_app/presentation/category/pages/add_new_category.dart';
import 'package:car_parts_app/presentation/details/pages/car_details_page.dart';
import 'package:car_parts_app/presentation/faqs/pages/faqs_page.dart';
import 'package:car_parts_app/presentation/home/pages/home_page.dart';
import 'package:car_parts_app/presentation/home/pages/main_screen.dart';

import 'package:car_parts_app/presentation/myproduct/myproduct.dart';
import 'package:car_parts_app/presentation/notification/pages/notification_pages.dart';
import 'package:car_parts_app/presentation/onboard/pages/onboardv2.dart';
import 'package:car_parts_app/presentation/privacyPolicy/privacy_policy.dart';
import 'package:car_parts_app/presentation/productByCategory/pages/product_by_category_page.dart';
import 'package:car_parts_app/presentation/sellerAccount/seller_account.dart';
import 'package:car_parts_app/presentation/splash/page/splash_screen.dart';
import 'package:car_parts_app/presentation/tearm_condition/page/tearms_condition.dart';
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
   static const String MainScreen = '/main-screen';
   static const String ProductByCategoryScreen = '/product-by-category-screen';
   static const String DrugBuiltScreen = '/drug-built-screen';
   static const String SellarScreen = '/sellar-screen';
   static const String TestPage = '/test-page';
   static const String FaqsPage = '/faqs-page';
   static const String TearmsConditionScreen = '/tearms-condition-screen';
   static const String PrivacyPolicyScreen = '/privacy-policy-screen';  
      static const String AboutScreen = '/about-screen';  
      static const String AddNewCategoryScreen = '/add-new-category-screen';
      static const String Myproduct = '/myproduct';
      static const String NotificationScreen = '/notification-screen';



}


final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.splashScreen,
      builder: (context, state) => const SplashScreen(),
    ),

    //  GoRoute(
    //   path: AppRoutes.DrugBuiltScreen,
    //   builder: (context, state) => const DrugBuiltWidget(),
    // ),

     

        GoRoute(
      path: AppRoutes.OnboardPage,
      builder: (context, state) => const Onboardv2(),
    ),

    GoRoute(
      path: AppRoutes.MainScreen,
      builder: (context, state) =>  MainScreen(),
    ),

    GoRoute(
      path: AppRoutes.homeScreen,
      builder: (context, state) => const HomePage(),
    ),


GoRoute(
  path: AppRoutes.detailsScreen,
  builder: (context, state) {
    final extra = state.extra;
    // if a map with 'product' exists and it's already a ProductModel, use it
    if (extra is Map && extra['product'] != null) {
      final product = extra['product'];
      return CarDetailsPage(product: product! as ProductModel, productId: product.id,); // pass model directly
    }
    // otherwise try to extract id (string or map id) as fallback
    final id = extra is String
        ? extra
        : extra is Map
            ? (extra['productId'] ?? extra['id'] ?? '').toString()
            : state.pathParameters['id'] ?? '';
    return CarDetailsPage(productId: id);
  },
),


//     GoRoute(
//   path: AppRoutes.detailsScreen,
//   pageBuilder: (context, state) => CustomTransitionPage(
//     child: CarDetailsPage(productId: state.extra as String? ?? ''),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return FadeTransition(
//         opacity: animation,
//         child: child,                         
//       );
//     },
//   ),
// ),

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
  path: AppRoutes.Myproduct,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: const MyProductPage(),
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
  pageBuilder: (context, state) {
    
    final email = state.extra as String? ?? '';

    return CustomTransitionPage(
      key: state.pageKey,
      child: OtpPage( email: email, ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  },
),


GoRoute(
  path: AppRoutes.AboutScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: AboutEPartsPage(),
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
  path: AppRoutes.TearmsConditionScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: TermsCondition(),
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
  path: AppRoutes.PrivacyPolicyScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: PrivacyPolicyPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),


GoRoute(
  path: AppRoutes.SellarScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: SellerAccount(),
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

GoRoute(
  path: AppRoutes.ProductByCategoryScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: ProductByCategoryPage(
      category: state.extra as String?,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

GoRoute(
  path: AppRoutes.NotificationScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: NotificationPages(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),

GoRoute(
  path: AppRoutes.FaqsPage,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: FaqsPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  ),
),


GoRoute(
  path: AppRoutes.AddNewCategoryScreen,
  pageBuilder: (context, state) => CustomTransitionPage(
    child: AddNewCategory(),
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

