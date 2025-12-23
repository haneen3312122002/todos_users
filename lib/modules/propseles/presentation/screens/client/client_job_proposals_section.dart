import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:notes_tasks/core/app/routs/app_routes.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';

import 'package:notes_tasks/modules/profile/presentation/providers/profile/users_stream_provider.dart';
import 'package:notes_tasks/modules/propseles/presentation/viewmodels/proposal_actions_viewmodel.dart';
import 'package:notes_tasks/modules/propseles/domain/entities/proposal_entity.dart';
import 'package:notes_tasks/modules/propseles/domain/entities/propsal_status.dart';

import 'package:notes_tasks/modules/propseles/presentation/providers/proposals_stream_providers.dart';
import 'package:notes_tasks/modules/propseles/presentation/screens/proposal_details_page.dart';
import 'package:notes_tasks/core/shared/enums/page_mode.dart';

class ClientJobProposalsSection extends ConsumerWidget {
  final String jobId;

  const ClientJobProposalsSection({
    super.key,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(jobProposalsStreamProvider(jobId));

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Text('Error: $e'),
      data: (list) {
        if (list.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.spaceMD),
            child: Text('No proposals yet', style: AppTextStyles.caption),
          );
        }

        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          separatorBuilder: (_, __) => SizedBox(height: AppSpacing.spaceMD),
          itemBuilder: (context, i) {
            final p = list[i];

            return _ClientProposalCard(
              proposal: p,
              onOpen: () {
                context.push(
                  AppRoutes.proposalDetails,
                  extra: ProposalDetailsArgs(
                    proposalId: p.id,
                    mode: PageMode.view,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class _ClientProposalCard extends ConsumerWidget {
  final ProposalEntity proposal;
  final VoidCallback onOpen;

  const _ClientProposalCard({
    required this.proposal,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.read(proposalActionsViewModelProvider.notifier);
    final canDecide = proposal.status == ProposalStatus.pending;

    final freelancerAsync =
        ref.watch(userByIdStreamProvider(proposal.freelancerId));

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onOpen,
      child: Container(
        padding: EdgeInsets.all(AppSpacing.spaceMD),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ===== Freelancer header =====
            freelancerAsync.when(
              loading: () => Row(
                children: const [
                  CircleAvatar(radius: 18),
                  SizedBox(width: 10),
                  Expanded(child: Text('Loading freelancer...')),
                ],
              ),
              error: (e, _) => Text('Freelancer error: $e'),
              data: (u) {
                final name = (u?['name'] ?? 'Freelancer') as String;
                final photoUrl = u?['photoUrl'] as String?;

                return Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage:
                          photoUrl == null ? null : NetworkImage(photoUrl),
                      child: photoUrl == null
                          ? const Icon(Icons.person_outline, size: 18)
                          : null,
                    ),
                    SizedBox(width: AppSpacing.spaceSM),
                    Expanded(
                      child: Text(
                        name,
                        style: AppTextStyles.body
                            .copyWith(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Icon(Icons.chevron_right,
                        color: Theme.of(context).hintColor),
                  ],
                );
              },
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
                Text('Status: ${proposal.status.name}',
                    style: AppTextStyles.caption),
                const Spacer(),
                if (proposal.price != null)
                  Text('Price: ${proposal.price!.toStringAsFixed(0)}',
                      style: AppTextStyles.caption),
              ],
            ),

            // ===== Decision buttons (pending only) =====
            if (canDecide) ...[
              SizedBox(height: AppSpacing.spaceMD),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => vm.reject(context, proposal.id),
                      child: const Text('Reject'),
                    ),
                  ),
                  SizedBox(width: AppSpacing.spaceSM),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => vm.accept(context, proposal.id),
                      child: const Text('Accept'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ClientProposalsArgs {
  final String jobId;
  const ClientProposalsArgs({required this.jobId});
}
