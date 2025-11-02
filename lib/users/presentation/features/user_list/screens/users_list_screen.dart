import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/widgets/app_scafold.dart';
import 'package:notes_tasks/core/widgets/error_view.dart';
import 'package:notes_tasks/core/widgets/loading_indicator.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/presentation/features/user_list/viewmodels/get_basic_users_viewmodel.dart';
import 'package:notes_tasks/users/presentation/features/user_list/widgets/user_list.dart';

class UsersListScreen extends ConsumerWidget {
  const UsersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(getBasicUsersViewModelProvider);
    final viewModel = ref.read(getBasicUsersViewModelProvider.notifier);

    return AppScaffold(
      scrollable: false,
      title: 'users_title'.tr(), // ✅ ترجمة العنوان
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: viewModel.fetchUsers,
        ),
      ],
      body: usersState.when(
        data: (List<UserEntity> users) =>
            UserList(users: users, onRefresh: viewModel.fetchUsers),
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(
          message: 'failed_load_users'.tr(), // ✅ ترجمة رسالة الخطأ
          onRetry: viewModel.fetchUsers,
        ),
      ),
    );
  }
}
