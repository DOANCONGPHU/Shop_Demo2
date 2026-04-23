import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isar_community/isar.dart';
import 'package:my_app/core/database/isar_service.dart';
import 'package:my_app/features/Cart/models/purchased_product.dart';
import 'package:my_app/features/Home/data/models/product_review.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_repository.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository repo;
  final IsarService isarService;

  ProductDetailBloc(this.repo, this.isarService)
    : super(ProductDetailInitial()) {
    on<FetchProductDetail>(_onFetchProductDetail);
    on<RetryFetchProductDetail>(_onRetry);
    on<ReviewSubmitted>(_onReviewSubmitted);
  }

  Future<void> _onFetchProductDetail(
    FetchProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (state is ProductDetailLoading) return;

    emit(ProductDetailLoading());
  
    try {
      final product = await repo.getProductById(event.productId);
      final review = await repo.getReviewByProduct(event.productId);

      emit(
        ProductDetailLoaded(
          product: product,
          isPurchased: await _onCheckProductPurchased(event.productId),
          isReviewed: await _onCheckProductReviewed(event.productId),
          review: review,
        ),
      );
    } catch (e) {
      emit(ProductDetailError(e.toString()));
    }
  }

  Future<void> _onRetry(
    RetryFetchProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    if (state is ProductDetailError) {
      add(FetchProductDetail(event.hashCode));
    }
  }

  Future<bool> _onCheckProductPurchased(int productId) async {
    final isar = await isarService.db;
    final count = await isar.purchasedProducts
        .filter()
        .productIdEqualTo(productId.toString())
        .count();
    return count > 0;
  }
  // Review - check
  Future<bool> _onCheckProductReviewed(int productId) async {
    final review = await repo.getReviewByProduct(productId);
    return review != null;
  }
  
  // Review - save
  Future<void> _onReviewSubmitted(
    ReviewSubmitted event,
    Emitter<ProductDetailState> emit,
  ) async {
    try {
      final review = ProductReview(
        productId: event.review.productId,
        isReviewed: event.review.isReviewed,
        rating: event.review.rating,
        comment: event.review.comment,
        images: event.review.images,
      );
      await repo.saveReview(review);
      add(FetchProductDetail(event.review.productId ?? 7));

    } catch (e) {
      "Lỗi khi lưu review: $e";
    }
  }
}
