import 'package:car_parts_app/core/appUrls/api_urls.dart';
import 'package:car_parts_app/core/network/network_caller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ── Events ──

abstract class ReviewSubmitEvent extends Equatable {
  const ReviewSubmitEvent();
  @override
  List<Object?> get props => [];
}

class SubmitProductReview extends ReviewSubmitEvent {
  final String productId;
  final int rating;
  final String comment;

  const SubmitProductReview({
    required this.productId,
    required this.rating,
    required this.comment,
  });

  @override
  List<Object?> get props => [productId, rating, comment];
}

// ── States ──

abstract class ReviewSubmitState extends Equatable {
  const ReviewSubmitState();
  @override
  List<Object?> get props => [];
}

class ReviewInitial extends ReviewSubmitState {}

class ReviewSubmitting extends ReviewSubmitState {}

class ReviewSuccess extends ReviewSubmitState {
  final String message;
  const ReviewSuccess({this.message = 'Review submitted successfully'});
  @override
  List<Object?> get props => [message];
}

class ReviewFailure extends ReviewSubmitState {
  final String message;
  const ReviewFailure(this.message);
  @override
  List<Object?> get props => [message];
}

// ── Bloc ──

class ReviewSubmitBloc extends Bloc<ReviewSubmitEvent, ReviewSubmitState> {
  final NetworkCaller networkCaller;

  ReviewSubmitBloc({required this.networkCaller}) : super(ReviewInitial()) {
    on<SubmitProductReview>(_onSubmitReview);
  }

  Future<void> _onSubmitReview(
    SubmitProductReview event,
    Emitter<ReviewSubmitState> emit,
  ) async {
    emit(ReviewSubmitting());

    final response = await networkCaller.post(
      ApiUrls.submitReview,
      body: {
        'productId': event.productId,
        'rating': event.rating,
        'comment': event.comment,
      },
    );

    if (response.success) {
      final msg = (response.data is Map && response.data['message'] != null)
          ? response.data['message'].toString()
          : 'Review submitted successfully';
      emit(ReviewSuccess(message: msg));
    } else {
      emit(ReviewFailure(response.message ?? 'Failed to submit review'));
    }
  }
}
