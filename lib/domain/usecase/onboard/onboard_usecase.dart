import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/domain/entities/onboard/onb_entities.dart';
import 'package:car_parts_app/domain/repositories/onboard/onboard_repositories.dart';
import 'package:dartz/dartz.dart';

class OnboardUsecase {
  final OnboardRepositories repositories;

  OnboardUsecase(this.repositories);

  Future<Either<Failure, List<OnbEntities>>> call() {
    return repositories.getOnboard();
  }
}
