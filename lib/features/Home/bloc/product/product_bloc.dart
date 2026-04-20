import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository repo;
  ProductBloc(this.repo) : super(ProductState()) {
    on<FetchAllProducts>(
      (event, emit) async => _handleLoad(emit, () => repo.getProducts()),
    );

    on<FetchProductsByCategory>((event, emit) async {
      if (event.categoryId == 'all') {
        add(FetchAllProducts());
        return;
      }
      await _handleLoad(
        emit,
        () => repo.getProductsByCategory(event.categoryId),
      );
    });
  }

  Future<void> _handleLoad(
    Emitter<ProductState> emit,
    Future<List<Products>> Function() fetcher,
  ) async {
    //  copyWith nhưng KHÔNG truyền products mới vào đây
    // isLoading = true, nhưng state.products VẪN GIỮ GIÁ TRỊ CŨ
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final newProducts = await fetcher();
      emit(state.copyWith(products: newProducts, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}

