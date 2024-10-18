import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GradientTextExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.purple, // Start color
              Colors.blue, // End color
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Gradient Text',
            style: GoogleFonts.poppins(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors
                  .white, // Required to be filled, but will be overridden by the gradient
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: GradientTextExample(),
  ));
}
