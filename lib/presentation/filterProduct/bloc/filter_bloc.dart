import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final int categoryCount;
  final int brandCount;

  FilterBloc({required this.categoryCount, required this.brandCount})
    : super(
        FilterState(
          selectedCategories: List.filled(categoryCount, false),
          selectedBrands: List.filled(brandCount, false),
        ),
      ) {
    on<ToggleCategory>((event, emit) {
      final newCategories = List<bool>.from(state.selectedCategories);
      newCategories[event.index] = !newCategories[event.index];
      emit(state.copyWith(selectedCategories: newCategories));
    });

    on<ToggleBrand>((event, emit) {
      final newBrands = List<bool>.from(state.selectedBrands);
      newBrands[event.index] = !newBrands[event.index];
      emit(state.copyWith(selectedBrands: newBrands));
    });

    on<ToggleShowAllCategories>((event, emit) {
      emit(state.copyWith(showAllCategories: !state.showAllCategories));
    });

    on<ToggleShowAllBrands>((event, emit) {
      emit(state.copyWith(showAllBrands: !state.showAllBrands));
    });

    on<UpdatePriceRange>((event, emit) {
      emit(state.copyWith(minPrice: event.min, maxPrice: event.max));
    });
  }
}
