
library ultra_fine;


import 'package:flutter/material.dart';

/// A simple animated text widget
class AnimatedTextUltra extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;

  const AnimatedTextUltra({
    Key? key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 100),
  }) : super(key: key);

  @override
  State<AnimatedTextUltra> createState() => _AnimatedTextUltraState();
}

class _AnimatedTextUltraState extends State<AnimatedTextUltra>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _charCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration * widget.text.length,
      vsync: this,
    );

    _charCount = StepTween(begin: 0, end: widget.text.length).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _charCount,
      builder: (context, child) {
        final count = _charCount.value;
        return Text(
          widget.text.substring(0, count),
          style: widget.style ?? const TextStyle(fontSize: 24),
        );
      },
    );
  }
}
