library ultra_fine;

export 'animated_text_ultra.dart';
import 'package:flutter/material.dart';

class AnimatedTextUltra extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration duration;
  final bool loop;

  const AnimatedTextUltra({
    super.key,
    required this.texts,
    this.style,
    this.duration = const Duration(milliseconds: 1000),
    this.loop = true,
  });

  @override
  State<AnimatedTextUltra> createState() => _AnimatedTextUltraState();
}

class _AnimatedTextUltraState extends State<AnimatedTextUltra>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _startAnimation();
  }

  void _startAnimation() {
    _controller.forward(from: 0).whenComplete(() async {
      await Future.delayed(const Duration(seconds: 5)); // small gap
      if (mounted) {
        setState(() {
          if (_currentIndex < widget.texts.length - 1) {
            _currentIndex++;
          } else if (widget.loop) {
            _currentIndex = 0;
          }
        });
        _startAnimation(); // run again for next text
      }
    });
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
        widget.texts[_currentIndex],
        style: widget.style,
      ),
    );
  }
}
