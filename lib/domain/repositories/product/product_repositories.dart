import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:dartz/dartz.dart';

abstract class ProductRepositories {
  Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
     String category,
     String condition,
     double lowestPrice,
     double highestPrice,
  );
}
