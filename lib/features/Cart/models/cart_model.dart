import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int id;
  final String name;
  final double price;
  final int quantity;
  final String imageUrl;


  const CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
  CartItem copyWith({int? quantity}) {
    return CartItem(
      id: id,
      name: name,
      price: price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, price, quantity, imageUrl];
}
