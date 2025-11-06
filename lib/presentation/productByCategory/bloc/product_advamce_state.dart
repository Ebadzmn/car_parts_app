part of 'product_advamce_bloc.dart';

sealed class ProductAdvamceState extends Equatable {
  const ProductAdvamceState();
  
  @override
  List<Object> get props => [];
}

final class ProductAdvamceInitial extends ProductAdvamceState {}

final class ProductAdvamceLoading extends ProductAdvamceState {}

final class ProductAdvamceSuccess extends ProductAdvamceState {
  final List<ProductEntity> productEntity;

  ProductAdvamceSuccess(this.productEntity);

  @override
  List<Object> get props => [productEntity];
}


final class ProductAdvamceFailure extends ProductAdvamceState {
  final String message;

  ProductAdvamceFailure(this.message);

  @override
  List<Object> get props => [message];
}
