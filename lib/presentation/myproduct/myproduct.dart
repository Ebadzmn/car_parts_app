import 'package:car_parts_app/core/appRoutes/app_routes.dart';

import 'package:car_parts_app/core/coreWidget/appBar_widget.dart';
import 'package:car_parts_app/presentation/myproduct/controllers/my_products_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:car_parts_app/core/coreWidget/reusable_product_card_widget.dart';

class MyProductPage extends StatefulWidget {
  const MyProductPage({super.key});

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  late final MyProductsController _controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = Get.put(MyProductsController());
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _controller.fetchMoreMyProducts();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    Get.delete<MyProductsController>();
    super.dispose();
  }

  Widget _buildShimmerGrid(double screenWidth, int crossAxisCount, double childAspectRatio) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[800]!,
          highlightColor: Colors.grey[600]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = 1.sw;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Appbar_widget(title: 'My Products'),
              ),
              Expanded(
                child: Obx(() {
                  // Grid setup
                  int crossAxisCount = screenWidth < 600 ? 2 : 3;
                  double childAspectRatio = screenWidth < 600 ? 2 / 3.4 : 2.2 / 3.4;

                  if (_controller.isLoading.value) {
                    return _buildShimmerGrid(screenWidth, crossAxisCount, childAspectRatio);
                  }

                  if (_controller.isEmpty.value) {
                    return Center(
                      child: Text(
                        'No products uploaded yet',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  if (_controller.hasError.value && _controller.products.isEmpty) {
                    return Center(
                      child: Text(
                        'Error loading products',
                        style: GoogleFonts.montserrat(
                          fontSize: 14.sp,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount: _controller.products.length,
                          itemBuilder: (context, index) {
                            final item = _controller.products[index];

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
                        ),
                      ),
                      if (_controller.isMoreLoading.value)
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const CircularProgressIndicator(color: Colors.green),
                        ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
