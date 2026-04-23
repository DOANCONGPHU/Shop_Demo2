import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/widgets/shimmer.dart';
import 'package:my_app/features/Home/bloc/product%20detail/product_detail_bloc.dart';
import 'package:my_app/features/Home/data/models/product_review.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/core/widgets/border_list_image.dart';
import 'package:my_app/features/Home/views/review_product.dart';
import 'package:my_app/features/Home/views/reviewed_product.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int selectedImageIndex = 0;

  @override
  void dispose() {
    print('đã xoá ProductDetail khỏi cây widget');
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailBloc>().add(FetchProductDetail(widget.productId));
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
        shadowColor: Colors.black,
        elevation: 1,
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return switch (state) {
            ProductDetailInitial() ||
            ProductDetailLoading() => const ShimmerBanner(),
            ProductDetailError(message: var message) => Text("Lỗi: $message"),
            ProductDetailLoaded(
              product: var product,
              isPurchased: var isPurchased,
              isReviewed: var isReviewed,
              review: var review,
            ) =>
              _buildProductDetail(
                product,
                isPurchased,
                isReviewed,
                review: review,
              ),
          };
        },
      ),
    );
  }

  Widget _buildProductDetail(
    Products product,
    bool isPurchased,
    bool isReviewed, {
    ProductReview? review,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildThumnail(product)),
          SliverToBoxAdapter(child: _buildListImage(product)),
          SliverToBoxAdapter(child: _buildInfoProduct(product)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(child: Divider(thickness: 2, height: 1)),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          if (isReviewed)
            SliverToBoxAdapter(child: ReviewedSection(review: review!))
          else if (isPurchased)
            SliverToBoxAdapter(child: ReviewSection())
          else
            SliverToBoxAdapter(child: Text("Bạn chưa mua sản phẩm này")),

          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }

  // Thumnail
  Widget _buildThumnail(Products product) {
    return Container(
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
            errorBuilder: (context, error, stackTrace) => Container(
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
    );
  }

  // List Image
  Widget _buildListImage(Products product) {
    return SizedBox(
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
    );
  }

  // Info Product
  Widget _buildInfoProduct(Products product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              "\$${product.price.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(width: 16),
            Text(
              "${product.rating.toStringAsFixed(1)}⭐️",
              style: TextStyle(fontSize: 16, color: Colors.orange),
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          product.description,
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
      ],
    );
  }
}
