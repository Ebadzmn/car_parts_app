part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class FetchCard extends HomeState {
  final List<ProductEntity> data;
  final String? currentCategory; // Track current category

  FetchCard(this.currentCategory, {required this.data});

  FetchCard copyWith({List<ProductEntity>? data}) {
    return FetchCard(currentCategory, data: data ?? this.data);
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
