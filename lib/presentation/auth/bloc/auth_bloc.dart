import 'package:bloc/bloc.dart';
import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:car_parts_app/domain/usecase/auth/auth_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase signUpUsecase;
  AuthBloc(this.signUpUsecase) : super(AuthInitial()) {
    on<SignUpEvent>(_signUp);
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final Either<Failure, dynamic> response = await signUpUsecase.signUp(event.signupModel);
    response.fold(
      (l) => emit(AuthError(message: l.message)),
      (r) => emit(SignUpSuccess(response: r)),
    );
  }




}
