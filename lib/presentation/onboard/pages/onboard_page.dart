import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/onboard/bloc/onboard_bloc.dart';
import 'package:car_parts_app/presentation/onboard/widgets/onb_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OnboardBloc, OnboardState>(
        builder: (context, state) {
          if (state is OnboardLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is OnboardLoad) {
            // Use PageController initialized with currentPage from state
            final PageController pageController = PageController(
              initialPage: state.currentPage,
            );

            final item = state.data[state.currentPage];

            return BlocListener<OnboardBloc, OnboardState>(
              listener: (context, state) {
                if (state is OnboardLoad) {
                  pageController.animateToPage(
                    state.currentPage,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(item.image, fit: BoxFit.cover),
                  ),
                  // Black opacity layer from bottom to 440 height
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 500.h, // Set height to 440 from bottom
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(
                              0.99,
                            ), // Darker black at the bottom
                            Colors.black.withOpacity(
                              0.1,
                            ), // Fading to transparent at the top
                          ],
                          begin: Alignment
                              .bottomCenter, // Gradient starts from the bottom
                          end: Alignment.topCenter, // Gradient goes to the top
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    // Positioning text over image and opacity layer
                    bottom: 80.h, // Adjust as per your requirement
                    left: 20.w, // Adjust for left alignment if needed
                    right: 20.w, // Adjust for right alignment if needed
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Center the text horizontally
                      children: [
                        Text(
                          item.title,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors
                                  .white, // Text color for better visibility
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h), // Space between the texts
                        Text(
                          item.desc,
                          textAlign: TextAlign.left,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 34.h),
                        OnbBtnWidget(pageController: pageController)
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is OnboardError) {
            return Center(child: Text(state.message));
          }
          return SizedBox();
        },
      ),
    );
  }
}
