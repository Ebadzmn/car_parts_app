// part of 'product_advamce_bloc.dart';

// sealed class ProductAdvamceState extends Equatable {
//   const ProductAdvamceState();
  
//   @override
//   List<Object> get props => [];
// }

// final class ProductAdvamceInitial extends ProductAdvamceState {}

// final class ProductAdvamceLoading extends ProductAdvamceState {}

// // final class ProductAdvamceSuccess extends ProductAdvamceState {
// //   final List<ProductEntity> productEntity;

// //   ProductAdvamceSuccess(this.productEntity);

// //   @override
// //   List<Object> get props => [productEntity];
// // }


import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:equatable/equatable.dart';

abstract class ProductAdvamceState extends Equatable {
  const ProductAdvamceState();

  @override
  List<Object?> get props => [];
}

class ProductAdvamceInitial extends ProductAdvamceState {}

class ProductAdvamceLoading extends ProductAdvamceState {}

class ProductAdvamceFailure extends ProductAdvamceState {
  final String message;
  const ProductAdvamceFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Success state keeps the accumulated products, current page, whether we reached last page,
/// and whether a "load more" is currently in progress.
class ProductAdvamceSuccess extends ProductAdvamceState {
  final List<ProductEntity> products;
  final int currentPage;
  final bool hasReachedMax;
  final bool isLoadingMore;
  final String limit;
  final String category;
  final String condition;
  final double lowestPrice;
  final double highestPrice;

  const ProductAdvamceSuccess({
    required this.products,
    required this.currentPage,
    required this.hasReachedMax,
    required this.isLoadingMore,
    required this.limit,
    required this.category,
    required this.condition,
    required this.lowestPrice,
    required this.highestPrice,
  });

  ProductAdvamceSuccess copyWith({
    List<ProductEntity>? products,
    int? currentPage,
    bool? hasReachedMax,
    bool? isLoadingMore,
    String? limit,
    String? category,
    String? condition,
    double? lowestPrice,
    double? highestPrice,
  }) {
    return ProductAdvamceSuccess(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      limit: limit ?? this.limit,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      lowestPrice: lowestPrice ?? this.lowestPrice,
      highestPrice: highestPrice ?? this.highestPrice,
    );
  }

  @override
  List<Object?> get props => [
        products,
        currentPage,
        hasReachedMax,
        isLoadingMore,
        limit,
        category,
        condition,
        lowestPrice,
        highestPrice,
      ];
}



