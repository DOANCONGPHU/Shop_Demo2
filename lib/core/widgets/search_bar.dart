import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController? controller;
  const MySearchBar({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: "Search products...",
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => {
                if (value.trim().isNotEmpty)
                  {context.push('/search?query=${Uri.encodeComponent(value)}')},
              },
            ),
          ),
        ],
      ),
    );
  }
}
