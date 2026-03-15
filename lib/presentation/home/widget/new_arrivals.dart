import 'package:car_parts_app/core/appRoutes/app_routes.dart';

import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/presentation/home/bloc/new_arrivals_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:car_parts_app/core/coreWidget/reusable_product_card_widget.dart';

class NewArrivalsWidget extends StatelessWidget {
  final String title;
  const NewArrivalsWidget({super.key, required this.title});

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
          /// ===== HEADER =====
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
                  context.push(AppRoutes.NewArrivalsListScreen);
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

          SizedBox(height: 15.h),

          /// ===== BlocBuilder =====
          BlocBuilder<NewArrivalsBloc, NewArrivalsState>(
            builder: (context, state) {
              // ── Loading ──
              if (state is NewArrivalsLoading) {
                return _buildShimmerGrid(crossAxisCount, childAspectRatio);
              }

              // ── Error ──
              if (state is NewArrivalsError) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Column(
                      children: [
                        Text(
                          state.message,
                          style: GoogleFonts.montserrat(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
                        ElevatedButton(
                          onPressed: () {
                            context.read<NewArrivalsBloc>().add(
                              const FetchNewArrivalsRequested(limit: '6'),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            'Retry',
                            style: GoogleFonts.montserrat(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              // ── Loaded ──
              if (state is NewArrivalsLoaded) {
                final products = state.products;

                if (products.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Center(
                      child: Text(
                        'No new arrivals available',
                        style: GoogleFonts.montserrat(
                          color: Colors.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  );
                }

                // Show limited items on home (first 6)
                final displayProducts = products.length > 6
                    ? products.sublist(0, 6)
                    : products;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.w,
                    vertical: 10.h,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                    childAspectRatio: childAspectRatio,
                  ),
                  itemCount: displayProducts.length,
                  itemBuilder: (context, index) {
                    final item = displayProducts[index];
                    return _buildProductCard(context, item);
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

  /// ===== Product Card =====
  Widget _buildProductCard(BuildContext context, ProductEntity item) {
    return ReusableProductCardWidget(
      item: item,
      onTap: () {
        context.push(
          AppRoutes.detailsScreen,
          extra: {'productId': item.id, 'product': item},
        );
      },
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
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: 4,
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
