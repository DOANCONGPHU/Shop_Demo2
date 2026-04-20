import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/Cart/views/cart_screen.dart';
import 'package:my_app/features/Favourite/fav_screen.dart';
import 'package:my_app/features/Home/views/homepage_screen.dart';
import 'package:my_app/features/Home/views/product_detail_screen.dart';
import 'package:my_app/features/Profile/profile_screen.dart';
import 'package:my_app/features/tabbar.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        routes: [
          GoRoute(path: '/home', pageBuilder: (context, state) => const NoTransitionPage(child: MyHomePage())),
          GoRoute(path: '/cart', pageBuilder: (context, state) => const NoTransitionPage(child: CartPage())),
          GoRoute(
            path: '/favorite',
            pageBuilder: (context, state) => const NoTransitionPage(child: FavScreen()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => const NoTransitionPage(child: ProfileScreen()),
          ),
        ],
      ),

      GoRoute(
        path: '/product_detail/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ProductDetailScreen(productId: id);
        },
      ),
    ],
  );
}
