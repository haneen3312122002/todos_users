import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:notes_tasks/modules/profile/presentation/providers/bio/bio_editing.dart';

import 'package:notes_tasks/modules/profile/presentation/providers/bio/bio_provider.dart';
import 'package:notes_tasks/modules/profile/presentation/viewmodels/bio/bio_form_viewmodel.dart';
import 'package:notes_tasks/modules/profile/presentation/widgets/bio/bio_section.dart';

class BioSectionContainer extends ConsumerWidget {
  const BioSectionContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bio = ref.watch(bioProvider);
    final isEditing = ref.watch(bioEditingProvider);

    final bioFormState = ref.watch(bioFormViewModelProvider);
    final bioFormNotifier = ref.read(bioFormViewModelProvider.notifier);

    final isSaving = bioFormState.isLoading;

    return BioSection(
      titleKey: 'profile_bio', // 👈 مفتاح
      bio: bio,
      emptyHintKey: 'bio_empty_hint',
      isEditing: isEditing,
      isSaving: isSaving,
      onEdit: () {
        bioFormNotifier.init(bio);
        ref.read(bioEditingProvider.notifier).state = true;
      },
      onCancel: () {
        ref.read(bioEditingProvider.notifier).state = false;
        bioFormNotifier.init(bio);
      },
      onChanged: bioFormNotifier.onChanged,
      onSave: () async {
        await bioFormNotifier.saveBio(context);
        if (!ref.read(bioFormViewModelProvider).hasError) {
          ref.read(bioEditingProvider.notifier).state = false;
        }
      },
    );
  }
}