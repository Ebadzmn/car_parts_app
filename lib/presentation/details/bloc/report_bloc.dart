// lib/presentation/details/bloc/report_bloc.dart
import 'dart:async';
import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final ImagePicker _picker;

  ReportBloc({ImagePicker? picker})
      : _picker = picker ?? ImagePicker(),
        super(const ReportState()) {
    on<PickImageFromGalleryEvent>(_onPickFromGallery);
    on<PickImageFromCameraEvent>(_onPickFromCamera);
    on<RemoveImageEvent>(_onRemoveImage);
    on<SubmitReportEvent>(_onSubmitReport);
  }

  Future<void> _onPickFromGallery(
      PickImageFromGalleryEvent event, Emitter<ReportState> emit) async {
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
      PickImageFromCameraEvent event, Emitter<ReportState> emit) async {
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
    // debug log - visible in console to confirm handler ran
    print('[ReportBloc] RemoveImageEvent received - removing image (emit null path)');
    emit(state.copyWith(imagePath: null, errorMessage: null));
  }

  Future<void> _onSubmitReport(
      SubmitReportEvent event, Emitter<ReportState> emit) async {
    // validation inside bloc (redundant to UI validation; keeps single source of truth)
    final trimmed = event.description.trim();
    if (trimmed.length < 3) {
      emit(state.copyWith(errorMessage: 'Description must be at least 3 characters'));
      return;
    }
    if (state.imagePath == null) {
      emit(state.copyWith(errorMessage: 'Please attach an image'));
      return;
    }

    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      // TODO: call your usecase/repository here to upload description + imagePath
      // Example pseudocode:
      // final file = File(state.imagePath!);
      // await reportUsecase.submitReport(description: trimmed, imageFile: file);
      await Future.delayed(const Duration(milliseconds: 800)); // simulate network
      emit(state.copyWith(isSubmitting: false, submitted: true));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, errorMessage: 'Submit failed. Try again.'));
    }
  }
}
