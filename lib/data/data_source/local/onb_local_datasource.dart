import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/domain/entities/onboard/onb_entities.dart';

class OnbLocalDatasource {
  static List<OnbEntities> getOnboard() {
    return [
      OnbEntities(
        title: 'Illuminate Your Drive with Unmatched Precision',
        desc: 'Precision lighting that guides every journey with clarity.',
        image: AssetsPath.onBoardImg1,
      ),
      OnbEntities(
        title: 'Built for Performance and Timeless Style',
        desc:
            'Rims engineered for strength, balance, and style in every drive.',
        image: AssetsPath.onBoardImg2,
      ),
      OnbEntities(
        title: 'Engineered for Unrivaled Power and Reliability',
        desc: 'Unleash power and reliability with advanced engineering.',
        image: AssetsPath.onBoardImg3,
      ),
    ];
  }
}
