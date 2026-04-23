part of 'product_bloc.dart';

class ProductState extends Equatable {
  final List<Products> products;
  final bool isLoading; 
  final String? error;

  const ProductState({
    this.products = const [],
    this.isLoading = false,
    this.error,
  });

  ProductState copyWith({
    List<Products>? products,
    bool? isLoading,
    String? error,
  }) {
    return ProductState(
      products: products ?? this.products, 
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  @override
  List<Object?> get props => [products, isLoading, error];
}

