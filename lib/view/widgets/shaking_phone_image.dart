import 'package:flutter/material.dart';
import 'dart:math';

class ShakingPhoneImage extends StatefulWidget {
  const ShakingPhoneImage({super.key});

  @override
  State<ShakingPhoneImage> createState() => _ShakingPhoneImageState();
}

class _ShakingPhoneImageState extends State<ShakingPhoneImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: -0.05, end: 0.05).animate(_controller);
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
      child: Image.asset(
        'lib/images/phone.jpg',
        width: 230,
        height: 200,
      ),
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value * pi,
          child: child,
        );
      },
    );
  }
}