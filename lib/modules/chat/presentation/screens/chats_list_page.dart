import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_tasks/core/app/routs/app_routes.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/widgets/common/error_view.dart';
import 'package:notes_tasks/core/shared/widgets/common/empty_view.dart';
import 'package:notes_tasks/core/shared/widgets/cards/app_card.dart';
import 'package:notes_tasks/core/shared/widgets/lists/app_list_tile.dart';

import 'package:notes_tasks/modules/chat/presentation/providers/chat_providers.dart';

class ChatsListScreen extends ConsumerWidget {
  const ChatsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(myChatsStreamProvider);

    return AppScaffold(
      scrollable: false,
      title: 'chats'.tr(), // ضيفي key
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => ErrorView(
          message: 'something_went_wrong'.tr(),
          fullScreen: false,
          onRetry: () => ref.refresh(myChatsStreamProvider),
        ),
        data: (chats) {
          if (chats.isEmpty) {
            return const EmptyView(
              icon: Icons.chat_bubble_outline,
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(AppSpacing.spaceMD),
            itemCount: chats.length,
            separatorBuilder: (_, __) => SizedBox(height: AppSpacing.spaceMD),
            itemBuilder: (_, i) {
              final c = chats[i];

              return AppCard(
                animate: false,
                child: AppListTile(
                  leading: CircleAvatar(
                    radius: 22,
                    backgroundImage: c.jobCoverUrl == null
                        ? null
                        : NetworkImage(c.jobCoverUrl!),
                    child: c.jobCoverUrl == null
                        ? const Icon(Icons.work_outline)
                        : null,
                  ),
                  title: c.jobTitle,
                  subtitle: c.lastMessageText ?? 'no_messages_yet'.tr(),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).hintColor,
                  ),
                  onTap: () {
                    // ✅ الأفضل: route param بدل extra args
                    context.push('${AppRoutes.chatDetails}/${c.id}');
                  },
                ),
              );
            },
          );
        },
      ),
      actions: const [],
    );
  }
}
