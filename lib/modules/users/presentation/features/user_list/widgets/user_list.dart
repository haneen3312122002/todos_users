import 'package:flutter/material.dart';
import 'package:notes_tasks/modules/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/core/widgets/error_view.dart';
import 'package:notes_tasks/modules/users/presentation/features/user_list/widgets/user_item.dart';

class UserList extends StatelessWidget {
  final List<UserEntity> users;
  final Future<void> Function()? onRefresh;

  const UserList({super.key, required this.users, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const ErrorView(message: 'No users found.', fullScreen: true);
    }

    final list = ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: users.length,
      itemBuilder: (_, index) => UserItem(user: users[index]),
    );

    return onRefresh != null
        ? RefreshIndicator(onRefresh: onRefresh!, child: list)
        : list;
  }
}
