import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
  @override
  List<Object?> get props => [];
}

class InitializeFilters extends FilterEvent {
  final List<String> categories;
  final List<String> conditions;
  InitializeFilters({required this.categories, required this.conditions});

  @override
  List<Object?> get props => [categories, conditions];
}

class ToggleCategory extends FilterEvent {
  final int index;
  const ToggleCategory(this.index);

  @override
  List<Object?> get props => [index];
}

class ToggleCondition extends FilterEvent {
  final int index;
  const ToggleCondition(this.index);

  @override
  List<Object?> get props => [index];
}

class ToggleShowAllCategories extends FilterEvent {}

class ToggleShowAllConditions extends FilterEvent {}

class UpdatePriceRange extends FilterEvent {
  final double min;
  final double max;
  const UpdatePriceRange(this.min, this.max);

  @override
  List<Object?> get props => [min, max];
}

class ResetFilters extends FilterEvent {}

