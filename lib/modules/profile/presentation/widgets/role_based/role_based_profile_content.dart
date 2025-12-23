import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/enums/role.dart';
import 'package:notes_tasks/core/shared/widgets/common/empty_view.dart';
import 'package:notes_tasks/core/shared/widgets/common/error_view.dart';
import 'package:notes_tasks/core/shared/widgets/common/loading_indicator.dart';
import 'package:notes_tasks/modules/profile/presentation/providers/bio/bio_editing.dart';
import 'package:notes_tasks/modules/profile/presentation/providers/profile/get_profile_stream_provider.dart';
import 'package:notes_tasks/modules/profile/presentation/providers/bio/bio_provider.dart';
import 'package:notes_tasks/modules/profile/presentation/viewmodels/bio/bio_form_viewmodel.dart';
import 'package:notes_tasks/modules/profile/presentation/widgets/bio/bio_section_container.dart';
import 'package:notes_tasks/modules/profile/presentation/widgets/header/profile_header.dart';
import 'package:notes_tasks/modules/profile/presentation/widgets/role_based/admin/admin_profile_sections.dart';
import 'package:notes_tasks/modules/profile/presentation/widgets/role_based/client/client_profile_sections.dart';
import 'package:notes_tasks/modules/profile/presentation/widgets/role_based/freelancer/freelancer_profile_sections.dart';

class RoleBasedProfileContent extends ConsumerWidget {
  const RoleBasedProfileContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileStreamProvider);

    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return EmptyView(message: 'no_profile_data'.tr());
        }

        final role = profile.role;

        final bio = ref.watch(bioProvider);

        final isEditing = ref.watch(bioEditingProvider);

        final bioState = ref.watch(bioFormViewModelProvider);
        final bioVm = ref.read(bioFormViewModelProvider.notifier);
        final isSaving = bioState.isLoading;

        Future<void> handleSave() async {
          await bioVm.saveBio(context);
//after saving -> reset the bio edit stse to false:
          ref.read(bioEditingProvider.notifier).state = false;
        }

        return Padding(
          padding: EdgeInsets.all(AppSpacing.spaceMD),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //cover + avatar imgs: fpr all roles
              ProfileHeader(profile: profile),
              SizedBox(height: AppSpacing.spaceLG),

              // bio section fpr all roles
              BioSectionContainer(),
              //role bassed content :
              if (role == UserRole.client)
                ClientProfileSections(profile: profile)
              else if (role == UserRole.freelancer)
                FreelancerProfileSections(profile: profile)
              else if (role == UserRole.admin)
                AdminProfileSections(profile: profile)
              else
                FreelancerProfileSections(profile: profile),

              SizedBox(height: AppSpacing.spaceLG),
            ],
          ),
        );
      },
      loading: () => const LoadingIndicator(withBackground: false),
      error: (e, st) => ErrorView(
        message: e.toString(),
        onRetry: () => ref.refresh(profileStreamProvider),
      ),
    );
  }
}
