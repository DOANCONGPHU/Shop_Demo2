import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_app/features/Home/data/models/product_review.dart';

class ReviewedSection extends StatelessWidget {
  final ProductReview review;
  const ReviewedSection({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            spreadRadius: 2,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(48),
                child: Image.network(
                  "https://www.pngitem.com/pimgs/m/575-5759580_anonymous-avatar-image-png-transparent-png.png",
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 48,
                    height: 48,
                    color: Colors.grey[200],
                    child: Icon(Icons.broken_image, color: Colors.grey[400]),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Anonymous",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: List.generate(5, (index) {
                        return Icon(
                          Icons.star_rounded,
                          size: 18,
                          color: index < review.rating ? Colors.amber : Colors.grey[300],
                        );
                      }),
                    
                  ),
                ],
              ),
            ],
          ),

          // Content
          const SizedBox(height: 12),
          Text(
            review.comment,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),

          // Footer
          const SizedBox(height: 12),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(width: 12),
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(review.images[index]),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
