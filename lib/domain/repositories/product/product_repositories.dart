import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/domain/entities/product/product_details_entity.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepositories {
  Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
     String page,
     String limit,
     String category,
     String condition,
     double lowestPrice,
     double highestPrice,
  );

  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(String productId);
}
