part of 'product_advamce_bloc.dart';

abstract class ProductAdvamceEvent extends Equatable {
  const ProductAdvamceEvent();

  @override
  List<Object> get props => [];
}

class getProductByAdvancedFilterEvent  extends ProductAdvamceEvent {
  final String? page;
  final String? limit;
  final String category;
  final String condition;
  final double lowestPrice;
  final double highestPrice;
  final double lat;
  final double lng;

  getProductByAdvancedFilterEvent(
    this.page,
    this.limit,
    this.category,
    this.condition,
    this.lowestPrice,
    this.highestPrice,
    this.lat,
    this.lng,
  );

  @override
  List<Object> get props => [
        page ?? '',
        limit ?? '',
        category,
        condition,
        lowestPrice,
        highestPrice,
        lat,
        lng,
      ];
}

class LoadMoreProductsEvent extends ProductAdvamceEvent {}
