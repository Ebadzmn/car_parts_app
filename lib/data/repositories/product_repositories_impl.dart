import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/data_source/remote/product_remoteDataSource.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';

import 'package:car_parts_app/domain/repositories/product/product_repositories.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoriesImpl implements ProductRepositories {

  final ProductRemotedatasource productRemotedatasource;

  ProductRepositoriesImpl(this.productRemotedatasource);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
    String page,
    String limit,
    String category,
    String condition,
    double lowestPrice,
    double highestPrice,
  ) async {
    try {
      final result = await productRemotedatasource.getProductByAdvancedFilter(page, limit, category, condition, lowestPrice, highestPrice);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
