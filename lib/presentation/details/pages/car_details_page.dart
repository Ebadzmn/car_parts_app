import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/injector/injector.dart' as di;
import 'package:car_parts_app/data/model/product/product_details_model.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:car_parts_app/presentation/details/widget/carosel_widget.dart';
import 'package:car_parts_app/presentation/details/widget/rating_pop_up_widget.dart';
import 'package:car_parts_app/presentation/details/widget/selectTab_widget.dart';
import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CarDetailsPage extends StatelessWidget {
  final String productId;
    final ProductModel? product; // or ProductModel type you have
  const CarDetailsPage({super.key, required this.productId, this.product});

  @override
  Widget build(BuildContext context) {
    // Dispatch fetch once if in initial state
    final detailsState = context.watch<DetailsBloc>().state;
    if (detailsState.status == DetailsStatus.initial) {
      Future.microtask(() => context.read<DetailsBloc>().add(GetProductDetailsEvent(productId)));
    }

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            // handle loading / failure first
            if (state.status == DetailsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == DetailsStatus.failure) {
              return _buildError(state.errorMessage ?? 'Something went wrong', context);
            }

            // success or other -> try to show product or fallback UI
            final product = state.product;
            // prepare images list: use galleryImages if available else fallback assets
            final List<String> carImages = (product != null &&
                    product.galleryImages != null &&
                    product.galleryImages!.isNotEmpty)
                ? product.galleryImages!.map((p) => _fullImageUrl(p)).toList()
                : [
                    AssetsPath.cardtire,
                    AssetsPath.cardtire,
                    AssetsPath.cardtire,
                    AssetsPath.cardtire,
                  ];

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Top row: back + title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.h,
                          width: 30.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 0,
                                spreadRadius: 1,
                                offset: const Offset(0, 1),
                                color: Colors.grey,
                              ),
                              BoxShadow(
                                blurRadius: 1,
                                spreadRadius: 1,
                                offset: const Offset(2, 2),
                                color: const Color(0xFF373737),
                              ),
                            ],
                          ),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                context.pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          product?.title ?? 'Product Details',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // action icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                              final productDetailsUsecase = di.sl<ProductDetailsUsecase>();
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: 'Report Popup',
                              barrierColor: Colors.black.withOpacity(0.4),
                              transitionDuration: const Duration(milliseconds: 300),
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return ReportPopup(usecase: productDetailsUsecase);
                              },
                            );
                          },
                          child: Image.asset(
                            AssetsPath.caution,
                            height: 24.h,
                            width: 24.h,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        GestureDetector(
                         onTap: () {
                          final productDetailsUsecase = di.sl<ProductDetailsUsecase>();
                          // <- make sure this context is under MultiProvider
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Report Popup',
    barrierColor: Colors.black.withOpacity(0.4),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) {
      return RatingPopUpWidget(usecase: productDetailsUsecase);
    },
  );
},

                          child: Image.asset(AssetsPath.wish1, height: 24.h, width: 24.h),
                        ),
                        SizedBox(width: 8.w),
                        Image.asset(AssetsPath.favourite, height: 24.h, width: 24.h),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // Carousel
                    CaroselWidget(carImages: carImages),
                    SizedBox(height: 16.h),

                    // Title / Brand / Condition badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                            product?.title?.toUpperCase() ?? 'OEM FRONT TIRE',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis, // ... দেখাবে শেষে
                            style: GoogleFonts.montserrat(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          
                              SizedBox(height: 6.h),
                              Text(
                                product?.brand ?? 'Toyota Corolla',
                                style: GoogleFonts.montserrat(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8.w),
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.red, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.6, 2.0],
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            (product?.condition ?? 'new').toString().toUpperCase(),
                            style: GoogleFonts.montserrat(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // description
                    Text(
                      product?.description ??
                          'High-quality OEM replacement front bumper for Toyota Corolla. Perfect fit and finish.',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      child: Container(
                        height: 1.h,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),

                    // Specifications header
                    Row(
                      children: [
                        Image.asset(
                          AssetsPath.specification,
                          width: 24.w,
                          height: 24.w,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Specifications',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    _buildSpecRow('Brand', product?.brand ?? 'Toyota'),
                    SizedBox(height: 18.h),
                    _buildSpecRow('Car Model', (product?.carModels != null && product!.carModels!.isNotEmpty) ? product.carModels!.join(', ') : 'Toyota 2021'),
                    SizedBox(height: 18.h),
                    _buildSpecRow('Chassis Number', product?.chassisNumber ?? '4UDH876G5F6H7'),
                    SizedBox(height: 18.h),
                    _buildSpecRow('Category', product?.category ?? 'Car Parts'),
                    SizedBox(height: 18.h),
                    _buildSpecRow('Warranty', product?.warranty ?? '6 Months'),

                    SizedBox(height: 16.h),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      child: Container(
                        height: 1.h,
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                    ),

                    // Seller info
                    Row(
                      children: [
                        const Icon(Icons.person_outline, color: Colors.green),
                        SizedBox(width: 12.w),
                        Text(
                          'Seller Information',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                           
                              product?.seller?.name ?? 'Shakhawat Hossain',
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Verified Seller',
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_border_outlined,
                                  color: Colors.yellow,
                                  size: 16,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  (product?.averageRating?.toStringAsFixed(1) ?? '0.0'),
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              'Ratings & Reviews',
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // Chat button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.chat_bubble, color: Colors.white),
                            SizedBox(width: 10.w),
                            Text(
                              'Chat with WhatsApp',
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10.h),

                    // Find seller
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search, color: Colors.black),
                            SizedBox(width: 10.w),
                            Text(
                              'Find The Seller',
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSpecRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildError(String message, BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: GoogleFonts.montserrat(fontSize: 14.sp, color: Colors.white)),
            SizedBox(height: 12.h),
            ElevatedButton(
              onPressed: () => context.read<DetailsBloc>().add(GetProductDetailsEvent(productId)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  String _fullImageUrl(String path) {
    const base = 'https://api.example.com'; // change to your base url
    if (path.startsWith('http')) return path;
    if (path.startsWith('/')) return '$base$path';
    return '$base/$path';
  }
}
