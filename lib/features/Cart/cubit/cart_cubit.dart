import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isar_community/isar.dart';
import 'package:my_app/core/database/isar_service.dart';
import 'package:my_app/features/Cart/models/cart_model.dart';
import 'package:my_app/features/Cart/models/purchased_product.dart';
import 'package:my_app/features/Home/data/product_repository.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final IsarService isarService;
  final ProductRepository repo;

  CartCubit(this.isarService, this.repo) : super(CartInitial());

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

  void removeFromCart(int itemId) {
    if (state is CartLoaded) {
      final updatedItems = (state as CartLoaded).items
          .where((item) => item.id != itemId)
          .toList();
      emit(CartLoaded(updatedItems));
    }
  }

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

      emit(CartCheckoutSuccess(purchasedItems));
    } catch (e) {
      emit(CartError("Checkout thất bại: ${e.toString()}"));
    }
  }

  Future<bool> isProductPurchased(String productId) async {
  try {
    final isar = await isarService.db;  

    final count = await isar.purchasedProducts
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
