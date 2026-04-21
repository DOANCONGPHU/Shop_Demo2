import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/Home/bloc/category/category_bloc.dart';
import 'package:my_app/features/Home/bloc/product/product_bloc.dart';
import 'package:my_app/features/Home/data/models/categories.dart';

class CategoryWidget extends StatelessWidget {
  final List<Categories> categories;
  final String selectedCategoryId;

  const CategoryWidget({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final item = categories[index];
        final bool isSelected = item.slug == selectedCategoryId;

        return GestureDetector(
          onTap: () {
            // Hai action này là cần thiết
            context.read<CategoryBloc>().add(SelectCategory(item.slug));
            context.read<ProductBloc>().add(FetchProductsByCategory(item.slug));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.grey[350],
              borderRadius: BorderRadius.circular(8), // bo tròn hơn cho đẹp
            ),
            child: Center(
              child: Text(
                item.name,
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 8),
      itemCount: categories.length,
    );
  }
}