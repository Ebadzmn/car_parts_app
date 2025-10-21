part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchCardEvent extends HomeEvent {}

class FetchProductByCategoryEvent extends HomeEvent {
  final String category;

  const FetchProductByCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class ClearFilterEvent extends HomeEvent {
  const ClearFilterEvent();
}
