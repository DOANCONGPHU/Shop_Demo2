import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/features/Home/data/models/categories.dart';
import 'package:my_app/features/Home/data/product_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final ProductRepository repo;
  CategoryBloc(this.repo) : super(CategoryState()) {
    on<FetchCategories>(_fetchCategories);

    on<RetryFetchCategories>(_fetchCategories);

    on<SelectCategory>((event, emit) {
      emit(state.copyWith(selectedId: event.categoryId));
    });
  }

  Future<void> _fetchCategories(
    CategoryEvent event,
    Emitter<CategoryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final categories = await repo.getCategories();
      final allCategory = Categories(name: 'All', slug: 'all', url: '');
      final updatedCategories = [allCategory, ...categories];
      emit(state.copyWith(categories: updatedCategories, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }
}
