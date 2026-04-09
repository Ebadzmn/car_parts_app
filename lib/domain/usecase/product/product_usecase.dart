import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/domain/entities/product/product_details_entity.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/repositories/product/product_repositories.dart';
import 'package:dartz/dartz.dart';

class ProductUsecase {
  final ProductRepositories repositories;

  ProductUsecase(this.repositories);

  Future<Either<Failure, List<ProductEntity>>> call(pageParams params) {
    return repositories.getProductByAdvancedFilter(
      params.page ?? '',
      params.limit ?? '',
      title: params.title,
      category: params.category,
      brand: params.brand,
      condition: params.condition,
      carModels: params.carModels,
      chassisNumber: params.chassisNumber,
      lowestPrice: params.lowestPrice,
      highestPrice: params.highestPrice,
      userLat: params.userLat,
      userLng: params.userLng,
    );
  }
}

class ProductDetailsUsecase {
  final ProductRepositories repositories;

  ProductDetailsUsecase(this.repositories);

  Future<Either<Failure, ProductDetailsEntity>> call(String productId) {
    return repositories.getProductDetails(productId);
  }
}

class pageParams {
  final String? page;
  final String? limit;
  final String? title;
  final String? category;
  final String? brand;
  final String? condition;
  final String? carModels;
  final String? chassisNumber;
  final double? lowestPrice;
  final double? highestPrice;
  final double? userLat;
  final double? userLng;

  pageParams({
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
  });
}
