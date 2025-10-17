import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPages extends StatelessWidget {
  const CategoryPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: GoogleFonts.montserrat(
                  fontSize: 16.sp,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 20.h),

              searchWidget(),

              SizedBox(height: 16.h),

              Container(
                height: 100.h,
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.yellow, width: 1.w),

                  boxShadow: [
                    BoxShadow(
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: Offset(0, 1),
                      color: Colors.grey,
                    ),

                    BoxShadow(
                      blurRadius: 1,
                      spreadRadius: 0,
                      offset: Offset(2, 2),
                      color: Color(0xFF5F615E),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 48.h,
                      width: 48.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.yellow, width: 1.w),
                      ),
                      child: Icon(
                        Icons.category_outlined,
                        size: 28.sp,
                        color: Colors.yellow,
                      ),
                    ),

                    SizedBox(height: 6.h),
                    Text(
                      'Engine Parts',
                      style: GoogleFonts.montserrat(
                        fontSize: 12.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
