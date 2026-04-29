import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/presentation/home/bloc/new_arrivals_bloc.dart';
import 'package:car_parts_app/presentation/home/controllers/main_screen_controller.dart';
import 'package:car_parts_app/presentation/home/widget/appbar_widget.dart';
import 'package:car_parts_app/presentation/home/widget/becomev2.dart';

import 'package:car_parts_app/presentation/home/widget/home_button_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_car_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/new_arrivals.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<NewArrivalsBloc>()
            ..add(const FetchNewArrivalsRequested(limit: '6')),
      child: Scaffold(
        body: Stack(
          children: [
            // 🔹 Main Scrollable Content
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 10.sp,
                  right: 10.sp,
                  top: 10.sp,
                  bottom: 120.h,
                ),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    const AppBarWidget(),
                    SizedBox(height: 24.h),
                    SearchWidget(
                      onTap: () {
                        if (Get.isRegistered<MainScreenController>()) {
                          Get.find<MainScreenController>().changeTabIndex(1);
                        }
                      },
                    ),
                    SizedBox(height: 24.h),
                    HomeCardWidget(),
                    SizedBox(height: 24.h),

                    HomeButtonWidget(),
                    SizedBox(height: 24.h),
                    HomeCarCardWidget(title: 'All'),

                    SizedBox(height: 12.h),
                    BecomeSellerCardWidget(),
                    const NewArrivalsWidget(title: 'NEW ARRIVALS'),
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
