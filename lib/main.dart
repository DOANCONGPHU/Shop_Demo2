import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/database/isar_service.dart';
import 'package:my_app/core/network/network_cubit.dart';
import 'package:my_app/core/routes/app_routes.dart';
import 'package:my_app/features/Home/bloc/banner/banner_bloc.dart';
import 'package:my_app/features/Home/bloc/category/category_bloc.dart';
import 'package:my_app/features/Home/bloc/product%20detail/product_detail_bloc.dart';
import 'package:my_app/features/Home/bloc/product/product_bloc.dart';
import 'package:my_app/features/Home/data/dio_client.dart';
import 'package:my_app/features/Home/data/product_api.dart';
import 'package:my_app/features/Home/data/product_repository.dart';
import 'package:my_app/features/Cart/cubit/cart_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dioClient = DioClient();
  final productApi = ProductApi(dioClient.dio);
  final productRepository = ProductRepository(productApi);

  final isarService = IsarService();
  await isarService.init();

  runApp(
    RepositoryProvider<ProductRepository>.value(
      value: productRepository,
      child: RepositoryProvider<IsarService>.value(   
        value: isarService,
        child: const MyApp(),
      ),
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
          create: (context) => BannerBloc(context.read<ProductRepository>()),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(context.read<ProductRepository>()),
        ),
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(context.read<ProductRepository>()),
        ),
        BlocProvider<CartCubit>(
          create: (_) => CartCubit(context.read<IsarService>(), context.read<ProductRepository>()),
        ),
        BlocProvider<NetworkCubit>(
          create: (_) => NetworkCubit(),
        ),
        BlocProvider<ProductDetailBloc>(
          create: (context) => ProductDetailBloc(
            context.read<ProductRepository>(),
            context.read<IsarService>(),
          ),
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