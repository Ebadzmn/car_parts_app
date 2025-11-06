part of 'product_advamce_bloc.dart';

abstract class ProductAdvamceEvent extends Equatable {
  const ProductAdvamceEvent();

  @override
  List<Object> get props => [];
}

class getProductByAdvancedFilterEvent  extends ProductAdvamceEvent {
  final String category;
  final String condition;
  final double lowestPrice;
  final double highestPrice;

  getProductByAdvancedFilterEvent(this.category, this.condition, this.lowestPrice, this.highestPrice);

  @override
  List<Object> get props => [category, condition, lowestPrice, highestPrice];
}
