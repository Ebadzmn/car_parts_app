import 'package:bloc/bloc.dart';
import 'package:car_parts_app/domain/entities/onboard/onb_entities.dart';
import 'package:car_parts_app/domain/usecase/onboard/onboard_usecase.dart';
import 'package:equatable/equatable.dart';

part 'onboard_event.dart';
part 'onboard_state.dart';

class OnboardBloc extends Bloc<OnboardEvent, OnboardState> {
  final OnboardUsecase onboardUsecase;

  OnboardBloc({required this.onboardUsecase}) : super(OnboardInitial()) {
    // 1️⃣ Fetch onboard data
    on<FetchOnBoardEvent>((event, emit) async {
      final result = await onboardUsecase();
      result.fold(
        (failure) => emit(OnboardError(message: 'Bloc Error')),
        (data) => emit(OnboardLoad(data: data)),
      );
    });

    // 2️⃣ Handle page changes
    on<PageChangeEvent>((event, emit) {
      final currentState = state;
      if (currentState is OnboardLoad) {
        emit(currentState.copyWith(currentPage: event.pageIndex));
      }
    });

    // on<OnboardNextEvent>((event, emit) {
    //   final currentState = state;
    //   if (currentState is OnboardLoad) {
    //     final nextPage = (currentState.currentPage + 1).clamp(
    //       0,
    //       currentState.data.length - 1,
    //     );
    //     emit(currentState.copyWith(currentPage: nextPage));
    //   }
    // });

    // // ✅ Go to previous page
    // on<OnboardBackEvent>((event, emit) {
    //   final currentState = state;
    //   if (currentState is OnboardLoad) {
    //     final prevPage = (currentState.currentPage - 1).clamp(
    //       0,
    //       currentState.data.length - 1,
    //     );
    //     emit(currentState.copyWith(currentPage: prevPage));
    //   }
    // });
  }
}
