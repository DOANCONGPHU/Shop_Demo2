import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/Cart/cubit/cart_cubit.dart';
import 'package:my_app/features/Cart/views/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 70, 125, 203),
          ),
        ),
        backgroundColor: Colors.grey[400],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return switch (state) {
            CartInitial() => const EmptyCartView(),
            CartLoading() => const Center(child: CircularProgressIndicator()),
            CartError(message: var message) => Text('Error: $message'),
            CartLoaded(items: var items) =>
              items.isEmpty
                  ? const EmptyCartView()
                  : Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return CartItemCard(cartItem: items[index]);
                            },
                          ),
                        ),
                        const Divider(thickness: 2, height: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    '\$${context.read<CartCubit>().totalPrice.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 12),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2E5AAC),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 4,
                                  minimumSize: const Size(double.infinity, 50),
                                ),
                                onPressed: () {
                                  //TODO
                                },
                                child: const Text('Checkout'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
          };
        },
      ),
    );
  }
}

class EmptyCartView extends StatelessWidget {
  const EmptyCartView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
