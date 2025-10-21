import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerAccount extends StatelessWidget {
  const SellerAccount({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = 1.sh; // total screen height

    double containerHeight = screenHeight <= 1000.h ? 150 : 120.h;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            // overflow fix
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Seller Account',
                  style: GoogleFonts.montserrat(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),

                SizedBox(height: 20.h),

                buildSellerCard(
                  height: containerHeight,
                  image: AssetsPath.upload,
                  title: 'Upload Product',
                  subtitle: 'Add new products to your store inventory',
                ),

                SizedBox(height: 20.h),

                buildSellerCard(
                  height: containerHeight,
                  image: AssetsPath.addnewcat,
                  title: 'Add New Category',
                  subtitle: 'Create and organize product categories',
                ),

                SizedBox(height: 20.h),

                buildSellerCard(
                  height: containerHeight,
                  image: AssetsPath.myproduct,
                  title: 'My Products',
                  subtitle: 'View and manage your existing products',
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
    required String image,
    required String title,
    required String subtitle,
  }) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white54, width: 1.3),
        borderRadius: BorderRadius.circular(12.r),
        color: const Color(0xFF373737),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(image, height: 40.h),
                SizedBox(height: 12.h),
                Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.montserrat(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.green, size: 26.sp),
          ],
        ),
      ),
    );
  }
}
