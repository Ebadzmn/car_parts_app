import 'package:equatable/equatable.dart';

abstract class StepperEvent extends Equatable {
  const StepperEvent();

  @override
  List<Object> get props => [];
}

class NextStepEvent extends StepperEvent {}

class PreviousStepEvent extends StepperEvent {}

class UpdateFormEvent extends StepperEvent {
  final Map<String, dynamic> formData;
  const UpdateFormEvent(this.formData);

  @override
  List<Object> get props => [formData];
}
