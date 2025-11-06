import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/category/category_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class CategoryRemotedatasource {
  Future<Either<Failure, List<CategoryModel>>> getCategories();
}


class CategoryRemotedatasourceImpl extends CategoryRemotedatasource {
  final Dio dio;
  CategoryRemotedatasourceImpl(this.dio);

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories() async {
    try {
      final response = await dio.get(ApiUrls.getCategories);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        final categories = data.map((e) => CategoryModel.fromJson(e)).toList();
        print("✅ Categories fetched: ${categories.length}");
        return Right(categories);
      } else {
        return Left(ServerFailure(message: response.data['message'] ?? "Unknown Error"));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? "Network Error"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
