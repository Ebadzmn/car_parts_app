part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitial extends CategoryState {}

final class CategoryLoaded extends CategoryState {
  final List<ProductEntities> products;

  const CategoryLoaded(this.products);

  CategoryLoaded copyWith({List<ProductEntities>? products}) {
    return CategoryLoaded(products ?? this.products);
  }

  @override
  List<Object> get props => [products];
}

final class CategoryLoading extends CategoryState {}

final class CategoryError extends CategoryState {
  final String message;
  const CategoryError({required this.message});

  @override
  List<Object> get props => [message];
}
