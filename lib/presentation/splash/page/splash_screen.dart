import 'dart:async';
import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double progress = 0;
  bool _blast = false;
  Timer? _timer;
  late AnimationController _blastController;
  late Animation<double> _blastAnimation;

  @override
  void initState() {
    super.initState();
    _startLoading();

    // Initialize blast animation controller
    _blastController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Animate scale from 0 to a large value to ensure full-screen coverage
    _blastAnimation = Tween<double>(begin: 0.0, end: 5.0).animate(
      CurvedAnimation(parent: _blastController, curve: Curves.easeOutExpo),
    );
  }

  void _startLoading() {
    const duration = Duration(milliseconds: 30);
    double step = 100 / (3000 / 30); // 3 seconds total

    _timer = Timer.periodic(duration, (timer) {
      if (progress < 100) {
        setState(() {
          progress += step;
          if (progress > 100) progress = 100;
        });
      } else {
        timer.cancel();
        _triggerBlast();
      }
    });
  }

  Future<void> _triggerBlast() async {
    setState(() => _blast = true);

    // Start the yellow circle expansion
    _blastController.forward();

    // Wait till blast completes (~700ms)
    await Future.delayed(const Duration(milliseconds: 700));

    // Navigate directly to HomePage with fade transition
    if (mounted) {
      context.push(AppRoutes.homeScreen );
      // Navigator.pushReplacement(
      //   context,
      //   PageRouteBuilder(
      //     transitionDuration: const Duration(milliseconds: 800),
      //     pageBuilder: (_, animation, __) =>
      //         FadeTransition(opacity: animation, child: const HomePage()),
      //   ),
      // );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _blastController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
    
      // Ignore safe area to allow full-screen expansion
      body: SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Loading bar and text
            if (!_blast)
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AssetsPath.logo,
                    width: 150.w,
                    height: 150.h,
                  ),
                  // const Text(
                  //   "My Awesome App",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 28,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3),
                  SizedBox(height: 20.h),
                  Center(
                    child: Container(
                      width: screenWidth * 0.6,
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: screenWidth * 0.6 * (progress / 100),
                          height: 8.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.amber, Colors.lightGreenAccent],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  
                ],
              ),

            // Full-screen yellow circle with scale animation
            if (_blast)
              AnimatedBuilder(
  animation: _blastAnimation,
  builder: (context, child) {
    return Positioned.fill(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Yellow animated circle
            Transform.scale(
              scale: _blastAnimation.value,
              child: Container(
                width: screenWidth,
                height: screenWidth,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Logo on top
            Positioned(
              top: screenWidth * 0.1, // প্রয়োজন অনুযায়ী স্থানান্তর করতে পারেন
              child: Image.asset(
                AssetsPath.logo, // আপনার logo path
                width: 150.w,         // size adjust করতে পারেন
                height: 150.h,
              ),
            ),
          ],
        ),
      ),
    );
  },
),

          ],
        ),
      ),
    );
  }
}

