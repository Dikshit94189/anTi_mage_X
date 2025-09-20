library ultra_fine;

export 'animated_text_ultra.dart';
import 'package:flutter/material.dart';

class AnimatedTextUltra extends StatefulWidget {
  final List<String> texts;
  final TextStyle? style;
  final Duration duration;
  final bool loop;
  final VoidCallback? onTap;
  final String? buttonName;
  final Color? iconColors;
  final bool showText;
  final Widget? icon;


  const AnimatedTextUltra({
    super.key,
    this.icon,
    this.showText = true,
    required this.texts,
    this.style,
    this.duration = const Duration(milliseconds: 100),
    this.loop = true,
    this.onTap,
    this.buttonName,
    this.iconColors,
  });

  @override
  State<AnimatedTextUltra> createState() => _AnimatedTextUltraState();
}

class _AnimatedTextUltraState extends State<AnimatedTextUltra>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<double> _textAnimation;

  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    /// Fade animation for text
    _textController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _textAnimation =
        CurvedAnimation(parent: _textController, curve: Curves.easeIn);
    _startTextAnimation();

    /// Shake animation for button icon
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..repeat(reverse: true); // repeat forever (left-right)

    _shakeAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );
  }

  void _startTextAnimation() {
    _textController.forward(from: 0).whenComplete(() async {
      await Future.delayed(const Duration(seconds: 5)); // gap
      if (mounted) {
        setState(() {
          if (_currentIndex < widget.texts.length - 1) {
            _currentIndex++;
          } else if (widget.loop) {
            _currentIndex = 0;
          }
        });
        _startTextAnimation();
      }
    });
  }

  void _onButtonPressed() {
    if (widget.onTap != null) {
      widget.onTap!();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Button tapped!")),
      );
    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if(widget.showText) ...[
          FadeTransition(
            opacity: _textAnimation,
            child: Text(
              widget.texts[_currentIndex],
              style: widget.style,
            ),
          ),
          const SizedBox(height: 10),
        ],
        GestureDetector(
          onTap: _onButtonPressed,
          behavior: HitTestBehavior.translucent, // ensures taps register even on transparent areas
          child: Container(
            color: Colors.transparent, // fully transparent background
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), // optional, matches button spacing
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _shakeAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _shakeAnimation.value,
                      child: child,
                    );
                  },
                  child: widget.icon ?? Icon(Icons.favorite, color: widget.iconColors),
                ),
                const SizedBox(width: 8), // spacing between icon and label (keeps same look)
                Text(widget.buttonName ?? ""),
              ],
            ),
          ),
        )

      ],
    );
  }
}

