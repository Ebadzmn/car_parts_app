import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/data_source/local/onb_local_datasource.dart';
import 'package:car_parts_app/domain/entities/onboard/onb_entities.dart';
import 'package:car_parts_app/domain/repositories/onboard/onboard_repositories.dart';
import 'package:dartz/dartz.dart';

class OnbRepositoriesImpl implements OnboardRepositories {
  @override
  Future<Either<Failure, List<OnbEntities>>> getOnboard() async {
    try {
      final result = await OnbLocalDatasource.getOnboard();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure(message: 'Local Error'));
    }
  }
}
