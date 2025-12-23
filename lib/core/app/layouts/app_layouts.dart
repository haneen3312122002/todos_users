import 'package:flutter/material.dart';
import 'package:notes_tasks/core/app/routs/app_routes.dart';
import 'package:notes_tasks/core/shared/widgets/navigation/app_navbar.dart';
import 'package:notes_tasks/core/shared/widgets/navigation/app_navbar_container.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';

class ClientShell extends StatelessWidget {
  final Widget child;
  const ClientShell({super.key, required this.child});

  static const List<NavItemConfig> navItems = [
    NavItemConfig(
      route: AppRoutes.clientHome,
      icon: Icons.home,
      label: 'Home',
    ),
    NavItemConfig(
      route: AppRoutes.clientJobs,
      icon: Icons.work_outline,
      label: 'My Jobs',
    ),
    NavItemConfig(
      route: AppRoutes.clientChats,
      icon: Icons.chat_bubble_outline,
      label: 'Messages',
    ),
    NavItemConfig(
      route: AppRoutes.clientProfile,
      icon: Icons.person_outline,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppNavBarContainer(
      items: navItems,
      child: child,
    );
  }
}

class FreelancerShell extends StatelessWidget {
  final Widget child;
  const FreelancerShell({super.key, required this.child});

  static const List<NavItemConfig> navItems = [
    NavItemConfig(
      route: AppRoutes.freelanceHome,
      icon: Icons.home,
      label: 'Home',
    ),
    NavItemConfig(
      route: AppRoutes.freelancerJobs,
      icon: Icons.work_outline,
      label: 'jobs',
    ),
    NavItemConfig(
      route: AppRoutes.freelancerProposals,
      icon: Icons.description_outlined,
      label: 'Proposals',
    ),
    NavItemConfig(
      route: AppRoutes.freelancerChats,
      icon: Icons.chat_bubble_outline,
      label: 'Messages',
    ),
    NavItemConfig(
      route: AppRoutes.freelancerProfile,
      icon: Icons.person_outline,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppNavBarContainer(
      items: navItems,
      child: child,
    );
  }
}

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      scrollable: false,
      actions: [],
      title: 'Admin Dashboard',
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _StatCard(title: 'Users', value: '0', icon: Icons.people_outline),
          SizedBox(height: 16),
          _StatCard(title: 'Jobs', value: '0', icon: Icons.work_outline),
          SizedBox(height: 16),
          _StatCard(title: 'Contracts', value: '0', icon: Icons.article),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                Text(value,
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: title,
      body: Center(
        child: Text(
          '$title (TODO: replace with real screen)',
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      actions: const [],
    );
  }
}
