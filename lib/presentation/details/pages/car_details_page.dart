import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:car_parts_app/presentation/details/widget/carosel_widget.dart';
import 'package:car_parts_app/presentation/details/widget/rating_pop_up_widget.dart';
import 'package:car_parts_app/presentation/details/widget/selectTab_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CarDetailsPage extends StatelessWidget {
  const CarDetailsPage({super.key, required List<String> carImages});

  @override
  Widget build(BuildContext context) {
    final List<String> carImages = [
      AssetsPath.cardtire,
      AssetsPath.cardtire,
      AssetsPath.cardtire,
      AssetsPath.cardtire,
      AssetsPath.cardtire,
      AssetsPath.cardtire,
      AssetsPath.cardtire,
      AssetsPath.cardtire,
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      'Change Contact',
                      style: GoogleFonts.montserrat(
                        fontSize: 16.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
  onTap: () {
showGeneralDialog(
  context: context,
  barrierDismissible: true,
  barrierLabel: 'Form Popup',
  barrierColor: Colors.black.withOpacity(0.4),
  transitionDuration: const Duration(milliseconds: 300),
  pageBuilder: (context, animation, secondaryAnimation) {
    return const ReportPopup();
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
  barrierLabel: 'Form Popup',
  barrierColor: Colors.black.withOpacity(0.4),
  transitionDuration: const Duration(milliseconds: 300),
  pageBuilder: (context, animation, secondaryAnimation) {
    return const RatingPopUpWidget();
  },
);
                      },
                      child: Image.asset(AssetsPath.wish1, height: 24.h, width: 24.h,)),
                    SizedBox(width: 8.w),
                    Image.asset(AssetsPath.favourite, height: 24.h, width: 24.h,),
                  ],
                ),

                SizedBox(height: 12.h),
                CaroselWidget(carImages: carImages),
                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'OEM FRONT TIRE',
                          style: GoogleFonts.montserrat(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'Toyota Corolla',
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ],
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
                        'New',
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

                Text(
                  'High-quality OEM replacement front bumper for Toyota Corolla. Perfect fit and finish with all mounting hardware included. Features impact-resistant ABS plastic construction with primer finish ready for painting.',
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

                _buildSpecRow('Brand', 'Toyota'),
                SizedBox(height: 18.h),
                _buildSpecRow('Car Model', 'Toyota 2021'),
                SizedBox(height: 18.h),
                _buildSpecRow('Chassis Number', '4UDH876G5F6H7'),
                SizedBox(height: 18.h),
                _buildSpecRow('Category', 'Car Parts'),
                SizedBox(height: 18.h),
                _buildSpecRow('Warranty', '6 Months'),

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
                          'Shakhawat Hossain',
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
                              '4.8',
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
              ],
            ),
          ),
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
}
