// lib/modules/profile/presentation/widgets/header/profile_header.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:notes_tasks/modules/profile/domain/entities/profile_entity.dart';
import 'package:notes_tasks/core/shared/providers/local_image_storage_provider.dart';
import 'package:notes_tasks/core/shared/widgets/header/app_cover_header.dart';
import 'package:notes_tasks/modules/profile/presentation/services/profile_actions_helpers.dart';

class ProfileHeader extends ConsumerWidget {
  final ProfileEntity profile;

  const ProfileHeader({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localImages = ref.watch(localImageStorageProvider);

    final uid = profile.uid; // 👈 تأكد إن ProfileEntity فيها uid

    return AppCoverHeader(
      title: profile.name,
      subtitle: null,
      coverUrl: profile.coverUrl,
      coverBytes: localImages.coverFor(uid),
      avatarUrl: profile.photoUrl,
      avatarBytes: localImages.avatarFor(uid),
      showAvatar: true,
      isCoverLoading: false,
      isAvatarLoading: false,
      onChangeCover: () {
        pickAndUploadCover(context, ref, uid: uid);
      },
      onChangeAvatar: () {
        pickAndUploadAvatar(context, ref, uid: uid);
      },
    );
  }
}
