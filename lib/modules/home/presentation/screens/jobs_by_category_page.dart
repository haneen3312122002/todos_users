import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_tasks/core/app/routs/app_routes.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/enums/page_mode.dart';
import 'package:notes_tasks/core/shared/widgets/cards/app_card.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/widgets/common/error_view.dart';
import 'package:notes_tasks/core/shared/widgets/common/loading_indicator.dart';
import 'package:notes_tasks/core/shared/widgets/lists/app_infinite_list.dart';
import 'package:notes_tasks/core/shared/widgets/lists/app_list_tile.dart';

import 'package:notes_tasks/modules/job/domain/entities/job_entity.dart';
import 'package:notes_tasks/modules/job/presentation/providers/jobs_stream_providers.dart';
import 'package:notes_tasks/modules/job/presentation/widgets/job_details_page.dart';

class JobsByCategoryPage extends ConsumerWidget {
  final String category;
  final String? titleLabel;

  const JobsByCategoryPage({
    super.key,
    required this.category,
    this.titleLabel,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncJobs = ref.watch(jobsByCategoryStreamProvider(category));

    return AppScaffold(
      title: titleLabel ?? 'jobs'.tr(),
      scrollable: false, // لأن القائمة فيها Scroll
      body: asyncJobs.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return Center(child: Text('no_jobs_yet'.tr()));
          }

          return AppInfiniteList<JobEntity>(
            items: jobs,
            hasMore: false,
            onLoadMore: () {}, // no pagination لأن Stream
            onRefresh: () async {
              ref.invalidate(jobsByCategoryStreamProvider(category));
            },
            padding: EdgeInsets.symmetric(vertical: AppSpacing.spaceSM),
            animateItems: true,
            itemBuilder: (context, job, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: AppSpacing.spaceMD),
                child: AppCard(
                  child: AppListTile(
                    leading: const Icon(Icons.work_outline),
                    title: job.title,
                    subtitle: job.description,
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      context.push(
                        AppRoutes.jobDetails,
                        extra:
                            JobDetailsArgs(jobId: job.id, mode: PageMode.view),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: LoadingIndicator(withBackground: false),
        ),
        error: (e, st) => Center(
          child: ErrorView(
            message: 'something_went_wrong'.tr(),
            fullScreen: false,
            onRetry: () =>
                ref.invalidate(jobsByCategoryStreamProvider(category)),
          ),
        ),
      ),
    );
  }
}

class JobsByCategoryArgs {
  final String category;
  final String? titleLabel;

  JobsByCategoryArgs({
    required this.category,
    this.titleLabel,
  });
}
