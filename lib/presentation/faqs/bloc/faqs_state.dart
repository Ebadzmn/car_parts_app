part of 'faqs_bloc.dart';

class FaqsState {
  final bool isExpanded;

  FaqsState({this.isExpanded = false});

  FaqsState copyWith({bool? isExpanded}) {
    return FaqsState(isExpanded: isExpanded ?? this.isExpanded);
  }
}

// final class FaqsInitial extends FaqsState {
//   const FaqsInitial() : super(isExpanded: false);
// }

// final class FaqsLoaded extends FaqsState {
//   const FaqsLoaded({required bool isExpanded}) : super(isExpanded: isExpanded);
// }
