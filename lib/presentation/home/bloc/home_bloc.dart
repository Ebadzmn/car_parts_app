import 'package:bloc/bloc.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductUsecase productUsecase;

  HomeBloc({required this.productUsecase}) : super(HomeInitial()) {
    // on<FetchCardEvent>(_onFetchCard);
    // on<FetchProductByCategoryEvent>(_onFetchProductByCategory);
    on<ClearFilterEvent>(_onClearFilter);
  }

  // Future<void> _onFetchProductByCategory(
  //   FetchProductByCategoryEvent event,
  //   Emitter<HomeState> emit,
  // ) async {
  //   emit(HomeLoading()); // optional loading state if you have one
  //   final result = await productUsecase.getProductByCategory(
  //     category: event.category,
  //   );

  //   result.fold(
  //     (failure) => emit(ProductError(message: 'Bloc Error')),
  //     (product) => emit(FetchCard(event.category, data: product)),
  //   );
  // }

  /// 🔹 Separated Function for Fetch Logic
  // Future<void> _onFetchCard(
  //   FetchCardEvent event,
  //   Emitter<HomeState> emit,
  // ) async {
  //   emit(HomeLoading()); // optional loading state if you have one
  //   final result = await productUsecase();

  //   result.fold(
  //     (failure) => emit(ProductError(message: 'Bloc Error')),
  //     (product) => emit(FetchCard(null, data: product.products)),
  //   );
  // }

  /// 🔹 Clear Filter Event Handler
  void _onClearFilter(ClearFilterEvent event, Emitter<HomeState> emit) {
    if (state is FetchCard) {
      emit((state as FetchCard).copyWith());
    }
  }
}
