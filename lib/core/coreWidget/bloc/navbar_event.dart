import 'package:equatable/equatable.dart';

abstract class BottomNavEvent extends Equatable {
  const BottomNavEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends BottomNavEvent {
  final int index;

  const TabChanged(this.index);

  @override
  List<Object> get props => [index];
}
