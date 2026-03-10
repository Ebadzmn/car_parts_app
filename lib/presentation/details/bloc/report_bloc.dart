// lib/presentation/details/bloc/report_bloc.dart
import 'dart:convert';
import 'dart:io';
import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ImagePicker _picker;
  final NetworkCaller networkCaller;

  ReportBloc({required this.networkCaller, ImagePicker? picker})
    : _picker = picker ?? ImagePicker(),
      super(const ReportState()) {
    on<PickImageFromGalleryEvent>(_onPickFromGallery);
    on<PickImageFromCameraEvent>(_onPickFromCamera);
    on<RemoveImageEvent>(_onRemoveImage);
    on<SubmitReportEvent>(_onSubmitReport);
  }

  Future<void> _onPickFromGallery(
    PickImageFromGalleryEvent event,
    Emitter<ReportState> emit,
  ) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (picked == null) return;
      emit(state.copyWith(imagePath: picked.path, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to pick image'));
    }
  }

  Future<void> _onPickFromCamera(
    PickImageFromCameraEvent event,
    Emitter<ReportState> emit,
  ) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (picked == null) return;
      emit(state.copyWith(imagePath: picked.path, errorMessage: null));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to take photo'));
    }
  }

  void _onRemoveImage(RemoveImageEvent event, Emitter<ReportState> emit) {
    emit(state.copyWith(imagePath: null, errorMessage: null));
  }

  Future<void> _onSubmitReport(
    SubmitReportEvent event,
    Emitter<ReportState> emit,
  ) async {
    final trimmed = event.description.trim();
    if (trimmed.length < 3) {
      emit(
        state.copyWith(errorMessage: 'Reason must be at least 3 characters'),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));

    try {
      // Build files list (image is optional)
      final List<MapEntry<String, File>> files = [];
      if (state.imagePath != null && state.imagePath!.isNotEmpty) {
        files.add(MapEntry('image', File(state.imagePath!)));
      }

      final response = await networkCaller.uploadMultipart(
        ApiUrls.submitReport,
        files: files,
        fields: {
          'data': jsonEncode({
            'type': event.type,
            'targetId': event.targetId,
            'reason': trimmed,
          }),
        },
      );

      if (response.success) {
        emit(state.copyWith(isSubmitting: false, submitted: true));
      } else {
        emit(
          state.copyWith(
            isSubmitting: false,
            errorMessage: response.message ?? 'Failed to submit report',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          isSubmitting: false,
          errorMessage: 'Submit failed. Try again.',
        ),
      );
    }
  }
}
