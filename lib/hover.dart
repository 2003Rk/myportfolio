import 'package:flutter/material.dart';
import 'package:portfolio/main.dart';
import 'package:portfolio/mobilephone.dart'; // Your MockIphoneWithContent widget
import 'package:google_fonts/google_fonts.dart';

class ExperienceCard extends StatefulWidget {
  final Experience experience;

  ExperienceCard({required this.experience});

  @override
  _ExperienceCardState createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<ExperienceCard> {
  bool _isHovered = false;

  void _onEnter(bool hover) {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isHovered = hover;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textFontSize =
        screenWidth > 600 ? 16 : 10; // Adjust text size for mobile
    double titleFontSize =
        screenWidth > 600 ? 18 : 12; // Adjust title size for mobile
    double containerPadding =
        screenWidth > 600 ? 15 : 7; // Smaller padding for mobile
    double containerMargin =
        screenWidth > 600 ? 10 : 4; // Smaller margin for mobile
    double imagePadding =
        screenWidth > 600 ? 15 : 2; // Smaller image padding for mobile

    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: Transform(
        transform:
            _isHovered ? Matrix4.identity().scaled(1.05) : Matrix4.identity(),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(vertical: containerMargin),
          padding: EdgeInsets.all(containerPadding), // Responsive padding
          decoration: BoxDecoration(
            color:
                _isHovered ? Colors.deepPurple.withOpacity(0.3) : Colors.black,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white70),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Colors.deepPurpleAccent.withOpacity(0.7),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ]
                : [],
          ),
          child: Row(
            children: [
              // Realistic iPhone model with unique image
              Padding(
                padding: EdgeInsets.only(
                    right: imagePadding), // Responsive padding for image
                child: MockIphoneWithContent(
                  mockIphoneImagePath: widget.experience
                      .imagePath, // Use the image path from the experience object
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.experience.date,
                      style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 12), // Small font for mobile
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.experience.title,
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: titleFontSize, // Responsive title font size
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.experience.company,
                      style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize:
                              textFontSize), // Responsive company text size
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.experience.description,
                      style: GoogleFonts.lato(
                        color: Colors.white70,
                        fontSize:
                            textFontSize, // Responsive description font size
                        fontWeight: FontWeight.w400,
                        height: 1.7, // Increased line height
                        letterSpacing: 0.5, // Added letter spacing
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
