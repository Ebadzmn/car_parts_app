part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

final class UserProfileInitial extends UserProfileState {}

final class UserLoading extends UserProfileState {}

final class UserLoaded extends UserProfileState {
  final ProfileEntity profileEntity;
  const UserLoaded(this.profileEntity);

  @override
  List<Object> get props => [profileEntity];
}

final class UserError extends UserProfileState {
  final String message;
  const UserError(this.message);
}
