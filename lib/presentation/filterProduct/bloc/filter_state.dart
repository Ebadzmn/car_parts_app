import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final List<String> categories;
  final List<String> conditions;
  final List<bool> selectedCategories;
  final List<bool> selectedConditions;
  final bool showAllCategories;
  final bool showAllConditions;
  final double minPrice;
  final double maxPrice;

  const FilterState({
    required this.categories,
    required this.conditions, 
    required this.selectedCategories,
    required this.selectedConditions,
    this.showAllCategories = false,
    this.showAllConditions = false,
    this.minPrice = 0,
    this.maxPrice = 1000,
  });

  FilterState copyWith({
    List<String>? categories,
    List<bool>? selectedCategories,
    List<bool>? selectedConditions,
    bool? showAllCategories,
    bool? showAllConditions,  
    double? minPrice,
    double? maxPrice,
  }) {
    return FilterState( 
      categories: categories ?? this.categories,
      conditions: conditions,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedConditions: selectedConditions ?? this.selectedConditions,
      showAllCategories: showAllCategories ?? this.showAllCategories,
      showAllConditions: showAllConditions ?? this.showAllConditions,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object> get props => [
    categories,
    selectedCategories,
    selectedConditions,
    showAllCategories,
    showAllConditions,      
    minPrice,
    maxPrice,
  ];
}
