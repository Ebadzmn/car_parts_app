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
                height: 300.h, // responsive height
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  bloc.add(CaroselPageChanged(index));
                },
              ),
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
                  size = 18.w; // selected dot
                } else if (distance == 1) {
                  size = 14.w; // next to selected
                } else if (distance == 2) {
                  size = 10.w; // next to next
                } else {
                  size = 8.w; // smallest
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
