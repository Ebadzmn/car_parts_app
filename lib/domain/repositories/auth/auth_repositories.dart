import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepositories {
  Future<Either<Failure , dynamic>> signUp(SignupModel signupModel);
}