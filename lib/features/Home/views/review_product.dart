import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/features/Home/bloc/product%20detail/product_detail_bloc.dart';
import 'package:my_app/features/Home/data/models/product_review.dart';
import 'package:my_app/features/Home/widgets/media_upload.dart';
import 'package:my_app/features/Home/widgets/rating_section.dart';

class ReviewSection extends StatefulWidget {
  final int productId;
  const ReviewSection({super.key, required this.productId});

  @override
  State<ReviewSection> createState() => _ReviewSectionState();
}

class _ReviewSectionState extends State<ReviewSection> {
  int _selectedRating = 0;
  List<XFile> _selectedImages = [];
  final TextEditingController _inputReview = TextEditingController();

  // Hàm gửi review
  void _onReviewSubmitted(BuildContext context) {
    if (_selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng chọn số sao đánh giá")),
      );
      return;
    }

    if (_inputReview.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Vui lòng nhập bình luận")));
      return;
    }

    // Gửi review
    final addReview = ProductReview(
      productId: widget.productId,
      isReviewed: true,
      rating: _selectedRating,
      comment: _inputReview.text,
      images: _selectedImages.map((file) => file.path).toList(),
    );
    context.read<ProductDetailBloc>().add(ReviewSubmitted(addReview));

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Reviews",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Marker Felt',
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        RatingSection(
          onRatingChanged: (rating) {
            setState(() {
              _selectedRating = rating;
            });
          },
        ),
        const SizedBox(height: 16),
        MediaUploadSection(
          onImagesChanged: (images) {
            setState(() {
              _selectedImages = images;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildReviewInputSection(),
        _buildAnonymousToggle(),
        _buildSubmitButton(context),
      ],
    );
  }

  // Nhập review
  Widget _buildReviewInputSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
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
                controller: _inputReview,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Hãy chia sẻ nhận xét...",
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
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
        const Text(
          "Đánh giá ẩn danh",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }

  // Submit
  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _onReviewSubmitted(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber[900],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 4,
        minimumSize: Size(double.infinity, 50),
      ),
      child: const Text("Gửi"),
    );
  }
}
