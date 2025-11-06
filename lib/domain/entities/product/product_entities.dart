import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
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
  final String mainImage;
  final List<String> galleryImages;
  final String sellerId;
  final double sellerRating;
  final double averageRating;
  final int totalRatings;
  final bool isBlocked;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProductEntity({
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
    required this.mainImage,
    required this.galleryImages,
    required this.sellerId,
    required this.sellerRating,
    required this.averageRating,
    required this.totalRatings,
    required this.isBlocked,
    required this.createdAt,
    required this.updatedAt,
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
        sellerId,
        sellerRating,
        averageRating,
        totalRatings,
        isBlocked,
        createdAt,
        updatedAt,
      ];
}
