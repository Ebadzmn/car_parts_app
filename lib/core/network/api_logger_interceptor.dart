import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Custom Dio [Interceptor] that prints detailed API request, response,
/// and error logs to the debug console.
///
/// Logs are only printed in **debug mode** (`kDebugMode`).
class ApiLoggerInterceptor extends Interceptor {
  // ──────────────────────── REQUEST ────────────────────────

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      final buffer = StringBuffer()
        ..writeln('======= API REQUEST =======')
        ..writeln('URL: ${options.baseUrl}${options.path}')
        ..writeln('METHOD: ${options.method}')
        ..writeln('HEADERS: ${options.headers}')
        ..writeln(
          'QUERY PARAMS: ${options.queryParameters.isNotEmpty ? options.queryParameters : null}',
        )
        ..writeln('BODY: ${options.data}')
        ..writeln('===========================');

      developer.log(buffer.toString(), name: 'API_REQUEST');
    }
    handler.next(options);
  }

  // ──────────────────────── RESPONSE ──────────────────────

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      final buffer = StringBuffer()
        ..writeln('======= API RESPONSE =======')
        ..writeln(
          'URL: ${response.requestOptions.baseUrl}${response.requestOptions.path}',
        )
        ..writeln('METHOD: ${response.requestOptions.method}')
        ..writeln('STATUS CODE: ${response.statusCode}')
        ..writeln('RESPONSE DATA: ${response.data}')
        ..writeln('============================');

      developer.log(buffer.toString(), name: 'API_RESPONSE');
    }
    handler.next(response);
  }

  // ──────────────────────── ERROR ─────────────────────────

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      final buffer = StringBuffer()
        ..writeln('======= API ERROR =======')
        ..writeln(
          'URL: ${err.requestOptions.baseUrl}${err.requestOptions.path}',
        )
        ..writeln('METHOD: ${err.requestOptions.method}')
        ..writeln('ERROR MESSAGE: ${err.message}')
        ..writeln('STATUS CODE: ${err.response?.statusCode}')
        ..writeln('RESPONSE DATA: ${err.response?.data}')
        ..writeln('=========================');

      developer.log(buffer.toString(), name: 'API_ERROR');
    }
    handler.next(err);
  }
}
