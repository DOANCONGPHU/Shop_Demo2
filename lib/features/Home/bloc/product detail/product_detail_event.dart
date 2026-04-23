part of 'product_detail_bloc.dart';

sealed class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object> get props => [];
}

final class FetchProductDetail extends ProductDetailEvent {
  final int productId;
  const FetchProductDetail(this.productId);

  @override
  List<Object> get props => [productId];
}

final class RetryFetchProductDetail extends ProductDetailEvent {}

final class ReviewSubmitted extends ProductDetailEvent {
  final ProductReview review;
  const ReviewSubmitted(this.review);

  @override
  List<Object> get props => [review];
}