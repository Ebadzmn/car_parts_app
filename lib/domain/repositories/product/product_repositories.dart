import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/domain/entities/product/product_details_entity.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepositories {
  Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
    String page,
    String limit, {
    String? title,
    String? category,
    String? brand,
    String? condition,
    String? carModels,
    String? chassisNumber,
    double? lowestPrice,
    double? highestPrice,
    double? userLat,
    double? userLng,
  });

  Future<Either<Failure, ProductDetailsEntity>> getProductDetails(
    String productId,
  );
}
