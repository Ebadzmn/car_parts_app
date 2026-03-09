import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final bool success;
  final String message;
  final String? accessToken;
  final String? refreshToken;

  const LoginResponseModel({
    required this.success,
    required this.message,
    this.accessToken,
    this.refreshToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    String? accessToken;
    String? refreshToken;

    if (data is Map<String, dynamic>) {
      accessToken = data['accessToken'] as String?;
      refreshToken = data['refreshToken'] as String?;
    } else if (data is String) {
      // Backward compatibility: if data is a plain token string
      accessToken = data;
    }

    return LoginResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'data': {'accessToken': accessToken, 'refreshToken': refreshToken},
    };
  }

  @override
  List<Object?> get props => [success, message, accessToken, refreshToken];
}
