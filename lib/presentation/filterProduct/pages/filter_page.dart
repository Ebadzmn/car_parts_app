import 'package:car_parts_app/presentation/filterProduct/bloc/filter_bloc.dart';
import 'package:car_parts_app/presentation/filterProduct/bloc/filter_event.dart';
import 'package:car_parts_app/presentation/filterProduct/bloc/filter_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterDrawer extends StatelessWidget {
  final List<String> categories;
  final List<String> brands;

  const FilterDrawer({
    super.key,
    required this.categories,
    required this.brands,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FilterBloc(
        categoryCount: categories.length,
        brandCount: brands.length,
      ),
      child: Drawer(
        backgroundColor: Colors.black,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                final bloc = context.read<FilterBloc>();

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
                      const SizedBox(height: 20),

                      // Categories
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
                      ...List.generate(
                        state.showAllCategories ? categories.length : 5,
                        (index) {
                          return CheckboxListTile(
                            activeColor: Colors.white,
                            checkColor: Colors.white,
                            value: state.selectedCategories[index],
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
                        },
                      ),
                      if (categories.length > 5)
                        

                      const Divider(color: Colors.white),

                      // Brands
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Brands',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                              color: Colors.white,
                            ),
                          ),

                          IconButton(
                            onPressed: () => bloc.add(ToggleShowAllBrands()),
                            icon: Icon(
                              state.showAllBrands
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      ...List.generate(
                        state.showAllBrands ? brands.length : 5,
                        (index) {
                          return CheckboxListTile(
                            activeColor: Colors.white,
                            checkColor: Colors.white,
                            value: state.selectedBrands[index],
                            onChanged: (_) => bloc.add(ToggleBrand(index)),
                            title: Row(
                              children: [
                                Text(
                                  brands[index],
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),

                                
                              ],
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 0,
                            ),
                          );
                        },
                      ),
                      if (brands.length > 5)
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => bloc.add(ToggleShowAllBrands()),
                            child: Text(
                              state.showAllBrands ? 'Show Less' : 'Show More',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
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
                        onChanged: (values) => bloc.add(
                          UpdatePriceRange(values.start, values.end),
                        ),
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
      ),
    );
  }
}
