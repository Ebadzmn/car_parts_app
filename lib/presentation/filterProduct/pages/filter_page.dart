// import 'package:car_parts_app/presentation/filterProduct/bloc/filter_bloc.dart';
// import 'package:car_parts_app/presentation/filterProduct/bloc/filter_event.dart';
// import 'package:car_parts_app/presentation/filterProduct/bloc/filter_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_fonts/google_fonts.dart';

// class FilterDrawer extends StatelessWidget {
//   final List<String> categories;
//   final List<String> brands;

//   const FilterDrawer({
//     super.key,
//     required this.categories,
//     required this.brands,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => FilterBloc(
//         categoryCount: categories.length,
//         brandCount: brands.length,
//       ),
//       child: Drawer(
//         backgroundColor: Colors.black,
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: BlocBuilder<FilterBloc, FilterState>(
//               builder: (context, state) {
//                 final bloc = context.read<FilterBloc>();

//                 return SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Filter',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic,
//                           color: Colors.white,
//                         ),
//                       ),
//                       const SizedBox(height: 20),

//                       // Categories
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Categories',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               fontStyle: FontStyle.italic,
//                               color: Colors.white,
//                             ),
//                           ),

//                           IconButton(
//                             onPressed: () => bloc.add(ToggleShowAllCategories()),
//                             icon: Icon(
//                               state.showAllCategories
//                                   ? Icons.arrow_drop_up
//                                   : Icons.arrow_drop_down,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                       ...List.generate(
//                         state.showAllCategories ? categories.length : 5,
//                         (index) {
//                           return CheckboxListTile(
//                             activeColor: Colors.white,
//                             checkColor: Colors.white,
//                             value: state.selectedCategories[index],
//                             onChanged: (_) => bloc.add(ToggleCategory(index)),
//                             title: Text(
//                               categories[index],
//                               style: GoogleFonts.montserrat(
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             controlAffinity: ListTileControlAffinity.leading,
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 0,
//                             ),
//                           );
//                         },
//                       ),
//                       if (categories.length > 5)

//                       const Divider(color: Colors.white),

//                       // Brands
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'Brands',
//                             style: GoogleFonts.montserrat(
//                               fontSize: 12,
//                               fontWeight: FontWeight.bold,
//                               fontStyle: FontStyle.italic,
//                               color: Colors.white,
//                             ),
//                           ),

//                           IconButton(
//                             onPressed: () => bloc.add(ToggleShowAllBrands()),
//                             icon: Icon(
//                               state.showAllBrands
//                                   ? Icons.arrow_drop_up
//                                   : Icons.arrow_drop_down,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                       ...List.generate(
//                         state.showAllBrands ? brands.length : 5,
//                         (index) {
//                           return CheckboxListTile(
//                             activeColor: Colors.white,
//                             checkColor: Colors.white,
//                             value: state.selectedBrands[index],
//                             onChanged: (_) => bloc.add(ToggleBrand(index)),
//                             title: Row(
//                               children: [
//                                 Text(
//                                   brands[index],
//                                   style: GoogleFonts.montserrat(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.white,
//                                   ),
//                                 ),

//                               ],
//                             ),
//                             controlAffinity: ListTileControlAffinity.leading,
//                             contentPadding: const EdgeInsets.symmetric(
//                               horizontal: 0,
//                             ),
//                           );
//                         },
//                       ),
//                       if (brands.length > 5)
//                         Align(
//                           alignment: Alignment.centerRight,
//                           child: TextButton(
//                             onPressed: () => bloc.add(ToggleShowAllBrands()),
//                             child: Text(
//                               state.showAllBrands ? 'Show Less' : 'Show More',
//                               style: GoogleFonts.montserrat(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),

//                       const Divider(color: Colors.white),

//                       // Price Range
//                       Text(
//                         'Price Range',
//                         style: GoogleFonts.montserrat(
//                           fontSize: 12,
//                           fontWeight: FontWeight.bold,
//                           fontStyle: FontStyle.italic,
//                           color: Colors.white,
//                         ),
//                       ),
//                       RangeSlider(
//                         values: RangeValues(state.minPrice, state.maxPrice),
//                         min: 0,
//                         max: 1000,
//                         divisions: 20,
//                         labels: RangeLabels(
//                           '\$${state.minPrice.round()}',
//                           '\$${state.maxPrice.round()}',
//                         ),
//                         activeColor: Colors.white.withOpacity(0.3),
//                         inactiveColor: Colors.green,
//                         onChanged: (values) => bloc.add(
//                           UpdatePriceRange(values.start, values.end),
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '\$${state.minPrice.round()}',
//                             style: GoogleFonts.montserrat(
//                               color: Colors.white,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Text(
//                             '\$${state.maxPrice.round()}',
//                             style: GoogleFonts.montserrat(
//                               color: Colors.white,
//                               fontSize: 12,
//                             ),
//                           ),
//                         ],
//                       ),

//                       const SizedBox(height: 20),
//                       Container(
//                         height: 3,
//                         width: double.infinity,
//                         color: Colors.white,
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:car_parts_app/presentation/filterProduct/bloc/filter_bloc.dart';
import 'package:car_parts_app/presentation/filterProduct/bloc/filter_event.dart';
import 'package:car_parts_app/presentation/filterProduct/bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({
    super.key,
    required this.brandController,
    required this.carModelsController,
    required this.chassisNumberController,
    required this.onFieldChanged,
    required this.useLocation,
    required this.isLocationLoading,
    required this.onUseLocationChanged,
    this.locationError,
  });

  final TextEditingController brandController;
  final TextEditingController carModelsController;
  final TextEditingController chassisNumberController;
  final VoidCallback onFieldChanged;
  final bool useLocation;
  final bool isLocationLoading;
  final ValueChanged<bool?> onUseLocationChanged;
  final String? locationError;

  @override
  Widget build(BuildContext context) {
    // IMPORTANT: FilterBloc must be provided by an ancestor (parent) widget.
    return Drawer(
      backgroundColor: Colors.black,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              final bloc = context.read<FilterBloc>();

              final categories = state.categories;
              final brands = state.selectedConditions;

              final visibleCategoryCount = state.showAllCategories
                  ? categories.length
                  : (categories.length > 5 ? 5 : categories.length);

              final visibleBrandCount = state.showAllConditions
                  ? brands.length
                  : (brands.length > 5 ? 5 : brands.length);

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter',
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: useLocation,
                          onChanged: onUseLocationChanged,
                          activeColor: Colors.green,
                        ),
                        Text(
                          'Use Location',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (useLocation && isLocationLoading) ...[
                          const SizedBox(width: 8),
                          const SizedBox(
                            height: 14,
                            width: 14,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ],
                      ],
                    ),
                    if (useLocation && locationError != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          locationError!,
                          style: GoogleFonts.montserrat(
                            color: Colors.redAccent,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    const SizedBox(height: 20),

                    // Categories header + toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Categories',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () => bloc.add(ToggleShowAllCategories()),
                          icon: Icon(
                            state.showAllCategories
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // Categories list (safe indexing)
                    ...List.generate(visibleCategoryCount, (index) {
                      final checked = (state.selectedCategories.length > index)
                          ? state.selectedCategories[index]
                          : false;
                      return CheckboxListTile(
                        activeColor: Colors.white,
                        checkColor: Colors.white,
                        value: checked,
                        onChanged: (_) => bloc.add(ToggleCategory(index)),
                        title: Text(
                          categories[index],
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                        ),
                      );
                    }),

                    if (categories.length > 5)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => bloc.add(ToggleShowAllCategories()),
                          child: Text(
                            state.showAllCategories ? 'Show Less' : 'Show More',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                    const Divider(color: Colors.white),

                    // Brands header + toggle
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Condition',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: () => bloc.add(ToggleShowAllConditions()),
                          icon: Icon(
                            state.showAllConditions
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),

                    // Brands list (safe indexing)
                    ...List.generate(visibleBrandCount, (index) {
                      final checked = (state.selectedConditions.length > index)
                          ? state.selectedConditions[index]
                          : false;
                      return CheckboxListTile(
                        activeColor: Colors.white,
                        checkColor: Colors.white,
                        value: checked,
                        onChanged: (_) => bloc.add(ToggleCondition(index)),
                        title: Text(
                          state.conditions[index],
                          // state.selectedBrands[index],
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 0,
                        ),
                      );
                    }),

                    if (brands.length > 5)
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => bloc.add(ToggleShowAllConditions()),
                          child: Text(
                            state.showAllConditions ? 'Show Less' : 'Show More',
                            style: GoogleFonts.montserrat(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),

                    const Divider(color: Colors.white),

                    _buildInputLabel('Brand'),
                    _buildInputField(
                      controller: brandController,
                      hintText: 'e.g. Michelin',
                    ),
                    const SizedBox(height: 10),

                    _buildInputLabel('Car Model'),
                    _buildInputField(
                      controller: carModelsController,
                      hintText: 'e.g. Corolla',
                    ),
                    const SizedBox(height: 10),

                    _buildInputLabel('Chassis No'),
                    _buildInputField(
                      controller: chassisNumberController,
                      hintText: 'e.g. ABC12345',
                    ),

                    const Divider(color: Colors.white),

                    // Price Range
                    Text(
                      'Price Range',
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                    RangeSlider(
                      values: RangeValues(state.minPrice, state.maxPrice),
                      min: 0,
                      max: 1000,
                      divisions: 20,
                      labels: RangeLabels(
                        '\$${state.minPrice.round()}',
                        '\$${state.maxPrice.round()}',
                      ),
                      activeColor: Colors.white.withOpacity(0.3),
                      inactiveColor: Colors.green,
                      onChanged: (values) =>
                          bloc.add(UpdatePriceRange(values.start, values.end)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\$${state.minPrice.round()}',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '\$${state.maxPrice.round()}',
                          style: GoogleFonts.montserrat(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Container(
                      height: 3,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildInputLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: Colors.white,
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return TextField(
      controller: controller,
      onChanged: (_) => onFieldChanged(),
      style: GoogleFonts.montserrat(color: Colors.white, fontSize: 12),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.montserrat(
          color: Colors.grey.shade400,
          fontSize: 12,
        ),
        filled: true,
        fillColor: const Color(0xFF2E2E2E),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade700),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.green),
        ),
      ),
    );
  }
}
