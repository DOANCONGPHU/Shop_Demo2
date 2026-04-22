import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:isar_community/isar.dart';

import 'package:my_app/core/database/isar_service.dart';
import 'package:my_app/features/Cart/models/cart_model.dart';
import 'package:my_app/features/Cart/models/purchased_product.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final IsarService isarService;

  CartCubit(this.isarService) : super(CartInitial());

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

      await _savePurchasedProducts(purchasedItems);

      emit(CartCheckoutSuccess(purchasedItems));
    } catch (e) {
      emit(CartError("Checkout thất bại: ${e.toString()}"));
    }
  }

  Future<void> _savePurchasedProducts(List<CartItem> purchasedItems) async {
    final isar = isarService.db;
    final List<PurchasedProduct> purchasedProducts = purchasedItems.map((item) {
      return PurchasedProduct(productId: item.id.toString());
    }).toList();

    await isar.writeTxn(() async {
      await isar.purchasedProducts.putAll(purchasedProducts);
    });
  }

  Future<bool> isProductPurchased(String productId) async {
    final isar = isarService.db;
    final count = await isar.purchasedProducts
        .filter()
        .productIdEqualTo(productId)
        .count();

    return count > 0;
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
