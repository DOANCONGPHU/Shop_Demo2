import 'package:go_router/go_router.dart';
import 'package:my_app/features/Cart/views/cart_screen.dart';
import 'package:my_app/features/Chart/views/chart_screen.dart';
import 'package:my_app/features/Home/views/homepage_screen.dart';
import 'package:my_app/features/Home/views/product_detail_screen.dart';
import 'package:my_app/features/Home/views/search_result.dart';
import 'package:my_app/features/Map/views/map_screen.dart';
import 'package:my_app/features/Tabbar/tabbar.dart';
import 'package:my_app/features/Setting/setting_screen.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) =>
            ScaffoldWithNavBar(location: state.uri.path, child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MyHomePage()),
          ),
          GoRoute(
            path: '/cart',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: CartPage()),
          ),
          GoRoute(
            path: '/chart',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ChartScreen()),
          ),
          GoRoute(
            path: '/map',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: MapScreen()),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SettingScreen(),
            ),
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
      GoRoute(path: '/search', builder: (context,state)
      {
        final query = state.uri.queryParameters['query'] ?? '';
        return SearchResult(query: query);
      })
    ],
  );
}
