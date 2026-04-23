import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repo;

  ProductBloc(this.repo) : super(const ProductState()) {
    on<FetchAllProducts>(_onFetchAllProducts);
    on<FetchProductsByCategory>(_onFetchByCategory);
    on<RetryFetchProducts>(_onRetry);
  }

  Future<void> _onFetchAllProducts(
    FetchAllProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final products = await repo.getProducts();
      emit(state.copyWith(products: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onFetchByCategory(
    FetchProductsByCategory event,
    Emitter<ProductState> emit,
  ) async {
    if (state.isLoading) return;
    if (event.categoryId == 'all') {
      add(FetchAllProducts());
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final products = await repo.getProductsByCategory(event.categoryId);
      emit(state.copyWith(products: products, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> _onRetry(
    RetryFetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state.error != null) {
      add(FetchAllProducts());
    }
  }
}

