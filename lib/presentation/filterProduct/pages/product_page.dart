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
// }
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
      child: _ProductPageContent(scaffoldKey: _scaffoldKey),
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
  bool _isLocationLoading = false;
  bool _useLocation = false;
  String? _locationError;
  FilterState? _pendingFilterState;
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _carModelsController = TextEditingController();
  final TextEditingController _chassisController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _brandController.dispose();
    _carModelsController.dispose();
    _chassisController.dispose();
    super.dispose();
  }

  Future<bool> _fetchLocation({bool fallbackOnFailure = false}) async {
    if (!mounted) return false;
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

      if (!mounted) return false;

      setState(() {
        _lat = position.latitude;
        _lng = position.longitude;
        _isLocationLoading = false;
        _locationError = null;
      });

      final filterState =
          _pendingFilterState ?? context.read<FilterBloc>().state;
      await _fetchProductsForFilter(filterState);
      return true;
    } catch (e) {
      if (!mounted) return false;

      final errorMessage = e.toString().toLowerCase().contains('permission')
          ? 'Location permission not granted. Showing results without location.'
          : 'Unable to get location. Showing results without location.';

      setState(() {
        _isLocationLoading = false;
        _locationError = errorMessage;
      });

      if (fallbackOnFailure) {
        setState(() {
          _useLocation = false;
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));

        final fallbackState = context.read<FilterBloc>().state;
        await _fetchProductsForFilter(fallbackState);
      }

      return false;
    }
  }

  Future<void> _fetchProductsForFilter(FilterState state) async {
    if (!mounted) return;

    if (_useLocation && (_lat == null || _lng == null)) {
      _pendingFilterState = state;
      if (!_isLocationLoading) {
        await _fetchLocation(fallbackOnFailure: true);
      }
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

      final categoryString = selectedCategories.isNotEmpty
          ? selectedCategories.join(',')
          : '';
      final conditionString = selectedConditions.isNotEmpty
          ? selectedConditions.join(',')
          : '';

      final title = _searchController.text.trim();
      final brand = _brandController.text.trim();
      final carModels = _carModelsController.text.trim();
      final chassisNumber = _chassisController.text.trim();

      if (!productAdvanceBloc.isClosed) {
        productAdvanceBloc.add(
          getProductByAdvancedFilterEvent(
            '1',
            '10',
            title,
            categoryString,
            brand,
            conditionString,
            carModels,
            chassisNumber,
            state.minPrice,
            state.maxPrice == 1000 ? null : state.maxPrice,
            _useLocation ? _lat : null,
            _useLocation ? _lng : null,
          ),
        );
      }
    });
  }

  Future<void> _triggerFetchFromCurrentFilters() async {
    if (!mounted) return;
    final state = context.read<FilterBloc>().state;
    await _fetchProductsForFilter(state);
  }

  Future<void> _onUseLocationChanged(bool? checked) async {
    final shouldUseLocation = checked ?? false;
    if (!mounted) return;

    setState(() {
      _useLocation = shouldUseLocation;
      if (!shouldUseLocation) {
        _locationError = null;
      }
    });

    if (shouldUseLocation && (_lat == null || _lng == null)) {
      await _fetchLocation(fallbackOnFailure: true);
    } else {
      await _triggerFetchFromCurrentFilters();
    }
  }

  Future<void> _openFilterPanel() async {
    final filterBloc = context.read<FilterBloc>();

    await showGeneralDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: true,
      barrierLabel: 'Close filter',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (dialogContext, _, __) {
        return StatefulBuilder(
          builder: (dialogContext, panelSetState) {
            return BlocProvider.value(
              value: filterBloc,
              child: Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(dialogContext).size.width * 0.82,
                  child: FilterDrawer(
                    brandController: _brandController,
                    carModelsController: _carModelsController,
                    chassisNumberController: _chassisController,
                    onFieldChanged: _triggerFetchFromCurrentFilters,
                    useLocation: _useLocation,
                    isLocationLoading: _isLocationLoading,
                    onUseLocationChanged: (checked) async {
                      panelSetState(() {});
                      await _onUseLocationChanged(checked);
                      if (mounted) {
                        panelSetState(() {});
                      }
                    },
                    locationError: _locationError,
                  ),
                ),
              ),
            );
          },
        );
      },
      transitionBuilder: (dialogContext, animation, _, child) {
        final offsetAnimation =
            Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOutCubic),
            );

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CategoryBloc, CategoryState>(
          listener: (context, catState) {
            if (catState is CategoryLoaded) {
              final categories = catState.categories
                  .map((e) => e.name)
                  .toList();
              context.read<FilterBloc>().add(
                InitializeFilters(
                  categories: categories,
                  conditions: const ['New', 'Used', 'Refurbished'],
                ),
              );
              _triggerFetchFromCurrentFilters();
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
                        child: SearchWidget(
                          controller: _searchController,
                          onChanged: (_) => _triggerFetchFromCurrentFilters(),
                          onSubmitted: (_) => _triggerFetchFromCurrentFilters(),
                        ),
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
                          onPressed: _openFilterPanel,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: BlocBuilder<ProductAdvamceBloc, ProductAdvamceState>(
                    builder: (context, state) {
                      if (state is ProductAdvamceLoading) {
                        return _buildShimmerGrid();
                      } else if (_useLocation && _locationError != null) {
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
                              'No products found',
                              style: TextStyle(color: Colors.white),
                            ),
                          );
                        }

                        return NotificationListener<ScrollNotification>(
                          onNotification: (scrollInfo) {
                            if (scrollInfo.metrics.pixels >=
                                scrollInfo.metrics.maxScrollExtent -
                                    ProductPage._scrollThreshold) {
                              final blocState = context
                                  .read<ProductAdvamceBloc>()
                                  .state;
                              if (blocState is ProductAdvamceSuccess &&
                                  !blocState.isLoadingMore &&
                                  !blocState.hasReachedMax) {
                                context.read<ProductAdvamceBloc>().add(
                                  LoadMoreProductsEvent(),
                                );
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
