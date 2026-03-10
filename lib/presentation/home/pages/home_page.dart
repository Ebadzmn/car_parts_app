import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/presentation/home/bloc/new_arrivals_bloc.dart';
import 'package:car_parts_app/presentation/home/widget/appbar_widget.dart';
import 'package:car_parts_app/presentation/home/widget/becomev2.dart';
import 'package:car_parts_app/presentation/home/widget/drawer_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_button_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_car_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/home_card_widget.dart';
import 'package:car_parts_app/presentation/home/widget/new_arrivals.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<NewArrivalsBloc>()
            ..add(const FetchNewArrivalsRequested(limit: '6')),
      child: Scaffold(
        drawer: DrawerWidget(),
        body: Stack(
          children: [
            // 🔹 Main Scrollable Content
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(10.sp),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    const AppBarWidget(),
                    SizedBox(height: 24.h),
                    const SearchWidget(),
                    SizedBox(height: 24.h),
                    HomeCardWidget(),
                    SizedBox(height: 24.h),

                    HomeButtonWidget(),
                    SizedBox(height: 24.h),
                    HomeCarCardWidget(title: 'All'),

                    SizedBox(height: 12.h),
                    BecomeSellerCardWidget(),
                    SizedBox(height: 20.h),
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
