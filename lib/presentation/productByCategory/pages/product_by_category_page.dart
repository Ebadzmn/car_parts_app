// import 'package:car_parts_app/core/appRoutes/app_routes.dart';
// import 'package:car_parts_app/core/config/assets_path.dart';
// import 'package:car_parts_app/presentation/home/bloc/home_bloc.dart';
// import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProductByCategoryPage extends StatelessWidget {
//   const ProductByCategoryPage({super.key});

//   @override
//   Widget build(BuildContext context) {

//     // Helper function
// List<Color> getGradientColors(String condition) {
//   switch (condition) {
//     case "New":
//       return [Colors.green, Colors.white];
//     case "Used":
//      return [Colors.red, Colors.white];
//     case "Refurb":
//      return [Color(0xFFE7BE00), Colors.white];
//     default:
//       return [Color(0xFFE7BE00), Colors.white]; // fallback
//   }
// }
//     final screenHeight = 1.sh;
//     final screenWidth = 1.sw;

//     return Scaffold(
    
//       body: SafeArea(
        
//         child: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: 16.w , vertical: 16.h),
//           child: Center(
//             child: Column(
//            // Minimize vertical space
//               children: [
            
//                 Row(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           context.pop();
//                         },
//                         child: Container(
//                           height: 40,
//                           width: 40,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             boxShadow: [
//                               BoxShadow(
//                                 blurRadius: 0,
//                                 spreadRadius: 1,
//                                 offset: Offset(0, 1),
//                                 color: Colors.grey,
//                               ),
                                    
//                               BoxShadow(
//                                 blurRadius: 1,
//                                 spreadRadius: 1,
//                                 offset: Offset(2, 2),
//                                 color: Color(0xFF373737),
//                               ),
//                             ],
//                           ),
//                           child: Center(
//                             child: Icon(
//                               Icons.arrow_back_ios_new_outlined,
//                               color: Colors.green,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 12.w),
//                       Text(
//                         'Parts & Accessories',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 12.sp,
//                           color: Colors.white,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
            
                  
             
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20),
//                   child: SearchWidget(),
//                 ),
//                 // ======= BlocBuilder =======
//                 BlocBuilder<HomeBloc, HomeState>(
//                   builder: (context, state) {
//                     if (state is HomeLoading) {
//                       return const Center(child: CircularProgressIndicator());
//                     } else if (state is ProductError) {
//                       return const Center(child: Text('Error loading products'));
//                     } else if (state is FetchCard) {
//                       // ✅ Responsive grid based on screen width
//                       int crossAxisCount = screenWidth < 600
//                           ? 2
//                           : screenWidth < 900
//                           ? 3
//                           : 3;
            
//                       double childAspectRatio = screenWidth < 600 ? 2 / 2.9 : 2.2 / 3.2;
            
//                       return GridView.builder(
//                         shrinkWrap: true,
//                         physics:  NeverScrollableScrollPhysics(),
//                         padding: EdgeInsets.symmetric(horizontal: 0.w , vertical: 20.h),
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: crossAxisCount,
//                           crossAxisSpacing: 10.w,
//                           mainAxisSpacing: 10.h,
//                           childAspectRatio: childAspectRatio,
//                         ),
//                         itemCount: state.data.length,
//                         itemBuilder: (context, index) {
//                           final item = state.data[index];
            
//                           return GestureDetector(
//                             onTap: () {
//                               context.push(
//                                 AppRoutes.detailsScreen,
//                               );
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey, width: 1.2),
//                                 borderRadius: BorderRadius.circular(20.r),
//                                 gradient: const LinearGradient(
//                                   begin: Alignment.topLeft,
//                                   end: Alignment.bottomRight,
//                                   colors: [
//                                     Color(0xFF2E2C2A),
//                                     Color(0xFF131313),
//                                     Color(0xFF1D1D20),
//                                   ],
//                                   stops: [0.0, 0.5, 1.0],
//                                 ),
//                               ),
//                               child: Padding(
//                                 padding: EdgeInsets.all(10.sp),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     // Car name
//                                     Text(
//                                       item.carName,
//                                       style: GoogleFonts.montserrat(
//                                         decoration: TextDecoration.underline,
//                                         decorationColor: Colors.grey,
//                                         color: Colors.grey,
//                                         fontSize: 11.sp,
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
                            
//                                     // Car condition
//                                     Text(
//               item.carCondition,
//               style: GoogleFonts.montserrat(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.bold,
//                 foreground: Paint()
//             ..shader = LinearGradient(
//               colors: getGradientColors(item.carCondition),
//               begin: Alignment.topLeft,
//               end: Alignment.topRight,
//             ).createShader(Rect.fromLTWH(0, 0, 200, 20)),
//               ),
//             ),
                            
//                                     SizedBox(height: 8.h),
                            
//                                     // Car image — responsive width & height
//                                     Expanded(
//                                       child: Container(
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(16.r),
//                                           color: Colors.black,
//                                         ),
//                                         child: Image.asset(
//                                           AssetsPath.cardtire,
//                                           fit: BoxFit.contain,
//                                         ),
//                                       ),
//                                     ),
                            
//                                     SizedBox(height: 8.h),
                            
//                                     // Price section
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               'PRICE',
//                                               style: GoogleFonts.montserrat(
//                                                 fontSize: 10.sp,
//                                                 color: Colors.white,
//                                               ),
//                                             ),
//                                             Text(
//                                               '32.60',
//                                               style: GoogleFonts.montserrat(
//                                                 fontSize: 13.sp,
//                                                 fontWeight: FontWeight.w600,
//                                                 foreground: Paint()
//                                                   ..shader =
//                                                       const LinearGradient(
//                                                         colors: [
//                                                           Color(0xFF5BB349),
//                                                           Colors.white,
//                                                         ],
//                                                         begin: Alignment.topLeft,
//                                                         end: Alignment.topRight,
//                                                       ).createShader(
//                                                         Rect.fromLTWH(0, 0, 200, 20),
//                                                       ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Image.asset(
//                                           AssetsPath.cardbtn,
//                                           width: 30.w,
//                                           height: 30.h,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     }
//                     return const SizedBox();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }















import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/presentation/productByCategory/bloc/product_advamce_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductByCategoryPage extends StatelessWidget {
  final String? category;
  final String? condition;
  final double? lowestPrice;
  final double? highestPrice;

  const ProductByCategoryPage({
    super.key,
     this.category,
    this.condition,
    this.lowestPrice,
    this.highestPrice,
  });

  // Helper function
  List<Color> getGradientColors(String condition) {
    switch (condition.toLowerCase()) {
      case "new":
        return [Colors.green, Colors.white];
      case "used":
        return [Colors.red, Colors.white];
      case "refurb":
        return [const Color(0xFFE7BE00), Colors.white];
      default:
        return [const Color(0xFFE7BE00), Colors.white]; // fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = 1.sw;

    return BlocProvider<ProductAdvamceBloc>(
      create: (_) => ProductAdvamceBloc(
        // ensure sl() returns ProductUsecase (or replace with your DI)
        sl(),
      )..add(
          getProductByAdvancedFilterEvent(
             category ?? '',
             condition ?? '',
            lowestPrice ?? 0.0,
            highestPrice ?? double.infinity,
          ),
        ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              children: [
                // Top row: back + title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 0,
                              spreadRadius: 1,
                              offset: Offset(0, 1),
                              color: Colors.grey,
                            ),
                            BoxShadow(
                              blurRadius: 1,
                              spreadRadius: 1,
                              offset: Offset(2, 2),
                              color: Color(0xFF373737),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      category ?? '',
                      style: GoogleFonts.montserrat(
                        fontSize: 14.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                // Search
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: const SearchWidget(),
                ),

                // Results: expand to fill remaining space
                Expanded(
                  child: BlocBuilder<ProductAdvamceBloc, ProductAdvamceState>(
                    builder: (context, state) {
                      if (state is ProductAdvamceLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is ProductAdvamceFailure) {
                        return Center(
                          child: Text(
                            state.message,
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else if (state is ProductAdvamceSuccess) {
                        final products = state.productEntity;

                        if (products.isEmpty) {
                          return Center(
                            child: Text(
                              'No products found',
                              style: GoogleFonts.montserrat(color: Colors.white),
                            ),
                          );
                        }

                        // Responsive grid columns
                        int crossAxisCount = screenWidth < 600
                            ? 2
                            : screenWidth < 900
                                ? 3
                                : 4;

                        double childAspectRatio =
                            screenWidth < 600 ? 2 / 2.9 : 2.2 / 3.2;

                        return GridView.builder(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0.w, vertical: 20.h),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: childAspectRatio,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final ProductEntity item = products[index];

                            return GestureDetector(
                              onTap: () {
                                context.push(
                                  AppRoutes.detailsScreen,
                                  extra: {'productId': item.id, 'product': item},
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey, width: 1.2),
                                  borderRadius: BorderRadius.circular(20.r),
                                  gradient: const LinearGradient(
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
                                  padding: EdgeInsets.all(10.sp),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Product / Car name
                                      Text(
                                        item.title ?? '',
                                        style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.underline,
                                          decorationColor: Colors.grey,
                                          color: Colors.grey,
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      // Car condition with gradient text
                                      Text(
                                        item.condition ?? '',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                          foreground: Paint()
                                            ..shader = LinearGradient(
                                              colors: getGradientColors(
                                                  item.condition ?? ''),
                                              begin: Alignment.topLeft,
                                              end: Alignment.topRight,
                                            ).createShader(Rect.fromLTWH(0, 0, 200, 20)),
                                        ),
                                      ),

                                      SizedBox(height: 8.h),

                                      // Car image — responsive width & height
                                      Expanded(
                                        child: Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16.r),
                                            color: Colors.black,
                                          ),
                                          child: Image.asset(
                                            AssetsPath.cardtire,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),

                                      SizedBox(height: 8.h),

                                      // Price section
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'PRICE',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 10.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Text(
                                                item.price?.toStringAsFixed(2) ??
                                                    '0.00',
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w600,
                                                  foreground: Paint()
                                                    ..shader = const LinearGradient(
                                                      colors: [
                                                        Color(0xFF5BB349),
                                                        Colors.white,
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.topRight,
                                                    ).createShader(
                                                      Rect.fromLTWH(0, 0, 200, 20),
                                                    ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            AssetsPath.cardbtn,
                                            width: 30.w,
                                            height: 30.h,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
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
      ),
    );
  }
}

