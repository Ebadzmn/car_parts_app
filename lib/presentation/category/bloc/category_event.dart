part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoriesEvent extends CategoryEvent {}





// class LoadProductByCategoryEvent extends CategoryEvent {
//   final String categoryId;
//   const LoadProductByCategoryEvent(this.categoryId);
//   @override
//   List<Object> get props => [categoryId];
// }

// class SelectCategoryEvent extends CategoryEvent {
//   final String categoryId;
//   const SelectCategoryEvent(this.categoryId);
//   @override
//   List<Object> get props => [categoryId];
// }
