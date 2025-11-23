import 'package:flutter/material.dart';

class SlidingTabSwitcher extends StatelessWidget {
  final int index; // The current selected tab index
  final List<Widget> pages; // List of tab pages

  final Duration duration; //
  final Curve curve; //

  const SlidingTabSwitcher({
    super.key,
    required this.index,
    required this.pages,
    this.duration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeInOut,
  });

  @override
  Widget build(BuildContext context) {
    final currentPage = KeyedSubtree(
      key: ValueKey(index),
      child: pages[index],
    );

    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: curve,
      switchOutCurve: curve,

      transitionBuilder: (widget, animation) {
        // comes in from right → to center.
        final slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0), // Start off-screen on the right
          end: Offset.zero, // Slide into its normal position
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: curve,
          ),
        );

        return SlideTransition(
          position: slideAnimation,
          child: widget,
        );
      },

      // The child page to show
      child: currentPage,
    );
  }
}
