// lib/presentation/details/bloc/report_state.dart
part of 'report_bloc.dart';

class ReportState extends Equatable {
  final String? imagePath; // store path only — reliable for equality
  final bool isSubmitting;
  final bool submitted;
  final String? errorMessage;

  const ReportState({
    this.imagePath,
    this.isSubmitting = false,
    this.submitted = false,
    this.errorMessage,
  });

  ReportState copyWith({
    String? imagePath,
    bool? isSubmitting,
    bool? submitted,
    String? errorMessage,
  }) {
    return ReportState(
      imagePath: imagePath ?? this.imagePath,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitted: submitted ?? this.submitted,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [imagePath, isSubmitting, submitted, errorMessage];
}
