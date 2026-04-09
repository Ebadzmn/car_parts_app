import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/product/product_details_model.dart';
import 'package:car_parts_app/data/model/product/product_model.dart';
import 'package:car_parts_app/domain/entities/product/product_entities.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ProductRemotedatasource {
  Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
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
  });

  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
    String productId,
  );
}

class ProductRemotedatasourceImpl extends ProductRemotedatasource {
  final Dio dio;
  ProductRemotedatasourceImpl(this.dio);

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductByAdvancedFilter(
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
      final endpoint = ApiUrls.productSearch;

      final Map<String, dynamic> params = {};
      final String pageValue = page.trim().isNotEmpty ? page.trim() : '1';
      final String limitValue = limit.trim().isNotEmpty ? limit.trim() : '5';

      params['page'] = pageValue;
      params['limit'] = limitValue;
      if ((title ?? '').trim().isNotEmpty) params['title'] = title!.trim();
      if ((category ?? '').trim().isNotEmpty) {
        params['category'] = category!.trim();
      }
      if ((brand ?? '').trim().isNotEmpty) params['brand'] = brand!.trim();
      if ((condition ?? '').trim().isNotEmpty) {
        params['condition'] = condition!.trim();
      }
      if ((carModels ?? '').trim().isNotEmpty) {
        params['carModels'] = carModels!.trim();
      }
      if ((chassisNumber ?? '').trim().isNotEmpty) {
        params['chassisNumber'] = chassisNumber!.trim();
      }
      if (lowestPrice != null && lowestPrice > 0) {
        params['lowestPrice'] = lowestPrice;
      }
      if (highestPrice != null && highestPrice > 0) {
        params['highestPrice'] = highestPrice;
      }
      if (userLat != null && userLng != null) {
        params['userLat'] = userLat;
        params['userLng'] = userLng;
      }

      if (kDebugMode) {
        final debugUri = Uri.parse(endpoint).replace(
          queryParameters: params.map((k, v) => MapEntry(k, v.toString())),
        );
        print("🔗 Final debug URL: $debugUri");
        print("🧾 Query Parameters: $params");
      }

      final response = await dio.get(endpoint, queryParameters: params);

      if (kDebugMode) {
        try {
          print("🌐 Request sent to: ${response.realUri}");
        } catch (_) {}
      }

      if (response.statusCode == 200 && response.data != null) {
        final body = response.data;
        // support both: { success:true, data: [...] }  or  [...direct array...]
        final dynamic dataNode = (body is Map && body['data'] != null)
            ? body['data']
            : body;

        if (dataNode is List) {
          final products = dataNode
              .map(
                (e) =>
                    ProductModel.fromJson(Map<String, dynamic>.from(e as Map)),
              )
              .toList();
          return Right(products);
        } else {
          final message = (body is Map && body['message'] != null)
              ? body['message'].toString()
              : 'Unexpected response format';
          return Left(ServerFailure(message: message));
        }
      } else {
        final message =
            (response.data is Map && response.data['message'] != null)
            ? response.data['message'].toString()
            : 'Invalid response from server';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final msg = e.message ?? e.type.toString();
      if (kDebugMode) print("❌ DioException: $msg");
      return Left(ServerFailure(message: msg));
    } catch (e) {
      if (kDebugMode) print("❌ Unexpected error: $e");
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDetailsModel>> getProductDetails(
    String productId,
  ) async {
    try {
      final endPoint = '${ApiUrls.productDetails}/$productId';
      final response = await dio.get(endPoint);

      if (kDebugMode) {
        print("🔍 ProductDetails request: $endPoint");
        print("🔁 Response: ${response.statusCode} | ${response.data}");
      }

      if (response.statusCode == 200 && response.data != null) {
        final body = response.data;
        // body may be { success: true, data: { ... } } OR directly the product object
        final dataNode = (body is Map && body['data'] != null)
            ? body['data']
            : body;

        if (dataNode is Map<String, dynamic>) {
          final product = ProductDetailsModel.fromJson(
            Map<String, dynamic>.from(dataNode),
          );
          return Right(product);
        } else {
          final msg = (body is Map && body['message'] != null)
              ? body['message'].toString()
              : 'Unexpected response format';
          return Left(ServerFailure(message: msg));
        }
      } else {
        final message =
            (response.data is Map && response.data['message'] != null)
            ? response.data['message'].toString()
            : 'Invalid response from server';
        return Left(ServerFailure(message: message));
      }
    } on DioException catch (e) {
      final msg = e.message ?? e.type.toString();
      if (kDebugMode) print("❌ DioException in getProductDetails: $msg");
      return Left(ServerFailure(message: msg));
    } catch (e) {
      if (kDebugMode) print("❌ Unexpected error in getProductDetails: $e");
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
