import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/data_source/remote/auth_remoteDatasource.dart';
import 'package:car_parts_app/data/model/auth/signIn_response_model.dart';
import 'package:car_parts_app/data/model/auth/sign_In_model.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:car_parts_app/data/model/auth/verify_account_model.dart';
import 'package:car_parts_app/domain/entities/user/userProfile.dart';
import 'package:car_parts_app/domain/repositories/auth/auth_repositories.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoriesImpl(this.authRemoteDatasource);
  @override
  Future<Either<Failure, dynamic>> signUp(SignupModel signupModel) async {
    try {
      final data = await authRemoteDatasource.signUp(signupModel);
      return Right(data);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> verifyAccount(
    VerifyAccountModel verifyAccountModel,
  ) async {
    try {
      final data = await authRemoteDatasource.verifyAccount(verifyAccountModel);
      return Right(data);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LoginResponseModel>> signIn(
    SignInModel signInModel,
  ) async {
    try {
      final data = await authRemoteDatasource.signIn(signInModel);
      return Right(data);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> getUserProfile() async {
    try {
      final data = await authRemoteDatasource.getUserProfile();
      return Right(data);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
