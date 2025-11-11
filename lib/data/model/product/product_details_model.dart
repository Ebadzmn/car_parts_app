// // data/models/product_model.dart

// import 'package:car_parts_app/domain/entities/product/product_details_entity.dart';

// class SellerModel extends SellerEntity {
//   const SellerModel({
//     required String id,
//     required String name,
//     required String email,
//   }) : super(id: id, name: name, email: email);

//   factory SellerModel.fromJson(Map<String, dynamic> json) {
//     return SellerModel(
//       id: json['_id'] as String,
//       name: json['name'] as String? ?? '',
//       email: json['email'] as String? ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'email': email,
//     };
//   }
// }

// class ProductDetailsModel extends ProductDetailsEntity {
//   const ProductDetailsModel({ 
//     required String id,
//     required String title,
//     required String category,
//     required String brand,
//     required String description,
//     required List<String> carModels,
//     required String chassisNumber,
//     required String condition,
//     required String warranty,
//     required double price,
//     required int discount,
//     required String? mainImage,
//     required List<String> galleryImages,
//     required SellerModel seller,
//     required double averageRating,
//     required int totalRatings,
//   }) : super(
//           id: id,
//           title: title,
//           category: category,
//           brand: brand,
//           description: description,
//           carModels: carModels,
//           chassisNumber: chassisNumber,
//           condition: condition,
//           warranty: warranty,
//           price: price,
//           discount: discount,
//           mainImage: mainImage,
//           galleryImages: galleryImages,
//           seller: seller,
//           averageRating: averageRating,
//           totalRatings: totalRatings,
//         );

//   factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
//     final data = json; // already the data object (not the outer wrapper)
//     return ProductDetailsModel(
//       id: data['_id'] as String,
//       title: data['title'] as String? ?? '',
//       category: data['category'] as String? ?? '',
//       brand: data['brand'] as String? ?? '',
//       description: data['description'] as String? ?? '',
//       carModels: (data['carModels'] as List? ?? []).map((e) => e.toString()).toList(),
//       chassisNumber: data['chassisNumber'] as String? ?? '',
//       condition: data['condition'] as String? ?? '',
//       warranty: data['warranty'] as String? ?? '',
//       price: (data['price'] is int) ? (data['price'] as int).toDouble() : (data['price'] as num?)?.toDouble() ?? 0.0,
//       discount: (data['discount'] as num?)?.toInt() ?? 0,
//       mainImage: data['mainImage'] as String?,
//       galleryImages: (data['galleryImages'] as List? ?? []).map((e) => e.toString()).toList(),
//         seller: SellerModel.fromJson(data['sellerId']), // ✅ safe dynamic call
//       averageRating: (data['averageRating'] as num?)?.toDouble() ?? 0.0,
//       totalRatings: (data['totalRatings'] as num?)?.toInt() ?? 0,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'title': title,
//       'category': category,
//       'brand': brand,
//       'description': description,
//       'carModels': carModels,
//       'chassisNumber': chassisNumber,
//       'condition': condition,
//       'warranty': warranty,
//       'price': price,
//       'discount': discount,
//       'mainImage': mainImage,
//       'galleryImages': galleryImages,
//       'sellerId': (seller as SellerModel).toJson(),
//       'averageRating': averageRating,
//       'totalRatings': totalRatings,
//     };
//   }
// }
// data/models/product_model.dart

import 'package:car_parts_app/domain/entities/product/product_details_entity.dart';

class SellerModel extends SellerEntity {
  const SellerModel({
    required String id,
    required String name,
    required String email,
  }) : super(id: id, name: name, email: email);

  /// Accepts dynamic because backend might return null or Map or sometimes an id string.
  factory SellerModel.fromJson(dynamic json) {
    final Map<String, dynamic> map = (json is Map) ? Map<String, dynamic>.from(json) : <String, dynamic>{};

    return SellerModel(
      id: (map['_id'] ?? map['id'] ?? '').toString(),
      name: (map['name'] ?? '').toString(),
      email: (map['email'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
    };
  }
}

class ProductDetailsModel extends ProductDetailsEntity {
  const ProductDetailsModel({
    required String id,
    required String title,
    required String category,
    required String brand,
    required String description,
    required List<String> carModels,
    required String chassisNumber,
    required String condition,
    required String warranty,
    required double price,
    required int discount,
    required String? mainImage,
    required List<String> galleryImages,
    required SellerModel seller,
    required double averageRating,
    required double sellerRating,
    required int totalRatings,
  }) : super(
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
          seller: seller,
          averageRating: averageRating,
          sellerRating: sellerRating,
          totalRatings: totalRatings,
        );

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    // json is expected to be the inner "data" object
    final data = Map<String, dynamic>.from(json);

    // safe parsing helpers
    double parseDouble(dynamic v) {
      if (v == null) return 0.0;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      final s = v.toString();
      return double.tryParse(s) ?? 0.0;
    }

    int parseInt(dynamic v) {
      if (v == null) return 0;
      if (v is int) return v;
      if (v is double) return v.toInt();
      final s = v.toString();
      return int.tryParse(s) ?? 0;
    }

    List<String> parseStringList(dynamic v) {
      if (v is List) return v.map((e) => e?.toString() ?? '').where((s) => s.isNotEmpty).toList();
      return <String>[];
    }

    // seller: use SellerModel.fromJson which already handles nulls and non-map
    final sellerRaw = data['sellerId'] ?? data['seller'] ?? {};
    final sellerModel = SellerModel.fromJson(sellerRaw);

    return ProductDetailsModel(
      id: (data['_id'] ?? '').toString(),
      title: (data['title'] ?? '').toString(),
      category: (data['category'] ?? '').toString(),
      brand: (data['brand'] ?? '').toString(),
      description: (data['description'] ?? '').toString(),
      carModels: parseStringList(data['carModels']),
      chassisNumber: (data['chassisNumber'] ?? '').toString(),
      condition: (data['condition'] ?? '').toString(),
      warranty: (data['warranty'] ?? '').toString(),
      price: parseDouble(data['price']),
      discount: parseInt(data['discount']),
      mainImage: data['mainImage']?.toString(),
      galleryImages: parseStringList(data['galleryImages']),
      seller: sellerModel,
      averageRating: parseDouble(data['averageRating']),
      totalRatings: parseInt(data['totalRatings']),
      sellerRating: parseDouble(data['sellerRating']),
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
      'sellerId': (seller as SellerModel).toJson(),
      'averageRating': averageRating,
      'totalRatings': totalRatings,
      'sellerRating': sellerRating,
    };
  }
}
