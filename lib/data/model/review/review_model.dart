class ReviewModel {
  final String id;
  final String productId;
  final ReviewUser userId;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id'] ?? '',
      productId: json['productId'] ?? '',
      userId: ReviewUser.fromJson(json['userId'] ?? {}),
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }
}

class ReviewUser {
  final String id;
  final String name;

  ReviewUser({
    required this.id,
    required this.name,
  });

  factory ReviewUser.fromJson(Map<String, dynamic> json) {
    return ReviewUser(
      id: json['_id'] ?? '',
      name: json['name'] ?? 'Unknown User',
    );
  }
}
