import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/constants/colors.dart';
import 'package:notes_tasks/core/constants/spacing.dart';
import 'package:notes_tasks/core/theme/text_styles.dart';
import 'package:notes_tasks/core/widgets/app_card.dart';
import 'package:notes_tasks/core/widgets/app_list_tile.dart';
import 'package:notes_tasks/users/domain/entities/user_entity.dart';
import 'package:notes_tasks/users/presentation/features/user_details/providers/ui_providers/expanded_user_provider.dart';
import 'package:notes_tasks/users/presentation/features/user_details/screens/user_details_screen.dart';
import 'package:notes_tasks/users/presentation/features/user_list/widgets/user_expanded_section.dart';

class UserItem extends ConsumerWidget {
  final UserEntity user;

  const UserItem({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedState = ref.watch(expandedUserProvider);
    final expandedNotifier = ref.read(expandedUserProvider.notifier);
    final isExpanded = expandedState[user.id] ?? false;

    return AppCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          AppListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(user.image)),
            title: '${user.firstName} ${user.lastName}',
            subtitle: 'Role: ${user.role}',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserDetailsScreen(userId: user.id),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                size: 24,
                color: Theme.of(
                  context,
                ).colorScheme.primary, // ✅ بدل الرمادي بالـ primary
              ),
              onPressed: () {
                expandedNotifier.state = {
                  ...expandedState,
                  user.id: !isExpanded,
                };
              },
            ),
          ),

          if (isExpanded)
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSpacing.spaceMD, // ✅ بدل القيم الثابتة
                vertical: AppSpacing.spaceSM,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: AppColors.border, height: AppSpacing.spaceMD),
                  UserExpandedSection(user: user),
                  SizedBox(height: AppSpacing.spaceSM),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.icon),
        SizedBox(width: AppSpacing.spaceSM),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }
}
