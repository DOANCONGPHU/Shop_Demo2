import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/network/network_cubit.dart';
import 'package:my_app/core/routes/app_routes.dart';
import 'package:my_app/features/Home/bloc/banner/banner_bloc.dart';
import 'package:my_app/features/Home/bloc/category/category_bloc.dart';
import 'package:my_app/features/Home/bloc/product/product_bloc.dart';
import 'package:my_app/features/Home/data/dio_client.dart';
import 'package:my_app/features/Home/data/product_api.dart';
import 'package:my_app/features/Home/data/product_repository.dart';
import 'package:my_app/features/Cart/cubit/cart_cubit.dart';

void main() {
  runApp(
    RepositoryProvider(
      create: (context) => ProductRepository(ProductApi(DioClient().dio)),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BannerBloc>(
          create: (_) => BannerBloc(context.read())..add(FetchBanners()),
        ),
        BlocProvider<ProductBloc>(
          create: (_) => ProductBloc(context.read())..add(FetchAllProducts()),
        ),
        BlocProvider<CategoryBloc>(
          create: (_) => CategoryBloc(context.read())..add(FetchCategories()),
        ),
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(),
        ),
        BlocProvider<NetworkCubit>(
          create: (_) => NetworkCubit(),
        ),
      ],
      child: MaterialApp.router(
        theme: ThemeData(primarySwatch: Colors.amber),
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
