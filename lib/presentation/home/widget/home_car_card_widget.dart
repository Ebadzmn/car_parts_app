import 'package:car_parts_app/core/appRoutes/app_routes.dart';

import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:car_parts_app/core/coreWidget/reusable_product_card_widget.dart';
import 'package:car_parts_app/presentation/home/controllers/main_screen_controller.dart';

class HomeCarCardWidget extends StatelessWidget {
  final String title;
  const HomeCarCardWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final screenWidth = 1.sw;
    int crossAxisCount = screenWidth < 600
        ? 2
        : screenWidth < 900
        ? 3
        : 3;

    double childAspectRatio = screenWidth < 600 ? 2 / 2.9 : 2.2 / 3.2;

    return SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ======= Header Row =======
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.italic,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Get.isRegistered<MainScreenController>()) {
                    Get.find<MainScreenController>().changeTabIndex(1);
                  }
                },
                child: Text(
                  'See More',
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),

          // ======= BlocBuilder =======
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return _buildShimmerGrid(crossAxisCount, childAspectRatio);
              } else if (state is ProductError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Text(
                      'Error loading products',
                      style: GoogleFonts.montserrat(color: Colors.white),
                    ),
                  ),
                );
              } else if (state is FetchCard) {
                if (state.data.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                      child: Text(
                        'No product found',
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.w,
                    vertical: 20.h,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    final item = state.data[index];

                    return ReusableProductCardWidget(
                      item: item,
                      onTap: () {
                        context.push(
                          AppRoutes.detailsScreen,
                          extra: {'productId': item.id, 'product': item},
                        );
                      },
                    );
                  },
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  /// ===== Shimmer Loading Grid =====
  Widget _buildShimmerGrid(int crossAxisCount, double childAspectRatio) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: 2, // Show 6 skeleton placeholders for a smaller loading area
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20.r),
            ),
          );
        },
      ),
    );
  }
}
