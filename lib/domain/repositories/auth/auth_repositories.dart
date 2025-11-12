import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/auth/signIn_response_model.dart';
import 'package:car_parts_app/data/model/auth/sign_In_model.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:car_parts_app/data/model/auth/verify_account_model.dart';
import 'package:car_parts_app/domain/entities/user/userProfile.dart';
import 'package:car_parts_app/presentation/auth/pages/forget_password.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepositories {
  Future<Either<Failure, dynamic>> signUp(SignupModel signupModel);
  Future<Either<Failure, dynamic>> verifyAccount(
    VerifyAccountModel verifyAccountModel,
  );
  Future<Either<Failure, LoginResponseModel>> signIn(SignInModel signInModel);
  Future<Either<Failure, ProfileEntity>> getUserProfile();
}
