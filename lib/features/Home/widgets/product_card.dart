import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/Cart/cubit/cart_cubit.dart';
import 'package:my_app/features/Cart/models/cart_model.dart';
import 'package:my_app/features/Home/data/models/products.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  const ProductCard({super.key, required this.product});

  void _onAddToCart(BuildContext context) {
    final cartNewItem = CartItem(
      id: product.id,
      name: product.title,
      price: product.price,
      imageUrl: product.thumbnail,
      quantity: 1,
    );
    context.read<CartCubit>().addToCart(cartNewItem);
    
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} thêm vào giỏ'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1, 
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), 
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(8), 
              child: Image.network(
                product.thumbnail,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                cacheWidth: 200, 
                cacheHeight: 200,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 80,
                  width: 80,
                  color: Colors.grey[200],
                  child: Icon(Icons.broken_image, color: Colors.grey[400]),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  const SizedBox(height: 4),
                  
                  Row(
                    children: [
                      const Icon(Icons.star, size: 14, color: Colors.orange),
                      const SizedBox(width: 4),
                      Text(
                        "${product.rating}",
                        style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${product.price}",
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.blueAccent, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      /* 
                      ElevatedButton(
                        onPressed: () => _onAddToCart(context),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          backgroundColor: Colors.blue[900],
                        ),
                        child: Text("Add to Cart", style: TextStyle(fontSize: 12)),
                      )
                      */
                      
                      Material(
                        color: Colors.blue[900],
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
                          onTap: () => _onAddToCart(context),
                          borderRadius: BorderRadius.circular(8),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            child: Icon(Icons.add_shopping_cart, color: Colors.white, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}