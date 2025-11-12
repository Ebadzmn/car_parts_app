import 'package:equatable/equatable.dart';

class SignInModel extends Equatable {
  final String email;
  final String password;

  final String token;

  SignInModel({required this.email, required this.password, this.token = ''});

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'token': token,
  };

  @override
  List<Object?> get props => [email, password];
}
