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
