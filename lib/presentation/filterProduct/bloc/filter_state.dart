import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final List<bool> selectedCategories;
  final List<bool> selectedBrands;
  final bool showAllCategories;
  final bool showAllBrands;
  final double minPrice;
  final double maxPrice;

  const FilterState({
    required this.selectedCategories,
    required this.selectedBrands,
    this.showAllCategories = false,
    this.showAllBrands = false,
    this.minPrice = 0,
    this.maxPrice = 1000,
  });

  FilterState copyWith({
    List<bool>? selectedCategories,
    List<bool>? selectedBrands,
    bool? showAllCategories,
    bool? showAllBrands,
    double? minPrice,
    double? maxPrice,
  }) {
    return FilterState(
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedBrands: selectedBrands ?? this.selectedBrands,
      showAllCategories: showAllCategories ?? this.showAllCategories,
      showAllBrands: showAllBrands ?? this.showAllBrands,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object> get props => [
    selectedCategories,
    selectedBrands,
    showAllCategories,
    showAllBrands,
    minPrice,
    maxPrice,
  ];
}
