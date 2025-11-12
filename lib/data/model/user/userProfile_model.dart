import 'package:car_parts_app/domain/entities/user/userProfile.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.name,
    required super.role,
    required super.email,
    required super.image,
    required super.averageRating,
    required super.ratingsCount,
    required super.isBlocked,
    required super.status,
    required super.verified,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json;

    return ProfileModel(
      id: data['_id'] ?? '',
      name: data['name'] ?? '',
      role: data['role'] ?? '',
      email: data['email'] ?? '',
      image: data['image'] ?? '',
      averageRating: (data['averageRating'] ?? 0).toDouble(),
      ratingsCount: data['ratingsCount'] ?? 0,
      isBlocked: data['isBlocked'] ?? false,
      status: data['status'] ?? '',
      verified: data['verified'] ?? false,
      createdAt: DateTime.tryParse(data['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(data['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "role": role,
    "email": email,
    "image": image,
    "averageRating": averageRating,
    "ratingsCount": ratingsCount,
    "isBlocked": isBlocked,
    "status": status,
    "verified": verified,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
