import 'package:equatable/equatable.dart';

abstract class DragEvent extends Equatable {
  const DragEvent();

  @override
  List<Object?> get props => [];
}

class DragUpdateEvent extends DragEvent {
  final double dx;
  const DragUpdateEvent(this.dx);

  @override
  List<Object?> get props => [dx];
}

class DragEndEvent extends DragEvent {
  final double dx;
  const DragEndEvent(this.dx);

  @override
  List<Object?> get props => [dx];
}
