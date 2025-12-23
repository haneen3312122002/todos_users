import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/widgets/buttons/app_icon_button.dart';


class AppRectImage extends StatelessWidget {

  final String? imageUrl;


  final Uint8List? bytes;


  final double? height;


  final double? width;


  final BorderRadius? borderRadius;


  final IconData placeholderIcon;


  final BoxFit fit;

  const AppRectImage({
    super.key,
    this.imageUrl,
    this.bytes,
    this.height,
    this.width,
    this.borderRadius,
    this.placeholderIcon = Icons.image_outlined,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final h = height ?? AppSpacing.spaceXXL * 3;
    final w = width ?? double.infinity;
    final br = borderRadius ?? BorderRadius.circular(AppSpacing.spaceSM);

    Widget buildPlaceholder() {
      return Container(
        decoration: BoxDecoration(
          borderRadius: br,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withOpacity(0.10),
              theme.colorScheme.secondary.withOpacity(0.10),
            ],
          ),
        ),
        child: Center(
          child: Icon(
            placeholderIcon,
            size: AppSpacing.spaceXL,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      );
    }

    Widget buildImage() {

      if (bytes != null) {
        return Image.memory(
          bytes!,
          fit: fit,
          errorBuilder: (_, __, ___) => buildPlaceholder(),
        );
      }


      if (imageUrl != null && imageUrl!.isNotEmpty) {
        return Image.network(
          imageUrl!,
          fit: fit,
          errorBuilder: (_, __, ___) => buildPlaceholder(),
        );
      }


      return buildPlaceholder();
    }

    return SizedBox(
      height: h,
      width: w,
      child: ClipRRect(
        borderRadius: br,
        child: buildImage(),
      ),
    );
  }
}


class AppEditableCoverImage extends StatelessWidget {

  final String? imageUrl;


  final Uint8List? bytes;


  final double? height;


  final bool isLoading;


  final bool showEditButton;


  final VoidCallback? onEdit;


  final IconData editIcon;


  final bool withGradientOverlay;

  const AppEditableCoverImage({
    super.key,
    this.imageUrl,
    this.bytes,
    this.height,
    this.isLoading = false,
    this.showEditButton = true,
    this.onEdit,
    this.editIcon = Icons.edit,
    this.withGradientOverlay = true,
  });

  @override
  Widget build(BuildContext context) {
    final double coverHeight = height ?? AppSpacing.spaceXXL * 3;
    final borderRadius = BorderRadius.circular(AppSpacing.spaceSM);

    return SizedBox(
      height: coverHeight,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: AppRectImage(
              imageUrl: imageUrl,
              bytes: bytes,
              height: coverHeight,
              borderRadius: borderRadius,
            ),
          ),
          if (withGradientOverlay)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.10),
                      Colors.black.withOpacity(0.25),
                    ],
                  ),
                ),
              ),
            ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: Colors.black.withOpacity(0.25),
                ),
                child: const Center(
                  child: SizedBox(
                    height: 22,
                    width: 22,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            ),
          if (showEditButton)
            Positioned(
              right: AppSpacing.spaceSM,
              bottom: AppSpacing.spaceSM,
              child: AppIconButton(
                icon: editIcon,
                onTap: isLoading ? null : onEdit,
              ),
            ),
        ],
      ),
    );
  }
}