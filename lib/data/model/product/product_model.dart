import 'package:car_parts_app/domain/entities/product/product_entities.dart';


class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.title,
    required super.category,
    required super.brand,
    required super.description,
    required super.carModels,
    required super.chassisNumber,
    required super.condition,
    required super.warranty,
    required super.price,
    required super.discount,
    required super.mainImage,
    required super.galleryImages,
    required super.sellerId,
    required super.sellerRating,
    required super.averageRating,
    required super.totalRatings,
    required super.isBlocked,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      category: json['category'] ?? '',
      brand: json['brand'] ?? '',
      description: json['description'] ?? '',
      carModels: List<String>.from(json['carModels'] ?? []),
      chassisNumber: json['chassisNumber'] ?? '',
      condition: json['condition'] ?? '',
      warranty: json['warranty'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      discount: json['discount'] ?? 0,
      mainImage: json['mainImage'] ?? '',
      galleryImages: List<String>.from(json['galleryImages'] ?? []),
      sellerId: json['sellerId'] ?? '',
      sellerRating: (json['sellerRating'] ?? 0).toDouble(),
      averageRating: (json['averageRating'] ?? 0).toDouble(),
      totalRatings: json['totalRatings'] ?? 0,
      isBlocked: json['isBlocked'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'category': category,
      'brand': brand,
      'description': description,
      'carModels': carModels,
      'chassisNumber': chassisNumber,
      'condition': condition,
      'warranty': warranty,
      'price': price,
      'discount': discount,
      'mainImage': mainImage,
      'galleryImages': galleryImages,
      'sellerId': sellerId,
      'sellerRating': sellerRating,
      'averageRating': averageRating,
      'totalRatings': totalRatings,
      'isBlocked': isBlocked,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

    // ✅ add this method to convert Model -> Entity
  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      category: category,
      brand: brand,
      description: description,
      carModels: carModels,
      chassisNumber: chassisNumber,
      condition: condition,
      warranty: warranty,
      price: price,
      discount: discount,
      mainImage: mainImage,
      galleryImages: galleryImages,
      sellerId: sellerId,
      sellerRating: sellerRating,
      averageRating: averageRating,
      totalRatings: totalRatings,
      isBlocked: isBlocked,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
