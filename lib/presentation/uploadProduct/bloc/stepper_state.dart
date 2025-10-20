import 'package:equatable/equatable.dart';

class StepperState extends Equatable {
  final int currentStep;
  final Map<String, dynamic> formData;

  const StepperState({this.currentStep = 1, this.formData = const {}});

  StepperState copyWith({int? currentStep, Map<String, dynamic>? formData}) {
    return StepperState(
      currentStep: currentStep ?? this.currentStep,
      formData: formData ?? this.formData,
    );
  }

  @override
  List<Object> get props => [currentStep, formData];
}
