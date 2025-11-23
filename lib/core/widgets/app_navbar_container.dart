import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/providers/navbar_provider.dart';
import 'package:notes_tasks/core/widgets/animation/sliding_tab_switcher.dart';
import 'package:notes_tasks/core/widgets/app_navbar.dart';
import 'package:notes_tasks/modules/cart/presentation/screens/cart_screen.dart';
import 'package:notes_tasks/modules/post/presentation/screens/post_screen.dart';
import 'package:notes_tasks/modules/profile/presentation/screens/profile_screen.dart';
import 'package:notes_tasks/modules/task/presentation/screens/task_screen.dart';
import 'package:notes_tasks/modules/users/presentation/features/user_list/screens/users_list_screen.dart';

class AppNavBarContainer extends ConsumerWidget {
  const AppNavBarContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);
    final notifier = ref.read(navIndexProvider.notifier);

    final pages = const [
      TaskListScreen(),
      PostListScreen(),
      UsersListScreen(),
      FirstCartScreen(),
      ProfileScreen()
    ];
    return Scaffold(
      body: SlidingTabSwitcher(
        index: currentIndex,
        pages: pages,
      ),
      bottomNavigationBar: AppNavBar(
        currentIndex: currentIndex,
        onTap: (index) => notifier.state = index,
      ),
    );
  }
}
