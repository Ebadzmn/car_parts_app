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
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/presentation/home/pages/home_page.dart';
import 'package:car_parts_app/presentation/filterProduct/pages/product_page.dart';
import 'package:car_parts_app/presentation/category/pages/category_pages.dart';
import 'package:car_parts_app/presentation/sellerAccount/seller_account.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomePage(),
    ProductPage(),
    const CategoryPages(),
    const SellerAccount(),
  ];

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // Custom circular nav icon
  Widget _buildNavIcon(String iconPath, bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.r),
        color: isSelected ? Colors.white : Colors.transparent,
        border: isSelected
            ? Border.all(color: const Color(0xFFFE9100), width: 2)
            : null,
        boxShadow: !isSelected
            ? [
                const BoxShadow(
                  color: Colors.grey,
                  blurRadius: 1,
                  spreadRadius: 0.5,
                  offset: Offset(0, 1),
                ),
                const BoxShadow(
                  color: Color(0xFF1A1A1A),
                  blurRadius: 1,
                  spreadRadius: 0.5,
                  offset: Offset(1, 2),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _screens[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 70.h,
          margin: EdgeInsets.symmetric(horizontal: 20.w), // floating style
          decoration: BoxDecoration(
            // color: const Color(0xFF1A1A1A),
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTap,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: _buildNavIcon(AssetsPath.navhome, _currentIndex == 0),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(AssetsPath.nav2, _currentIndex == 1),
                label: 'Products',
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(AssetsPath.navcat, _currentIndex == 2),
                label: 'Category',
              ),
              BottomNavigationBarItem(
                icon: _buildNavIcon(AssetsPath.navcart, _currentIndex == 3),
                label: 'Account',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
