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
    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      return double.tryParse(v.toString()) ?? 0.0;
    }

    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is double) return v.toInt();
      return int.tryParse(v.toString()) ?? 0;
    }

    List<String> parseStringList(dynamic v) {
      if (v is List) {
        return v
            .map((e) => e.toString())
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return <String>[];
    }

    String parseSellerId(dynamic raw) {
      if (raw is Map<String, dynamic>) {
        return (raw['_id'] ?? raw['id'] ?? '').toString();
      }
      return raw?.toString() ?? '';
    }

    return ProductModel(
      id: (json['_id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      category: (json['category'] ?? '').toString(),
      brand: (json['brand'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      carModels: parseStringList(json['carModels']),
      chassisNumber: (json['chassisNumber'] ?? '').toString(),
      condition: (json['condition'] ?? '').toString(),
      warranty: (json['warranty'] ?? '').toString(),
      price: parseDouble(json['price']),
      discount: parseInt(json['discount']),
      mainImage: json['mainImage']?.toString() ?? '',
      galleryImages: parseStringList(json['galleryImages']),
      sellerId: parseSellerId(json['sellerId']),
      sellerRating: parseDouble(json['sellerRating']),
      averageRating: parseDouble(json['averageRating']),
      totalRatings: parseInt(json['totalRatings']),
      isBlocked: json['isBlocked'] as bool? ?? false,
      createdAt:
          DateTime.tryParse(json['createdAt']?.toString() ?? '') ??
              DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt']?.toString() ?? '') ??
              DateTime.now(),
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
