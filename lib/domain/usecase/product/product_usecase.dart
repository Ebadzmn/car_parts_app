import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/repositories/product/product_repositories.dart';
import 'package:dartz/dartz.dart';

class ProductUsecase {
  final ProductRepositories repositories;

  ProductUsecase(this.repositories);

  Future<Either<Failure, List<ProductEntity>>> call(
    pageParams params,
  ) {
    return repositories.getProductByAdvancedFilter(
      params.category ?? '',
      params.condition ?? '',
      params.lowestPrice ?? 0.0,
      params.highestPrice ?? 0.0,
    );
  }
}

class pageParams {
  final String? category;
  final String? condition;
  final double? lowestPrice;
  final double? highestPrice;

  pageParams(
     this.category,
     this.condition,
     this.lowestPrice,
     this.highestPrice,
  );
}
