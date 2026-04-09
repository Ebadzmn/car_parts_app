import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/presentation/details/widget/carosel_widget.dart';
import 'package:car_parts_app/presentation/details/widget/rating_pop_up_widget.dart';
import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:car_parts_app/presentation/details/widget/selectTab_widget.dart';

class CarDetailsPage extends StatelessWidget {
  final String productId;
  final ProductModel? product;
  const CarDetailsPage({super.key, required this.productId, this.product});

  @override
  Widget build(BuildContext context) {
    // Dispatch fetch once if in initial state
    final detailsState = context.watch<DetailsBloc>().state;
    if (detailsState.status == DetailsStatus.initial) {
      Future.microtask(
        () =>
            context.read<DetailsBloc>().add(GetProductDetailsEvent(productId)),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocBuilder<DetailsBloc, DetailsState>(
          builder: (context, state) {
            // ── Loading ──
            if (state.status == DetailsStatus.loading) {
              return _buildShimmer();
            }

            // ── Error ──
            if (state.status == DetailsStatus.failure) {
              return _buildError(
                state.errorMessage ?? 'Failed to load product',
                context,
              );
            }

            // ── Success ──
            final product = state.product;

            final List<String> carImages =
                (product != null && product.galleryImages.isNotEmpty)
                ? product.galleryImages.map((p) => _fullImageUrl(p)).toList()
                : (product?.mainImage != null && product!.mainImage!.isNotEmpty)
                ? [_fullImageUrl(product.mainImage!)]
                : [AssetsPath.cardtire];

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Top row: back + title ──
                    Row(
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
                              onPressed: () => context.pop(),
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            product?.title ?? 'Product Details',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontSize: 16.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // ── Action icons ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            final selId =
                                context
                                    .read<DetailsBloc>()
                                    .state
                                    .product
                                    ?.seller
                                    .id ??
                                '';
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: 'Report Popup',
                              barrierColor: Colors.black.withOpacity(0.4),
                              transitionDuration: const Duration(
                                milliseconds: 300,
                              ),
                              pageBuilder:
                                  (
                                    dialogContext,
                                    animation,
                                    secondaryAnimation,
                                  ) {
                                    return ReportPopup(
                                      productId: productId,
                                      sellerId: selId,
                                    );
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
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: 'Rating Popup',
                              barrierColor: Colors.black.withOpacity(0.4),
                              transitionDuration: const Duration(
                                milliseconds: 300,
                              ),
                              pageBuilder:
                                  (
                                    dialogContext,
                                    animation,
                                    secondaryAnimation,
                                  ) {
                                    return RatingPopUpWidget(
                                      productId: productId,
                                    );
                                  },
                            );
                          },
                          child: Image.asset(
                            AssetsPath.wish1,
                            height: 24.h,
                            width: 24.h,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Image.asset(
                          AssetsPath.favourite,
                          height: 24.h,
                          width: 24.h,
                        ),
                      ],
                    ),

                    SizedBox(height: 12.h),

                    // ── Carousel ──
                    CaroselWidget(carImages: carImages),
                    SizedBox(height: 16.h),

                    // ── Title / Brand / Condition badge ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product?.title?.toUpperCase() ?? 'PRODUCT',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.montserrat(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                product?.brand ?? '',
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
                            gradient: LinearGradient(
                              colors: _conditionGradient(
                                product?.condition ?? 'new',
                              ),
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: const [0.6, 2.0],
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            (product?.condition ?? 'new')
                                .toString()
                                .toUpperCase(),
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

                    // ── Description ──
                    Text(
                      product?.description ?? '',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),

                    SizedBox(height: 20.h),

                    // ── Price / Discount Section ──
                    _buildPriceSection(
                      product?.price ?? 0,
                      product?.discount ?? 0,
                    ),

                    _buildDivider(),

                    // ── Rating Section ──
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 20),
                        SizedBox(width: 8.w),
                        Text(
                          'Product Rating',
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
                      children: [
                        ..._buildStars(product?.averageRating ?? 0),
                        SizedBox(width: 8.w),
                        Text(
                          '${product?.averageRating?.toStringAsFixed(1) ?? '0.0'}',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '(${product?.totalRatings ?? 0} ratings)',
                          style: GoogleFonts.montserrat(
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // ── Show Reviews Button ──
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push(
                            AppRoutes.reviewScreen,
                            extra: productId,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1D1D20),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.star_half, color: Colors.amber),
                            SizedBox(width: 10.w),
                            Text(
                              'Show Reviews',
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    _buildDivider(),

                    // ── Specifications ──
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
                    _buildSpecRow('Brand', product?.brand ?? '-'),
                    SizedBox(height: 18.h),
                    _buildSpecRow('Category', product?.category ?? '-'),
                    SizedBox(height: 18.h),
                    _buildSpecRow(
                      'Chassis Number',
                      product?.chassisNumber ?? '-',
                    ),
                    SizedBox(height: 18.h),
                    _buildSpecRow('Warranty', product?.warranty ?? '-'),

                    _buildDivider(),

                    // ── Compatible Car Models (Chips) ──
                    Row(
                      children: [
                        const Icon(
                          Icons.directions_car,
                          color: Colors.green,
                          size: 20,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Compatible Car Models',
                          style: GoogleFonts.montserrat(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    if (product != null && product.carModels.isNotEmpty)
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: product.carModels
                            .map(
                              (model) => Chip(
                                backgroundColor: const Color(0xFF1D1D20),
                                side: const BorderSide(color: Colors.grey),
                                label: Text(
                                  model,
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      )
                    else
                      Text(
                        'No compatible models listed',
                        style: GoogleFonts.montserrat(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),

                    _buildDivider(),

                    // ── Seller Info ──
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
                    _buildSpecRow('Seller Name', product?.seller.name ?? '-'),
                    SizedBox(height: 12.h),
                    _buildSpecRow(
                      'WhatsApp',
                      product?.seller.whatsappNumber.isNotEmpty == true
                          ? product!.seller.whatsappNumber
                          : '-',
                    ),
                    SizedBox(height: 12.h),
                    _buildSpecRow(
                      'Address',
                      product?.seller.address.isNotEmpty == true
                          ? product!.seller.address
                          : '-',
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Seller Rating',
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${product?.sellerRating?.toStringAsFixed(1) ?? '0.0'}',
                              style: GoogleFonts.montserrat(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // ── Chat with WhatsApp ──
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _launchWhatsApp('01869943362'),
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

                    // ── Find seller ──
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

  // ── PRICE SECTION ──
  Widget _buildPriceSection(double price, int discount) {
    if (discount > 0) {
      final discountedPrice = price - (price * discount / 100);
      return Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          children: [
            Text(
              '\$${price.toStringAsFixed(2)}',
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.grey,
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                '$discount% OFF',
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              '\$${discountedPrice.toStringAsFixed(2)}',
              style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Color(0xFF5BB349), Colors.white],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 20)),
              ),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Text(
            'PRICE',
            style: GoogleFonts.montserrat(fontSize: 12.sp, color: Colors.grey),
          ),
          SizedBox(width: 10.w),
          Text(
            '\$${price.toStringAsFixed(2)}',
            style: GoogleFonts.montserrat(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              foreground: Paint()
                ..shader = const LinearGradient(
                  colors: [Color(0xFF5BB349), Colors.white],
                ).createShader(const Rect.fromLTWH(0, 0, 200, 20)),
            ),
          ),
        ],
      ),
    );
  }

  // ── STAR ICONS ──
  List<Widget> _buildStars(double rating) {
    final int fullStars = rating.floor();
    final bool hasHalf = (rating - fullStars) >= 0.5;
    final List<Widget> stars = [];
    for (int i = 0; i < fullStars && i < 5; i++) {
      stars.add(const Icon(Icons.star, color: Colors.amber, size: 18));
    }
    if (hasHalf && stars.length < 5) {
      stars.add(const Icon(Icons.star_half, color: Colors.amber, size: 18));
    }
    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: Colors.amber, size: 18));
    }
    return stars;
  }

  // ── DIVIDER ──
  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Container(
        height: 1.h,
        width: double.infinity,
        color: Colors.grey.withOpacity(0.3),
      ),
    );
  }

  // ── SPEC ROW ──
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
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.montserrat(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // ── ERROR ──
  Widget _buildError(String message, BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 14.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton.icon(
              onPressed: () => context.read<DetailsBloc>().add(
                GetProductDetailsEvent(productId),
              ),
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: Text(
                'Retry',
                style: GoogleFonts.montserrat(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── SHIMMER LOADING ──
  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[850]!,
      highlightColor: Colors.grey[700]!,
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Row(
              children: [
                _shimmerCircle(30),
                SizedBox(width: 10.w),
                _shimmerBox(150, 16),
              ],
            ),
            SizedBox(height: 24.h),
            // Image placeholder
            _shimmerBox(double.infinity, 220),
            SizedBox(height: 16.h),
            // Title
            _shimmerBox(200, 20),
            SizedBox(height: 8.h),
            _shimmerBox(120, 14),
            SizedBox(height: 20.h),
            // Description lines
            _shimmerBox(double.infinity, 12),
            SizedBox(height: 6.h),
            _shimmerBox(double.infinity, 12),
            SizedBox(height: 6.h),
            _shimmerBox(200, 12),
            SizedBox(height: 20.h),
            // Price
            _shimmerBox(160, 22),
            SizedBox(height: 20.h),
            // Spec rows
            for (int i = 0; i < 5; i++) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_shimmerBox(80, 14), _shimmerBox(100, 14)],
              ),
              SizedBox(height: 16.h),
            ],
            // Buttons
            _shimmerBox(double.infinity, 44),
            SizedBox(height: 10.h),
            _shimmerBox(double.infinity, 44),
          ],
        ),
      ),
    );
  }

  Widget _shimmerBox(double width, double height) {
    return Container(
      width: width,
      height: height.h,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8.r),
      ),
    );
  }

  Widget _shimmerCircle(double size) {
    return Container(
      width: size.h,
      height: size.h,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        shape: BoxShape.circle,
      ),
    );
  }

  // ── WHATSAPP LAUNCH ──
  Future<void> _launchWhatsApp(String phone) async {
    if (phone.isEmpty) return;
    final cleaned = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse('https://wa.me/$cleaned');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  // ── IMAGE URL HELPER ──
  String _fullImageUrl(String path) {
    if (path.startsWith('http')) return path;
    // Prepend your API base if paths are relative
    return path;
  }

  // ── CONDITION GRADIENT ──
  List<Color> _conditionGradient(String condition) {
    switch (condition.toLowerCase()) {
      case 'new':
        return [Colors.green, Colors.white];
      case 'used':
        return [Colors.red, Colors.white];
      case 'refurbished':
        return [const Color(0xFFE7BE00), Colors.white];
      default:
        return [Colors.red, Colors.white];
    }
  }
}
