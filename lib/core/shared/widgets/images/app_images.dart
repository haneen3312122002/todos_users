import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:notes_tasks/core/shared/constants/colors.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/app_icon_button.dart';


class AppCircularImage extends StatelessWidget {

  final String? imageUrl;


  final Uint8List? bytes;


  final double? radius;


  final IconData placeholderIcon;


  final Color? backgroundColor;


  final Color? borderColor;
  final double borderWidth;

  const AppCircularImage({
    super.key,
    this.imageUrl,
    this.bytes,
    this.radius,
    this.placeholderIcon = Icons.person,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final r = radius ?? (AppSpacing.spaceXL + AppSpacing.spaceSM);
    final iconSize = AppSpacing.spaceXL;

    ImageProvider? provider;

    if (bytes != null) {
      provider = MemoryImage(bytes!);
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      provider = NetworkImage(imageUrl!);
    }

    final showPlaceholder = provider == null;

    Widget avatar = CircleAvatar(
      radius: r,
      backgroundColor: backgroundColor ?? AppColors.border,
      backgroundImage: showPlaceholder ? null : provider,
      child: showPlaceholder
          ? Icon(
              placeholderIcon,
              size: iconSize,
              color: theme.colorScheme.onSurface,
            )
          : null,
    );


    if (borderColor == null || borderWidth <= 0) {
      return avatar;
    }


    return Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor!, width: borderWidth),
      ),
      child: avatar,
    );
  }
}


class AppEditableCircularImage extends StatelessWidget {

  final String? imageUrl;


  final Uint8List? bytes;


  final double? radius;


  final bool showEditButton;


  final bool isLoading;


  final VoidCallback? onEdit;


  final IconData editIcon;


  final IconData placeholderIcon;

  const AppEditableCircularImage({
    super.key,
    this.imageUrl,
    this.bytes,
    this.radius,
    this.showEditButton = true,
    this.isLoading = false,
    this.onEdit,
    this.editIcon = Icons.edit,
    this.placeholderIcon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatarRadius = radius ?? (AppSpacing.spaceXL + AppSpacing.spaceSM);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        AppCircularImage(
          imageUrl: imageUrl,
          bytes: bytes,
          radius: avatarRadius,
          placeholderIcon: placeholderIcon,
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black54,
              ),
              child: const Center(
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            ),
          ),
        if (showEditButton)
          Positioned(
            bottom: 0,
            right: 0,
            child: AppIconButton(
              icon: editIcon,
              backgroundColor: theme.colorScheme.primary,
              iconColor: Colors.white,
              onTap: isLoading || onEdit == null
                  ? null
                  : () {

                      onEdit!();
                    },
            ),
          ),
      ],
    );
  }
}