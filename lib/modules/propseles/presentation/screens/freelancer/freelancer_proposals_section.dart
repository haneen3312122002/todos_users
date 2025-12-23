import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_tasks/core/app/routs/app_routes.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/enums/page_mode.dart';

import 'package:notes_tasks/modules/propseles/domain/entities/proposal_entity.dart';
import 'package:notes_tasks/modules/propseles/domain/entities/propsal_status.dart';
import 'package:notes_tasks/modules/propseles/presentation/providers/proposals_stream_providers.dart';
import 'package:notes_tasks/modules/propseles/presentation/screens/proposal_details_page.dart';

class FreelancerProposalsListPage extends ConsumerWidget {
  const FreelancerProposalsListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(myProposalsStreamProvider);

    return AppScaffold(
      scrollable: false,
      title: 'My Proposals',
      body: async.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (list) {
          if (list.isEmpty) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.spaceMD),
              child: Text('No proposals yet', style: AppTextStyles.caption),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.all(AppSpacing.spaceMD),
            itemCount: list.length,
            separatorBuilder: (_, __) => SizedBox(height: AppSpacing.spaceMD),
            itemBuilder: (context, i) {
              final p = list[i];
              return _FreelancerProposalCard(proposal: p);
            },
          );
        },
      ),
    );
  }
}

class _FreelancerProposalCard extends ConsumerWidget {
  final ProposalEntity proposal;

  const _FreelancerProposalCard({required this.proposal});

  String _fmtStatus(ProposalStatus s) {
    switch (s) {
      case ProposalStatus.pending:
        return 'Pending';
      case ProposalStatus.accepted:
        return 'Accepted';
      case ProposalStatus.rejected:
        return 'Rejected';
    }
  }

  String _fmtMoney(double? v) => v == null ? '-' : v.toStringAsFixed(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        context.push(
          AppRoutes.proposalDetails,
          extra: ProposalDetailsArgs(
            proposalId: proposal.id,
            mode: PageMode.view,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(AppSpacing.spaceMD),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Job snapshot (أفضل UX للفريلانسر) =====
            Text(
              proposal.jobTitle.isNotEmpty ? proposal.jobTitle : 'Job',
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w800),
            ),
            SizedBox(height: AppSpacing.spaceXS),

            Row(
              children: [
                Expanded(
                  child: Text(
                    proposal.jobCategory.isNotEmpty
                        ? proposal.jobCategory
                        : '-',
                    style: AppTextStyles.caption,
                  ),
                ),
                if (proposal.jobBudget != null)
                  Text(
                    'Budget: ${_fmtMoney(proposal.jobBudget)}',
                    style: AppTextStyles.caption,
                  ),
              ],
            ),

            SizedBox(height: AppSpacing.spaceSM),

            // ===== Proposal summary =====
            Text(
              proposal.title,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w700),
            ),
            SizedBox(height: AppSpacing.spaceXS),
            Text(
              proposal.coverLetter,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.body,
            ),

            SizedBox(height: AppSpacing.spaceSM),

            Row(
              children: [
                Text(
                  'Status: ${_fmtStatus(proposal.status)}',
                  style: AppTextStyles.caption,
                ),
                const Spacer(),
                if (proposal.price != null)
                  Text(
                    'Price: ${_fmtMoney(proposal.price)}',
                    style: AppTextStyles.caption,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
