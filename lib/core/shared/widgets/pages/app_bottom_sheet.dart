import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';







class AppBottomSheet extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool useSafeArea;
  final bool enableScroll;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.padding,
    this.useSafeArea = true,
    this.enableScroll = true,
  });

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;

    Widget content = Padding(
      padding: (padding ?? EdgeInsets.all(AppSpacing.spaceMD))
          .add(EdgeInsets.only(bottom: viewInsets.bottom)),
      child: child,
    );

    if (useSafeArea) {
      content = SafeArea(
        top: false, // غالبًا ما بدك الشيت يطلع لحد فوق
        child: content,
      );
    }

    if (enableScroll) {
      content = SingleChildScrollView(child: content);
    }

    return content;
  }
}