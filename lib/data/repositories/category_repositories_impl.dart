import 'package:car_parts_app/core/error/failure.dart';

import 'package:car_parts_app/data/data_source/remote/category_remoteDataSource.dart';
import 'package:car_parts_app/data/model/category/category_model.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/repositories/category/category_repositories.dart';
import 'package:dartz/dartz.dart';

class CategoryRepositoriesImpl implements CategoryRepository {
  final CategoryRemotedatasource categoryRemotedatasource;
  CategoryRepositoriesImpl(this.categoryRemotedatasource);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
   try {
     final result = await categoryRemotedatasource.getCategories();
     return result;
  } catch (e) {
    return Left(ServerFailure(message: e.toString()));
  }
  }
}
