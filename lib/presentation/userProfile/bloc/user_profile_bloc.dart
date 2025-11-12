import 'package:bloc/bloc.dart';
import 'package:car_parts_app/data/model/user/userProfile_model.dart';
import 'package:car_parts_app/domain/entities/user/userProfile.dart';
import 'package:car_parts_app/domain/usecase/auth/auth_usecase.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetUserProfileUsecase getUserProfileUsecase;
  UserProfileBloc(this.getUserProfileUsecase) : super(UserProfileInitial()) {
    on<GetUserProfileEvent>(_onProfileRequested);
  }
  Future<void> _onProfileRequested(
    GetUserProfileEvent event,
    Emitter<UserProfileState> emit,
  ) async {
    emit(UserLoading());
    final result = await getUserProfileUsecase.getUserProfile();
    result.fold((l) => emit(UserError(l.message)), (r) => emit(UserLoaded(r)));
  }
}
