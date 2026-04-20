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

// class HomeState extends Equatable {
//   final List<Products> products;
//   final List<Products> banners;
//   final List<Categories> categories;
//   final bool isLoading;
//   final String? error;
  

//   final String selectedCategoryId; 

//   const HomeState({
//     this.products = const [],
//     this.banners = const [],
//     this.categories = const [],
//     this.isLoading = false,
//     this.error,
//     this.selectedCategoryId = '', 
//   });

//   @override
//   List<Object?> get props => [products, banners, categories, isLoading, error, selectedCategoryId];

//   HomeState copyWith({
//     List<Products>? products,
//     List<Products>? banners,
//     List<Categories>? categories,
//     bool? isLoading,
//     String? error,
//     String? selectedCategoryId, 
//   }) {
//     return HomeState(
//       products: products ?? this.products,
//       banners: banners ?? this.banners,
//       categories: categories ?? this.categories,
//       isLoading: isLoading ?? this.isLoading,
//       error: error, 
//       selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId, 
//     );
//   }
// }

// abstract class ProductState {}

// class ProductInitial extends ProductState {}

// class ProductLoading extends ProductState {}

// class ProductLoaded extends ProductState {
//   final List<Products> products;

//   ProductLoaded(this.products);
// }

// class BannerLoaded extends ProductState {
//   final List<Products> banners;

//   BannerLoaded(this.banners);
// }

// class ProductError extends ProductState {
//   final String message;

//   ProductError(this.message);
// }