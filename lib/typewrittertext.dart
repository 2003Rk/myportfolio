import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypewriterText extends StatefulWidget {
  @override
  _TypewriterTextState createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText> {
  String _displayedText = "";
  final String _fullText = "Flutter App Developer";
  final String _changedText = "Backend Developer";
  bool _isFullText = true; // Track which text is currently displayed

  @override
  void initState() {
    super.initState();
    _startTypewriterEffect();
  }

  void _startTypewriterEffect() {
    _animateText(_fullText);
  }

  void _animateText(String text) {
    _displayedText = "";
    for (int i = 0; i <= text.length; i++) {
      Future.delayed(Duration(milliseconds: 200 * i), () {
        setState(() {
          _displayedText = "${text.substring(0, i)} _"; // Append underscore
        });

        // Restart the animation after finishing the current one
        if (i == text.length) {
          Future.delayed(const Duration(seconds: 1), () {
            _isFullText = !_isFullText; // Toggle the text state
            _animateText(_isFullText ? _fullText : _changedText);
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayedText,
      style: GoogleFonts.poppins(
        color: Colors.deepPurpleAccent,
        fontSize: 24,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
