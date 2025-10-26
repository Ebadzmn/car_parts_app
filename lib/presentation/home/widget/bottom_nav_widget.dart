import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavBarwidget extends StatelessWidget {
  const BottomNavBarwidget({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 16.h, // slightly above bottom edge (floating look)
      child: Center(
        child: Container(
          height: 60.h,
          width: screenWidth * 0.8, // a bit narrower for aesthetic margin
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 0,
                spreadRadius: 1,
                offset: const Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.black,
                blurRadius: 1,
                spreadRadius: 1,
                offset: Offset(2, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Color(0xFF1A1A1A),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Image.asset(AssetsPath.navhome),
              ),
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Color(0xFF1A1A1A),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Image.asset(AssetsPath.nav2),
              ),
    
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: Offset(0, 2),
                    ),
                    BoxShadow(
                      color: Color(0xFF1A1A1A),
                      blurRadius: 1,
                      spreadRadius: 1,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Image.asset(
                  AssetsPath.navcat,
                  color: Colors.white,
                ),
              ),
    
              Container(
                padding: EdgeInsets.all(12.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFFE9100), width: 2),
                ),
                child: Image.asset(
                  AssetsPath.navcart,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
