import 'package:flutter/material.dart';
import 'package:my_app/features/Home/data/dio_client.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_api.dart';
import 'package:my_app/features/Home/data/product_repository.dart';
import 'package:my_app/core/widgets/border_list_image.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late Future<Products> _futureProductDetail;
  int selectedImageIndex = 0;

  @override
  void dispose() {
    print('đã xoá ProductDetail khỏi cây widget');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _futureProductDetail = ProductRepository(
      ProductApi(DioClient().dio),
    ).getProductById(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail"),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      body: FutureBuilder<Products>(
        future: _futureProductDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("Product not found"));
          } else {
            final product = snapshot.data!;
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: ClipRRect(
                        child: Image.network(
                          product.images[selectedImageIndex],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey[300],
                                child: Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey[600],
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.images.length,
                      itemBuilder: (context, index) {
                        return BorderListImage(
                          imageUrl: product.images[index],
                          isSelected: selectedImageIndex == index,
                          onTap: () {
                            setState(() {
                              selectedImageIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "\$${product.price.toStringAsFixed(2)}",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              "${product.rating.toStringAsFixed(1)}⭐️",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Text(
                          product.description,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
