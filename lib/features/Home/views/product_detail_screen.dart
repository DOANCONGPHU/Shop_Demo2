import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:my_app/features/Home/data/dio_client.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_api.dart';
import 'package:my_app/features/Home/data/product_repository.dart';
import 'package:my_app/core/widgets/border_list_image.dart';
import 'package:my_app/features/Home/widgets/media_upload.dart';

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
        shadowColor: Colors.black,
        elevation: 1
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
            return Padding(
              padding: const EdgeInsets.all(8),
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            fontSize: 18,
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
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverToBoxAdapter(child: Divider(thickness: 2, height: 1)),
                  SliverToBoxAdapter(child: const ReviewSection()),
                  SliverToBoxAdapter(child: SizedBox(height: 20)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class ReviewSection extends StatelessWidget {
  const ReviewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Reviews",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Marker Felt',
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        RatingSection(),
        SizedBox(height: 16),
        MediaUploadSection(),
        SizedBox(height: 16),
        _buildReviewInputSection(),
        SizedBox(height: 16),
        _buildAnonymousToggle(),
        Divider(thickness: 1, height: 1),
        _buildSubmitButton(),
      ],
    );
  }


  // Nhập review
  Widget _buildReviewInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Viết đánh giá từ 50 ký tự trở lên",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          child: Stack(
            children: [
              TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Hãy chia sẻ nhận xét...",
                  border: InputBorder.none, 
                  enabledBorder: InputBorder.none, 
                  focusedBorder:
                      InputBorder.none, 
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Text(
                  "0/200",
                  style: TextStyle(color: Colors.grey, fontSize: 8),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Ẩn danh
  Widget _buildAnonymousToggle() {
    bool isChecked = false;
    return Row(
      children: [
        Checkbox(tristate: true, value: isChecked, onChanged: null),
        Text(
          "Đánh gái ẩn danh",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  // Submit
  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber[900],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        minimumSize: Size(double.infinity, 50),
      ),
      child: Text("Gửi"),
    );
  }
}

// RatingSection.dart  (hoặc để cùng file cũng được)
class RatingSection extends StatefulWidget {
  const RatingSection({super.key});

  @override
  State<RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Đánh giá sản phẩm",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _rating = index + 1;
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.star,
                  size: 45,
                  color: index < _rating ? Colors.amber : Colors.grey[300],
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 6),
        Center(
          child: Text(
            _rating == 0 ? "Chưa đánh giá" : "$_rating / 5 sao",
            style: TextStyle(
              fontSize: 14,
              color: _rating == 0 ? Colors.grey : Colors.amber,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}