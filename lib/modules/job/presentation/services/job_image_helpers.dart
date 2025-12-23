import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';
import 'package:notes_tasks/core/shared/providers/image_picker_provider.dart';
import 'package:notes_tasks/modules/job/presentation/viewmodels/job_cover_image_viewmodel.dart';

Future<void> pickAndUploadJobCover(
  BuildContext context,
  WidgetRef ref, {
  required String jobId,
}) async {
  final picker = ref.read(imagePickerServiceProvider);

  final Uint8List? bytes = await picker.pickFromGallery(imageQuality: 80);
  if (bytes == null) return;

  final ok = await ref
      .read(jobCoverImageViewModelProvider(jobId).notifier)
      .saveCover(context, bytes);

  if (!ok) {
    AppSnackbar.show(
      context,
      'failed_with_error'.tr(namedArgs: {'error': 'job_cover_upload'}),
    );
  }
}
