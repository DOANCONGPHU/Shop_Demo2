import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

@injectable
class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ProductRepository repo;
  SearchBloc(this.repo) : super(SearchInitial()) {
    on<FetchSearchResults>(_handleSearch);
  }
  Future<void> _handleSearch(FetchSearchResults event, Emitter<SearchState> emit) async {
    emit(SearchLoading());
    try {
      final results = await repo.getProductsBySearch(event.query);
      emit(SearchLoaded(results));
    } catch (e) {
      emit(SearchError('Failed to fetch search results: $e'));
    }
  }
}
