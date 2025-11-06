import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/category/category_model.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepository {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}
