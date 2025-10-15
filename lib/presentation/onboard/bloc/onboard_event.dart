part of 'onboard_bloc.dart';

abstract class OnboardEvent extends Equatable {
  const OnboardEvent();

  @override
  List<Object> get props => [];
}

class FetchOnBoardEvent extends OnboardEvent {}

class PageChangeEvent extends OnboardEvent {
  final int pageIndex;

  PageChangeEvent(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

// // ✅ New events for button navigation
// class OnboardNextEvent extends OnboardEvent {}

// class OnboardBackEvent extends OnboardEvent {}
