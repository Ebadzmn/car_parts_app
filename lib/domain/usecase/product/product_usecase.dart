import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/repositories/product/product_repositories.dart';
import 'package:dartz/dartz.dart';

class ProductUsecase {
  final ProductRepositories repositories;

  ProductUsecase(this.repositories);

  Future<Either<Failure, List<ProductEntities>>> call() {
    return repositories.getProduct();
  }
}
