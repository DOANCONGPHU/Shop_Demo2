import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBanner extends StatelessWidget {
  const ShimmerBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,     
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: const EdgeInsets.all(16),
        width: double.infinity,
        height: 150, 
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}