import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/features/Home/data/models/products.dart';
import 'package:my_app/features/Home/data/product_repository.dart';

part 'banner_event.dart';
part 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  final ProductRepository repo;

  BannerBloc(this.repo) : super(BannerInitial()) {
    on<FetchBanners>((event, emit) async {
      emit(BannerLoading());
      try {
        final banners = await repo.getBanners();
        emit(BannerLoaded(banners));
      } catch (e) {
        emit(BannerError(e.toString()));
      }
    });
  }
}
