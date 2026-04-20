import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/features/Cart/models/cart_model.dart';

// Giả sử ông đã định nghĩa CartItem ở một file khác
// import 'cart_item.dart'; 

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  // 1. Thêm sản phẩm vào giỏ
  void addToCart(CartItem newItem) {
    List<CartItem> currentItems = [];

    // Nếu đang ở trạng thái đã load, lấy danh sách cũ ra
    if (state is CartLoaded) {
      currentItems = List.from((state as CartLoaded).items);
    }

    final int existingIndex = currentItems.indexWhere((i) => i.id == newItem.id);

    if (existingIndex != -1) {
      // Nếu trùng ID, dùng copyWith để tăng số lượng (Immutability)
      currentItems[existingIndex] = currentItems[existingIndex].copyWith(
        quantity: currentItems[existingIndex].quantity + newItem.quantity,
      );
    } else {
      currentItems.add(newItem);
    }

    emit(CartLoaded(currentItems));
  }

  // 2. Xóa sản phẩm
  void removeFromCart(int itemId) {
    if (state is CartLoaded) {
      final updatedItems = (state as CartLoaded)
          .items
          .where((item) => item.id != itemId)
          .toList();
      emit(CartLoaded(updatedItems));
    }
  }

  // 3. Cập nhật số lượng (Tăng/Giảm)
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

  // 4. Xóa sạch giỏ hàng
  void clearCart() {
    emit(const CartLoaded([]));
  }

  // 5. Tính tổng tiền (Getter)
  double get totalPrice {
    final currentState = state;
    if (currentState is CartLoaded) {
      return currentState.items.fold(0, (sum, item) => sum + (item.price * item.quantity));
    }
    return 0;
  }
}