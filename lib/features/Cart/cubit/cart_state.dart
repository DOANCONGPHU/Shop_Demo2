// cart_state.dart
part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<CartItem> items;
  const CartLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

final class CartError extends CartState {
  final String message;
  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}

final class CartCheckoutSuccess extends CartState{
  final List<CartItem> purchasedItems;
  const CartCheckoutSuccess(this.purchasedItems);

  @override
  List<Object?> get props => [purchasedItems];
}
