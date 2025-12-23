import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_tasks/core/shared/widgets/navigation/app_navbar.dart';
import 'package:notes_tasks/core/shared/widgets/animation/slide_in.dart';

class AppNavBarContainer extends StatelessWidget {
  final Widget child; // current page from ShellRoute
  final List<NavItemConfig> items;

  const AppNavBarContainer({
    super.key,
    required this.child,
    required this.items,
  });

  int _locationToIndex(String location) {
    final index = items.indexWhere(
      (item) => location.startsWith(item.route),
    );
    return index == -1 ? 0 : index;
  }

  @override
  Widget build(BuildContext context) {

    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _locationToIndex(location);

    return Scaffold(
      body: SlideIn(
        key: ValueKey(location),
        from: const Offset(40, 0),
        duration: const Duration(milliseconds: 300),
        child: child,
      ),
      bottomNavigationBar: AppNavBar(
        currentIndex: currentIndex,
        items: items,
        onTap: (index) {
          final route = items[index].route;
          context.go(route);
        },
      ),
    );
  }
}