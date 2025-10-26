// import 'package:car_parts_app/core/config/assets_path.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class BottomNavBarwidget extends StatelessWidget {
//   const BottomNavBarwidget({
//     super.key,
//     required this.screenWidth,
//   });

//   final double screenWidth;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: 0,
//       right: 0,
//       bottom: 16.h, // slightly above bottom edge (floating look)
//       child: Center(
//         child: Container(
//           height: 60.h,
//           width: screenWidth * 0.8, // a bit narrower for aesthetic margin
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(100.r),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey,
//                 blurRadius: 0,
//                 spreadRadius: 1,
//                 offset: const Offset(0, 2),
//               ),
//               BoxShadow(
//                 color: Colors.black,
//                 blurRadius: 1,
//                 spreadRadius: 1,
//                 offset: Offset(2, 4),
//               ),
//             ],
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Container(
//                 padding: EdgeInsets.all(12.sp),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 0,
//                       spreadRadius: 1,
//                       offset: Offset(0, 2),
//                     ),
//                     BoxShadow(
//                       color: Color(0xFF1A1A1A),
//                       blurRadius: 1,
//                       spreadRadius: 1,
//                       offset: Offset(2, 4),
//                     ),
//                   ],
//                 ),
//                 child: Image.asset(AssetsPath.navhome),
//               ),
//               Container(
//                 padding: EdgeInsets.all(12.sp),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 0,
//                       spreadRadius: 1,
//                       offset: Offset(0, 2),
//                     ),
//                     BoxShadow(
//                       color: Color(0xFF1A1A1A),
//                       blurRadius: 1,
//                       spreadRadius: 1,
//                       offset: Offset(2, 4),
//                     ),
//                   ],
//                 ),
//                 child: Image.asset(AssetsPath.nav2),
//               ),
    
//               Container(
//                 padding: EdgeInsets.all(12.sp),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100.r),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey,
//                       blurRadius: 0,
//                       spreadRadius: 1,
//                       offset: Offset(0, 2),
//                     ),
//                     BoxShadow(
//                       color: Color(0xFF1A1A1A),
//                       blurRadius: 1,
//                       spreadRadius: 1,
//                       offset: Offset(2, 4),
//                     ),
//                   ],
//                 ),
//                 child: Image.asset(
//                   AssetsPath.navcat,
//                   color: Colors.white,
//                 ),
//               ),
    
//               Container(
//                 padding: EdgeInsets.all(12.sp),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100.r),
//                   color: Colors.white,
//                   border: Border.all(color: Color(0xFFFE9100), width: 2),
//                 ),
//                 child: Image.asset(
//                   AssetsPath.navcart,
//                   color: Colors.black,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'package:car_parts_app/core/appRoutes/app_routes.dart';
// import 'package:car_parts_app/core/config/assets_path.dart';
// import 'package:car_parts_app/core/coreWidget/bloc/navbar_bloc.dart';
// import 'package:car_parts_app/core/coreWidget/bloc/navbar_event.dart';
// import 'package:car_parts_app/core/coreWidget/bloc/navbar_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';


// class NavBarWidget extends StatelessWidget {
//   const NavBarWidget({super.key, required this.screenWidth});
//   final double screenWidth;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: 0,
//       right: 0,
//       bottom: 16.h,
//       child: Center(
//         child: BlocBuilder<BottomNavBloc, BottomNavState>(
//           builder: (context, state) {
//             return Container(
//               height: 60.h,
//               width: screenWidth * 0.8,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100.r),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Colors.grey,
//                     blurRadius: 0,
//                     spreadRadius: 1,
//                     offset: Offset(0, 2),
//                   ),
//                   BoxShadow(
//                     color: Colors.black,
//                     blurRadius: 1,
//                     spreadRadius: 1,
//                     offset: Offset(2, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: List.generate(4, (index) {
//                   String asset;
//                   String routeName;

//                   switch (index) {
//                     case 0:
//                       asset = AssetsPath.navhome;
//                       routeName = AppRoutes.homeScreen;
//                       break;
//                     case 1:
//                       asset = AssetsPath.nav2;
//                       routeName = AppRoutes.homeScreen;
//                       break;
//                     case 2:
//                       asset = AssetsPath.navcat;
//                       routeName = AppRoutes.detailsScreen;
//                       break;
//                     case 3:
//                       asset = AssetsPath.navcart;
//                       routeName = AppRoutes.LoginPage;
//                       break;
//                     default:
//                       asset = '';
//                       routeName = AppRoutes.homeScreen;
//                   }

//                   bool isActive = state.selectedIndex == index;

//                   return GestureDetector(
//                     onTap: () {
//                       context.read<BottomNavBloc>().add(TabChanged(index));
//                       context.push(routeName);
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(12.sp),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100.r),
//                         color: isActive
//                             ? Colors.grey[800]
//                             : Colors.transparent,
//                         border: index == 3
//                             ? Border.all(color: const Color(0xFFFE9100), width: 2)
//                             : null,
//                       ),
//                       child: Image.asset(
//                         asset,
//                         color: isActive ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   );
//                 }),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
