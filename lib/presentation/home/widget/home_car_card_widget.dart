import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeCarCardWidget extends StatelessWidget {
  final String title;
  const HomeCarCardWidget({super.key, required this.title});

  // Helper function
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
                  context.push(AppRoutes.ProductByCategoryScreen);
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
                            colors: [
                              Color(0xFF2E2C2A),
                              Color(0xFF131313),
                              Color(0xFF1D1D20),
                            ],
                            stops: [0.0, 0.5, 1.0],
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product title
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

                              // Product condition
                              Text(
                                item.condition,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  foreground: Paint()
                                    ..shader =
                                        LinearGradient(
                                          colors: getGradientColors(
                                            item.condition,
                                          ),
                                          begin: Alignment.topLeft,
                                          end: Alignment.topRight,
                                        ).createShader(
                                          const Rect.fromLTWH(0, 0, 200, 20),
                                        ),
                                ),
                              ),

                              SizedBox(height: 8.h),

                              // Product image
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
                                            errorBuilder: (_, __, ___) =>
                                                Image.asset(
                                                  AssetsPath.cardtire,
                                                  fit: BoxFit.contain,
                                                ),
                                          )
                                        : Image.asset(
                                            AssetsPath.cardtire,
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 8.h),

                              // Price section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  colors: [
                                                    Color(0xFF5BB349),
                                                    Colors.white,
                                                  ],
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.topRight,
                                                ).createShader(
                                                  const Rect.fromLTWH(
                                                    0,
                                                    0,
                                                    200,
                                                    20,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    AssetsPath.cardbtn,
                                    width: 30.w,
                                    height: 30.h,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
