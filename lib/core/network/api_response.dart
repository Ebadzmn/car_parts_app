/// Generic wrapper for all API responses.
///
/// Every call through [NetworkCaller] returns an [ApiResponse] so BLoCs /
/// repositories can pattern-match on [success] without inspecting raw Dio
/// objects.
class ApiResponse<T> {
  final bool success;
  final int? statusCode;
  final T? data;
  final String? message;

  const ApiResponse({
    required this.success,
    this.statusCode,
    this.data,
    this.message,
  });

  /// Convenience factory for successful responses.
  factory ApiResponse.success({required T data, int? statusCode}) {
    return ApiResponse(success: true, statusCode: statusCode, data: data);
  }

  /// Convenience factory for failed responses.
  factory ApiResponse.failure({required String message, int? statusCode}) {
    return ApiResponse(
      success: false,
      statusCode: statusCode,
      message: message,
    );
  }

  @override
  String toString() =>
      'ApiResponse(success: $success, statusCode: $statusCode, message: $message, data: $data)';
}
