// lib/presentation/details/bloc/report_event.dart
part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();
  @override
  List<Object?> get props => [];
}

class PickImageFromGalleryEvent extends ReportEvent {}

class PickImageFromCameraEvent extends ReportEvent {}

class RemoveImageEvent extends ReportEvent {
  const RemoveImageEvent();
  @override
  List<Object?> get props => [];
}

class SubmitReportEvent extends ReportEvent {
  final String type; // 'product' or 'seller'
  final String targetId;
  final String description;

  const SubmitReportEvent({
    required this.type,
    required this.targetId,
    required this.description,
  });

  @override
  List<Object?> get props => [type, targetId, description];
}
