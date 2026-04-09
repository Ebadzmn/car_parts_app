// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'filter_event.dart';
// import 'filter_state.dart';

// class FilterBloc extends Bloc<FilterEvent, FilterState> {
//   final int categoryCount;
//   final int brandCount;

//   FilterBloc({required this.categoryCount, required this.brandCount})
//     : super(
//         FilterState(
//           selectedCategories: List.filled(categoryCount, false),
//           selectedBrands: List.filled(brandCount, false),
//         ),
//       ) {
//     on<ToggleCategory>((event, emit) {
//       final newCategories = List<bool>.from(state.selectedCategories);
//       newCategories[event.index] = !newCategories[event.index];
//       emit(state.copyWith(selectedCategories: newCategories));
//     });

//     on<ToggleBrand>((event, emit) {
//       final newBrands = List<bool>.from(state.selectedBrands);
//       newBrands[event.index] = !newBrands[event.index];
//       emit(state.copyWith(selectedBrands: newBrands));
//     });

//     on<ToggleShowAllCategories>((event, emit) {
//       emit(state.copyWith(showAllCategories: !state.showAllCategories));
//     });

//     on<ToggleShowAllBrands>((event, emit) {
//       emit(state.copyWith(showAllBrands: !state.showAllBrands));
//     });

//     on<UpdatePriceRange>((event, emit) {
//       emit(state.copyWith(minPrice: event.min, maxPrice: event.max));
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'filter_event.dart';
import 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc()
    : super(
        FilterState(
          categories: [],
          conditions: ['new', 'used', 'refurbished'],
          selectedCategories: const [],
          selectedConditions: [false, false, false],
          showAllCategories: false,
          showAllConditions: false,
          minPrice: 0,
          maxPrice: 1000,
        ),
      ) {
    // 🔹 Initialize filters when categories arrive
    on<InitializeFilters>(_onInitializeFilters);

    // 🔹 Toggle category
    on<ToggleCategory>((event, emit) {
      if (event.index < 0 || event.index >= state.selectedCategories.length)
        return;

      final updated = List<bool>.from(state.selectedCategories);
      updated[event.index] = !updated[event.index];
      emit(state.copyWith(selectedCategories: updated));
    });

    // 🔹 Toggle condition
    on<ToggleCondition>((event, emit) {
      if (event.index < 0 || event.index >= state.selectedConditions.length)
        return;

      final updated = List<bool>.from(state.selectedConditions);
      updated[event.index] = !updated[event.index];
      emit(state.copyWith(selectedConditions: updated));
    });

    // 🔹 Show / Hide category list
    on<ToggleShowAllCategories>((event, emit) {
      emit(state.copyWith(showAllCategories: !state.showAllCategories));
    });

    // 🔹 Show / Hide condition list
    on<ToggleShowAllConditions>((event, emit) {
      emit(state.copyWith(showAllConditions: !state.showAllConditions));
    });

    // 🔹 Price Range update
    on<UpdatePriceRange>((event, emit) {
      final double min = event.min < 0 ? 0.0 : event.min;
      final double max = event.max < min ? min : event.max;

      emit(state.copyWith(minPrice: min, maxPrice: max));
    });

    // 🔹 Reset filters
    on<ResetFilters>((event, emit) {
      emit(
        state.copyWith(
          selectedCategories: List<bool>.filled(state.categories.length, false),
          selectedConditions: List<bool>.filled(state.conditions.length, false),
          minPrice: 0,
          maxPrice: 1000,
          showAllCategories: false,
          showAllConditions: false,
        ),
      );
    });
  }

  // 🔹 Handle category initialization
  void _onInitializeFilters(
    InitializeFilters event,
    Emitter<FilterState> emit,
  ) {
    final newCategories = List<String>.from(event.categories);
    final newConditions = List<String>.from(event.conditions);
    final newSelectedCategories = List<bool>.filled(
      newCategories.length,
      false,
    );
    final newSelectedConditions = List<bool>.filled(
      newConditions.length,
      false,
    );

    emit(
      state.copyWith(
        categories: newCategories,

        selectedCategories: newSelectedCategories,
        selectedConditions: newSelectedConditions,
      ),
    );
  }
}
