import 'dart:convert';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:notes_tasks/core/shared/widgets/common/app_snackbar.dart';

class JobCoverImageViewModel extends StateNotifier<Uint8List?> {
  JobCoverImageViewModel(this._jobId) : super(null) {
    _loadInitial();
  }

  final String _jobId;
  static const _prefix = 'job_cover_';

  Future<void> _loadInitial() async {
    final prefs = await SharedPreferences.getInstance();
    final base64 = prefs.getString('$_prefix$_jobId');
    if (base64 == null) return;

    try {
      state = base64Decode(base64);
    } catch (_) {
      state = null;
    }
  }

  Future<bool> saveCover(BuildContext context, Uint8List bytes) async {
    try {
      state = bytes;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('$_prefix$_jobId', base64Encode(bytes));

      AppSnackbar.show(context, 'cover_image_updated'.tr());
      return true;
    } catch (e) {
      AppSnackbar.show(
        context,
        'failed_with_error'.tr(namedArgs: {'error': e.toString()}),
      );
      return false;
    }
  }

  Future<void> clear() async {
    state = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$_jobId');
  }
}

final jobCoverImageViewModelProvider =
    StateNotifierProviderFamily<JobCoverImageViewModel, Uint8List?, String>(
  (ref, jobId) => JobCoverImageViewModel(jobId),
);
