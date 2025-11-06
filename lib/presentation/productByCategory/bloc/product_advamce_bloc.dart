import 'package:bloc/bloc.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:equatable/equatable.dart';

part 'product_advamce_event.dart';
part 'product_advamce_state.dart';

class ProductAdvamceBloc extends Bloc<ProductAdvamceEvent, ProductAdvamceState> {
  final ProductUsecase productUsecase;

  ProductAdvamceBloc(this.productUsecase) : super(ProductAdvamceInitial()) {
    on<getProductByAdvancedFilterEvent>(_onGetProductByAdvancedFilterEvent);
  }

  Future<void> _onGetProductByAdvancedFilterEvent(
    getProductByAdvancedFilterEvent event,
    Emitter<ProductAdvamceState> emit,
  ) async {
    emit(ProductAdvamceLoading());
    final result = await productUsecase(
      pageParams(
        event.category,
        event.condition,
        event.lowestPrice,
        event.highestPrice,
      ),
    );
    result.fold(
      (failure) => emit(ProductAdvamceFailure(failure.message)),
      (products) => emit(ProductAdvamceSuccess(products)),
      // (products) => emit(ProductAdvamceSuccess(products.map((e) => e.toEntity()).toList())),
    );
  }
}
