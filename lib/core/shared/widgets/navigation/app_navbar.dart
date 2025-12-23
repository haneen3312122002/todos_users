import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/widgets/animation/animated_nav_icon.dart';

class NavItemConfig {
  final String route;
  final IconData icon;
  final String label;

  const NavItemConfig({
    required this.route,
    required this.icon,
    required this.label,
  });
}

class AppNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavItemConfig> items;

  const AppNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: theme.colorScheme.surface,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.outline,
      selectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: theme.colorScheme.primary,
      ),
      unselectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
        color: theme.colorScheme.outline,
      ),
      items: [
        for (var i = 0; i < items.length; i++)
          BottomNavigationBarItem(
            icon: AnimatedNavIcon(
              icon: items[i].icon,
              isActive: currentIndex == i,
            ),
            label: items[i].label,
          ),
      ],
    );
  }
}