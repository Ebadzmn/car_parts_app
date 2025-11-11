part of 'details_bloc.dart';

enum DetailsStatus { initial, loading, success, failure }

class DetailsState extends Equatable {
  final DetailsStatus status;
  final ProductDetailsEntity? product; // from domain entity
  final String? errorMessage;
  final int carouselIndex;
  final int selectedTabIndex;

  const DetailsState({
    required this.status,
    this.product,
    this.errorMessage,
    this.carouselIndex = 0,
    this.selectedTabIndex = 0,
  });

  // convenience initial
  factory DetailsState.initial() {
    return const DetailsState(status: DetailsStatus.initial);
  }

  DetailsState copyWith({
    DetailsStatus? status,
    ProductDetailsEntity? product,
    String? errorMessage,
    int? carouselIndex,
    int? selectedTabIndex,
  }) {
    return DetailsState(
      status: status ?? this.status,
      product: product as ProductDetailsEntity? ?? this.product,
      errorMessage: errorMessage ?? this.errorMessage,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
    );
  }

  @override
  List<Object?> get props => [
        status,
        product,
        errorMessage,
        carouselIndex,
        selectedTabIndex,
      ];
}
