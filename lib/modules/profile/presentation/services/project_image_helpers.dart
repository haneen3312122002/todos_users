import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/core/shared/providers/image_picker_provider.dart';
import 'package:notes_tasks/modules/profile/presentation/viewmodels/project/project_cover_image_viewmodel.dart';

Future<void> pickAndUploadProjectCover(
  BuildContext context,
  WidgetRef ref, {
  required String projectId,
}) async {
  final picker = ref.read(imagePickerServiceProvider);


  final Uint8List? bytes = await picker.pickFromGallery(imageQuality: 80);

  if (bytes == null) return;

  final success = await ref
      .read(projectCoverImageViewModelProvider(projectId).notifier)
      .saveCover(context, bytes);

  if (!success) {
    AppSnackbar.show(
      context,
      'failed_with_error'.tr(
        namedArgs: {'error': 'project_cover_upload'},
      ),
    );
  }
}