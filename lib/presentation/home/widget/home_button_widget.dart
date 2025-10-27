import 'package:car_parts_app/data/data_source/local/car_local_datasource.dart';
import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButtonWidget extends StatelessWidget {
  const HomeButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final allProducts = CarLocalDatasource.getProduct();
    final categories = allProducts.map((e) => e.carCategory).toSet().toList();
    categories.insert(0, 'All');

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        String selectedCategory = 'All';
        if (state is FetchCard && state.currentCategory != null) {
          selectedCategory = state.currentCategory!;
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
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: categories.map((category) {
                      final isSelected = category == selectedCategory;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.r),
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 2)
                                : null,
                            color: isSelected
                                ? Color(0xFFE7BE00)
                                : Colors.transparent,
                            boxShadow: isSelected
                                ? [] // 🔹 No shadow when selected
                                : [
                                    BoxShadow(
                                      blurRadius: 0,
                                      spreadRadius: 2,
                                      offset: Offset(0, 0),
                                      color: Colors.grey,
                                    ),
                                    BoxShadow(
                                      blurRadius: 1,
                                      spreadRadius: 2,
                                      offset: Offset(2, 2),
                                      color: Color(0xFF373737),
                                    ),


                                    // BoxShadow(
                                    //   blurRadius: 0,
                                    //   spreadRadius: 2,
                                    //   offset: Offset(0, 0),
                                    //   color: Colors.grey,
                                    // ),
                                    // BoxShadow(
                                    //   blurRadius: 1,
                                    //   spreadRadius: 1,
                                    //   offset: Offset(2, 2),
                                    //   color: Color(0xFF373737),
                                    // ),
                                  ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            onPressed: () {
                              if (category == 'All') {
                                context.read<HomeBloc>().add(FetchCardEvent());
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
}
