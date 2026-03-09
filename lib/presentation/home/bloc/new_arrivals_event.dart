part of 'new_arrivals_bloc.dart';

abstract class NewArrivalsEvent extends Equatable {
  const NewArrivalsEvent();

  @override
  List<Object> get props => [];
}

/// Fetch the first page of new arrival products.
class FetchNewArrivalsRequested extends NewArrivalsEvent {
  final String? limit;

  const FetchNewArrivalsRequested({this.limit});

  @override
  List<Object> get props => [limit ?? ''];
}

/// Load the next page of new arrival products (pagination).
class FetchMoreNewArrivalsRequested extends NewArrivalsEvent {}
