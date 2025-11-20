import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/cart/presentation/screens/cart_screen.dart';
import 'package:notes_tasks/core/providers/navbar_provider.dart';
import 'package:notes_tasks/modules/post/presentation/screens/post_screen.dart';
import 'package:notes_tasks/modules/profile/presentation/screens/profile_screen.dart';
import 'package:notes_tasks/modules/users/presentation/features/user_list/screens/users_list_screen.dart';
import 'app_navbar.dart';

class AppNavBarContainer extends ConsumerWidget {
  const AppNavBarContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(navIndexProvider);
    final notifier = ref.read(navIndexProvider.notifier);

    final pages = const [
      PostListScreen(),
      UsersListScreen(),
      FirstCartScreen(),
      ProfileScreen()
    ];
    return Scaffold(
      body: IndexedStack(index: currentIndex, children: pages),
      bottomNavigationBar: AppNavBar(
        currentIndex: currentIndex,
        onTap: (index) => notifier.state = index,
      ),
    );
  }
}
