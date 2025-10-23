part of 'details_bloc.dart';

class DetailsState extends Equatable {
  final int currentIndex;

  const DetailsState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class ReportState extends DetailsState {
  const ReportState(int selectedIndex) : super(selectedIndex);

  ReportState copyWith({int? selectedIndex}) {
    return ReportState(selectedIndex ?? currentIndex);
  }
}
