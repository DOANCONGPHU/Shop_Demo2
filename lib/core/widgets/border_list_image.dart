import 'package:flutter/material.dart';

class BorderListImage extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final VoidCallback onTap;
  const BorderListImage({
    super.key,
    required this.imageUrl,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            color: Colors.grey[300],
            child: Image.network(
              imageUrl,
              width: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: Colors.grey[300],
                child: Icon(
                  Icons.broken_image,
                  size: 30,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
