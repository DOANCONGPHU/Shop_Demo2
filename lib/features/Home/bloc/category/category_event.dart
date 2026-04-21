part of 'category_bloc.dart';

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}
final class FetchCategories extends CategoryEvent {}
final class SelectCategory extends CategoryEvent {
  final String categoryId;
  const SelectCategory(this.categoryId);
  @override
  List<Object> get props => [categoryId];
}
final class RetryFetchCategories extends CategoryEvent {}