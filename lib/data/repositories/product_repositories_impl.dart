import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/data_source/local/car_local_datasource.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/repositories/product/product_repositories.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoriesImpl implements ProductRepositories {
  @override
  Future<Either<Failure, List<ProductEntities>>> getProduct() async {
    try {
      final result = await CarLocalDatasource.getProduct();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: 'Local Error'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntities>>> getProductByCategory({
    required String category,
  }) async {
    try {
      final result = await CarLocalDatasource.getProduct()
          .where((product) => product.carCategory == category)
          .toList();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: 'Local Error'));
    }
  }
}
