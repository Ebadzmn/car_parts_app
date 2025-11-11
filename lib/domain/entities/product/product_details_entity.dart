// domain/entities/product_entity.dart
import 'package:equatable/equatable.dart';

class SellerEntity extends Equatable {
  final String id;
  final String name;
  final String email;

  const SellerEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [id, name, email];
}

class ProductDetailsEntity extends Equatable {
  final String id;
  final String title;
  final String category;
  final String brand;
  final String description;
  final List<String> carModels;
  final String chassisNumber;
  final String condition;
  final String warranty;
  final double price;
  final int discount;
  final String? mainImage;
  final List<String> galleryImages;
  final SellerEntity seller;
  final double averageRating;
  final double sellerRating;
  final int totalRatings;

  const ProductDetailsEntity({
    required this.id,
    required this.title,
    required this.category,
    required this.brand,
    required this.description,
    required this.carModels,
    required this.chassisNumber,
    required this.condition,
    required this.warranty,
    required this.price,
    required this.discount,
    this.mainImage,
    required this.galleryImages,
    required this.seller,
    required this.averageRating,
    required this.sellerRating,
    required this.totalRatings,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        category,
        brand,
        description,
        carModels,
        chassisNumber,
        condition,
        warranty,
        price,
        discount,
        mainImage,
        galleryImages,
        seller,
        averageRating,
        sellerRating,
        totalRatings,
      ];
}
