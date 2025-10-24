import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/home/widget/appbar_widget.dart';
import 'package:car_parts_app/presentation/home/widget/drawer_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_button_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_car_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = 1.sw;

      // 🔹 Make status bar transparent & icons light
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.amber,
        statusBarColor: Colors.amber,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const DrawerWidget(),
      body: Stack(
        children: [
          // 🔹 Main Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                const AppBarWidget(),
                SizedBox(height: 24.h),
                const SearchWidget(),
                SizedBox(height: 24.h),
                const HomeCardWidget(),
                SizedBox(height: 12.h),
                const HomeButtonWidget(),
                const HomeCarCardWidget(),
                SizedBox(height: 120.h), // spacing under navbar
              ],
            ),
          ),

          // 🔹 Floating Bottom Bar OVER the content
          Positioned(
            left: 0,
            right: 0,
            bottom: 16.h, // slightly above bottom edge (floating look)
            child: Center(
              child: Container(
                height: 60.h,
                width: screenWidth * 0.8, // a bit narrower for aesthetic margin
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: const Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0,
                            spreadRadius: 1,
                            offset: Offset(0, 2),
                          ),
                          BoxShadow(
                            color: Color(0xFF1A1A1A),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(AssetsPath.navhome),
                    ),
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0,
                            spreadRadius: 1,
                            offset: Offset(0, 2),
                          ),
                          BoxShadow(
                            color: Color(0xFF1A1A1A),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(AssetsPath.nav2),
                    ),

                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0,
                            spreadRadius: 1,
                            offset: Offset(0, 2),
                          ),
                          BoxShadow(
                            color: Color(0xFF1A1A1A),
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(2, 4),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        AssetsPath.navcat,
                        color: Colors.white,
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        color: Colors.white,
                        border: Border.all(color: Color(0xFFFE9100), width: 2),
                      ),
                      child: Image.asset(
                        AssetsPath.navcart,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
