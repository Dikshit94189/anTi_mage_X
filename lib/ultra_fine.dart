library ultra_fine;
export 'animated_text_ultra.dart';
import 'package:flutter/material.dart';

class AnimatedTextUltra extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;

  const AnimatedTextUltra({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 100),
  });

  @override
  State<AnimatedTextUltra> createState() => _AnimatedTextUltraState();
}

class _AnimatedTextUltraState extends State<AnimatedTextUltra>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Text(
        widget.text,
        style: widget.style,
      ),
    );
  }
}
