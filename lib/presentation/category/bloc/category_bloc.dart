import 'package:bloc/bloc.dart';
import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/usecase/category/category_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryUsecase categoryUsecase;

  CategoryBloc({required this.categoryUsecase}) : super(CategoryInitial()) {
    on<CategoryEvent>(_onCategoryEvent);
    // on<LoadProductByCategoryEvent>(_onLoadProductByCategoryEvent);
    // on<SelectCategoryEvent>(_onSelectCategoryEvent);
  }

  // Future<void> _onSelectCategoryEvent(
  //   SelectCategoryEvent event,
  //   Emitter<CategoryState> emit,
  // ) async {
  //   if (state is CategoryLoaded) {
  //     final currentState = state as CategoryLoaded;
  //     List<String> updatedCategories = List.from(currentState.selectCategories);
  //     if (updatedCategories.contains(event.categoryId)) {
  //       updatedCategories.remove(event.categoryId);
  //     } else {
  //       updatedCategories.add(event.categoryId);
  //     }
  //     emit(currentState.copyWith(selectCategories: updatedCategories));
  //   }
  // }

  // Future<void> _onLoadProductByCategoryEvent(
  //   LoadProductByCategoryEvent event,
  //   Emitter<CategoryState> emit,
  // ) async {
  //   final result = await categoryUsecase.getProductByCategory(event.categoryId);
  //   result.fold(
  //     (failure) => emit(CategoryError(message: failure.message)),
  //     (products) => emit(CategoryLoaded(products, [event.categoryId])),
  //   );
  // }

  Future<void> _onCategoryEvent(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if (event is LoadCategoryEvent) {
      final result = await categoryUsecase();
      result.fold(
        (failure) => emit(CategoryError(message: failure.message)),
        (products) => emit(CategoryLoaded(products)),
      );
    }
  }
}
