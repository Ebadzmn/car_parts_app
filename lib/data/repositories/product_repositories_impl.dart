import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/data_source/remote/product_remoteDataSource.dart';
import 'package:car_parts_app/data/model/product/product_details_model.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';

import 'package:car_parts_app/domain/repositories/product/product_repositories.dart';
import 'package:dartz/dartz.dart';

class ProductRepositoriesImpl implements ProductRepositories {
  final ProductRemotedatasource productRemotedatasource;

  ProductRepositoriesImpl(this.productRemotedatasource);

  @override
  Future<Either<Failure, List<ProductModel>>> getProductByAdvancedFilter(
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
  }) async {
    try {
      final result = await productRemotedatasource.getProductByAdvancedFilter(
        page,
        limit,
        title: title,
        category: category,
        brand: brand,
        condition: condition,
        carModels: carModels,
        chassisNumber: chassisNumber,
        lowestPrice: lowestPrice,
        highestPrice: highestPrice,
        userLat: userLat,
        userLng: userLng,
      );
      return result.map(
        (products) =>
            products.map((product) => product as ProductModel).toList(),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
    String productId,
  ) async {
    try {
      final result = await productRemotedatasource.getProductDetails(productId);
      return result;
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
