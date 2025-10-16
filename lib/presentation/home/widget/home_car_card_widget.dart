import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCarCardWidget extends StatelessWidget {
  const HomeCarCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = 1.sh; // sh = screen height
    final screenWidth = 1.sw; // sw = screen width

    double childAspectRatioValue;
    if (screenHeight >= 1000) {
      childAspectRatioValue = 2.3 / 3; // বড় screen এর জন্য
    } else {
      childAspectRatioValue = 2.5 / 4; // ছোট screen এর জন্য
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ALL',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              'See More',
              style: GoogleFonts.montserrat(
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductError) {
                  return Center(child: Text(''));
                } else if (state is FetchCard) {
                  return Expanded(
                    // Add Expanded here
                    child: GridView.builder(
                      shrinkWrap:
                          true, // Shrink the GridView to fit the content
                      physics:
                          NeverScrollableScrollPhysics(), // Disable scrolling within GridView
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 18.h,
                        childAspectRatio: childAspectRatioValue,
                      ),
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        final item = state.data[index];
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.2),
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF2E2C2A),
                                Color(0xFF131313),
                                Color(0xFF1D1D20),
                              ],
                              stops: [0.0, 0.5, 1.0],
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(13.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.carName,
                                  style: GoogleFonts.montserrat(
                                    color: Colors.grey,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  maxLines: 1, // এক লাইনের বেশি হলে কেটে দেবে
                                  overflow: TextOverflow
                                      .ellipsis, // শেষের দিকে ... দেখাবে
                                ),
                                Text(
                                  item.carCondition,
                                  style: GoogleFonts.montserrat(
                                    textStyle: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      foreground: Paint()
                                        ..shader =
                                            const LinearGradient(
                                              colors: [
                                                Color(0xFFE7BE00),
                                                Color.fromARGB(
                                                  255,
                                                  255,
                                                  255,
                                                  255,
                                                ),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.topRight,
                                            ).createShader(
                                              Rect.fromLTWH(0, 0, 200, 20),
                                            ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  height: 105.h,
                                  width: 130.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.black,
                                  ),
                                  child: Image.asset(AssetsPath.cardtire),
                                ),
                                SizedBox(height: 6.h),
                                Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      left: 105.w,
                                      bottom: 0,
                                      child: Image.asset(AssetsPath.cardbtn),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'PRICE',
                                          style: GoogleFonts.montserrat(
                                            textStyle: TextStyle(
                                              fontSize: 10.sp,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '32.60',
                                              style: GoogleFonts.montserrat(
                                                textStyle: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w600,
                                                  foreground: Paint()
                                                    ..shader =
                                                        const LinearGradient(
                                                          colors: [
                                                            Color(0xFF5BB349),
                                                            Colors.white,
                                                          ],
                                                          begin:
                                                              Alignment.topLeft,
                                                          end: Alignment
                                                              .topRight,
                                                        ).createShader(
                                                          Rect.fromLTWH(
                                                            0,
                                                            0,
                                                            200,
                                                            20,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ],
    );
  }
}
