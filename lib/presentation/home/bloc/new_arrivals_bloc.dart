import 'package:bloc/bloc.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:equatable/equatable.dart';

part 'new_arrivals_event.dart';
part 'new_arrivals_state.dart';

class NewArrivalsBloc extends Bloc<NewArrivalsEvent, NewArrivalsState> {
  final ProductUsecase productUsecase;

  NewArrivalsBloc({required this.productUsecase})
    : super(NewArrivalsInitial()) {
    on<FetchNewArrivalsRequested>(_onFetchNewArrivals);
    on<FetchMoreNewArrivalsRequested>(_onFetchMoreNewArrivals);
  }

  Future<void> _onFetchNewArrivals(
    FetchNewArrivalsRequested event,
    Emitter<NewArrivalsState> emit,
  ) async {
    emit(NewArrivalsLoading());

    final limit = event.limit ?? '10';

    final result = await productUsecase(
      pageParams('1', limit, '', 'new', 0.0, 0.0, null, null),
    );

    result.fold((failure) => emit(NewArrivalsError(failure.message)), (
      products,
    ) {
      final bool reachedMax = products.isEmpty;
      emit(
        NewArrivalsLoaded(
          products: products,
          currentPage: 1,
          totalPage: 1, // will be refined if API returns pagination info
          hasReachedMax: reachedMax,
          isLoadingMore: false,
          limit: limit,
        ),
      );
    });
  }

  Future<void> _onFetchMoreNewArrivals(
    FetchMoreNewArrivalsRequested event,
    Emitter<NewArrivalsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! NewArrivalsLoaded) return;
    if (currentState.isLoadingMore || currentState.hasReachedMax) return;

    final nextPage = currentState.currentPage + 1;

    emit(currentState.copyWith(isLoadingMore: true));

    final result = await productUsecase(
      pageParams(
        nextPage.toString(),
        currentState.limit,
        '',
        'new',
        0.0,
        0.0,
        null,
        null,
      ),
    );

    result.fold(
      (failure) {
        emit(currentState.copyWith(isLoadingMore: false));
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
