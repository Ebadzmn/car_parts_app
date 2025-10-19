part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object> get props => [];
}

class CaroselPageChanged extends DetailsEvent {
  final int index;

  const CaroselPageChanged(this.index);

  @override
  List<Object> get props => [index];
}
