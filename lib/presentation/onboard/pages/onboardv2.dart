import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/onboard/bloc/onboard_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboardv2 extends StatelessWidget {
  const Onboardv2({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize PageController for PageView
    final PageController pageController = PageController();

    return Scaffold(
      body: BlocBuilder<OnboardBloc, OnboardState>(
        builder: (context, state) {
          if (state is OnboardLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is OnboardError) {
            return Center(child: Text(state.message));
          }
          if (state is OnboardLoad) {
            final items = state.data; // List<OnbEntities>
            final currentPage = state.currentPage;

            return PageView.builder(
              controller: pageController,
              itemCount: items.length,
              physics: NeverScrollableScrollPhysics(),

              onPageChanged: (index) {
                // Dispatch PageChangeEvent to update current page in Bloc
                context.read<OnboardBloc>().add(PageChangeEvent(index));
              },
              itemBuilder: (context, index) {
                final item = items[index];

                return Stack(
                  children: [
                    // Background image
                    Positioned.fill(
                      child: Image.asset(
                        item.image ?? AssetsPath.onBoardImg1,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(width: 120), // Placeholder to maintain layout
                    // Page indicator text
                    // Black opacity layer from bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 500.h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.99),
                              Colors.black.withOpacity(0.1),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ),

                    Positioned(
                      bottom: 270.h,
                      left: 30.w,
                      child: Container(
                        height: 20.h,
                        width: 56.w,
                        decoration: BoxDecoration(
                          
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              spreadRadius: 0,
                              blurRadius: 0,
                              offset: const Offset(1, 3), // Shadow direction
                            ),
                             BoxShadow(
                              color: Colors.black,
                              spreadRadius: 0,
                              blurRadius: 3,
                              offset: const Offset(2, 3), // Shadow direction
                            ),


                          ],
                        ),
                        child: Center(
                          child: Text(
                            textAlign: TextAlign.center,
                            '${index + 1}/${items.length}',
                            style: GoogleFonts.inter(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Text and buttons
                    Positioned(
                      bottom: 70.h,
                      left: 20.w,
                      right: 20.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title ?? 'Default Title',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            item.desc ?? 'Default Description',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.inter(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 34.h),
                          // Navigation buttons
                          // Navigation buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Back Button (only shown if index > 0)
                              if (index > 0)
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 120,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFF5BB349),
                                          width: 4,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 1,
                                      left: 0,
                                      right: 14,
                                      top: 0,
                                      child: Container(
                                        width: 140,
                                        height: 150,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF5BB349),
                                            width: 3,
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (index > 0) {
                                          pageController.previousPage(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            curve: Curves.easeInOut,
                                          );
                                        }
                                      },
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.green,
                                        size: 32,
                                      ),
                                    ),
                                  ],
                                )
                              else
                                const SizedBox(
                                  width: 120,
                                ), // Placeholder to maintain layout
                              // Next / Get Started Button
                              Container(
                                height: 40.h,
                                width: 130.w,
                                decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(66.sp),
                                ),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                  ),
                                  onPressed: () {
                                    if (index < items.length - 1) {
                                      // Navigate to next page
                                      pageController.nextPage(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      // Handle Get Started action
                                      Navigator.pushReplacementNamed(
                                        context,
                                        '/home',
                                      );
                                    }
                                  },
                                  child: Text(
                                    index == items.length - 1
                                        ? 'Get Started'
                                        : 'Next',
                                    style: GoogleFonts.inter(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
