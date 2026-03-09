import 'dart:developer' as developer;

import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/data/data_source/local/auth_local_datasource.dart';
import 'package:dio/dio.dart';

/// Dio [Interceptor] that:
///  1. Injects `Authorization: Bearer <token>` on every request.
///  2. On a 401 response, attempts to refresh the token and retries once.
class TokenInterceptor extends Interceptor {
  final AuthLocalDatasource _authLocal;
  final Dio _dio; // the app's main Dio instance (used to retry)

  TokenInterceptor({
    required AuthLocalDatasource authLocalDatasource,
    required Dio dio,
  }) : _authLocal = authLocalDatasource,
       _dio = dio;

  // ──────────────────────────── REQUEST ────────────────────────────

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await _authLocal.getToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    } catch (e) {
      developer.log('TokenInterceptor: failed to read token – $e');
    }
    handler.next(options);
  }

  // ─────────────────────────── ERROR ──────────────────────────────

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Only handle 401 Unauthorized
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    developer.log('TokenInterceptor: 401 received – attempting token refresh');

    try {
      // Use a separate Dio instance so the interceptor doesn't re-trigger.
      final refreshDio = Dio(BaseOptions(baseUrl: ApiUrls.baseUrl));

      final refreshToken = await _authLocal.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        developer.log('TokenInterceptor: no refresh token stored – skipping');
        return handler.next(err);
      }

      final response = await refreshDio.post(
        ApiUrls.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data as Map<String, dynamic>;

        final newAccessToken =
            data['accessToken']?.toString() ?? data['token']?.toString();
        final newRefreshToken = data['refreshToken']?.toString();

        if (newAccessToken != null) {
          await _authLocal.saveToken(newAccessToken);
        }
        if (newRefreshToken != null) {
          await _authLocal.saveRefreshToken(newRefreshToken);
        }

        developer.log('TokenInterceptor: token refreshed successfully');

        // Clone & retry the original request with the new token.
        final opts = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $newAccessToken';

        final retryResponse = await _dio.fetch(opts);
        return handler.resolve(retryResponse);
      }

      // Refresh call returned a non-success status – clear tokens.
      developer.log(
        'TokenInterceptor: refresh failed with ${response.statusCode}',
      );
      await _clearTokens();
      return handler.next(err);
    } on DioException catch (e) {
      developer.log('TokenInterceptor: refresh DioException – ${e.message}');
      await _clearTokens();
      return handler.next(err);
    } catch (e) {
      developer.log('TokenInterceptor: refresh unknown error – $e');
      await _clearTokens();
      return handler.next(err);
    }
  }

  /// Clears stored tokens so the UI layer can detect logout.
  Future<void> _clearTokens() async {
    try {
      await _authLocal.clearToken();
      await _authLocal.clearRefreshToken();
    } catch (_) {}
  }
}
