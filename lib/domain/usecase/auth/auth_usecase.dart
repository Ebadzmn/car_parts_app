import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/auth/signIn_response_model.dart';
import 'package:car_parts_app/data/model/auth/sign_In_model.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:car_parts_app/data/model/auth/verify_account_model.dart';
import 'package:car_parts_app/domain/entities/user/userProfile.dart';
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

  Future<Either<Failure, dynamic>> verifyAccount(
    VerifyAccountModel verifyAccountModel,
  ) async {
    return await authRepositories.verifyAccount(verifyAccountModel);
  }
}

class SignInUsecase {
  final AuthRepositories authRepositories;

  SignInUsecase({required this.authRepositories});

  Future<Either<Failure, LoginResponseModel>> signIn(
    SignInModel signInModel,
  ) async {
    return await authRepositories.signIn(signInModel);
  }
}

class GetUserProfileUsecase {
  final AuthRepositories authRepositories;

  GetUserProfileUsecase({required this.authRepositories});

  Future<Either<Failure, ProfileEntity>> getUserProfile() async {
    return await authRepositories.getUserProfile();
  }
}

// class CheckInStatusUsecase {
//   final AuthRepositories authRepositories;

//   CheckInStatusUsecase({required this.authRepositories});

//   Future<Either<Failure, dynamic>> checkInStatus(String token) async {
//     return await authRepositories.checkInStatus(token);
//   }
// }
