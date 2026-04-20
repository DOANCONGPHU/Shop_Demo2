// widgets/scaffold_with_navbar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(  
        height: 40,
        backgroundColor: Colors.white,
        elevation: 0,
        indicatorColor: Colors.blue.withValues(alpha: 0.12), // nhẹ hơn
        labelBehavior: NavigationDestinationLabelBehavior
            .alwaysHide, 
        selectedIndex: _selectedIndex(context),
        onDestinationSelected: (index) => _onTap(index, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 22),
            selectedIcon: Icon(Icons.home, size: 24, color: Colors.blue),
            label: '',
            tooltip: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border, size: 22),
            selectedIcon: Icon(Icons.favorite, size: 24, color: Colors.blue),
            label: '',
            tooltip: 'Favorite',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined, size: 22),
            selectedIcon: Icon(Icons.shopping_cart, size: 24, color: Colors.blue),
            label: '',
            tooltip: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, size: 22),
            selectedIcon: Icon(Icons.person, size: 24, color: Colors.blue),
            label: '',
            tooltip: 'Profile',
          ),
        ],
      ),
    );
  }

  int _selectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/favorite')) return 1;
    if (location.startsWith('/cart')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0;
  }

  void _onTap(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/favorite');
        break;
      case 2:
        context.go('/cart');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }
}
