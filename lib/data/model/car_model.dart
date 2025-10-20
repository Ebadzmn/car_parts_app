import '../../domain/entities/product/product_entities.dart';

class ProductModel extends ProductEntities {
  ProductModel({
    required String carName,
    required String carCondition,
    required String carImage,
    required String carDescription,
    required String carPrice,
    required String carCategory,
    Map<String, dynamic>? specifications,
    Map<String, dynamic>? sellerInfo,
  }) : super(
         carName: carName,
         carCondition: carCondition,
         carImage: carImage,
         carDescription: carDescription,
         carPrice: carPrice,
         carCategory: carCategory,
         specifications: specifications,
         sellerInfo: sellerInfo,
       );

  // From JSON factory
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      carName: json['title'] ?? '',
      carCondition:
          '${json['condition']['status']} (${json['condition']['color']})',
      carImage: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]
          : '',
      carPrice: json['price'].toString(),
      carCategory: json['category'] ?? '',
      carDescription: json['description'] ?? '',
      specifications: json['specifications'] != null
          ? Map<String, dynamic>.from(json['specifications'])
          : null,
      sellerInfo: json['sellerinfo'] != null
          ? Map<String, dynamic>.from(json['sellerinfo'])
          : null,
    );
  }

  // // To JSON method (optional)
  // Map<String, dynamic> toJson() {
  //   return {
  //     'title': carName,
  //     'condition': {
  //       'status': carCondition.split(' (')[0],
  //       'color': carCondition.contains('(')
  //           ? carCondition.split('(')[1].replaceAll(')', '')
  //           : '',
  //     },
  //     'images': [carImage],
  //     'price': carPrice,
  //     'category': carCategory,
  //     'specifications': specifications,
  //     'sellerinfo': sellerInfo,
  //   };
  // }
}
