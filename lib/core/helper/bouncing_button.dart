import 'package:flutter/material.dart';

class Bouncing extends StatefulWidget {
  const Bouncing({
    required this.child,
    required this.onTap,
    super.key,
    this.duration,
    this.onLongPress,
    this.enableFeedback,
  });
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Widget? child;
  final Duration? duration;
  final bool? enableFeedback;

  @override
  State<Bouncing> createState() => BouncingState();
}

class BouncingState extends State<Bouncing>
    with SingleTickerProviderStateMixin {
  late double _scale;

  late AnimationController _animate;

  VoidCallback? get onTap => widget.onTap;
  VoidCallback? get _onLongPress => widget.onLongPress;
  bool? get enableFeedback => widget.enableFeedback;

  Duration get userDuration =>
      widget.duration ?? const Duration(milliseconds: 100);

  @override
  void initState() {
    _animate = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animate.value;
    return InkWell(
      enableFeedback: enableFeedback ?? true,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: _onTap,
      onLongPress: _onLongPress,
      child: Transform.scale(
        scale: _scale,
        child: widget.child,
      ),
    );
  }

  void _onTap() {
    _animate.forward();
    Future.delayed(userDuration, () {
      _animate.reverse();
      onTap!();
    });
  }
}
