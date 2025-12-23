import 'package:flutter/material.dart';
import 'package:notes_tasks/core/shared/constants/spacing.dart';

class AppGridView extends StatelessWidget {

  final int itemCount;


  final IndexedWidgetBuilder itemBuilder;


  final double minItemWidth;


  final double? mainAxisSpacing;


  final double? crossAxisSpacing;


  final double childAspectRatio;


  final EdgeInsetsGeometry? padding;


  final bool scrollable;

  const AppGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.minItemWidth = 140,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.childAspectRatio = 3.5,
    this.padding,
    this.scrollable = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;


        int crossAxisCount = (width / minItemWidth).floor();
        if (crossAxisCount < 1) crossAxisCount = 1;

        return GridView.builder(
          padding: padding ?? EdgeInsets.zero,
          shrinkWrap: true,
          physics: scrollable
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: mainAxisSpacing ?? AppSpacing.spaceSM,
            crossAxisSpacing: crossAxisSpacing ?? AppSpacing.spaceSM,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: itemCount,
          itemBuilder: itemBuilder,
        );
      },
    );
  }
}