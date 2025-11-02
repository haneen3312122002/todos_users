import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/core/widgets/app_card.dart';
import 'package:notes_tasks/core/widgets/app_list_tile.dart';
import 'package:notes_tasks/core/widgets/app_scafold.dart';
import 'package:notes_tasks/core/widgets/error_view.dart';
import 'package:notes_tasks/core/widgets/loading_indicator.dart';

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
        loading: () => const LoadingIndicator(),
        error: (e, _) => ErrorView(
          fullScreen: true,
          message: 'Failed to load ${title.toLowerCase()}',
        ),
        data: (data) {
          if (data == null) {
            return const Center(child: Text('No data available'));
          }

          final mapped = mapper(data);

          return AppCard(
            child: Column(
              children: mapped.entries.map((e) {
                return AppListTile(
                  title: e.key,
                  subtitle: e.value?.toString() ?? '-',
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
