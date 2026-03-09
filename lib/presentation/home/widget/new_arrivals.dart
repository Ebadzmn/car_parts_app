import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/presentation/home/bloc/new_arrivals_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class NewArrivalsWidget extends StatelessWidget {
  final String title;
  const NewArrivalsWidget({super.key, required this.title});

  // Helper function for condition gradient colors
  List<Color> getGradientColors(String condition) {
    switch (condition.toLowerCase()) {
      case "new":
        return [Colors.green, Colors.white];
      case "used":
        return [Colors.red, Colors.white];
      case "refurb":
        return [const Color(0xFFE7BE00), Colors.white];
      default:
        return [const Color(0xFFE7BE00), Colors.white];
    }
  }

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
    return GestureDetector(
      onTap: () {
        context.push(
          AppRoutes.detailsScreen,
          extra: {'productId': item.id, 'product': item},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1.2),
          borderRadius: BorderRadius.circular(20.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF2E2C2A), Color(0xFF131313), Color(0xFF1D1D20)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Title
              Text(
                item.title,
                style: GoogleFonts.montserrat(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.grey,
                  color: Colors.grey,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              /// Brand
              Text(
                item.brand,
                style: GoogleFonts.montserrat(
                  fontSize: 10.sp,
                  color: Colors.white70,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              /// Condition gradient text
              Text(
                item.condition,
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: getGradientColors(item.condition),
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 20)),
                ),
              ),

              SizedBox(height: 8.h),

              /// Image
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.black,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: item.mainImage.isNotEmpty
                        ? Image.network(
                            item.mainImage,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              AssetsPath.cardtire,
                              fit: BoxFit.contain,
                            ),
                          )
                        : Image.asset(AssetsPath.cardtire, fit: BoxFit.contain),
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              /// PRICE + DISCOUNT + RATING
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PRICE',
                          style: GoogleFonts.montserrat(
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '\$${item.price.toStringAsFixed(2)}',
                          style: GoogleFonts.montserrat(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            foreground: Paint()
                              ..shader =
                                  const LinearGradient(
                                    colors: [Color(0xFF5BB349), Colors.white],
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                  ).createShader(
                                    const Rect.fromLTWH(0, 0, 200, 20),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Discount badge
                  if (item.discount > 0)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '-${item.discount}%',
                        style: GoogleFonts.montserrat(
                          fontSize: 9.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  SizedBox(width: 4.w),
                  // Rating
                  if (item.averageRating > 0)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14.sp),
                        SizedBox(width: 2.w),
                        Text(
                          item.averageRating.toStringAsFixed(1),
                          style: GoogleFonts.montserrat(
                            fontSize: 10.sp,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
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
