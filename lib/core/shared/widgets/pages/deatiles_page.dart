import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:notes_tasks/core/shared/constants/spacing.dart';
import 'package:notes_tasks/core/shared/enums/page_mode.dart';
import 'package:notes_tasks/core/shared/widgets/cards/app_card.dart';
import 'package:notes_tasks/core/shared/widgets/common/app_scaffold.dart';
import 'package:notes_tasks/core/shared/widgets/header/app_cover_header.dart';

class AppDetailsPage extends StatelessWidget {
  final String? appBarTitleKey;

  final String? coverImageUrl;
  final Uint8List? coverBytes;

  final String? avatarImageUrl;
  final Uint8List? avatarBytes;

  final String title;
  final String? subtitle;

  /// ✅ existing primary button (optional)
  final String? primaryButtonLabelKey;
  final IconData? primaryButtonIcon;
  final VoidCallback? onPrimaryButtonPressed;

  /// ✅ NEW: proposal button (shown only in view mode)
  final String proposalButtonLabelKey;
  final IconData? proposalButtonIcon;
  final VoidCallback? onProposalPressed;

  final List<Widget> sections;
  final List<IconButton> appBarActions;

  final bool wrapSectionsInCard;
  final bool showAvatar;

  /// ✅ NEW: required mode
  final PageMode mode;

  /// header edit controls (will be enabled only in edit mode)
  final VoidCallback? onChangeCover;
  final VoidCallback? onChangeAvatar;

  final bool isCoverLoading;
  final bool isAvatarLoading;

  const AppDetailsPage({
    super.key,
    required this.mode, // ✅ required now

    this.appBarTitleKey,
    this.coverImageUrl,
    this.coverBytes,
    this.avatarImageUrl,
    this.avatarBytes,
    required this.title,
    this.subtitle,
    this.primaryButtonLabelKey,
    this.primaryButtonIcon,
    this.onPrimaryButtonPressed,

    /// ✅ proposal button inputs (you can customize later)
    this.proposalButtonLabelKey = 'Make Proposal',
    this.proposalButtonIcon,
    this.onProposalPressed,
    this.sections = const [],
    this.appBarActions = const [],
    this.wrapSectionsInCard = true,
    this.showAvatar = false,
    this.onChangeCover,
    this.onChangeAvatar,
    this.isCoverLoading = false,
    this.isAvatarLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isEdit = mode == PageMode.edit;
    final isView = mode == PageMode.view;

    return AppScaffold(
      actions: appBarActions,
      title: appBarTitleKey?.tr(),
      scrollable: true,
      usePadding: true,
      showSettingsButton: false,
      showLogout: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppCoverHeader(
            title: title,
            subtitle: subtitle,
            coverUrl: coverImageUrl,
            coverBytes: coverBytes,
            avatarUrl: avatarImageUrl,
            avatarBytes: avatarBytes,
            showAvatar: showAvatar,
            isCoverLoading: isCoverLoading,
            isAvatarLoading: isAvatarLoading,

            // ✅ editable only in edit mode
            onChangeCover: isEdit ? onChangeCover : null,
            onChangeAvatar: isEdit ? onChangeAvatar : null,
          ),

          SizedBox(height: AppSpacing.spaceLG),

          // ✅ show proposal button only in view mode
          if (isView)
            Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.spaceLG),
              child: ElevatedButton.icon(
                onPressed: onProposalPressed,
                icon: Icon(proposalButtonIcon ?? Icons.send_outlined),
                label: Text(proposalButtonLabelKey.tr()),
              ),
            ),

          // ✅ existing primary button (if you still want it)
          if (primaryButtonLabelKey != null && onPrimaryButtonPressed != null)
            Padding(
              padding: EdgeInsets.only(bottom: AppSpacing.spaceLG),
              child: ElevatedButton.icon(
                onPressed: onPrimaryButtonPressed,
                icon: Icon(primaryButtonIcon ?? Icons.check),
                label: Text(primaryButtonLabelKey!.tr()),
              ),
            ),

          if (sections.isNotEmpty)
            wrapSectionsInCard
                ? AppCard(
                    padding: EdgeInsets.all(AppSpacing.spaceMD),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _withSpacing(sections),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _withSpacing(sections),
                  ),
        ],
      ),
    );
  }

  List<Widget> _withSpacing(List<Widget> children) {
    if (children.isEmpty) return [];

    final spaced = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      spaced.add(children[i]);
      if (i != children.length - 1) {
        spaced.add(SizedBox(height: AppSpacing.spaceLG));
      }
    }
    return spaced;
  }
}
