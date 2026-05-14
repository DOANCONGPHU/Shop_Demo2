// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:my_app/core/database/isar_service.dart' as _i330;
import 'package:my_app/core/di/register_module.dart' as _i356;
import 'package:my_app/core/Notification/fcm_service.dart' as _i542;
import 'package:my_app/core/Notification/notification_service.dart' as _i486;
import 'package:my_app/features/Cart/cubit/cart_cubit.dart' as _i737;
import 'package:my_app/features/Home/bloc/banner/banner_bloc.dart' as _i599;
import 'package:my_app/features/Home/bloc/category/category_bloc.dart'
    as _i1069;
import 'package:my_app/features/Home/bloc/product%20detail/product_detail_bloc.dart'
    as _i473;
import 'package:my_app/features/Home/bloc/product/product_bloc.dart' as _i740;
import 'package:my_app/features/Home/bloc/search/bloc/search_bloc.dart'
    as _i884;
import 'package:my_app/features/Home/data/dio_client.dart' as _i231;
import 'package:my_app/features/Home/data/product_api.dart' as _i10;
import 'package:my_app/features/Home/data/product_repository.dart' as _i952;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    final dioModule = _$DioModule();
    await gh.factoryAsync<_i486.NotificationService>(
      () => appModule.notificationService,
      preResolve: true,
    );
    await gh.factoryAsync<_i330.IsarService>(
      () => appModule.isarService,
      preResolve: true,
    );
    gh.lazySingleton<_i542.FCMService>(() => _i542.FCMService());
    gh.lazySingleton<_i231.DioClient>(() => _i231.DioClient());
    gh.lazySingleton<_i361.Dio>(() => dioModule.dio(gh<_i231.DioClient>()));
    gh.lazySingleton<_i10.ProductApi>(() => _i10.ProductApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i952.ProductRepository>(
      () => _i952.ProductRepository(
        gh<_i10.ProductApi>(),
        gh<_i330.IsarService>(),
      ),
    );
    gh.factory<_i473.ProductDetailBloc>(
      () => _i473.ProductDetailBloc(
        gh<_i952.ProductRepository>(),
        gh<_i330.IsarService>(),
      ),
    );
    gh.factory<_i599.BannerBloc>(
      () => _i599.BannerBloc(gh<_i952.ProductRepository>()),
    );
    gh.factory<_i1069.CategoryBloc>(
      () => _i1069.CategoryBloc(gh<_i952.ProductRepository>()),
    );
    gh.factory<_i740.ProductBloc>(
      () => _i740.ProductBloc(gh<_i952.ProductRepository>()),
    );
    gh.factory<_i884.SearchBloc>(
      () => _i884.SearchBloc(gh<_i952.ProductRepository>()),
    );
    gh.factory<_i737.CartCubit>(
      () => _i737.CartCubit(
        gh<_i330.IsarService>(),
        gh<_i952.ProductRepository>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i356.AppModule {}

class _$DioModule extends _i231.DioModule {}
