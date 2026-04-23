// import 'package:car_parts_app/core/config/assets_path.dart';
// import 'package:car_parts_app/core/coreWidget/bloc/navbar_bloc.dart';
// import 'package:car_parts_app/core/coreWidget/bloc/navbar_event.dart';
// import 'package:car_parts_app/core/coreWidget/bloc/navbar_state.dart';
// import 'package:car_parts_app/presentation/category/pages/category_pages.dart';
// import 'package:car_parts_app/presentation/details/pages/car_details_page.dart';
// import 'package:car_parts_app/presentation/filterProduct/pages/filter_page.dart';
// import 'package:car_parts_app/presentation/filterProduct/pages/product_page.dart';
// import 'package:car_parts_app/presentation/home/pages/home_page.dart';
// import 'package:car_parts_app/presentation/sellerAccount/seller_account.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class MainScreen extends StatelessWidget {
//   MainScreen({super.key});

//   final List<Widget> _screens = [
//     const HomePage(),
//     ProductPage(),
//     const CategoryPages(),
//     const SellerAccount(), // Profile or other
//   ];

//   @override
//   Widget build(BuildContext context) {

//       // Hide navigation bar completely
//     // SystemChrome.setEnabledSystemUIMode(
//     //   SystemUiMode.manual,
//     //   overlays: [SystemUiOverlay.top], // Only status bar, hide bottom nav
//     // );
//   // Tablet check
//     return BlocProvider(
//       create: (_) => BottomNavBloc(),
//       child: BlocBuilder<BottomNavBloc, BottomNavState>(
//         builder: (context, state) {
//           double screenWidth = MediaQuery.of(context).size.width;

//           return Scaffold(

//             backgroundColor: Colors.black,
//             body: Stack(
//               children: [
//                 IndexedStack(
//                   index: state.currentIndex,
//                   children: _screens,
//                 ),
//                 Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: 40.h,
//                   child: Center(
//                     child: Container(
//                       height: 60.h,
//                       width: screenWidth * 0.8,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100.r),
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.grey.withOpacity(0.3),
//                             blurRadius: 3,
//                             spreadRadius: 1,
//                             offset: const Offset(0, 2),
//                           ),
//                           const BoxShadow(
//                             color: Colors.black,
//                             blurRadius: 1,
//                             spreadRadius: 1,
//                             offset: Offset(2, 4),
//                           ),
//                         ],
//                         color: const Color(0xFF1A1A1A),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _navItem(
//                             context,
//                             index: 0,
//                             currentIndex: state.currentIndex,
//                             iconPath: AssetsPath.navhome,
//                           ),
//                           _navItem(
//                             context,
//                             index: 1,
//                             currentIndex: state.currentIndex,
//                             iconPath: AssetsPath.nav2,
//                           ),
//                           _navItem(
//                             context,
//                             index: 2,
//                             currentIndex: state.currentIndex,
//                             iconPath: AssetsPath.navcat,
//                           ),
//                           _navItem(
//                             context,
//                             index: 3,
//                             currentIndex: state.currentIndex,
//                             iconPath: AssetsPath.navcart,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _navItem(BuildContext context, {
//     required int index,
//     required int currentIndex,
//     required String iconPath,
//   }) {
//     final bool isSelected = currentIndex == index;
//         final screenWidth = MediaQuery.of(context).size.width;
//     final bool isTablet = screenWidth > 600;

//     return GestureDetector(
//       onTap: () {
//         context.read<BottomNavBloc>().add(TabChanged(index));
//       },
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 250),
//         padding: EdgeInsets.all(12.sp),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(100.r),
//           color: isSelected ? Colors.white : Colors.transparent,
//           border: isSelected
//               ? Border.all(color: const Color(0xFFFE9100), width: 2)
//               : null,
//           boxShadow: !isSelected
//               ? [
//                   const BoxShadow(
//                     color: Colors.grey,
//                     blurRadius: 0,
//                     spreadRadius: 1,
//                     offset: Offset(0, 2),
//                   ),
//                   const BoxShadow(
//                     color: Color(0xFF1A1A1A),
//                     blurRadius: 1,
//                     spreadRadius: 1,
//                     offset: Offset(2, 4),
//                   ),
//                 ]
//               : [],
//         ),
//         child: Image.asset(
//           iconPath,
//           height:  22.h,
//           width: 22.h,
//           color: isSelected ? Colors.black : Colors.white,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Assets import
import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/utils/auth_gate.dart';
import 'package:car_parts_app/presentation/home/pages/home_page.dart';
import 'package:car_parts_app/presentation/filterProduct/pages/product_page.dart';
import 'package:car_parts_app/presentation/category/pages/category_pages.dart';
import 'package:car_parts_app/presentation/sellerAccount/seller_account.dart';
import 'package:car_parts_app/presentation/home/widget/drawer_widget.dart';
import 'package:car_parts_app/presentation/home/controllers/main_screen_controller.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  static final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final MainScreenController controller = Get.put(MainScreenController());

  final List<Widget> _screens = [
    const HomePage(),
    ProductPage(),
    const CategoryPages(),
    const SellerAccount(),
  ];

  // Custom circular nav icon
  Widget _buildNavIcon(
    BuildContext context,
    String iconPath,
    bool isSelected,
    int index,
  ) {
    return GestureDetector(
      onTap: () async {
        final loggedIn = await hasAuthToken();

        if (!context.mounted) return;

        if (index == 3 && !loggedIn) {
          await redirectToLogin(
            context,
            intendedLocation: AppRoutes.SellarScreen,
          );
          return;
        }

        controller.changeTabIndex(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 55.h,
        width: 55.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.white : null,
          boxShadow: isSelected
              ? []
              : [
                  const BoxShadow(
                    color: Colors.black, // Dark rim base
                  ),
                  BoxShadow(
                    color: Colors.white.withOpacity(
                      0.45,
                    ), // Top-left light edge glow
                    spreadRadius: -2.0,
                    blurRadius: 0.2,
                    offset: const Offset(-1.5, -1.5),
                  ),
                  const BoxShadow(
                    color: Color(0xFF262626), // Inner surface dark grey
                    spreadRadius: -2.0,
                    blurRadius: 1,
                    offset: Offset(
                      1.5,
                      1.5,
                    ), // Shifts surface to expose white on top-left and black on bottom-right
                  ),
                ],
          border: isSelected
              ? Border.all(color: const Color(0xFFFFA500), width: 2.5.w)
              : Border.all(color: Colors.transparent, width: 2.5.w),
        ),
        child: Center(
          child: Image.asset(
            iconPath,
            height: 26.h,
            width: 26.h,
            color: isSelected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: MainScreen.scaffoldKey,
      extendBody: true,
      drawer: DrawerWidget(),
      body: Obx(() => Stack(
        children: [
          _screens[controller.currentIndex.value],
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                height: 85.h,
                margin: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  bottom: 20.h,
                ), // floating margin
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F0F0F),
                  borderRadius: BorderRadius.circular(50.r),
                  border: Border.all(
                    color: const Color(0xFF2A2A2A),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavIcon(context, AssetsPath.navhome, controller.currentIndex.value == 0, 0),
                    SizedBox(width: 6.w),
                    _buildNavIcon(context, AssetsPath.nav2, controller.currentIndex.value == 1, 1),
                    SizedBox(width: 6.w),
                    _buildNavIcon(context, AssetsPath.navcat, controller.currentIndex.value == 2, 2),
                    SizedBox(width: 6.w),
                    _buildNavIcon(context, AssetsPath.navcart, controller.currentIndex.value == 3, 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
