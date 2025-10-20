//

import 'package:equatable/equatable.dart';

class ProductEntities extends Equatable {
  final String carName; // গাড়ির নাম
  final String carCondition; // New / Used + Color
  final String carImage; // Image URL
  final String carDescription; // Description
  final String carPrice; // Price
  final String carCategory; // Category (Sedan, SUV, etc.)
  final Map<String, dynamic>?
  specifications; // Optional: brand, model, warranty, etc.
  final Map<String, dynamic>?
  sellerInfo; // Optional: seller name, rating, verified/not

  const ProductEntities({
    required this.carName,
    required this.carCondition,
    required this.carImage,
    required this.carDescription,
    required this.carPrice,
    required this.carCategory,
    this.specifications,
    this.sellerInfo,
  });

  @override
  List<Object?> get props => [
    carName,
    carCondition,
    carDescription,
    carImage,
    carPrice,
    carCategory,
    specifications,
    sellerInfo,
  ];
}
