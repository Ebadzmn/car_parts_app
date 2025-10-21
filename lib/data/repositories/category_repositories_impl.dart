import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/data_source/local/car_local_datasource.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/repositories/category/category_repositories.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoriesImpl implements CategoryRepository {
  @override
  Future<Either<Failure, List<ProductEntities>>> getProduct() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      final result = await CarLocalDatasource.getProduct();
      print(result);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntities>>> getProductByCategory(
    String categoryId,
  ) async {
    try {
      final allProduct = await CarLocalDatasource.getProduct();
      final result = allProduct
          .where((product) => product.carCategory == categoryId)
          .toList();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
