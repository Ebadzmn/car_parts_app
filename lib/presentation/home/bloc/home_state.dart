part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class FetchCard extends HomeState {
  final List<ProductEntities> data;

  FetchCard({required this.data});

  FetchCard copyWith({List<ProductEntities>? data}) {
    return FetchCard(data: data ?? this.data);
  }

  @override
  List<Object> get props => [data];
}

final class ProductError extends HomeState {
  final String message;

  ProductError({required this.message});
  @override
  List<Object> get props => [message];
}
