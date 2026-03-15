import 'package:bloc/bloc.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductUsecase productUsecase;

  HomeBloc({required this.productUsecase}) : super(HomeInitial()) {
    on<FetchCardEvent>(_onFetchCard);
    on<FetchProductByCategoryEvent>(_onFetchProductByCategory);
    on<ClearFilterEvent>(_onClearFilter);
  }

  Future<void> _onFetchCard(
    FetchCardEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const HomeLoading(currentCategory: 'All'));
    // Empty pageParams fetches all (default limit/page)
    final result = await productUsecase.call(
      pageParams(null, null, null, null, null, null, null, null),
    );

    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (products) => emit(FetchCard('All', data: products)),
    );
  }

  Future<void> _onFetchProductByCategory(
    FetchProductByCategoryEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading(currentCategory: event.category));
    // Filter by the selected category
    final result = await productUsecase.call(
      pageParams(null, null, event.category, null, null, null, null, null),
    );

    result.fold(
      (failure) => emit(ProductError(message: failure.message)),
      (products) => emit(FetchCard(event.category, data: products)),
    );
  }

  /// 🔹 Clear Filter Event Handler
  void _onClearFilter(ClearFilterEvent event, Emitter<HomeState> emit) {
    if (state is FetchCard) {
      emit((state as FetchCard).copyWith());
    }
  }
}
