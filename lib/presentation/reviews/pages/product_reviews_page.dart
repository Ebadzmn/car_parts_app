import 'package:car_parts_app/core/coreWidget/appBar_widget.dart';
import 'package:car_parts_app/presentation/reviews/controllers/product_reviews_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class ProductReviewsPage extends StatefulWidget {
  final String productId;

  const ProductReviewsPage({super.key, required this.productId});

  @override
  State<ProductReviewsPage> createState() => _ProductReviewsPageState();
}

class _ProductReviewsPageState extends State<ProductReviewsPage> {
  late final ProductReviewsController _controller;

  @override
  void initState() {
    super.initState();
    // Use tag to isolate instances if multiple are opened
    _controller = Get.put(ProductReviewsController(), tag: widget.productId);
    _controller.fetchReviews(widget.productId);
  }

  @override
  void dispose() {
    Get.delete<ProductReviewsController>(tag: widget.productId);
    super.dispose();
  }

  Widget _buildShimmerGrid() {
    return ListView.builder(
      itemCount: 5,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[800]!,
            highlightColor: Colors.grey[600]!,
            child: Container(
              height: 100.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildStars(int rating) {
    final List<Widget> stars = [];
    for (int i = 0; i < 5; i++) {
      if (i < rating) {
        stars.add(const Icon(Icons.star, color: Colors.amber, size: 16));
      } else {
        stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 16));
      }
    }
    return stars;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: const Appbar_widget(title: 'Product Reviews'),
            ),
            Expanded(
              child: Obx(() {
                if (_controller.isLoading.value) {
                  return _buildShimmerGrid();
                }

                if (_controller.isEmpty.value) {
                  return Center(
                    child: Text(
                      'No reviews available',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                if (_controller.hasError.value) {
                  return Center(
                    child: Text(
                      'Error loading reviews',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  itemCount: _controller.reviews.length,
                  itemBuilder: (context, index) {
                    final review = _controller.reviews[index];
                    final dateStr = DateFormat('dd MMM yyyy').format(review.createdAt);

                    return Container(
                      margin: EdgeInsets.only(bottom: 16.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1D1D20),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: Colors.grey.withOpacity(0.3)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                review.userId.name,
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                dateStr,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            children: _buildStars(review.rating),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            review.comment.isNotEmpty ? review.comment : 'No comment provided.',
                            style: GoogleFonts.montserrat(
                              fontSize: 13.sp,
                              color: Colors.white70,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
