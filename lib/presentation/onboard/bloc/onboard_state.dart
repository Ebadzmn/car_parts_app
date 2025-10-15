part of 'onboard_bloc.dart';

sealed class OnboardState extends Equatable {
  const OnboardState();

  @override
  List<Object> get props => [];
}

final class OnboardInitial extends OnboardState {}

final class OnboardLoading extends OnboardState {}

final class OnboardLoad extends OnboardState {
  final List<OnbEntities> data;
  final int currentPage;

  OnboardLoad({required this.data, this.currentPage = 0});

  OnboardLoad copyWith({List<OnbEntities>? data, int? currentPage}) {
    return OnboardLoad(
      data: data ?? this.data,
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

final class OnboardError extends OnboardState {
  final String message;

  OnboardError({required this.message});
  @override
  List<Object> get props => [message];
}
