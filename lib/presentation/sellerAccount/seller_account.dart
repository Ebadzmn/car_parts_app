import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerAccount extends StatelessWidget {
  const SellerAccount({super.key});

  @override
  Widget build(BuildContext context) {
    final width = 1.sw;

    // ✅ Device size logic
    bool isTablet = width > 600; // tablet/ipad detection

    // Different height for mobile and tablet
    double cardHeight = isTablet ? 150.h : 115.h;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller Account',
                  style: GoogleFonts.montserrat(
                    fontSize: isTablet ? 28.sp : 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                SizedBox(height: 20.h),

                buildSellerCard(
                  height: cardHeight,
                  width: width,
                  image: AssetsPath.upload,
                  title: 'Upload Product',
                  subtitle: 'Add new products to your store inventory',
                  isTablet: isTablet,
                ),

                SizedBox(height: 20.h),

                buildSellerCard(
                  height: cardHeight,
                  width: width,
                  image: AssetsPath.addnewcat,
                  title: 'Add New Category',
                  subtitle: 'Create and organize product categories',
                  isTablet: isTablet,
                ),

                SizedBox(height: 20.h),

                buildSellerCard(
                  height: cardHeight,
                  width: width,
                  image: AssetsPath.myproduct,
                  title: 'My Products',
                  subtitle: 'View and manage your existing products',
                  isTablet: isTablet,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSellerCard({
    required double height,
    required double width,
    required String image,
    required String title,
    required String subtitle,
    required bool isTablet,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54, width: 1.2.w),
        borderRadius: BorderRadius.circular(14.r),
        color: const Color(0xFF373737),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Image.asset(image, height: isTablet ? 50.h : 32.h, fit: BoxFit.contain),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.montserrat(
                            fontSize: isTablet ? 18.sp : 14.5.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.montserrat(
                            fontSize: isTablet ? 13.sp : 11.5.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios,
                color: Colors.green, size: isTablet ? 28.sp : 22.sp),
          ],
        ),
      ),
    );
  }
}
