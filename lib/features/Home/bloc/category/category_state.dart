part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final List<Categories> categories;
  final String selectedId; // Mặc định là 'all'
  final bool isLoading;
  final String?error;

  const CategoryState({
    this.categories = const [],
    this.selectedId = 'all',
    this.isLoading = false,
    this.error,
  });

  CategoryState copyWith({
    List<Categories>? categories,
    String? selectedId,
    bool? isLoading,
    String? error,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      selectedId: selectedId ?? this.selectedId,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [categories, selectedId, isLoading, error];
}
