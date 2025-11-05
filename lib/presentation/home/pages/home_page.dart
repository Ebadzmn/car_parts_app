import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/coreWidget/bottom_nav_widget.dart';
import 'package:car_parts_app/presentation/home/widget/become_a_seller.dart';
import 'package:car_parts_app/presentation/home/widget/appbar_widget.dart';
import 'package:car_parts_app/presentation/home/widget/becomev2.dart';
import 'package:car_parts_app/presentation/home/widget/bottom_nav_widget.dart';
import 'package:car_parts_app/presentation/home/widget/drawer_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_button_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_car_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/new_arrivals.dart';
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
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     // systemNavigationBarColor: Colors.amber,
    //     // statusBarColor: Colors.amber,
    //     statusBarIconBrightness: Brightness.light,
    //   ),
    // );

    return Scaffold(
     
      drawer:  DrawerWidget(),
      body: Stack(
        children: [
          // 🔹 Main Scrollable Content
          SingleChildScrollView(
            padding: EdgeInsets.all(10.sp),
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
                HomeCarCardWidget(title: 'ALLS',),
                BecomeSellerCardWidget(),
                // SellerCardWidget(),
                SizedBox(height: 20.h), 
                NewArrivalsWidget(title: 'NEW ARRIVALS',),
        // spacing under navbar
              ],
            ),
          ),

          // 🔹 Floating Bottom Bar OVER the content
          // NavBarWidget(screenWidth: screenWidth),
          
        ],
      ),
    );
  }
}
