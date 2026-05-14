import 'package:alarm/alarm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:my_app/core/Notification/fcm_service.dart';
import 'package:my_app/core/Notification/notification_service.dart';
import 'package:my_app/core/database/isar_service.dart';
import 'package:my_app/core/di/injection.dart';
import 'package:my_app/core/network/network_cubit.dart';
import 'package:my_app/core/routes/app_routes.dart';
import 'package:my_app/features/Home/bloc/banner/banner_bloc.dart';
import 'package:my_app/features/Home/bloc/category/category_bloc.dart';
import 'package:my_app/features/Home/bloc/product%20detail/product_detail_bloc.dart';
import 'package:my_app/features/Home/bloc/product/product_bloc.dart';
import 'package:my_app/features/Home/bloc/search/bloc/search_bloc.dart';
import 'package:my_app/features/Cart/cubit/cart_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupDependencies();

  await Alarm.init();

  FlutterForegroundTask.initCommunicationPort();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BannerBloc>(create: (_) => getIt<BannerBloc>()),
        BlocProvider<ProductBloc>(create: (_) => getIt<ProductBloc>()),
        BlocProvider<CategoryBloc>(create: (_) => getIt<CategoryBloc>()),
        BlocProvider<CartCubit>(create: (_) => getIt<CartCubit>()),
        BlocProvider<NetworkCubit>(create: (_) => NetworkCubit()),
        BlocProvider<ProductDetailBloc>(
          create: (_) => getIt<ProductDetailBloc>(),
        ),
        BlocProvider<SearchBloc>(create: (_) => getIt<SearchBloc>()),
      ],
      child: MaterialApp.router(
        theme: ThemeData(primarySwatch: Colors.amber),
        routerConfig: AppRoutes.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
