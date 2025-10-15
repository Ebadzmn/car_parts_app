import 'package:car_parts_app/domain/entities/product/product_entities.dart';

class CarLocalDatasource {
  static List<ProductEntities> getProduct() {
    return [
      ProductEntities(
        carName: 'Front Bumper',
        carCondition: 'New',
        carImage: 'https://i.ibb.co/CMzZy9B/front-bumper.jpg',
        carPrice: '200',
        carCategory: 'Exterior',
      ),
      ProductEntities(
        carName: 'Rear Brake Pads Set',
        carCondition: 'Used',
        carImage: 'https://i.ibb.co/pjmL5dH/brake-pads.jpg',
        carPrice: '45',
        carCategory: 'Brakes',
      ),
      ProductEntities(
        carName: 'LED Headlight (Pair)',
        carCondition: 'New',
        carImage: 'https://i.ibb.co/LzLGs9v/led-headlight.jpg',
        carPrice: '120',
        carCategory: 'Lighting',
      ),
      ProductEntities(
        carName: 'Engine Oil Filter',
        carCondition: 'New',
        carImage: 'https://i.ibb.co/MN8C9Qm/oil-filter.jpg',
        carPrice: '25',
        carCategory: 'Engine',
      ),
      ProductEntities(
        carName: 'Side Mirror (Right) – Honda Civic',
        carCondition: 'Used',
        carImage: 'https://i.ibb.co/gv6nqNc/side-mirror.jpg',
        carPrice: '60',
        carCategory: 'Exterior',
      ),
      ProductEntities(
        carName: 'Air Conditioning Compressor',
        carCondition: 'Refurbished',
        carImage: 'https://i.ibb.co/KrF4Npn/ac-compressor.jpg',
        carPrice: '220',
        carCategory: 'Cooling System',
      ),
      ProductEntities(
        carName: 'Alloy Wheel – 16 inch',
        carCondition: 'New',
        carImage: 'https://i.ibb.co/Zz8T0Wr/alloy-wheel.jpg',
        carPrice: '150',
        carCategory: 'Wheels & Tires',
      ),
      ProductEntities(
        carName: 'Car Battery – 12V 60Ah',
        carCondition: 'New',
        carImage: 'https://i.ibb.co/tcLr7nW/car-battery.jpg',
        carPrice: '95',
        carCategory: 'Electrical',
      ),
      ProductEntities(
        carName: 'Radiator Fan Assembly',
        carCondition: 'Used',
        carImage: 'https://i.ibb.co/4Jmtxmr/radiator-fan.jpg',
        carPrice: '85',
        carCategory: 'Cooling System',
      ),
      ProductEntities(
        carName: 'Touchscreen Car Stereo',
        carCondition: 'New',
        carImage: 'https://i.ibb.co/bsKn0Tk/car-stereo.jpg',
        carPrice: '130',
        carCategory: 'Electronics',
      ),
      ProductEntities(
        carName: 'Shock Absorber Rear – Nissan Altima',
        carCondition: 'Used',
        carImage: 'https://i.ibb.co/ZKzSHy2/shock-absorber.jpg',
        carPrice: '70',
        carCategory: 'Suspension',
      ),
      ProductEntities(
        carName: 'Tail Light Assembly',
        carCondition: 'Refurbished',
        carImage: 'https://i.ibb.co/WGLB5Y5/tail-light.jpg',
        carPrice: '95',
        carCategory: 'Lighting',
      ),
    ];
  }
}
