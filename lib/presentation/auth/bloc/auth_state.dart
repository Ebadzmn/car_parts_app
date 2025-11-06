part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});
}

final class SignUpSuccess extends AuthState {
  final Map<String, dynamic> response;

  SignUpSuccess({required this.response});
}
