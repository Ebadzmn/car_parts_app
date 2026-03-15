import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableProductCardWidget extends StatelessWidget {
  final ProductEntity item;
  final VoidCallback onTap;

  const ReusableProductCardWidget({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(20.r),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2E2C2A),
              Color(0xFF131313),
              Color(0xFF1D1D20),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Text(
                item.condition,
                style: GoogleFonts.montserrat(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: getGradientColors(
                        item.condition,
                      ),
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
              SizedBox(height: 8.h),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.black,
                  ),
                  child: (item.mainImage.isNotEmpty)
                      ? Image.network(
                          item.mainImage,
                          fit: BoxFit.contain,
                          errorBuilder: (
                            context,
                            error,
                            stack,
                          ) =>
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
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
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
                            ..shader = const LinearGradient(
                              colors: [
                                Color(0xFF5BB349),
                                Color(0xFFFFFFFF),
                              ],
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
  }
}

/// Gradient helper for product condition text
List<Color> getGradientColors(String condition) {
  switch (condition.toLowerCase()) {
    case 'new':
      return const [Color(0xFF00FF87), Color(0xFF60EFFF)];
    case 'used':
      return const [Color(0xFFFFC371), Color(0xFFFF5F6D)];
    case 'refurbished':
      return const [Color(0xFF8E2DE2), Color(0xFF4A00E0)];
    default:
      return const [Colors.white, Colors.grey];
  }
}
