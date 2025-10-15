import 'package:bloc/bloc.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductUsecase productUsecase;
  HomeBloc({required this.productUsecase}) : super(HomeInitial()) {
    on<FetchCardEvent>((event, emit) async {
      final result = await productUsecase();
      result.fold(
        (failure) => emit(ProductError(message: 'Bloc Error')),
        (product) => emit(FetchCard(data: product)),
      );
    });
  }
}
