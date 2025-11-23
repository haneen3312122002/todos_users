import 'package:flutter/material.dart';

class ShakeAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double offset; // قوة الاهتزاز
  final bool trigger; // لما يصير true -> تهتز

  const ShakeAnimation({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 400),
    this.offset = 10,
    required this.trigger,
  });

  @override
  State<ShakeAnimation> createState() => _ShakeAnimationState();
}

class _ShakeAnimationState extends State<ShakeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _animation = Tween<double>(begin: 0, end: widget.offset)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(_controller);
  }

  @override
  void didUpdateWidget(covariant ShakeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.trigger && !oldWidget.trigger) {
      _controller.forward(from: 0); // اهتزاز جديد
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_animation.value, 0), // اهتزاز أفقي
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
