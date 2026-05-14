import 'package:flutter/material.dart';

class RatingSection extends StatefulWidget {
  final Function(int rating) onRatingChanged;
  const RatingSection({super.key, required this.onRatingChanged});

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
                widget.onRatingChanged(_rating);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(
                  Icons.star,
                  size: 45,
                  color: index < _rating
                      ? Colors.yellow.shade700
                      : Colors.grey.shade400,
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
