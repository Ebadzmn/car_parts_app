import 'package:dio/dio.dart';

/// Base class for all network-related exceptions.
sealed class NetworkException implements Exception {
  final String message;
  final int? statusCode;

  const NetworkException({required this.message, this.statusCode});

  @override
  String toString() =>
      '$runtimeType(statusCode: $statusCode, message: $message)';

  /// Maps a [DioException] into a typed [NetworkException].
  factory NetworkException.fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException(
          message: 'Connection timed out. Please try again.',
          statusCode: e.response?.statusCode,
        );

      case DioExceptionType.connectionError:
        return NoInternetException(
          message: 'No internet connection. Please check your network.',
        );

      case DioExceptionType.badResponse:
        return _fromStatusCode(
          statusCode: e.response?.statusCode,
          responseData: e.response?.data,
        );

      case DioExceptionType.cancel:
        return RequestCancelledException(message: 'Request was cancelled.');

      case DioExceptionType.badCertificate:
        return UnknownApiException(
          message: 'Bad certificate. Please contact support.',
          statusCode: e.response?.statusCode,
        );

      case DioExceptionType.unknown:
        return UnknownApiException(
          message: e.message ?? 'An unexpected error occurred.',
          statusCode: e.response?.statusCode,
        );
    }
  }

  /// Derives the appropriate exception from an HTTP status code.
  static NetworkException _fromStatusCode({
    int? statusCode,
    dynamic responseData,
  }) {
    final serverMessage = _extractMessage(responseData);

    switch (statusCode) {
      case 400:
        return BadRequestException(
          message: serverMessage ?? 'Bad request.',
          statusCode: statusCode,
        );
      case 401:
        return UnauthorizedException(
          message: serverMessage ?? 'Unauthorized. Please log in again.',
          statusCode: statusCode,
        );
      case 403:
        return ForbiddenException(
          message: serverMessage ?? 'You do not have permission.',
          statusCode: statusCode,
        );
      case 404:
        return NotFoundException(
          message: serverMessage ?? 'Resource not found.',
          statusCode: statusCode,
        );
      case 409:
        return ConflictException(
          message: serverMessage ?? 'Conflict. The resource already exists.',
          statusCode: statusCode,
        );
      case 422:
        return UnprocessableEntityException(
          message: serverMessage ?? 'Validation error.',
          statusCode: statusCode,
        );
      case 500:
      case 502:
      case 503:
        return ServerException(
          message: serverMessage ?? 'Server error. Please try again later.',
          statusCode: statusCode,
        );
      default:
        return UnknownApiException(
          message: serverMessage ?? 'Something went wrong.',
          statusCode: statusCode,
        );
    }
  }

  /// Tries to pull a human-readable message out of the response body.
  static String? _extractMessage(dynamic data) {
    if (data == null) return null;
    if (data is Map<String, dynamic>) {
      return data['message']?.toString() ??
          data['error']?.toString() ??
          data['msg']?.toString();
    }
    if (data is String && data.isNotEmpty) return data;
    return null;
  }
}

// ─── Concrete exception types ────────────────────────────────────────────────

class NoInternetException extends NetworkException {
  const NoInternetException({required super.message, super.statusCode});
}

class TimeoutException extends NetworkException {
  const TimeoutException({required super.message, super.statusCode});
}

class BadRequestException extends NetworkException {
  const BadRequestException({required super.message, super.statusCode});
}

class UnauthorizedException extends NetworkException {
  const UnauthorizedException({required super.message, super.statusCode});
}

class ForbiddenException extends NetworkException {
  const ForbiddenException({required super.message, super.statusCode});
}

class NotFoundException extends NetworkException {
  const NotFoundException({required super.message, super.statusCode});
}

class ConflictException extends NetworkException {
  const ConflictException({required super.message, super.statusCode});
}

class UnprocessableEntityException extends NetworkException {
  const UnprocessableEntityException({
    required super.message,
    super.statusCode,
  });
}

class ServerException extends NetworkException {
  const ServerException({required super.message, super.statusCode});
}

class RequestCancelledException extends NetworkException {
  const RequestCancelledException({required super.message, super.statusCode});
}

class UnknownApiException extends NetworkException {
  const UnknownApiException({required super.message, super.statusCode});
}
