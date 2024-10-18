import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class _aboutMeOpacity extends StatelessWidget {
  final double aboutMeOpacity;
  final String imagePath;

  const _aboutMeOpacity({
    Key? key,
    required this.aboutMeOpacity,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textFontSize = screenWidth > 600 ? 16 : 14;

    return AnimatedOpacity(
      opacity: aboutMeOpacity,
      duration: const Duration(seconds: 1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = screenWidth < 600;
            bool isTablet = screenWidth >= 600 && screenWidth < 900;

            return Column(
              children: [
                if (isMobile || isTablet) ...[
                  // Image above the text for Mobile and Tablet
                  Center(
                    child: Transform.translate(
                      offset: const Offset(
                          0, 10), // Reduced offset for better alignment
                      child: SizedBox(
                        width: isMobile ? 200 : 300,
                        height: isMobile ? 200 : 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(imagePath),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // Adding spacing after the image
                ],
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!(isMobile || isTablet)) ...[
                      // Image on the left side for Desktop
                      Transform.translate(
                        offset: const Offset(0, 80),
                        child: SizedBox(
                          width: 400,
                          height: 400,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 100),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: isMobile || isTablet
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
                          // Centering "About Me" text
                          Center(
                            child: ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Colors.purple, Colors.blue],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ).createShader(bounds),
                              child: Text(
                                'About Me',
                                style: GoogleFonts.poppins(
                                  fontSize: isMobile ? 36 : 46,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Main About Me text with centered alignment on mobile and tablet
                          Text(
                            "I am a passionate Flutter app developer and Python backend developer with a keen interest in IoT and machine learning. My experience spans across building seamless mobile applications and developing scalable backend systems using Django. I enjoy exploring the intersection of software and hardware through IoT projects, while also diving into the world of machine learning to create intelligent solutions. With a strong foundation in both front-end and back-end development, I take pride in delivering efficient, well-designed full-stack applications. I am continuously learning and evolving, aiming to integrate cutting-edge technology into practical applications. My goal is to create impactful and innovative experiences for users in the digital space.",
                            style: GoogleFonts.roboto(
                              color: Colors.white70,
                              fontSize: textFontSize, // Responsive font size
                              fontWeight: FontWeight.w400, // Medium weight
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
                            textAlign: isMobile || isTablet
                                ? TextAlign.center
                                : TextAlign
                                    .start, // Center text for mobile/tablet
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildHoverCard(
                                  context,
                                  Icons.code,
                                  'Languages',
                                  'C, Python, Dart, Java, C++, SQL, DSA in Python.',
                                  Colors.purple.withOpacity(0.9),
                                  isMobile,
                                  isTablet, // Passing isTablet too
                                ),
                                const SizedBox(width: 5),
                                _buildHoverCard(
                                  context,
                                  Icons.settings,
                                  'Technical Skills',
                                  'Flutter, Xcode, IoT, TensorFlow, Android Studio, Figma, Firebase, Django.',
                                  Colors.blueAccent,
                                  isMobile,
                                  isTablet, // Passing isTablet too
                                ),
                                const SizedBox(width: 5),
                                _buildHoverCard(
                                  context,
                                  Icons.school,
                                  'Education',
                                  'Currently Pursuing B.Tech in Computer Science.',
                                  Colors.greenAccent,
                                  isMobile,
                                  isTablet, // Passing isTablet too
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHoverCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
    Color color,
    bool isMobile,
    bool isTablet,
  ) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) {
            setState(() {
              isHovered = true;
            });
          },
          onExit: (_) {
            setState(() {
              isHovered = false;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: (isMobile || isTablet)
                  ? color // Constant color for mobile and tablet
                  : (isHovered
                      ? color.withOpacity(0.8)
                      : Colors.transparent), // Hover effect for desktop
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: isHovered && !(isMobile || isTablet)
                  ? [
                      BoxShadow(
                          color: Colors.purple, blurRadius: 10, spreadRadius: 1)
                    ]
                  : [],
            ),
            child: Card(
              elevation: isHovered && !(isMobile || isTablet) ? 10 : 5,
              color: (isMobile || isTablet)
                  ? color // Constant solid color for mobile/tablet
                  : color.withOpacity(
                      isHovered ? 1.0 : 0.0), // Hover effect for desktop
              child: Padding(
                padding: EdgeInsets.all(isMobile ? 30.0 : 50.0),
                child: Column(
                  children: [
                    Icon(icon, size: isMobile ? 30 : 40, color: Colors.white),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 16 : 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 12 : 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
