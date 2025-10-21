import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();
  @override
  List<Object?> get props => [];
}

class ToggleCategory extends FilterEvent {
  final int index;
  const ToggleCategory(this.index);

  @override
  List<Object?> get props => [index];
}

class ToggleBrand extends FilterEvent {
  final int index;
  const ToggleBrand(this.index);

  @override
  List<Object?> get props => [index];
}

class ToggleShowAllCategories extends FilterEvent {}

class ToggleShowAllBrands extends FilterEvent {}

class UpdatePriceRange extends FilterEvent {
  final double min;
  final double max;
  const UpdatePriceRange(this.min, this.max);

  @override
  List<Object?> get props => [min, max];
}
