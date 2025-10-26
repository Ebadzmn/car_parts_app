import 'package:equatable/equatable.dart';

class BottomNavState extends Equatable {
  final int currentIndex;

  const BottomNavState({this.currentIndex = 0});

  BottomNavState copyWith({int? currentIndex}) {
    return BottomNavState(currentIndex: currentIndex ?? this.currentIndex);
  }

  @override
  List<Object> get props => [currentIndex];
}
