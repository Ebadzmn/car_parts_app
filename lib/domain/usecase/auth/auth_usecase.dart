import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:car_parts_app/data/model/auth/verify_account_model.dart';
import 'package:car_parts_app/domain/repositories/auth/auth_repositories.dart';
import 'package:dartz/dartz.dart';

class SignUpUsecase {
  final AuthRepositories authRepositories;

  SignUpUsecase({required this.authRepositories});

  Future<Either<Failure, dynamic>> signUp(SignupModel signupModel) async {
    return await authRepositories.signUp(signupModel);
  }
}

class VerifyAccountUsecase {
  final AuthRepositories authRepositories;

  VerifyAccountUsecase({required this.authRepositories});

  Future<Either<Failure, dynamic>> verifyAccount(VerifyAccountModel verifyAccountModel) async {
    return await authRepositories.verifyAccount(verifyAccountModel);
  }
}