import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/Cart/cubit/cart_cubit.dart';
import 'package:my_app/features/Cart/models/cart_model.dart';
import 'package:my_app/features/Home/data/models/products.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  const ProductCard({super.key, required this.product});

  // Tối ưu: Tách hàm xử lý Add to Cart để hàm build ngắn gọn hơn
  void _onAddToCart(BuildContext context) {
    final cartNewItem = CartItem(
      id: product.id,
      name: product.title,
      price: product.price,
      imageUrl: product.thumbnail,
      quantity: 1,
    );
    context.read<CartCubit>().addToCart(cartNewItem);
    
    // Tối ưu UX: Tránh việc hiện nhiều SnackBar chồng chéo
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.title} added to cart!'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1, // Giảm nhẹ elevation để trông hiện đại và đỡ tốn tài nguyên vẽ
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), // Bo góc 12 nhìn mềm mại hơn 8
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn trên để các dòng text đẹp hơn
          children: [
            // PHẦN HÌNH ẢNH
            ClipRRect(
              borderRadius: BorderRadius.circular(8), // Bo đều 4 góc cho ảnh trong Row
              child: Image.network(
                product.thumbnail,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
                // QUAN TRỌNG: Tối ưu bộ nhớ bằng cacheWidth/Height
                // Điều này giúp Flutter không phải load toàn bộ ảnh gốc (có thể vài MB) 
                // vào RAM mà chỉ load đúng kích thước hiển thị.
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

            // PHẦN NỘI DUNG
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
                  
                  // Rating gọn hơn
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
                          color: Colors.blueAccent, // Đổi màu để nổi bật giá tiền
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      // TỐI ƯU NÚT BẤM
                      /* // Code cũ của bạn: ElevatedButton khá chiếm diện tích trong Row hẹp
                      ElevatedButton(
                        onPressed: () => _onAddToCart(context),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          backgroundColor: Colors.blue[900],
                        ),
                        child: Text("Add to Cart", style: TextStyle(fontSize: 12)),
                      )
                      */
                      
                      // Giải pháp thay thế: IconButton hoặc MaterialButton nhỏ gọn
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