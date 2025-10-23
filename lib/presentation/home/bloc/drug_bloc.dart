
import 'package:car_parts_app/presentation/home/bloc/drug_event.dart';
import 'package:car_parts_app/presentation/home/bloc/drug_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DragBloc extends Bloc<DragEvent, DragState> {
  DragBloc() : super(const DragState(dx: 0)) {
    on<DragUpdateEvent>((event, emit) {
      emit(state.copyWith(dx: event.dx, shouldNavigate: false));
    });

    on<DragEndEvent>((event, emit) {
      // Threshold distance for navigation
      if (event.dx > 109) {
        emit(state.copyWith(shouldNavigate: true));
      } else {
        // Reset to start position
        emit(state.copyWith(dx: 0, shouldNavigate: false));
      }
    });
  }
}
