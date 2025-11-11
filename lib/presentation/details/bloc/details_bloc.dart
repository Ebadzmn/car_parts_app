import 'package:bloc/bloc.dart';
import 'package:car_parts_app/domain/entities/product/product_details_entity.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/usecase/product/product_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:car_parts_app/core/error/failure.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ProductDetailsUsecase productDetailsUsecase;
  // If you don't use repositories directly inside the bloc, you can remove it.
  DetailsBloc({required this.productDetailsUsecase})
      : super(DetailsState.initial()) {
    // Carousel page change
    on<CaroselPageChanged>(_onCarouselChanged);

    // Tab selection
    on<SelectTabEvent>(_onSelectTab);

    // Fetch product details
    on<GetProductDetailsEvent>(_onGetProductDetails);
  }

  void _onCarouselChanged(CaroselPageChanged event, Emitter<DetailsState> emit) {
    emit(state.copyWith(carouselIndex: event.index));
  }

  void _onSelectTab(SelectTabEvent event, Emitter<DetailsState> emit) {
    emit(state.copyWith(selectedTabIndex: event.index));
  }

  Future<void> _onGetProductDetails(
      GetProductDetailsEvent event, Emitter<DetailsState> emit) async {
    emit(state.copyWith(status: DetailsStatus.loading, errorMessage: null));

    final Either<Failure, ProductDetailsEntity> result =
        await productDetailsUsecase(event.productId);

    result.fold(
      (failure) {
        // Provide better message if Failure has no message
        final message = (failure is Failure && (failure.message?.isNotEmpty ?? false))
            ? failure.message
            : 'Something went wrong';
        emit(state.copyWith(status: DetailsStatus.failure, errorMessage: message));
      },
      (product) {
        emit(state.copyWith(status: DetailsStatus.success, product:  product, errorMessage: null)); 
      },
    );
  }
}
