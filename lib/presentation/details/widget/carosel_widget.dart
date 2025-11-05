import 'package:car_parts_app/presentation/details/bloc/details_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CaroselWidget extends StatelessWidget {
  const CaroselWidget({super.key, required this.carImages});

  final List<String> carImages;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        final bloc = context.read<DetailsBloc>();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                CarouselSlider(
                  items: carImages
                      .map(
                        (imagePath) => Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.6.w),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                  options: CarouselOptions(
                    height: 300.h,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    onPageChanged: (index, reason) {
                      bloc.add(CaroselPageChanged(index));
                    },
                  ),
                ),

                /// ⭐ Rating over image
                Positioned(
                  top: 15.h,
                  right: 25.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.grey, width: 1.6.w),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow, size: 18.sp),
                        SizedBox(width: 4.w),
                        Text(
                          "4.5",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            // 🔵 Indicator Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: carImages.asMap().entries.map((entry) {
                final index = entry.key;
                final distance = (state.currentIndex - index).abs();

                double size;
                if (distance == 0) {
                  size = 18.w;
                } else if (distance == 1) {
                  size = 14.w;
                } else if (distance == 2) {
                  size = 10.w;
                } else {
                  size = 8.w;
                }

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                  width: size,
                  height: 6.h,
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  decoration: BoxDecoration(
                    color: distance == 0
                        ? Colors.grey
                        : Colors.grey.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}
