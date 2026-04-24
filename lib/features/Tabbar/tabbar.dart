import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  final Widget child;
  final String location; 

  const ScaffoldWithNavBar({
    super.key, 
    required this.child, 
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _getSelectedIndex();

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 8),
        height: 70,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.15),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_outlined,
                  selectedIcon: Icons.home,
                  index: 0,
                  selectedIndex: selectedIndex,
                  onTap: () => context.go('/home'),
                ),
                _NavItem(
                  icon: Icons.bar_chart_outlined,
                  selectedIcon: Icons.bar_chart,
                  index: 1,
                  selectedIndex: selectedIndex,
                  onTap: () => context.go('/chart'),
                ),
                _NavItem(
                  icon: Icons.shopping_cart_outlined,
                  selectedIcon: Icons.shopping_cart,
                  index: 2,
                  selectedIndex: selectedIndex,
                  onTap: () => context.go('/cart'),
                ),
                _NavItem(
                  icon: Icons.map_outlined,
                  selectedIcon: Icons.map,
                  index: 3,
                  selectedIndex: selectedIndex,
                  onTap: () => context.go('/map'),
                ),
                _NavItem(
                  icon: Icons.settings_outlined,
                  selectedIcon: Icons.settings,
                  index: 4,
                  selectedIndex: selectedIndex,
                  onTap: () => context.go('/settings'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int _getSelectedIndex() {
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/chart')) return 1;
    if (location.startsWith('/cart')) return 2;
    if (location.startsWith('/map')) return 3;
    if (location.startsWith('/settings')) return 4;
    return 0;
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final int index;
  final int selectedIndex;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.selectedIcon,
    required this.index,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastOutSlowIn,
            transform: Matrix4.identity()
              ..translate(0.0, isSelected ? -22.0 : 0.0),
            width: isSelected ? 55 : 42,
            height: isSelected ? 55 : 42,
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue : Colors.transparent,
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.4),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? Colors.white : Colors.grey.shade600,
              size: isSelected ? 28 : 24,
            ),
          ),
        ),
      ),
    );
  }
}