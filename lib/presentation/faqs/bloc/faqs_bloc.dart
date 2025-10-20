import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'faqs_event.dart';
part 'faqs_state.dart';

class FaqsBloc extends Bloc<FaqsEvent, FaqsState> {
  FaqsBloc() : super(FaqsState()) {
    on<toggleFaqExpansion>((event, emit) {
      emit(state.copyWith(isExpanded: !state.isExpanded));
    });
  }
}
