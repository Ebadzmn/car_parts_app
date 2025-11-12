import 'package:equatable/equatable.dart';

class LoginResponseModel extends Equatable {
  final bool success;
  final String message;
  final String? token; // data field (JWT token)

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool? ?? false,
      message: json['message'] as String? ?? '',
      token: json['data'] as String?, // token key = data
    );
  }

  Map<String, dynamic> toJson() {
    return {'success': success, 'message': message, 'data': token};
  }

  @override
  // TODO: implement props
  List<Object?> get props => [success, message, token];
}
