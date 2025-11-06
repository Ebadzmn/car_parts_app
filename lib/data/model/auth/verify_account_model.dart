import 'package:equatable/equatable.dart';

class VerifyAccountModel extends Equatable {
  final String email;
  final int oneTimeCode;

  const VerifyAccountModel({
    required this.email,
    required this.oneTimeCode,
  });

  factory VerifyAccountModel.fromJson(Map<String, dynamic> json) {
    return VerifyAccountModel(
      email: json['email'] ?? '',
      oneTimeCode: json['oneTimeCode'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'oneTimeCode': oneTimeCode,
    };
  }

  @override
  List<Object?> get props => [email, oneTimeCode];
}
