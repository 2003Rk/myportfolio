import 'package:flutter/material.dart';

class BouncingTechIcon extends StatefulWidget {
  final String assetPath;

  BouncingTechIcon({required this.assetPath});

  @override
  _BouncingTechIconState createState() => _BouncingTechIconState();
}

class _BouncingTechIconState extends State<BouncingTechIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true); // Repeat animation

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.assetPath),
                fit: BoxFit.contain,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white70,
                width: 2,
              ),
            ),
          ),
        );
      },
    );
  }
}
