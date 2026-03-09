part of 'new_arrivals_bloc.dart';

abstract class NewArrivalsState extends Equatable {
  const NewArrivalsState();

  @override
  List<Object?> get props => [];
}

class NewArrivalsInitial extends NewArrivalsState {}

class NewArrivalsLoading extends NewArrivalsState {}

class NewArrivalsLoaded extends NewArrivalsState {
  final List<ProductEntity> products;
  final int currentPage;
  final int totalPage;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String limit;

  const NewArrivalsLoaded({
    required this.products,
    required this.currentPage,
    required this.totalPage,
    required this.hasReachedMax,
    required this.isLoadingMore,
    required this.limit,
  });

  NewArrivalsLoaded copyWith({
    List<ProductEntity>? products,
    int? currentPage,
    int? totalPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? limit,
  }) {
    return NewArrivalsLoaded(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      totalPage: totalPage ?? this.totalPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      limit: limit ?? this.limit,
    );
  }

  @override
  List<Object?> get props => [
    products,
    currentPage,
    totalPage,
    hasReachedMax,
    isLoadingMore,
    limit,
  ];
}

class NewArrivalsError extends NewArrivalsState {
  final String message;
  const NewArrivalsError(this.message);

  @override
  List<Object?> get props => [message];
}
