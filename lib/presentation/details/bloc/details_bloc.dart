import 'package:bloc/bloc.dart';
import 'package:car_parts_app/presentation/onboard/bloc/onboard_bloc.dart';
import 'package:equatable/equatable.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsState(0)) {
    // Carousel page change
    on<CaroselPageChanged>((event, emit) {
      emit(DetailsState(event.index));
    });

    // Tab selection
    on<SelectTabEvent>((event, emit) {
      // Use positional parameter, not named
      emit(ReportState(event.index));
    });
  }
}
