import 'package:flutter_bloc/flutter_bloc.dart';
import 'stepper_event.dart';
import 'stepper_state.dart';

class StepperBloc extends Bloc<StepperEvent, StepperState> {
  StepperBloc() : super(const StepperState()) {
    on<NextStepEvent>((event, emit) {
      if (state.currentStep < 3) {
        emit(state.copyWith(currentStep: state.currentStep + 1));
      }
    });

    on<PreviousStepEvent>((event, emit) {
      if (state.currentStep > 1) {
        emit(state.copyWith(currentStep: state.currentStep - 1));
      }
    });

    on<UpdateFormEvent>((event, emit) {
      emit(state.copyWith(formData: event.formData));
    });
  }
}
