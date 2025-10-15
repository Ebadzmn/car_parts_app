import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/home/widget/appbar_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_button_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_car_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              children: [
                SizedBox(height: 24.h),
                AppBarWidget(),
                SizedBox(height: 24.h),
                searchWidget(),
                SizedBox(height: 24.h),
                HomeCardWidget(),
                SizedBox(height: 20.h),
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
