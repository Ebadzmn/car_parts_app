part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpEvent extends AuthEvent {
  final SignupModel signupModel;

  SignUpEvent({required this.signupModel});

  @override
  List<Object> get props => [signupModel];
}

class VerifyAccountEvent extends AuthEvent {
  final VerifyAccountModel verifyAccountModel;

  VerifyAccountEvent({required this.verifyAccountModel});

  @override
  List<Object> get props => [verifyAccountModel];
}

class SignInEvent extends AuthEvent {
  final SignInModel signInModel;

  SignInEvent({required this.signInModel});

  @override
  List<Object> get props => [signInModel];
}

class CheckInStatusEvent extends AuthEvent {}
