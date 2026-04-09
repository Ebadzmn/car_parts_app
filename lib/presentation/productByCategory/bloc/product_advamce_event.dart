part of 'product_advamce_bloc.dart';

abstract class ProductAdvamceEvent extends Equatable {
  const ProductAdvamceEvent();

  @override
  List<Object> get props => [];
}

class getProductByAdvancedFilterEvent extends ProductAdvamceEvent {
  final String? page;
  final String? limit;
  final String title;
  final String category;
  final String brand;
  final String condition;
  final String carModels;
  final String chassisNumber;
  final double? lowestPrice;
  final double? highestPrice;
  final double? userLat;
  final double? userLng;

  getProductByAdvancedFilterEvent(
    this.page,
    this.limit,
    this.title,
    this.category,
    this.brand,
    this.condition,
    this.carModels,
    this.chassisNumber,
    this.lowestPrice,
    this.highestPrice,
    this.userLat,
    this.userLng,
  );

  @override
  List<Object> get props => [
    page ?? '',
    limit ?? '',
    title,
    category,
    brand,
    condition,
    carModels,
    chassisNumber,
    lowestPrice ?? 0.0,
    highestPrice ?? 0.0,
    userLat ?? 0.0,
    userLng ?? 0.0,
  ];
}

class LoadMoreProductsEvent extends ProductAdvamceEvent {}
