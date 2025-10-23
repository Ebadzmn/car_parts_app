import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:car_parts_app/presentation/home/widget/drug_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeCardWidget extends StatelessWidget {
  const HomeCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Container(
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.sp),
            boxShadow: [
              BoxShadow(
                blurRadius: 0,
                offset: Offset(-1, 0),
                spreadRadius: 1,
                color: Colors.white38,
              ),

              BoxShadow(
                blurRadius: 1,
                offset: Offset(1, 2),
                spreadRadius: 0,
                color: Color(0xFF373737),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 15.w, top: 20.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 136.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(92.r),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0,
                            offset: const Offset(-1, 0),
                            spreadRadius: 0,
                            color: Colors.white54,
                          ),
                          BoxShadow(
                            blurRadius: 2,
                            offset: const Offset(1, 1),
                            spreadRadius: 0,
                            color: const Color(0xFF5B5B5B),
                          ),
                          BoxShadow(
                            blurRadius: 0,
                            offset: const Offset(2, 2),
                            spreadRadius: 0,
                            color: const Color(0xFF5B5B5B),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent, // shadow remove
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(92.r),
                          ),
                          padding: EdgeInsets.zero, // important!
                          minimumSize: Size(
                            double.infinity,
                            double.infinity,
                          ), // fills container
                        ),
                        onPressed: () {},
                        child: Center(
                          // ensures vertical + horizontal centering
                          child: Text(
                            'Premium Product',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              fontSize: 10.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              height: 1, // text vertical alignment fix
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 18.h),
                    Text(
                      'Engine',
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    SizedBox(
                      width: 140.w,
                      child: Text(
                        'Engine is the science of delivering power.',
                        style: GoogleFonts.montserrat(
                          fontSize: 10.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Container(
                      height: 50.h,
                      width: 140.w,
                      child: DragButtonWidget())         
                    ],
                ),
                Image.asset(AssetsPath.heroparts, height: 170.h, width: 170.w),
              ],
            ),
          ),
        );
      },
    );
  }
}
