import 'package:bloc/bloc.dart';
import 'package:car_parts_app/core/error/failure.dart';
import 'package:car_parts_app/data/data_source/local/auth_local_datasource.dart';
import 'package:car_parts_app/data/model/auth/signIn_response_model.dart';
import 'package:car_parts_app/data/model/auth/sign_In_model.dart';
import 'package:car_parts_app/data/model/auth/sign_up_model.dart';
import 'package:car_parts_app/data/model/auth/verify_account_model.dart';
import 'package:car_parts_app/domain/usecase/auth/auth_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase signUpUsecase;
  final VerifyAccountUsecase verifyAccountUsecase;
  final SignInUsecase signInUsecase;
  final AuthLocalDatasource authLocalDatasource;
  AuthBloc(
    this.signUpUsecase,
    this.verifyAccountUsecase,
    this.signInUsecase,
    this.authLocalDatasource,
  ) : super(AuthInitial()) {
    on<SignUpEvent>(_signUp);
    on<VerifyAccountEvent>(_verifyAccount);
    on<SignInEvent>(_signIn);
    on<CheckInStatusEvent>(_checkInStatus);
  }

  Future<void> _signIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    final Either<Failure, LoginResponseModel> response = await signInUsecase
        .signIn(event.signInModel);

    await response.fold(
      (failure) async {
        emit(AuthError(message: failure.message));
      },
      (loginResponse) async {
        // save token if available
        final token = loginResponse.token;
        if (token != null && token.isNotEmpty) {
          try {
            await authLocalDatasource.saveToken(token);
          } catch (e) {
            // যদি save করতে সমস্যা হয়, তবুও user কে success দেখানো যাবে কিন্তু log রাখো
            print('Failed to save token: $e');
          }
        }

        // emit success with the response model
        emit(SignInSuccess(response: loginResponse));
      },
    );
  }

  Future<void> _signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final Either<Failure, dynamic> response = await signUpUsecase.signUp(
      event.signupModel,
    );
    response.fold(
      (l) => emit(AuthError(message: l.message)),
      (r) => emit(SignUpSuccess(response: r)),
    );
  }

  Future<void> _verifyAccount(
    VerifyAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final Either<Failure, dynamic> response = await verifyAccountUsecase
        .verifyAccount(event.verifyAccountModel);
    response.fold(
      (l) => emit(AuthError(message: l.message)),
      (r) => emit(VerifyAccountSuccess(response: r)),
    );
  }

  Future<void> _checkInStatus(
    CheckInStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final token = await authLocalDatasource.getToken();
    if (token != null) {
      final data = LoginResponseModel(token: token, success: true, message: '');
      emit(SignInSuccess(response: data));
    } else {
      emit(AuthError(message: 'No token found'));
    }
  }
}
