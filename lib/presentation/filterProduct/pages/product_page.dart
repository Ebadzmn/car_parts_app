// import 'package:car_parts_app/core/config/assets_path.dart';
// import 'package:car_parts_app/presentation/filterProduct/pages/filter_page.dart';
// import 'package:car_parts_app/presentation/home/widget/home_car_card_widget.dart';
// import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProductPage extends StatelessWidget {
//   ProductPage({super.key});

//   // GlobalKey to control the Scaffold
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   final categories = [
//     'Electronics',
//     'Fashion',
//     'Home & Garden',
//     'Sports',
//     'Toys',
//     'Automotive',
//     'Books',
//     'Beauty',
//     'Music',
//     'Furniture',
//   ];

//   final brands = [
//     'Apple',
//     'Samsung',
//     'Nike',
//     'Adidas',
//     'Sony',
//     'LG',
//     'Dell',
//     'HP',
//     'Asus',
//     'Puma',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey, // Assign key to Scaffold
      
//       drawer: FilterDrawer(categories: categories, brands: brands),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(20.sp),
//             child: Column(
              
//               children: [
//                 // ElevatedButton(
//                 //   onPressed: () {
//                 //     // Open the drawer
//                 //     _scaffoldKey.currentState?.openDrawer();
//                 //   },
//                 //   child: const Text('Open Filter Drawer'),
//                 // ),
                    
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   child: Text('Product' , textAlign: TextAlign.left, style: GoogleFonts.montserrat(fontSize: 24 , fontWeight: FontWeight.w600 , color: Colors.white , fontStyle: FontStyle.italic),)),
//                   SizedBox(height: 10.h),
//                 Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Search Box
//             Expanded(
//         flex: 10,
//         child: Container(
//           height: 40.h,
//           child: SearchWidget(),
//         ),
//             ),
        
//             SizedBox(width: 10.w),
        
//             // Filter Button
//             Flexible(
//         flex: 2,
//         child: Container(
//           height: 45.h,
//           width: 50.w,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade700,
//             borderRadius: BorderRadius.circular(16.r),
//           ),
//           child: IconButton(
//             icon: Image.asset(
//               AssetsPath.filterPng,
//               color: Colors.white,
//               fit: BoxFit.contain,
//             ),
//             onPressed: () {
//               _scaffoldKey.currentState?.openDrawer();
//             },
//           ),
//         ),
//             ),
//           ],
//         ),
//         SizedBox(height: 20.h),
//         // HomeCarCardWidget(title: 'New Arrival',)
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }import 'package:car_parts_app/core/config/assets_path.dart';
import 'dart:async';
import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/injector/injector.dart' as di;
import 'package:car_parts_app/presentation/category/bloc/category_bloc.dart';

import 'package:car_parts_app/presentation/filterProduct/bloc/filter_bloc.dart';
import 'package:car_parts_app/presentation/filterProduct/bloc/filter_event.dart';
import 'package:car_parts_app/presentation/filterProduct/bloc/filter_state.dart';
import 'package:car_parts_app/presentation/filterProduct/pages/filter_page.dart';
import 'package:car_parts_app/presentation/home/widget/search_widget.dart';
import 'package:car_parts_app/presentation/productByCategory/bloc/product_advamce_bloc.dart';

import 'package:car_parts_app/presentation/productByCategory/bloc/product_advamce_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // debounce helper static future
  static Future<void> _debounced(Future<void> Function() action) async {
    _lastAction?.cancel();
    final completer = Completer<void>();
    _lastAction = Timer(const Duration(milliseconds: 500), () async {
      await action();
      completer.complete();
    });
    await completer.future;
  }

  static Timer? _lastAction;

  static const double _scrollThreshold = 200.0; // px from bottom to trigger load more

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (_) => di.sl<CategoryBloc>()..add(FetchCategoriesEvent()),
        ),
        BlocProvider<FilterBloc>(
          create: (_) => FilterBloc(),
        ),
        BlocProvider<ProductAdvamceBloc>(
          create: (_) => di.sl<ProductAdvamceBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          // When categories load → initialize filters
          BlocListener<CategoryBloc, CategoryState>(
            listener: (context, catState) {
              if (catState is CategoryLoaded) {
                final categories =
                    catState.categories.map((e) => e.name).toList();
                context.read<FilterBloc>().add(
                      InitializeFilters(
                        categories: categories,
                        conditions: const ['New', 'Used', 'Refurbished'],
                      ),
                    );
              }
            },
          ),

          // When filter changes → debounce → call product API
          BlocListener<FilterBloc, FilterState>(
            listenWhen: (prev, curr) =>
                prev.selectedCategories != curr.selectedCategories ||
                prev.selectedConditions != curr.selectedConditions ||
                prev.minPrice != curr.minPrice ||
                prev.maxPrice != curr.maxPrice,
            listener: (context, state) async {
              await _debounced(() async {
                final selectedCategories = <String>[];
                for (int i = 0; i < state.categories.length; i++) {
                  if (state.selectedCategories.length > i &&
                      state.selectedCategories[i]) {
                    selectedCategories.add(state.categories[i]);
                  }
                }

                final selectedConditions = <String>[];
                for (int i = 0; i < state.conditions.length; i++) {
                  if (state.selectedConditions.length > i &&
                      state.selectedConditions[i]) {
                    selectedConditions.add(state.conditions[i]);
                  }
                }

                final categoryString = selectedCategories.isNotEmpty
                    ? selectedCategories.join(',')
                    : '';
                final conditionString = selectedConditions.isNotEmpty
                    ? selectedConditions.join(',')
                    : '';

                context.read<ProductAdvamceBloc>().add(
                      getProductByAdvancedFilterEvent(
                        '1',
                        '10',
                        categoryString,
                        conditionString,
                        state.minPrice,
                        state.maxPrice,
                      ),
                    );
              });
            },
          ),
        ],
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.black,
          drawer: const FilterDrawer(),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(20.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product',
                    style: GoogleFonts.montserrat(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: SizedBox(
                          height: 40.h,
                          child: SearchWidget(),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Flexible(
                        flex: 2,
                        child: Container(
                          height: 45.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade700,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: IconButton(
                            icon: Image.asset(
                              AssetsPath.filterPng,
                              color: Colors.white,
                            ),
                            onPressed: () =>
                                _scaffoldKey.currentState?.openDrawer(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),

                  // Product list UI with infinite scroll (NotificationListener)
                  Expanded(
                    child: BlocBuilder<ProductAdvamceBloc, ProductAdvamceState>(
                      builder: (context, state) {
                        if (state is ProductAdvamceLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ProductAdvamceFailure) {
                          return Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        } else if (state is ProductAdvamceSuccess) {
                          final products = state.products;
                          if (products.isEmpty) {
                            return const Center(
                              child: Text(
                                'No Products Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          return NotificationListener<ScrollNotification>(
                            onNotification: (scrollInfo) {
                              if (scrollInfo.metrics.pixels >=
                                  scrollInfo.metrics.maxScrollExtent -
                                      _scrollThreshold) {
                                final blocState =
                                    context.read<ProductAdvamceBloc>().state;
                                if (blocState is ProductAdvamceSuccess &&
                                    !blocState.isLoadingMore &&
                                    !blocState.hasReachedMax) {
                                  context
                                      .read<ProductAdvamceBloc>()
                                      .add(LoadMoreProductsEvent());
                                }
                              }
                              return false;
                            },
                            child: GridView.builder(
                              padding: EdgeInsets.only(top: 10.h),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 16.h,
                                crossAxisSpacing: 16.w,
                                childAspectRatio: 0.68,
                              ),
                              itemCount: products.length +
                                  (state.isLoadingMore ? 1 : 0),
                              itemBuilder: (context, index) {
                                // If last item and loading more -> show loader
                                if (index >= products.length) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                final item = products[index];
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1.2),
                                    borderRadius: BorderRadius.circular(20.r),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF2E2C2A),
                                        Color(0xFF131313),
                                        Color(0xFF1D1D20),
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.sp),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title ?? '',
                                          style: GoogleFonts.montserrat(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.grey,
                                            color: Colors.grey,
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
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
                                              ).createShader(
                                                  Rect.fromLTWH(0, 0, 200, 20)),
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(16.r),
                                              color: Colors.black,
                                            ),
                                            child: (item.mainImage != null &&
                                                    item.mainImage!.isNotEmpty)
                                                ? Image.network(
                                                    item.mainImage!,
                                                    fit: BoxFit.contain,
                                                    errorBuilder: (context,
                                                            error, stack) =>
                                                        Image.asset(
                                                      AssetsPath.cardtire,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  )
                                                : Image.asset(
                                                    AssetsPath.cardtire,
                                                    fit: BoxFit.contain,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
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
                                                  '\$${item.price?.toStringAsFixed(2) ?? '0.00'}',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w600,
                                                    foreground: Paint()
                                                      ..shader = const LinearGradient(
                                                        colors: [
                                                          Color(0xFF5BB349),
                                                        Color(0xFFFFFFFF),
                                                        ],
                                                      ).createShader(
                                                          Rect.fromLTWH(
                                                              0, 0, 200, 20)),
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
                                );
                              },
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Gradient helper for product condition text
List<Color> getGradientColors(String condition) {
  switch (condition.toLowerCase()) {
    case 'new':
      return const [Color(0xFF00FF87), Color(0xFF60EFFF)];
    case 'used':
      return const [Color(0xFFFFC371), Color(0xFFFF5F6D)];
    case 'refurbished':
      return const [Color(0xFF8E2DE2), Color(0xFF4A00E0)];
    default:
      return const [Colors.white, Colors.grey];
  }
}
