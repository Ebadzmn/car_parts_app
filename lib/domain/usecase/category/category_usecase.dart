import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:car_parts_app/domain/repositories/category/category_repositories.dart';
import 'package:dartz/dartz.dart';

class CategoryUsecase {
  final CategoryRepository categoryRepository;
  CategoryUsecase(this.categoryRepository);

  Future<Either<Failure, List<ProductEntities>>> call() {
    return categoryRepository.getProduct();
  }

  Future<Either<Failure, List<ProductEntities>>> getProductByCategory(
    String categoryId,
  ) {
    return categoryRepository.getProductByCategory(categoryId);
  }
}
