part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class FetchAllProducts extends ProductEvent {}
final class FetchProductsByCategory extends ProductEvent {
  final String categoryId;
  const FetchProductsByCategory(this.categoryId);
  @override
  List<Object> get props => [categoryId];
}