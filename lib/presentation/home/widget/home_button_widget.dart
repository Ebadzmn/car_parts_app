import 'package:car_parts_app/presentation/category/bloc/category_bloc.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = 1.sw;
    final bool isTablet = screenWidth > 600;

    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, categoryState) {
        // ── Loading ──
        if (categoryState is CategoryInitial ||
            categoryState is CategoryLoading) {
          return SizedBox(
            height: 100.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        // ── Error ──
        if (categoryState is CategoryError) {
          return SizedBox(
            height: 100.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load categories',
                    style: GoogleFonts.montserrat(
                      color: Colors.white70,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE7BE00),
                    ),
                    onPressed: () {
                      context.read<CategoryBloc>().add(FetchCategoriesEvent());
                    },
                    child: Text(
                      'Retry',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // ── Loaded ──
        if (categoryState is CategoryLoaded) {
          // Build dynamic list: "All" + API category names
          final List<String> categoryNames = [
            'All',
            ...categoryState.categories.map((c) => c.name),
          ];

          return BlocBuilder<HomeBloc, HomeState>(
            builder: (context, homeState) {
              String selectedCategory = 'All';
              if (homeState is FetchCard && homeState.currentCategory != null) {
                selectedCategory = homeState.currentCategory!;
              } else if (homeState is HomeLoading &&
                  homeState.currentCategory != null) {
                selectedCategory = homeState.currentCategory!;
              }

              return SizedBox(
                height: 100.h,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Popular Category',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    SingleChildScrollView(
                      key: const PageStorageKey('home_category_scroll'),
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.h),
                        child: Row(
                          children: categoryNames.map((category) {
                            final isSelected = category == selectedCategory;

                            return Padding(
                              padding: EdgeInsets.symmetric(horizontal: 6.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: isTablet ? 8.h : 2.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.r),
                                  border: isSelected
                                      ? Border.all(
                                          color: Colors.white,
                                          width: 2,
                                        )
                                      : null,
                                  color: isSelected
                                      ? const Color(0xFFE7BE00)
                                      : Colors.transparent,
                                  boxShadow: isSelected
                                      ? []
                                      : [
                                          const BoxShadow(
                                            blurRadius: 0,
                                            spreadRadius: 2,
                                            offset: Offset(0, 0),
                                            color: Colors.grey,
                                          ),
                                          const BoxShadow(
                                            blurRadius: 1,
                                            spreadRadius: 2,
                                            offset: Offset(2, 2),
                                            color: Color(0xFF373737),
                                          ),
                                        ],
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    if (category == 'All') {
                                      context.read<HomeBloc>().add(
                                        FetchCardEvent(),
                                      );
                                    } else {
                                      context.read<HomeBloc>().add(
                                        FetchProductByCategoryEvent(category),
                                      );
                                    }
                                  },
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      category,
                                      style: GoogleFonts.montserrat(
                                        textStyle: TextStyle(
                                          color: isSelected
                                              ? Colors.black
                                              : Colors.white70,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.w600,
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }

        // Fallback
        return const SizedBox.shrink();
      },
    );
  }
}
