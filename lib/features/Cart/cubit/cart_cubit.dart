import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';
import 'package:my_app/core/Notification/notification_service.dart';
import 'package:my_app/core/database/isar_service.dart';
import 'package:my_app/features/Cart/models/cart_model.dart';
import 'package:my_app/features/Cart/models/purchased_item.dart';
import 'package:my_app/features/Home/data/product_repository.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final IsarService isarService;
  final ProductRepository repo;

  CartCubit(this.isarService, this.repo) : super(CartInitial());
  // Thêm sản phẩm vào giỏ hàng
  void addToCart(CartItem newItem) {
    List<CartItem> currentItems = [];

    if (state is CartLoaded) {
      currentItems = List.from((state as CartLoaded).items);
    }

    final int existingIndex = currentItems.indexWhere(
      (i) => i.id == newItem.id,
    );

    if (existingIndex != -1) {
      currentItems[existingIndex] = currentItems[existingIndex].copyWith(
        quantity: currentItems[existingIndex].quantity + newItem.quantity,
      );
    } else {
      currentItems.add(newItem);
    }

    emit(CartLoaded(currentItems));
  }

  // Xoá sản phẩm khỏi giỏ hàng
  void removeFromCart(int itemId) {
    if (state is CartLoaded) {
      final updatedItems = (state as CartLoaded).items
          .where((item) => item.id != itemId)
          .toList();
      emit(CartLoaded(updatedItems));
    }
  }

  // Cập nhật số lượng sản phẩm trong giỏ hàng
  void updateQuantity(int itemId, int newQuantity) {
    if (state is CartLoaded) {
      if (newQuantity <= 0) {
        removeFromCart(itemId);
        return;
      }

      final updatedItems = (state as CartLoaded).items.map((item) {
        return item.id == itemId ? item.copyWith(quantity: newQuantity) : item;
      }).toList();

      emit(CartLoaded(updatedItems));
    }
  }

  void clearCart() {
    emit(const CartLoaded([]));
  }

  // Thanh toán
  Future<void> checkout() async {
    if (state is! CartLoaded || (state as CartLoaded).items.isEmpty) {
      emit(const CartError("Giỏ hàng trống!"));
      return;
    }
    final currentItems = (state as CartLoaded).items;
    emit(CartLoading());

    try {
      await Future.delayed(const Duration(seconds: 1, milliseconds: 500));
      final purchasedItems = List<CartItem>.from(currentItems);

      await repo.savePurchasedProducts(purchasedItems);

      await NotificationService().showNotification(
        id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title: 'Đơn hàng đã hoàn tất',
        body:
            'Bạn hài lòng với sản phẩm này chứ? Hãy dành 30 giây đánh giá nhé!',
        payload: 'open_review_',
        channelId: 'review_channel',
        channelName: 'Đánh giá sản phẩm',
      );

      emit(CartCheckoutSuccess(purchasedItems));
    } catch (e) {
      emit(CartError("Checkout thất bại: ${e.toString()}"));
    }
  }

  // Kiểm tra sản phẩm đã mua hay chưa
  Future<bool> isProductPurchased(String productId) async {
    try {
      final isar =  isarService.db;

      final count = await isar.purchasedItems
          .filter()
          .productIdEqualTo(productId)
          .count();

      return count > 0;
    } catch (e) {
      emit(CartError("Lỗi kiểm tra mua hàng: ${e.toString()}"));
      return false;
    }
  }

  double get totalPrice {
    final currentState = state;
    if (currentState is CartLoaded) {
      return currentState.items.fold(
        0,
        (sum, item) => sum + (item.price * item.quantity),
      );
    }
    return 0;
  }
}
