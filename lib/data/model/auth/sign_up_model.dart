import 'package:equatable/equatable.dart';

class SignupModel extends Equatable {
  final String name;
  final String email;
  final String whatsappNumber;
  final String password;
  final String address;
  final double lat;
  final double lng;

  SignupModel({
    required this.name,
    required this.email,
    required this.whatsappNumber,
    required this.password,
    this.address = '',
    this.lat = 0.0,
    this.lng = 0.0,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    final coordinates = json['coordinates'] as Map<String, dynamic>?;
    return SignupModel(
      name: json['name'],
      email: json['email'],
      whatsappNumber: json['whatsappNumber'] ?? json['contact'],
      password: json['password'],
      address: json['address'] ?? '',
      lat: (coordinates?['lat'] ?? 0.0).toDouble(),
      lng: (coordinates?['lng'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'whatsappNumber': whatsappNumber,
      'password': password,
      'address': address,
      'coordinates': {
        'lat': lat,
        'lng': lng,
      },
    };
  }

  @override
  List<Object?> get props => [name, email, whatsappNumber, password, address, lat, lng];
}