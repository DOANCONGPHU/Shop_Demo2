part of 'product_detail_bloc.dart';

sealed class ProductDetailState extends Equatable {
  const ProductDetailState();
  
  @override
  List<Object> get props => [];
}

final class ProductDetailInitial extends ProductDetailState {}

final class ProductDetailLoading extends ProductDetailState {}

final class ProductDetailLoaded extends ProductDetailState {
  final Products product;
  final bool isPurchased;
  final bool isReviewed;
  final ProductReview? review;


  const ProductDetailLoaded({
    required this.product,
    required this.isReviewed,
    this.isPurchased = false,
    this.review,
  });

  ProductDetailLoaded copyWith({
    Products? product,
    bool? isPurchased,
    bool? isReviewed,
    ProductReview? review,
  }) {
    return ProductDetailLoaded(
      review: review ?? this.review,
      isReviewed: isReviewed ?? this.isReviewed,
      product: product ?? this.product,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }

  @override
  List<Object> get props => [product, isPurchased, isReviewed, review!];
}

final class ProductDetailError extends ProductDetailState {
  final String message;
  const ProductDetailError(this.message);

  @override
  List<Object> get props => [message];
}

