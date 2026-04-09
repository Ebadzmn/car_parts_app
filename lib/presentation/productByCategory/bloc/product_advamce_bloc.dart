// import 'package:bloc/bloc.dart';
// import 'package:car_parts_app/data/model/product/product_model.dart';
// import 'package:car_parts_app/domain/entities/product/product_entities.dart';
// import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
// import 'package:equatable/equatable.dart';

// part 'product_advamce_event.dart';
// part 'product_advamce_state.dart';

// class ProductAdvamceBloc extends Bloc<ProductAdvamceEvent, ProductAdvamceState> {
//   final ProductUsecase productUsecase;

//   ProductAdvamceBloc(this.productUsecase) : super(ProductAdvamceInitial()) {
//     on<getProductByAdvancedFilterEvent>(_onGetProductByAdvancedFilterEvent);
//   }

//   Future<void> _onGetProductByAdvancedFilterEvent(
//     getProductByAdvancedFilterEvent event,
//     Emitter<ProductAdvamceState> emit,
//   ) async {
//     emit(ProductAdvamceLoading());
//     final result = await productUsecase(
//       pageParams(
//         event.page,
//         event.limit,
//         event.category,
//         event.condition,
//         event.lowestPrice,
//         event.highestPrice,
//       ),
//     );
//     result.fold(
//       (failure) => emit(ProductAdvamceFailure(failure.message)),
//       (products) => emit(ProductAdvamceSuccess(products)),
//       // (products) => emit(ProductAdvamceSuccess(products.map((e) => e.toEntity()).toList())),
//     );
//   }
// }

import 'package:bloc/bloc.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:car_parts_app/presentation/productByCategory/bloc/product_advamce_state.dart';
import 'package:equatable/equatable.dart';
part 'product_advamce_event.dart';

class ProductAdvamceBloc
    extends Bloc<ProductAdvamceEvent, ProductAdvamceState> {
  final ProductUsecase productUsecase;

  ProductAdvamceBloc(this.productUsecase) : super(ProductAdvamceInitial()) {
    on<getProductByAdvancedFilterEvent>(_onGetInitialProducts);
    on<LoadMoreProductsEvent>(_onLoadMoreProducts);
  }

  Future<void> _onGetInitialProducts(
    getProductByAdvancedFilterEvent event,
    Emitter<ProductAdvamceState> emit,
  ) async {
    emit(ProductAdvamceLoading());

    final result = await productUsecase(
      pageParams(
        page: event.page,
        limit: event.limit,
        title: event.title,
        category: event.category,
        brand: event.brand,
        condition: event.condition,
        carModels: event.carModels,
        chassisNumber: event.chassisNumber,
        lowestPrice: event.lowestPrice,
        highestPrice: event.highestPrice,
        userLat: event.userLat,
        userLng: event.userLng,
      ),
    );

    result.fold((failure) => emit(ProductAdvamceFailure(failure.message)), (
      products,
    ) {
      // determine page integer safely
      final int currentPage = int.tryParse(event.page ?? '1') ?? 1;
      final bool reachedMax = products.isEmpty;
      emit(
        ProductAdvamceSuccess(
          products: products,
          currentPage: currentPage,
          hasReachedMax: reachedMax,
          isLoadingMore: false,
          limit: event.limit ?? '10',
          title: event.title,
          category: event.category,
          brand: event.brand,
          condition: event.condition,
          carModels: event.carModels,
          chassisNumber: event.chassisNumber,
          lowestPrice: event.lowestPrice,
          highestPrice: event.highestPrice,
          userLat: event.userLat,
          userLng: event.userLng,
        ),
      );
    });
  }

  Future<void> _onLoadMoreProducts(
    LoadMoreProductsEvent event,
    Emitter<ProductAdvamceState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ProductAdvamceSuccess) return;

    // if already loading more OR already reached max, do nothing
    if (currentState.isLoadingMore || currentState.hasReachedMax) return;

    final nextPage = currentState.currentPage + 1;

    // mark loading more
    emit(currentState.copyWith(isLoadingMore: true));

    final result = await productUsecase(
      pageParams(
        page: nextPage.toString(),
        limit: currentState.limit,
        title: currentState.title,
        category: currentState.category,
        brand: currentState.brand,
        condition: currentState.condition,
        carModels: currentState.carModels,
        chassisNumber: currentState.chassisNumber,
        lowestPrice: currentState.lowestPrice,
        highestPrice: currentState.highestPrice,
        userLat: currentState.userLat,
        userLng: currentState.userLng,
      ),
    );

    result.fold(
      (failure) {
        // stop loading more but keep existing products and don't change page
        emit(currentState.copyWith(isLoadingMore: false));
        // optionally, could emit a separate failure state — here we keep UX simple
      },
      (newProducts) {
        final bool reachedMax = newProducts.isEmpty;
        final combined = List<ProductEntity>.from(currentState.products)
          ..addAll(newProducts);

        emit(
          currentState.copyWith(
            products: combined,
            currentPage: nextPage,
            hasReachedMax: reachedMax,
            isLoadingMore: false,
          ),
        );
      },
    );
  }
}
