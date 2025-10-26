import 'package:car_parts_app/core/coreWidget/bloc/navbar_event.dart';
import 'package:car_parts_app/core/coreWidget/bloc/navbar_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBloc extends Bloc<BottomNavEvent, BottomNavState> {
  BottomNavBloc() : super(const BottomNavState()) {
    on<TabChanged>((event, emit) {
      emit(state.copyWith(currentIndex: event.index));
    });
  }
}
