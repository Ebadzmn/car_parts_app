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
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:geolocator/geolocator.dart';
import 'package:car_parts_app/core/coreWidget/reusable_product_card_widget.dart';
import 'package:shimmer/shimmer.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  static const double _scrollThreshold = 200.0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (_) => di.sl<CategoryBloc>()..add(FetchCategoriesEvent()),
        ),
        BlocProvider<FilterBloc>(create: (_) => FilterBloc()),
        BlocProvider<ProductAdvamceBloc>(
          create: (_) => di.sl<ProductAdvamceBloc>(),
        ),
      ],
      child: _ProductPageContent(
        scaffoldKey: _scaffoldKey,
      ),
    );
  }
}

class _ProductPageContent extends StatefulWidget {
  const _ProductPageContent({required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<_ProductPageContent> createState() => _ProductPageContentState();
}

class _ProductPageContentState extends State<_ProductPageContent> {
  double? _lat;
  double? _lng;
  bool _isLocationLoading = true;
  String? _locationError;
  FilterState? _pendingFilterState;

  @override
  void initState() {
    super.initState();
    _fetchLocation();
  }

  Future<void> _fetchLocation() async {
    if (!mounted) return;
    setState(() {
      _isLocationLoading = true;
      _locationError = null;
    });

    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Location permission not granted');
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      setState(() {
        _lat = position.latitude;
        _lng = position.longitude;
        _isLocationLoading = false;
      });

      final filterState =
          _pendingFilterState ?? context.read<FilterBloc>().state;
      await _fetchProductsForFilter(filterState);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLocationLoading = false;
        _locationError = 'Unable to fetch location';
      });
    }
  }

  Future<void> _fetchProductsForFilter(FilterState state) async {
    if (!mounted) return;
    if (_lat == null || _lng == null) {
      _pendingFilterState = state;
      return;
    }

    final productAdvanceBloc = context.read<ProductAdvamceBloc>();

    await ProductPage._debounced(() async {
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

      final categoryString =
          selectedCategories.isNotEmpty ? selectedCategories.join(',') : '';
      final conditionString =
          selectedConditions.isNotEmpty ? selectedConditions.join(',') : '';

      if (!productAdvanceBloc.isClosed) {
        productAdvanceBloc.add(
          getProductByAdvancedFilterEvent(
            '1',
            '10',
            categoryString,
            conditionString,
            state.minPrice,
            state.maxPrice,
            _lat ?? 0.0,
            _lng ?? 0.0,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryBloc, CategoryState>(
          listener: (context, catState) {
            if (catState is CategoryLoaded) {
              final categories = catState.categories.map((e) => e.name).toList();
              context.read<FilterBloc>().add(
                    InitializeFilters(
                      categories: categories,
                      conditions: const ['New', 'Used', 'Refurbished'],
                    ),
                  );
            }
          },
        ),
        BlocListener<FilterBloc, FilterState>(
          listenWhen: (prev, curr) =>
              prev.selectedCategories != curr.selectedCategories ||
              prev.selectedConditions != curr.selectedConditions ||
              prev.minPrice != curr.minPrice ||
              prev.maxPrice != curr.maxPrice,
          listener: (context, state) async {
            await _fetchProductsForFilter(state);
          },
        ),
      ],
      child: Scaffold(
        key: widget.scaffoldKey,
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
                      child: SizedBox(height: 40.h, child: const SearchWidget()),
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
                              widget.scaffoldKey.currentState?.openDrawer(),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child:
                      BlocBuilder<ProductAdvamceBloc, ProductAdvamceState>(
                    builder: (context, state) {
                      if (_isLocationLoading ||
                          state is ProductAdvamceLoading) {
                        return _buildShimmerGrid();
                      } else if (_locationError != null) {
                        return Center(
                          child: Text(
                            _locationError!,
                            style: const TextStyle(color: Colors.white),
                          ),
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
                              'No products found near your location',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent -
                                    ProductPage._scrollThreshold) {
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
                            itemCount:
                                products.length + (state.isLoadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index >= products.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final item = products[index];
                              return ReusableProductCardWidget(
                                item: item,
                                onTap: () {
                                  context.push(
                                    AppRoutes.detailsScreen,
                                    extra: {'productId': item.id},
                                  );
                                },
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
    );
  }

  Widget _buildShimmerGrid() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: GridView.builder(
        padding: EdgeInsets.only(top: 10.h),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 0.68,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(20.r),
            ),
          );
        },
      ),
    );
  }
}

