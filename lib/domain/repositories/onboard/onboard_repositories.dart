import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/domain/entities/onboard/onb_entities.dart';
import 'package:dartz/dartz.dart';

abstract class OnboardRepositories {
  Future<Either<Failure, List<OnbEntities>>> getOnboard();
}
