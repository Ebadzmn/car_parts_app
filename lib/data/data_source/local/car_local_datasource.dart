//

import 'package:car_parts_app/domain/entities/product/product_entities.dart';

class CarLocalDatasource {
  static List<ProductEntities> getProduct() {
    return [
      ProductEntities(
        carName: 'Toyota Corolla 2020',
        carDescription: 'A reliable and fuel-efficient sedan.',
        carCondition: 'Used',
        carImage: 'https://example.com/images/corolla1.jpg',
        carPrice: '18000',
        carCategory: 'enadb',
        specifications: {
          'brand': 'Toyota',
          'carmodel': 'Corolla',
          'chasis_number': 'JTDBL40E799123456',
          'warranty': '6 months',
        },
        sellerInfo: {
          'name': 'John Doe',
          'rating': 4.8,
          'sellerstatus': 'Verified',
        },
      ),
      ProductEntities(
        carName: 'Honda Civic 2019',
        carCondition: 'Used',
        carImage: 'https://example.com/images/civic1.jpg',
        carDescription: 'A reliable and fuel-efficient sedan.',
        carPrice: '17000',
        carCategory: 'Sedan',
        specifications: {
          'brand': 'Honda',
          'carmodel': 'Civic',
          'chasis_number': '2HGFC2F69KH123456',
          'warranty': '3 months',
        },
        sellerInfo: {
          'name': 'Alice Smith',
          'rating': 4.6,
          'sellerstatus': 'Verified',
        },
      ),
      ProductEntities(
        carName: 'Ford F-150 2021',
        carCondition: 'New',
        carDescription: 'A powerful and spacious pickup truck.',
        carImage: 'https://example.com/images/f150_1.jpg',
        carPrice: '35000',
        carCategory: 'Truck',
        specifications: {
          'brand': 'Ford',
          'carmodel': 'F-150',
          'chasis_number': '1FTEW1E57MFA12345',
          'warranty': '12 months',
        },
        sellerInfo: {
          'name': 'Michael Johnson',
          'rating': 4.9,
          'sellerstatus': 'Verified',
        },
      ),
      ProductEntities(
        carName: 'BMW X5 2022',
        carCondition: 'Refub',
        carDescription: 'A luxurious and spacious SUV.',
        carImage: 'https://example.com/images/bmwx5_1.jpg',
        carPrice: '60000',
        carCategory: 'SUV',
        specifications: {
          'brand': 'BMW',
          'carmodel': 'X5',
          'chasis_number': '5UXCR6C05N9D12345',
          'warranty': '24 months',
        },
        sellerInfo: {
          'name': 'Samantha Lee',
          'rating': 4.7,
          'sellerstatus': 'Not Verified',
        },
      ),
    ];
  }
}
