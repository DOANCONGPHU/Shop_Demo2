part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final List<Categories> categories;
  final String selectedId; // Mặc định là 'all'
  final bool isLoading;

  const CategoryState({
    this.categories = const [],
    this.selectedId = 'all',
    this.isLoading = false,
  });

  CategoryState copyWith({
    List<Categories>? categories,
    String? selectedId,
    bool? isLoading,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      selectedId: selectedId ?? this.selectedId,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [categories, selectedId, isLoading];
}
