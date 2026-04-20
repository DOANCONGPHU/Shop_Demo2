import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/features/Cart/models/cart_model.dart';

// Giả sử ông đã định nghĩa CartItem ở một file khác
// import 'cart_item.dart'; 

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void addToCart(CartItem newItem) {
    List<CartItem> currentItems = [];

    if (state is CartLoaded) {
      currentItems = List.from((state as CartLoaded).items);
    }

    final int existingIndex = currentItems.indexWhere((i) => i.id == newItem.id);

    if (existingIndex != -1) {
      // trùng ID,  copyWith tăng số lượng 
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
      final updatedItems = (state as CartLoaded)
          .items
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

  double get totalPrice {
    final currentState = state;
    if (currentState is CartLoaded) {
      return currentState.items.fold(0, (sum, item) => sum + (item.price * item.quantity));
    }
    return 0;
  }
}