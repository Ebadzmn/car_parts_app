import 'package:car_parts_app/presentation/home/widget/appbar_widget.dart';
import 'package:car_parts_app/presentation/home/widget/drawer_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_button_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_car_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = 1.sh; // sh = screen height
    final screenWidth = 1.sw; // sw = screen width
    return Scaffold(
      // ✅ Add Drawer here
      drawer: DrawerWidget(),

      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                AppBarWidget(), // You can add a menu icon here to open drawer
                SizedBox(height: 24.h),
                searchWidget(),
                SizedBox(height: 24.h),
                HomeCardWidget(),
                SizedBox(height: 12.h),
                HomeButtonWidget(),
                HomeCarCardWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
