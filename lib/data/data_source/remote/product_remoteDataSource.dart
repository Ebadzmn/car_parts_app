// import 'package:car_parts_app/core/appUrls/api_urls.dart';
// import 'package:car_parts_app/core/error/failure.dart';
// import 'package:car_parts_app/data/model/product/product_model.dart';
// import 'package:car_parts_app/domain/entities/product/product_entities.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';

// abstract class ProductRemotedatasource {
//   Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
//     String page,
//     String limit,
//     String category,
//     String condition,
//     double lowestPrice,
//     double highestPrice,
//   );
// }

// class ProductRemotedatasourceImpl extends ProductRemotedatasource {
//   final Dio dio;
//   ProductRemotedatasourceImpl(this.dio);

//   @override
//   Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
//     String page,
//     String limit,
//     String category,
//     String condition,
//     double lowestPrice,
//     double highestPrice,
//   ) async {
//     try {
//       final endpoint = ApiUrls.productAdvanced;

//       // 👇 dynamic query parameter map তৈরি
//       final Map<String, dynamic> params = {
//         "page": page.trim() ?? '1',
//         "limit": limit.trim() ?? '2',
//         "category": category.trim(),
//         "condition": condition.trim(),
//         "lowestPrice": lowestPrice,
//         "highestPrice": highestPrice,
//       };

//       // 👇 এখন খালি / null / 0 (price বাদে) ফিল্ডগুলো বাদ দিচ্ছি
//       params.removeWhere((key, value) {
//         if (value == null) return true;
//         if (value is String && value.isEmpty) return true;
//         // price 0 বাদ দিতে চাইলে নিচের লাইন uncomment করো
//         // if (value is num && value == 0) return true;
//         return false;
//       });

//       // ✅ এখন শুধু valid params যাবে
//       final uri = Uri.parse(endpoint)
//           .replace(queryParameters: params.map((k, v) => MapEntry(k, v.toString())));

//       if (kDebugMode) {
//         print("🔗 Final URL: $uri");
//         print("🧾 Sending Params: $params");
//       }

//       final response = await dio.get(endpoint, queryParameters: params);

//       if (response.statusCode == 200 && response.data['success'] == true) {
//         final List<dynamic> data = response.data['data'];
//         final products =
//             data.map((e) => ProductModel.fromJson(e)).toList();
//         print("✅ Products fetched: ${products.length}");
//         return Right(products);
//       } else {
//         return Left(ServerFailure(
//             message: response.data['message'] ?? "Unknown Error"));
//       }
//     } on DioException catch (e) {
//       return Left(ServerFailure(message: e.message ?? "Network Error"));
//     } catch (e) {
//       return Left(ServerFailure(message: e.toString()));
//     }
//   }
// }


import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ProductRemotedatasource {
  Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
    String page,
    String limit,
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
    String page,
    String limit,
    String category,
    String condition,
    double lowestPrice,
    double highestPrice,
  ) async {
    try {
      final endpoint = ApiUrls.productAdvanced;

      // Build query parameters with defensive checks
      final Map<String, dynamic> params = {};

      // page & limit: use provided if not empty, otherwise defaults
      final String pageValue = page.trim().isNotEmpty ? page.trim() : '1';
      final String limitValue = limit.trim().isNotEmpty ? limit.trim() : '5';

      params['page'] = pageValue;
      params['limit'] = limitValue;

      if (category.trim().isNotEmpty) params['category'] = category.trim();
      if (condition.trim().isNotEmpty) params['condition'] = condition.trim();

      // Only include prices if they are > 0 and make sense
      if (lowestPrice > 0) params['lowestPrice'] = lowestPrice;
      if (highestPrice > 0) params['highestPrice'] = highestPrice;

      if (kDebugMode) {
        // build a debug URI so you can visually inspect final URL if needed
        final debugUri = Uri.parse(endpoint)
            .replace(queryParameters: params.map((k, v) => MapEntry(k, v.toString())));
        print("🔗 Final debug URL: $debugUri");
        print("🧾 Query Parameters being sent: $params");
      }

      // Use Dio's queryParameters directly (recommended)
      final response = await dio.get(
        endpoint,
        queryParameters: params,
      );

      // Dio's Response has .realUri which shows the final URL actually requested
      if (kDebugMode) {
        try {
          print("🌐 Request sent to: ${response.realUri}");
        } catch (_) {}
      }

      if (response.statusCode == 200 && response.data != null) {
        // Expecting a JSON structure like: { success: true, data: [...] }
        final success = response.data['success'];
        if (success == true) {
          final List<dynamic> data = response.data['data'] as List<dynamic>;
          final products = data.map((e) => ProductModel.fromJson(e)).toList();

          if (kDebugMode) print("✅ Products fetched: ${products.length}");

          // ProductModel should implement/extend ProductEntity; cast for return type
          return Right(products.cast<ProductEntity>());
        } else {
          final message = response.data['message'] ?? 'Unknown error from server';
          return Left(ServerFailure(message: message));
        }
      } else {
        return Left(ServerFailure(message: 'Invalid response from server'));
      }
    } on DioException catch (e) {
      // DioException (dio >=5) gives good details; use response/message when available
      final msg = e.message ?? (e.type.toString());
      if (kDebugMode) print("❌ DioException: $msg");
      return Left(ServerFailure(message: msg));
    } catch (e) {
      if (kDebugMode) print("❌ Unexpected error: $e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
