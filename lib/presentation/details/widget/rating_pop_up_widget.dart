import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:car_parts_app/presentation/details/widget/rating_star_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RatingPopUpWidget extends StatelessWidget {
  const RatingPopUpWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          height: screenHeight >= 1024 ? 350.h : 300.h,
          width: 330.w,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF202020),
                Color(0xFF373737),
                Color(0xFF202020),
              ],
              stops: [0.0, 0.5, 1.0],
            ),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Rate the product ?', style: GoogleFonts.montserrat(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),),
                SizedBox(height: 12.h),

                RatingStars(
                  maxRating: 5,
                  iconSize: 40.0,
                  onRatingChanged: (rating) {
                    // Handle rating change here
                  },
                ),

              SizedBox(height: 12.h),

              CustomTextField(label: 'Write a review', hintText: 'Write a review' , maxLines: 3, ),

              Container(
                    height: 34.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: Colors.amber,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Submit',
                        style: GoogleFonts.montserrat(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),



            ],
          ),
        ),
      ),
    );
  }
}

