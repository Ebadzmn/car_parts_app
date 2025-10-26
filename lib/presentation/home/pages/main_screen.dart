import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/coreWidget/bloc/navbar_bloc.dart';
import 'package:car_parts_app/core/coreWidget/bloc/navbar_event.dart';
import 'package:car_parts_app/core/coreWidget/bloc/navbar_state.dart';
import 'package:car_parts_app/presentation/category/pages/category_pages.dart';
import 'package:car_parts_app/presentation/details/pages/car_details_page.dart';
import 'package:car_parts_app/presentation/filterProduct/pages/filter_page.dart';
import 'package:car_parts_app/presentation/filterProduct/pages/product_page.dart';
import 'package:car_parts_app/presentation/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> _screens = [
    const HomePage(),
    ProductPage(),
    const CategoryPages(),
    const HomePage(), // Profile or other
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavBloc(),
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          double screenWidth = MediaQuery.of(context).size.width;

          return Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                IndexedStack(
                  index: state.currentIndex,
                  children: _screens,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 16.h,
                  child: Center(
                    child: Container(
                      height: 60.h,
                      width: screenWidth * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 3,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                          const BoxShadow(
                            color: Colors.black,
                            blurRadius: 1,
                            spreadRadius: 1,
                            offset: Offset(2, 4),
                          ),
                        ],
                        color: const Color(0xFF1A1A1A),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _navItem(
                            context,
                            index: 0,
                            currentIndex: state.currentIndex,
                            iconPath: AssetsPath.navhome,
                          ),
                          _navItem(
                            context,
                            index: 1,
                            currentIndex: state.currentIndex,
                            iconPath: AssetsPath.nav2,
                          ),
                          _navItem(
                            context,
                            index: 2,
                            currentIndex: state.currentIndex,
                            iconPath: AssetsPath.navcat,
                          ),
                          _navItem(
                            context,
                            index: 3,
                            currentIndex: state.currentIndex,
                            iconPath: AssetsPath.navcart,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _navItem(BuildContext context, {
    required int index,
    required int currentIndex,
    required String iconPath,
  }) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        context.read<BottomNavBloc>().add(TabChanged(index));
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.r),
          color: isSelected ? Colors.white : Colors.transparent,
          border: isSelected
              ? Border.all(color: const Color(0xFFFE9100), width: 2)
              : null,
          boxShadow: !isSelected
              ? [
                  const BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                  const BoxShadow(
                    color: Color(0xFF1A1A1A),
                    blurRadius: 1,
                    spreadRadius: 1,
                    offset: Offset(2, 4),
                  ),
                ]
              : [],
        ),
        child: Image.asset(
          iconPath,
          height: 22.h,
          width: 22.h,
          color: isSelected ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
