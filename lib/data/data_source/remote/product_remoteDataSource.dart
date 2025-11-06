import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ProductRemotedatasource {
  Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
    String category,
    String condition,
    double lowestPrice,
    double highestPrice,
  );
}

class ProductRemotedatasourceImpl extends ProductRemotedatasource {
  final Dio dio;
  ProductRemotedatasourceImpl(this.dio);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
    String category,
    String condition,
    double lowestPrice,
    double highestPrice,
  ) async {
    try {
      final endpoint = ApiUrls.productAdvanced;

      // 👇 dynamic query parameter map তৈরি
      final Map<String, dynamic> params = {
        "category": category.trim(),
        "condition": condition.trim(),
        "lowestPrice": lowestPrice,
        "highestPrice": highestPrice,
      };

      // 👇 এখন খালি / null / 0 (price বাদে) ফিল্ডগুলো বাদ দিচ্ছি
      params.removeWhere((key, value) {
        if (value == null) return true;
        if (value is String && value.isEmpty) return true;
        // price 0 বাদ দিতে চাইলে নিচের লাইন uncomment করো
        // if (value is num && value == 0) return true;
        return false;
      });

      // ✅ এখন শুধু valid params যাবে
      final uri = Uri.parse(endpoint)
          .replace(queryParameters: params.map((k, v) => MapEntry(k, v.toString())));

      if (kDebugMode) {
        print("🔗 Final URL: $uri");
        print("🧾 Sending Params: $params");
      }

      final response = await dio.get(endpoint, queryParameters: params);

      if (response.statusCode == 200 && response.data['success'] == true) {
        final List<dynamic> data = response.data['data'];
        final products =
            data.map((e) => ProductModel.fromJson(e)).toList();
        print("✅ Products fetched: ${products.length}");
        return Right(products);
      } else {
        return Left(ServerFailure(
            message: response.data['message'] ?? "Unknown Error"));
      }
    } on DioException catch (e) {
      return Left(ServerFailure(message: e.message ?? "Network Error"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
