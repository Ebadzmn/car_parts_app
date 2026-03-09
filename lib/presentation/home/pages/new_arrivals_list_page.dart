import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/presentation/home/bloc/new_arrivals_bloc.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class NewArrivalsListPage extends StatelessWidget {
  const NewArrivalsListPage({super.key});

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

    return BlocProvider(
      create: (_) =>
          NewArrivalsBloc(productUsecase: sl())
            ..add(const FetchNewArrivalsRequested(limit: '10')),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                // ═══ App Bar ═══
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                              color: Colors.grey,
                            ),
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(2, 2),
                              color: Color(0xFF373737),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'New Arrivals',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                const SearchWidget(),

                // ═══ Products Grid ═══
                Expanded(
                  child: BlocBuilder<NewArrivalsBloc, NewArrivalsState>(
                    builder: (context, state) {
                      // ── Loading ──
                      if (state is NewArrivalsLoading) {
                        return _buildShimmerGrid(screenWidth);
                      }

                      // ── Error ──
                      if (state is NewArrivalsError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.message,
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16.h),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<NewArrivalsBloc>().add(
                                    const FetchNewArrivalsRequested(
                                      limit: '10',
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: Text(
                                  'Retry',
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      // ── Loaded ──
                      if (state is NewArrivalsLoaded) {
                        final products = state.products;

                        if (products.isEmpty) {
                          return Center(
                            child: Text(
                              'No new arrivals available',
                              style: GoogleFonts.montserrat(
                                color: Colors.grey,
                                fontSize: 14.sp,
                              ),
                            ),
                          );
                        }

                        int crossAxisCount = screenWidth < 600
                            ? 2
                            : screenWidth < 900
                            ? 3
                            : 4;
                        double childAspectRatio = screenWidth < 600
                            ? 2 / 2.9
                            : 2.2 / 3.2;

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent - 200) {
                              if (!state.isLoadingMore &&
                                  !state.hasReachedMax) {
                                context.read<NewArrivalsBloc>().add(
                                  FetchMoreNewArrivalsRequested(),
                                );
                              }
                            }
                            return false;
                          },
                          child: CustomScrollView(
                            slivers: [
                              SliverPadding(
                                padding: EdgeInsets.only(top: 20.h),
                                sliver: SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      if (index >= products.length) {
                                        return state.isLoadingMore
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              )
                                            : const SizedBox();
                                      }

                                      final item = products[index];
                                      return _buildProductCard(context, item);
                                    },
                                    childCount:
                                        products.length +
                                        (state.isLoadingMore ? 1 : 0),
                                  ),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: crossAxisCount,
                                        crossAxisSpacing: 10.w,
                                        mainAxisSpacing: 10.h,
                                        childAspectRatio: childAspectRatio,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
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
  Widget _buildShimmerGrid(double screenWidth) {
    int crossAxisCount = screenWidth < 600
        ? 2
        : screenWidth < 900
        ? 3
        : 4;
    double childAspectRatio = screenWidth < 600 ? 2 / 2.9 : 2.2 / 3.2;

    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          childAspectRatio: childAspectRatio,
        ),
        itemCount: 6,
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
