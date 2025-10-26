import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/presentation/category/bloc/category_bloc.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class CategoryPages extends StatelessWidget {
  const CategoryPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: GoogleFonts.montserrat(
                  fontSize: 20.sp,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),

              const SearchWidget(),
              SizedBox(height: 16.h),

              Expanded(
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    /// 🟡 Shimmer while loading
                    if (state is CategoryLoading) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade800,
                        highlightColor: Colors.grey.shade600,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16.w,
                                mainAxisSpacing: 16.h,
                                childAspectRatio: 1.5,
                              ),
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 120.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.yellow,
                                  width: 1.w,
                                ),
                                color: Colors.black.withOpacity(0.2),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Container(
                                    height: 14.h,
                                    width: 80.w,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    }
                    /// ✅ Category Loaded
                    else if (state is CategoryLoaded) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16.w,
                          mainAxisSpacing: 16.h,
                          childAspectRatio: 1.5,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          final category = state.products[index];
                          return GestureDetector(
                            onTap: () {
                              context.push(
                                AppRoutes.ProductByCategoryScreen,
                              );
                            },
                            child: Container(
                              height: 120.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: Colors.yellow,
                                  width: 1.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 2.r,
                                    spreadRadius: 1.r,
                                    offset: Offset(0, 1.h),
                                    color: Colors.grey,
                                  ),
                                  BoxShadow(
                                    blurRadius: 2.r,
                                    spreadRadius: 0,
                                    offset: Offset(2.w, 2.h),
                                    color: const Color(0xFF5F615E),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 60.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.yellow,
                                        width: 1.w,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.category_outlined,
                                      size: 32.sp,
                                      color: Colors.yellow,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    category.carCategory,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14.sp,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    /// 🔴 Error State
                    else if (state is CategoryError) {
                      return Center(
                        child: Text(
                          state.message,
                          style: GoogleFonts.montserrat(
                            fontSize: 14.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
