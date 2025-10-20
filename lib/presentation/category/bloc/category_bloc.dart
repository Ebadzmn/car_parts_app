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
  }

  Future<void> _onCategoryEvent(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    if (event is LoadCategoryEvent) {
      emit(CategoryLoading());
      final result = await categoryUsecase();
      result.fold(
        (failure) => emit(CategoryError(message: failure.message)),
        (products) => emit(CategoryLoaded(products)),
      );
    }
  }
}
