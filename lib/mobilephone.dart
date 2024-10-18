import 'package:flutter/material.dart';

class MockIphoneWithContent extends StatefulWidget {
  final String mockIphoneImagePath; // Path to the mock iPhone image
  final Widget?
      child; // The content you want to display inside the iPhone screen

  MockIphoneWithContent({required this.mockIphoneImagePath, this.child});

  @override
  _MockIphoneWithContentState createState() => _MockIphoneWithContentState();
}

class _MockIphoneWithContentState extends State<MockIphoneWithContent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize AnimationController and set the duration and bounce effect
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true); // Repeat the animation in reverse

    _bounceAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth curve for the bouncing effect
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose the controller when not needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _bounceAnimation, // Apply bouncing animation to the iPhone image
        child: Stack(
          children: [
            // iPhone mockup image
            Image.asset(
              widget.mockIphoneImagePath,
              width: 200, // Width of your iPhone mockup
              height: 150, // Height of your iPhone mockup
              fit: BoxFit.contain, // Adjust image fit if necessary
            ),
            // Positioned widget to place content inside the screen
            Positioned(
              top:
                  110, // Adjust top based on where the screen starts on your mock image
              left: 30, // Adjust left based on screen position in the image
              right: 30, // Adjust right based on screen width in the image
              bottom:
                  100, // Adjust bottom based on where the screen ends in your mock image
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    15), // Optional: round the corners of the screen area
                child: Container(
                  color: Colors.white, // Set the background color of the screen
                  child: widget.child, // Your content inside the iPhone screen
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
