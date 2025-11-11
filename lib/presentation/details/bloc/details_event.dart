part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();

  @override
  List<Object?> get props => [];
}

class CaroselPageChanged extends DetailsEvent {
  final int index;
  const CaroselPageChanged(this.index);

  @override
  List<Object?> get props => [index];
}

class SelectTabEvent extends DetailsEvent {
  final int index;
  const SelectTabEvent(this.index);

  @override
  List<Object?> get props => [index];
}

class GetProductDetailsEvent extends DetailsEvent {
  final String productId;
  const GetProductDetailsEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}
