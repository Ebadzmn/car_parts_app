import 'package:equatable/equatable.dart';

class SignupModel extends Equatable {
  final String name;
  final String email;
  final String contact;
  final String password;

  SignupModel({
    required this.name,
    required this.email,
    required this.contact,
    required this.password,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'contact': contact,
      'password': password,
    };
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [name, email, contact, password];
}