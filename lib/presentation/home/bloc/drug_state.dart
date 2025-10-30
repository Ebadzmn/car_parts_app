import 'package:equatable/equatable.dart';

class DragState extends Equatable {
  final double dx;
  final bool shouldNavigate;

  const DragState({required this.dx, this.shouldNavigate = false});

  DragState copyWith({double? dx, bool? shouldNavigate}) {
    return DragState(
      dx: dx ?? this.dx,
      shouldNavigate: shouldNavigate ?? false,
    );
  }

  @override
  List<Object?> get props => [dx, shouldNavigate];
}
