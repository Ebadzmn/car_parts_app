import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/data_source/remote/auth_remoteDatasource.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:car_parts_app/domain/repositories/auth/auth_repositories.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoriesImpl implements AuthRepositories{
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoriesImpl(this.authRemoteDatasource, );
  @override
  Future<Either<Failure, dynamic>> signUp(SignupModel signupModel) async {
    try {
      final data = await authRemoteDatasource.signUp(signupModel);
      return Right(data);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}