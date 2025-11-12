import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String name;
  final String role;
  final String email;
  final String image;
  final double averageRating;
  final int ratingsCount;
  final bool isBlocked;
  final String status;
  final bool verified;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProfileEntity({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.image,
    required this.averageRating,
    required this.ratingsCount,
    required this.isBlocked,
    required this.status,
    required this.verified,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    role,
    email,
    image,
    averageRating,
    ratingsCount,
    isBlocked,
    status,
    verified,
    createdAt,
    updatedAt,
  ];
}
