import 'dart:developer' as developer;
import 'dart:io';

import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/network/api_response.dart';
import 'package:car_parts_app/core/network/network_exceptions.dart';
import 'package:car_parts_app/core/network/token_interceptor.dart';
import 'package:car_parts_app/data/data_source/local/auth_local_datasource.dart';
import 'package:dio/dio.dart';
import 'package:car_parts_app/core/network/api_logger_interceptor.dart';

/// Universal, reusable network caller.
///
/// Inject this via GetIt and call from any repository / data-source.
///
/// ```dart
/// final response = await networkCaller.get('/products');
/// if (response.success) { /* use response.data */ }
/// ```
class NetworkCaller {
  late final Dio _dio;

  NetworkCaller({required AuthLocalDatasource authLocalDatasource}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiUrls.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // ── Interceptors ──────────────────────────────────────────────

    // 1. Token injection + 401 refresh
    _dio.interceptors.add(
      TokenInterceptor(authLocalDatasource: authLocalDatasource, dio: _dio),
    );

    // 2. Custom API logger (debug-only)
    _dio.interceptors.add(ApiLoggerInterceptor());
  }

  // ─────────────────────── PUBLIC API ────────────────────────────

  /// HTTP **GET**
  Future<ApiResponse<dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    return _execute(
      () => _dio.get(
        url,
        queryParameters: queryParams,
        options: _options(headers),
      ),
    );
  }

  /// HTTP **POST**
  Future<ApiResponse<dynamic>> post(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    return _execute(
      () => _dio.post(
        url,
        data: body,
        queryParameters: queryParams,
        options: _options(headers),
      ),
    );
  }

  /// HTTP **PUT**
  Future<ApiResponse<dynamic>> put(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    return _execute(
      () => _dio.put(
        url,
        data: body,
        queryParameters: queryParams,
        options: _options(headers),
      ),
    );
  }

  /// HTTP **PATCH**
  Future<ApiResponse<dynamic>> patch(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    return _execute(
      () => _dio.patch(
        url,
        data: body,
        queryParameters: queryParams,
        options: _options(headers),
      ),
    );
  }

  /// HTTP **DELETE**
  Future<ApiResponse<dynamic>> delete(
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
  }) async {
    return _execute(
      () => _dio.delete(
        url,
        data: body,
        queryParameters: queryParams,
        options: _options(headers),
      ),
    );
  }

  /// **Multipart** form-data upload (files + fields).
  ///
  /// [files] – list of `MapEntry<fieldName, File>`.
  /// [fields] – optional plain text fields sent alongside the files.
  Future<ApiResponse<dynamic>> uploadMultipart(
    String url, {
    required List<MapEntry<String, File>> files,
    Map<String, String>? fields,
    Map<String, String>? headers,
  }) async {
    return _execute(() async {
      final formMap = <String, dynamic>{};

      // Attach plain fields
      if (fields != null) {
        formMap.addAll(fields);
      }

      // Attach files
      for (final entry in files) {
        final file = entry.value;
        formMap[entry.key] = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split(Platform.pathSeparator).last,
        );
      }

      final formData = FormData.fromMap(formMap);

      return _dio.post(
        url,
        data: formData,
        options: Options(
          headers: {...?headers, 'Content-Type': 'multipart/form-data'},
        ),
      );
    });
  }

  // ──────────────────── PRIVATE HELPERS ─────────────────────────

  /// Wraps every HTTP call with uniform error handling.
  Future<ApiResponse<dynamic>> _execute(
    Future<Response<dynamic>> Function() request,
  ) async {
    try {
      final response = await request();
      return ApiResponse.success(
        data: response.data,
        statusCode: response.statusCode,
      );
    } on DioException catch (e) {
      final networkException = NetworkException.fromDioException(e);
      developer.log('NetworkCaller error: $networkException');
      return ApiResponse.failure(
        message: networkException.message,
        statusCode: networkException.statusCode,
      );
    } catch (e) {
      developer.log('NetworkCaller unexpected error: $e');
      return ApiResponse.failure(message: e.toString());
    }
  }

  /// Merges per-request headers with defaults.
  Options? _options(Map<String, String>? headers) {
    if (headers == null || headers.isEmpty) return null;
    return Options(headers: headers);
  }
}
