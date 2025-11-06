import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/category/category_model.dart';
import 'package:car_parts_app/domain/repositories/category/category_repositories.dart';
import 'package:dartz/dartz.dart';

class CategoryUsecase {
  final CategoryRepository categoryRepository;
  CategoryUsecase(this.categoryRepository);

  Future<Either<Failure, List<CategoryModel>>> call() {
    return categoryRepository.getCategories();
  }
}
