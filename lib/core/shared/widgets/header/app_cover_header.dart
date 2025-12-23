import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/app/theme/text_styles.dart';

import 'package:notes_tasks/core/shared/widgets/images/app_cover_images.dart';
import 'package:notes_tasks/core/shared/widgets/images/app_images.dart';

class AppCoverHeader extends StatelessWidget {
  final String title;

  final String? subtitle;

  final String? coverUrl;

  final Uint8List? coverBytes;

  final String? avatarUrl;

  final Uint8List? avatarBytes;

  final bool showAvatar;

  final bool isCoverLoading;

  final bool isAvatarLoading;

  final VoidCallback? onChangeCover;

  final VoidCallback? onChangeAvatar;

  final double? avatarRadius;

  const AppCoverHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.coverUrl,
    this.coverBytes,
    this.avatarUrl,
    this.avatarBytes,
    this.showAvatar = true,
    this.isCoverLoading = false,
    this.isAvatarLoading = false,
    this.onChangeCover,
    this.onChangeAvatar,
    this.avatarRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final r = avatarRadius ?? (AppSpacing.spaceXL + AppSpacing.spaceSM);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            AppEditableCoverImage(
              imageUrl: coverUrl,
              bytes: coverBytes,
              isLoading: isCoverLoading,
              showEditButton: onChangeCover != null,
              onEdit: onChangeCover,
            ),
            if (showAvatar)
              Positioned(
                bottom: -20,
                child: AppEditableCircularImage(
                  imageUrl: avatarUrl,
                  bytes: avatarBytes,
                  radius: r,
                  isLoading: isAvatarLoading,
                  showEditButton: onChangeAvatar != null,
                  onEdit: onChangeAvatar,
                ),
              ),
          ],
        ),
        SizedBox(
          height: showAvatar ? r + AppSpacing.spaceLG : AppSpacing.spaceLG,
        ),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyles.title.copyWith(
            color: theme.colorScheme.onSurface,
          ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          SizedBox(height: AppSpacing.spaceXS),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: AppTextStyles.caption.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
        SizedBox(height: AppSpacing.spaceLG),
      ],
    );
  }
}
