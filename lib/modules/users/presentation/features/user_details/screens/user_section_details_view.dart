import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/shared/widgets/cards/app_card.dart';
import 'package:notes_tasks/core/shared/widgets/lists/app_list_tile.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/widgets/common/empty_view.dart';
import 'package:notes_tasks/core/shared/widgets/common/error_view.dart';
import 'package:notes_tasks/core/shared/widgets/common/loading_indicator.dart';

class UserSectionDetailsView<T> extends ConsumerWidget {
  final String title;
  final AsyncNotifierProvider<dynamic, T?> provider;
  final Map<String, dynamic> Function(T data) mapper;

  const UserSectionDetailsView({
    super.key,
    required this.title,
    required this.provider,
    required this.mapper,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(provider);

    return AppScaffold(
      title: title,
      body: state.when(
        loading: () => const LoadingIndicator(withBackground: false),
        error: (e, _) => ErrorView(
          fullScreen: true,
          message: 'failed_load_tasks'.tr(), // 🔹 ترجمة عامة لرسائل الخطأ
        ),
        data: (data) {
          if (data == null) {
            return EmptyView(message: 'no_data'.tr());
          }

          final mapped = mapper(data);

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: mapped.entries.map((e) {
                  return AppListTile(
                    title: e.key,
                    subtitle: e.value?.toString() ?? '-',
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
      actions: [],
    );
  }
}