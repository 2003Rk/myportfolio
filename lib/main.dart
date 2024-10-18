import 'dart:convert';
import 'package:just_audio/just_audio.dart';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:portfolio/hover.dart';
import 'package:portfolio/typewrittertext.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rahul Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  @override
  _PortfolioPageState createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  late ScrollController _scrollController;
  double _aboutMeOpacity = 0.0;
  double _skillsOpacity = 0.0;
  double _experienceOpacity = 0.0;
  double _projectsOpacity = 0.0;
  double _getInTouchOpacity = 0.0;
  late AnimationController _animationController;
  bool _isHovered = false;
  bool _isHoveredOnCV = false;
  bool _isHoveredOnCV2 = false;
  bool _isHoveredOnHire = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    // Animation controller for smooth animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    double offset = _scrollController.offset;

    // Debouncing the scroll to avoid frequent state updates
    Future.delayed(Duration(milliseconds: 20), () {
      if (!mounted) return;
      setState(() {
        _aboutMeOpacity = offset > 250 ? 1.0 : 0.0;
        _skillsOpacity = offset > 800 ? 1.0 : 0.0;
        _experienceOpacity = offset > 1500 ? 1.0 : 0.0;
        _projectsOpacity = offset > 2200 ? 1.0 : 0.0;
        _getInTouchOpacity = offset > 3500 ? 1.0 : 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF000000),
              Color(0xFF3E1A78),
            ],
            begin: Alignment.topCenter,
            end: Alignment.topRight,
          ),
        ),
        child: ListView(
          controller: _scrollController,
          children: [
            _buildTopBar(context),
            const SizedBox(height: 60),
            _buildMainSection(),
            const SizedBox(height: 300),
            _buildAnimatedAboutMeSection(),
            const SizedBox(height: 200),
            _buildAnimatedSkillsSection(),
            const SizedBox(height: 200),
            _buildExperienceSection(),
            const SizedBox(height: 300),
            _buildProjectsSection(),
            const SizedBox(height: 300),
            _buildGetInTouchSection(),
            const SizedBox(height: 50),
            _buildFooterSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Adjust padding, font size, and layout based on screen width
    double horizontalPadding = screenWidth > 600 ? 40.0 : 20.0;
    double verticalPadding = screenWidth > 600 ? 30.0 : 20.0;
    double fontSize = screenWidth > 600 ? 15.0 : 14.0;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: verticalPadding,
        horizontal: horizontalPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [
                Colors.black,
                Colors.white,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              'RK',
              style: GoogleFonts.poppins(
                fontSize: fontSize + 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          // For smaller screens, show a PopupMenuButton instead of the links
          if (screenWidth < 600)
            PopupMenuButton<int>(
              icon: const Icon(Icons.menu, color: Colors.white),
              onSelected: (int result) {
                if (result == 1) {
                  _launchURL('https://www.linkedin.com/in/rahul-kr2000/');
                } else if (result == 2) {
                  _launchURL(
                      'https://www.fiverr.com/rahul_kr2003?up_rollout=true');
                } else if (result == 3) {
                  _launchURL('https://github.com/2003Rk');
                } else if (result == 4) {
                  _launchURL('mailto:rahulkr99222@gmail.com');
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
                const PopupMenuItem<int>(
                  value: 1,
                  child: Text('LinkedIn'),
                ),
                const PopupMenuItem<int>(
                  value: 2,
                  child: Text('Fiverr'),
                ),
                const PopupMenuItem<int>(
                  value: 3,
                  child: Text('GitHub'),
                ),
                const PopupMenuItem<int>(
                  value: 4,
                  child: Text('Email'),
                ),
              ],
              offset: const Offset(0, 50),
            )
          else
            // For larger screens, show the links directly
            Row(
              children: [
                _buildTextButton(
                  'LinkedIn',
                  'https://www.linkedin.com/in/rahul-kr2000/',
                  fontSize,
                ),
                const SizedBox(width: 20),
                _buildTextButton(
                  'Fiverr',
                  'https://www.fiverr.com/rahul_kr2003?up_rollout=true',
                  fontSize,
                ),
                const SizedBox(width: 20),
                _buildTextButton(
                  'GitHub',
                  'https://github.com/2003Rk',
                  fontSize,
                ),
                const SizedBox(width: 20),
                _buildTextButton(
                  'Email',
                  'mailto:rahulkr99222@gmail.com',
                  fontSize,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildTextButton(String label, String url, double fontSize) {
    return TextButton(
      onPressed: () async {
        await _launchURL(url);
      },
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
          color: Colors.white60,
        ),
      ),
    );
  }

// URL launcher function
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> sendEmail(
      BuildContext context, String name, String email, String message) async {
    const serviceId = 'service_bvb85g8';
    const templateId = 'template_xihrh1o';
    const userId = 'BIuP8dyWoF0ZncIFs';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_message': message,
        },
      }),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
      _showSuccessDialog(context);
      _playSound();
    } else {
      print('Failed to send email');
      _showErrorDialog(context);
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thank You!'),
          content: const Text('Your feedback has been sent successfully.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Fill all the fiels.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _playSound() async {
    final player = AudioPlayer();

    try {
      await player.setAsset('assets/mailsound.mp3');
      await player.play(); // Play the sound
    } catch (e) {
      print('Error playing sound: $e');
    } finally {
      player.dispose();
    }
  }

  Widget _buildMainSection() {
    double screenWidth = MediaQuery.of(context).size.width;

    // Check screen width to decide layout: Row for desktop, Column for mobile
    if (screenWidth > 600) {
      // Desktop view: Main info on the left, profile image on the right
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          children: [
            Expanded(
              flex: 1, // Main info takes 50% of the screen
              child: _buildMainInfo(context,
                  isMobile: false), // Pass isMobile = false for desktop
            ),
            SizedBox(width: 50), // Add some spacing between the two sections
            Expanded(
              flex: 1, // Profile image takes 50% of the screen
              child: _buildProfileImage(context),
            ),
          ],
        ),
      );
    } else {
      // Mobile view: Main info and profile image stacked vertically
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            _buildProfileImage(context),
            const SizedBox(height: 30), // Spacing between image and info
            Center(
              child: _buildMainInfo(context,
                  isMobile: true), // Pass isMobile = true for mobile
            ),
          ],
        ),
      );
    }
  }

  Widget _buildProfileImage(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Adjust image size based on screen width
    double imageWidth = screenWidth > 600 ? 300 : 200;
    double imageHeight = screenWidth > 600 ? 290 : 190;

    // Only apply hover effects if the screen width is more than 600 (desktop/tablet)
    return MouseRegion(
      onEnter: (_) {
        if (screenWidth > 600) {
          setState(() {
            _isHovered = true; // Set hover state to true for larger screens
          });
        }
      },
      onExit: (_) {
        if (screenWidth > 600) {
          setState(() {
            _isHovered = false; // Set hover state to false for larger screens
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        transform: _isHovered && screenWidth > 600
            ? (Matrix4.identity()
              ..rotateY(0.1) // Slightly rotate around Y-axis for 3D effect
              ..scale(1.05)) // Scale up for a pop-out effect
            : (Matrix4.identity()
              ..rotateZ(
                  screenWidth > 600 ? 0.2 : 0)), // Tilt only on large screens
        transformAlignment: Alignment.center,
        child: Center(
          child: Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  _isHovered && screenWidth > 600
                      ? 'assets/about2.jpg' // Change image on hover for large screens
                      : 'assets/about1.jpg', // Default profile image
                ),
                fit: BoxFit.cover,
              ),
              // Circular shape on smaller screens, rounded rectangle on larger screens
              borderRadius: BorderRadius.circular(screenWidth > 600 ? 25 : 100),
              boxShadow: _isHovered && screenWidth > 600
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ]
                  : [],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMainInfo(BuildContext context, {required bool isMobile}) {
    double screenWidth = MediaQuery.of(context).size.width;

    double headingFontSize = screenWidth > 600 ? 50 : 30;
    double subheadingFontSize = screenWidth > 600 ? 20 : 14;
    double textFontSize = screenWidth > 600 ? 16 : 14;

    double buttonWidth =
        screenWidth > 600 ? 180 : 110; // Smaller width for mobile
    double buttonHeight =
        screenWidth > 600 ? 50 : 40; // Smaller height for mobile
    double buttonFontSize =
        screenWidth > 600 ? 16 : 10; // Smaller font size for mobile
    EdgeInsets buttonPadding = screenWidth > 600
        ? const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0)
        : const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0);

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start, // Center for mobile
      mainAxisAlignment: MainAxisAlignment.center, // Vertically center content
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.9, end: 1.0),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.grey, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Row(
              mainAxisAlignment: isMobile
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start, // Center row for mobile
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      'Hi there, Welcome to My Space ',
                      style: GoogleFonts.poppins(
                        fontSize: subheadingFontSize,
                        color: Colors.white,
                      ),
                      textAlign: isMobile
                          ? TextAlign.center
                          : TextAlign.left, // Center text for mobile
                    ),
                  ),
                ),
                // Display the GIF, ensure it resizes properly
                SizedBox(
                  width: screenWidth > 600 ? 40 : 30, // Adjust size for mobile
                  height: screenWidth > 600 ? 40 : 30,
                  child: Image.asset(
                    'assets/hi.gif', // Replace with the actual URL or use Image.asset for local assets
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
        // "I'm Rahul Kumar" text
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.9, end: 1.0),
          duration: const Duration(seconds: 2),
          curve: Curves.easeInOut,
          builder: (context, scale, child) {
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Colors.grey, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: Text(
              "I'm Rahul Kumar",
              style: GoogleFonts.poppins(
                fontSize: headingFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: isMobile
                  ? TextAlign.center
                  : TextAlign.left, // Center text for mobile
            ),
          ),
        ),
        const SizedBox(height: 10),
        TypewriterText(), // Use your custom TypewriterText widget
        const SizedBox(height: 20),
        Text(
          "I'm a Flutter app and backend developer, specializing in Python and Django to build scalable, full-stack applications. I focus on creating efficient, user-friendly solutions that combine functionality with clean design.",
          style: GoogleFonts.lato(
            color: Colors.white70,
            fontSize: textFontSize,
            fontWeight: FontWeight.w400,
            height: 1.7,
            letterSpacing: 0.5,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          textAlign: isMobile
              ? TextAlign.center
              : TextAlign.left, // Center text for mobile
        ),
        const SizedBox(height: 20),
        MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHoveredOnCV = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHoveredOnCV = false;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            width: buttonWidth,
            height: buttonHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(7),
              gradient: _isHoveredOnCV
                  ? const LinearGradient(
                      colors: [Colors.blue, Colors.green],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
            ),
            child: ElevatedButton(
              onPressed: () async {
                const url =
                    'https://drive.google.com/file/d/1NchDpuSdfSHIhOFWcA3Tc7lt-bCPwb03/view?usp=sharing'; // Add your PDF link here

                if (await canLaunch(url)) {
                  await launch(url); // Launch the PDF URL
                } else {
                  throw 'Could not launch $url';
                }
              },
              style: ElevatedButton.styleFrom(
                padding: buttonPadding,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.transparent, // Make button transparent
                shadowColor: Colors.transparent, // Disable shadow on hover
              ),
              child: Text(
                'Download CV',
                style: TextStyle(
                  fontSize: buttonFontSize,
                  color: _isHoveredOnCV ? Colors.white : Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedAboutMeSection() {
    double screenWidth = MediaQuery.of(context).size.width;
    double textFontSize = screenWidth > 600 ? 16 : 14;

    return RepaintBoundary(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: _aboutMeOpacity,
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(-6, -6),
                  blurRadius: 8, // Reduced blur for better performance
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  offset: const Offset(6, 6),
                  blurRadius: 8, // Reduced blur for better performance
                ),
              ],
              gradient: LinearGradient(
                colors: [Colors.grey.shade800, Colors.grey.shade900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                if (screenWidth < 600) ...[
                  _buildLottieAnimation(200, 200),
                  const SizedBox(height: 10),
                ],
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (screenWidth >= 600) ...[
                      _buildLottieAnimation(450, 450),
                      const SizedBox(width: 100),
                    ],
                    Expanded(
                      child: Column(
                        crossAxisAlignment: screenWidth < 600
                            ? CrossAxisAlignment.center
                            : CrossAxisAlignment.start,
                        children: [
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
                                  fontSize: screenWidth < 600 ? 36 : 46,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "I am a passionate Flutter app developer and a skilled backend developer with expertise in Python and Django. As a self-learner, I have honed my skills through hands-on projects, learning from platforms like YouTube and Google. I am also actively freelancing in app development, allowing me to collaborate with diverse clients and tackle a variety of challenges. My journey has equipped me to deliver efficient and innovative solutions. With a strong foundation in coding, I continuously explore new technologies to enhance my development process. Problem-solving and self-learning are at the core of my growth as a developer.",
                            style: GoogleFonts.lato(
                              color: Colors.white70,
                              fontSize: textFontSize,
                              fontWeight: FontWeight.w400,
                              height: 1.7,
                              letterSpacing: 0.5,
                            ),
                            textAlign: screenWidth < 600
                                ? TextAlign.center
                                : TextAlign.start,
                          ),
                          const SizedBox(height: 20),
                          _buildActionButtons(screenWidth),
                          const SizedBox(height: 5),
                          _buildSocialIcons(screenWidth),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLottieAnimation(double width, double height) {
    return Lottie.asset(
      "assets/about2.json",
      width: width,
      height: height,
      fit: BoxFit.cover,
      // Add condition to only play when it's in view
    );
  }

  Widget _buildActionButtons(double screenWidth) {
    return Row(
      mainAxisAlignment: screenWidth < 600
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        // Download CV Button with Hover Effect
        MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHoveredOnCV2 = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHoveredOnCV2 = false;
            });
          },
          child: RepaintBoundary(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(7),
                gradient: _isHoveredOnCV2
                    ? const LinearGradient(
                        colors: [Colors.blue, Colors.green],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : null,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  const url =
                      'https://drive.google.com/file/d/1NchDpuSdfSHIhOFWcA3Tc7lt-bCPwb03/view?usp=sharing'; // Add your PDF link here

                  if (await canLaunch(url)) {
                    await launch(url); // Launch the PDF URL
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  'Download CV',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        // Hire Me Button with Hover Effect
        MouseRegion(
          onEnter: (_) {
            setState(() {
              _isHoveredOnHire = true;
            });
          },
          onExit: (_) {
            setState(() {
              _isHoveredOnHire = false;
            });
          },
          child: RepaintBoundary(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 800),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(7),
                gradient: _isHoveredOnHire
                    ? const LinearGradient(
                        colors: [Colors.blue, Colors.green],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                    : null,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  const email =
                      'mailto:rahulkr99222@gmail.com?subject=Hiring%20Inquiry';
                  if (await canLaunch(email)) {
                    await launch(email);
                  } else {
                    throw 'Could not launch $email';
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  'Hire Me',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcons(double screenWidth) {
    return Row(
      mainAxisAlignment: screenWidth < 600
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
      children: [
        IconButton(
          icon: Image.asset("assets/link.png", width: 35, height: 35),
          onPressed: () async {
            const url = 'https://www.linkedin.com/in/rahul-kr2000/';
            await _launchURL(url);
          },
        ),
        const SizedBox(width: 2),
        IconButton(
          icon: Image.asset("assets/github.png", width: 25, height: 25),
          onPressed: () async {
            const url = 'https://github.com/2003Rk';
            await _launchURL(url);
          },
        ),
      ],
    );
  }

  Widget _buildAnimatedSkillsSection() {
    double screenWidth = MediaQuery.of(context).size.width;
    double cardFontSize = screenWidth > 600 ? 16 : 14;

    return RepaintBoundary(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: _skillsOpacity,
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = MediaQuery.of(context).size.width;
              bool isMobile = screenWidth < 600;
              bool isTablet = screenWidth >= 600 && screenWidth < 900;

              return Column(
                children: [
                  Center(
                    child: ShaderMask(
                      shaderCallback: (bounds) => const LinearGradient(
                        colors: [Colors.purple, Colors.blue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds),
                      child: Text(
                        'Technical proficiency',
                        style: GoogleFonts.poppins(
                          fontSize: isMobile ? 36 : 46,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Wrap(
                      alignment: isMobile || isTablet
                          ? WrapAlignment.center
                          : WrapAlignment.start,
                      spacing: 20.0,
                      runSpacing: 20.0,
                      children: [
                        _buildSkillCard(
                          'App Development',
                          [
                            'Flutter',
                            'Firebase',
                            'Riverpod',
                            'GetX',
                            'Django',
                            'RestfulApi',
                            'Stripe',
                            'Figma'
                          ],
                          [
                            'assets/flutter.png',
                            'assets/fire.png',
                            'assets/riverpod.png',
                            'assets/getx.png',
                            'assets/dj.png',
                            'assets/restapi.png',
                            'assets/stripe.png',
                            'assets/figma.png'
                          ],
                          Colors.purpleAccent,
                        ),
                        _buildSkillCard(
                          'Backend Development',
                          ['Python', 'Django', 'Mysql', 'Redis', 'Firebase'],
                          [
                            'assets/py.png',
                            'assets/dj.png',
                            'assets/mysql.png',
                            'assets/redis.png',
                            'assets/fire.png'
                          ],
                          Colors.blueAccent,
                        ),
                        _buildSkillCard(
                          'Tools',
                          [
                            'VS Code',
                            'Xcode',
                            'Git',
                            'GitHub',
                            'Emailjs',
                            'Netlify',
                            'Tensorflow',
                            'Arduino IDE'
                          ],
                          [
                            'assets/vscode.png',
                            'assets/xcode.png',
                            'assets/git2.png',
                            'assets/github3.png',
                            'assets/emailjs.png',
                            'assets/netlify.png',
                            'assets/tensor.png',
                            'assets/arudino.png'
                          ],
                          Colors.greenAccent,
                        ),
                        _buildSkillCard(
                          'Soft Skills',
                          [
                            'Problem-Solving',
                            'Adaptability',
                            'Collaboration',
                            'Team Management'
                          ],
                          [
                            'assets/problem.png',
                            'assets/adaptability.png',
                            'assets/collab.png',
                            'assets/teammang.png'
                          ],
                          Colors.orangeAccent,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard(String category, List<String> skills,
      List<String> iconPaths, Color color) {
    return RepaintBoundary(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 4),
              blurRadius: 8,
            ),
          ],
        ),
        width: 500,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 6.0,
              children: skills.asMap().entries.map((entry) {
                int index = entry.key;
                String skill = entry.value;

                return Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        iconPaths[index],
                        width: 16,
                        height: 16,
                        cacheWidth: 64, // Optimize image size
                      ),
                      const SizedBox(width: 8),
                      Text(
                        skill,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExperienceSection() {
    // List of experiences
    final List<Experience> experiences = [
      Experience(
        date: '2024 Jun - 2024 Aug',
        title: 'Flutter App Developer Intern',
        company: 'Freshtronics',
        description:
            "I successfully developed and implemented a custom UI design for a company's Flutter app, enhancing user experience and aligning with the client's brand vision. My work focused on delivering a seamless and visually engaging interface.",
        imagePath: 'assets/recycle.png',
      ),
      Experience(
        date: '2024 Jun - 2024 Aug',
        title: 'Flutter App Developer Intern',
        company: 'Freshtronics',
        description:
            "I developed an innovative app that seamlessly transforms an entire website into a mobile application, enhancing accessibility and user engagement. This project involved adapting the web interface to ensure a smooth and intuitive mobile experience.",
        imagePath: 'assets/tamilmani.png',
      ),
    ];

    return RepaintBoundary(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: _experienceOpacity,
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Get the width of the screen
              double screenWidth = MediaQuery.of(context).size.width;

              // Check if the screen is mobile-sized or not
              bool isMobile = screenWidth < 600;

              return Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Colors.purple,
                        Colors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Work Experience',
                      style: GoogleFonts.poppins(
                        fontSize:
                            isMobile ? 36 : 46, // Adjust font size for mobile
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Display experiences differently based on screen size
                  Column(
                    children: List.generate(experiences.length, (index) {
                      final experience = experiences[index];
                      final isLeft = index.isEven;

                      // For mobile, stack experiences vertically
                      if (isMobile) {
                        return Column(
                          children: [
                            ExperienceCard(experience: experience),
                            if (index < experiences.length - 1)
                              _buildTimelineIndicator(),
                          ],
                        );
                      }

                      // For larger screens, use the original row layout
                      return Row(
                        children: [
                          Expanded(
                            child: isLeft
                                ? ExperienceCard(experience: experience)
                                : Container(),
                          ),
                          _buildTimelineIndicator(),
                          Expanded(
                            child: isLeft
                                ? Container()
                                : ExperienceCard(experience: experience),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineIndicator() {
    return RepaintBoundary(
      child: SizedBox(
        width: 20,
        child: Column(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.deepPurpleAccent,
              ),
            ),
            Container(
              height: 60,
              width: 2,
              color: Colors.deepPurpleAccent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectsSection() {
    return RepaintBoundary(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: _projectsOpacity,
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            children: [
              Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Colors.purple,
                        Colors.blue,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      'Projects',
                      style: GoogleFonts.poppins(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [
                        Color.fromARGB(255, 59, 58, 58),
                        Colors.white,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      "Discover how I apply my skills to create engaging and effective applications.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DefaultTabController(
                    length: 4, // Four tabs now
                    child: Column(
                      children: [
                        Container(
                          width: 500,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          child: const TabBar(
                            indicatorColor: Colors.deepPurple,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            tabs: [
                              Tab(text: 'All'),
                              Tab(text: 'Mobile Apps'),
                              Tab(text: 'Web Apps'),
                              Tab(text: 'IoT Projects'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          height: 600,
                          child: TabBarView(
                            children: [
                              _buildAllProjectsTabContent(),
                              _buildMobileAppsTabContent(),
                              _buildWebAppsTabContent(),
                              _buildIoTProjectsTabContent(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Add Scroll Down image only for larger screens
              if (MediaQuery.of(context).size.width >
                  600) // Show scroll image only on larger screens
                Positioned(
                  right: 10,
                  top: 130, // Adjust based on design
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/scrolldown.png', // Change this to your image path
                        width: 30, // Set the width for the image
                        height: 30, // Set the height for the image
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

// Function for All Projects tab
  Widget _buildAllProjectsTabContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        int itemsPerRow = maxWidth > 600
            ? 3
            : maxWidth > 800
                ? 2
                : 1;
        double cardWidth = (maxWidth - (itemsPerRow - 1) * 20) / itemsPerRow;

        return SingleChildScrollView(
          // Add scrollable view
          child: Center(
            child: Wrap(
              spacing: 20.0, // Space between cards
              runSpacing: 20.0, // Space between rows
              children: List.generate(6, (index) {
                switch (index) {
                  case 0:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Food Delivery App',
                        titleImage: 'assets/fooddel.jpg',
                        githubUrl: 'https://github.com/2003Rk/foodDel',
                        description:
                            'A fast and user-friendly food delivery app.',
                      ),
                    );
                  case 1:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Task Manager App',
                        titleImage: 'assets/taskmang.png',
                        githubUrl: 'https://github.com/2003Rk/taskmang',
                        description:
                            'A simple and intuitive task management app.',
                      ),
                    );
                  case 2:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Portfolio Website',
                        titleImage: 'assets/website.png',
                        githubUrl:
                            'https://github.com/your_github/portfolio_website',
                        description:
                            'A sleek portfolio website built with Flutter.',
                      ),
                    );
                  case 3:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Arduino RC Controller App',
                        titleImage: 'assets/arduino rc controller.png',
                        githubUrl: 'https://github.com/2003Rk/Arduino-Bt-App',
                        description:
                            'An Arduino RC car controller app built with Flutter.',
                      ),
                    );
                  case 4:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Arduino Line Follower Car',
                        titleImage: 'assets/linefollower.png',
                        githubUrl:
                            'https://github.com/2003Rk/Arduino-line-following-robot',
                        description:
                            'A line follower robot built using infrared sensors.',
                      ),
                    );
                  case 5:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Voice Assistant App',
                        titleImage: 'assets/Vi.png',
                        githubUrl: 'https://github.com/2003Rk/voice_assit',
                        description:
                            'A voice assistant app powered by the OpenAI API.',
                      ),
                    );
                  default:
                    return Container(); // Fallback
                }
              }),
            ),
          ),
        );
      },
    );
  }

// Function for Mobile Apps tab
  Widget _buildMobileAppsTabContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        int itemsPerRow = maxWidth > 600
            ? 3
            : maxWidth > 800
                ? 2
                : 1;
        double cardWidth = (maxWidth - (itemsPerRow - 1) * 20) / itemsPerRow;

        return SingleChildScrollView(
          // Add scrollable view
          child: Center(
            child: Wrap(
              spacing: 20.0, // Space between cards
              runSpacing: 20.0, // Space between rows
              children: List.generate(2, (index) {
                switch (index) {
                  case 0:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Food Delivery App',
                        titleImage: 'assets/fooddel.jpg',
                        githubUrl: 'https://github.com/2003Rk/foodDel',
                        description:
                            'A fast and user-friendly food delivery app.',
                      ),
                    );
                  case 1:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Task Manager App',
                        titleImage: 'assets/taskmang.png',
                        githubUrl: 'https://github.com/2003Rk/taskmang',
                        description:
                            'A simple and intuitive task management app.',
                      ),
                    );
                  default:
                    return Container(); // Fallback
                }
              }),
            ),
          ),
        );
      },
    );
  }

// Function for Web Apps tab
  Widget _buildWebAppsTabContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        int itemsPerRow = maxWidth > 600
            ? 3
            : maxWidth > 800
                ? 3
                : 1;
        double cardWidth = (maxWidth - (itemsPerRow - 1) * 20) / itemsPerRow;

        return SingleChildScrollView(
          // Add scrollable view
          child: Center(
            child: Wrap(
              spacing: 20.0, // Space between cards
              runSpacing: 20.0, // Space between rows
              children: List.generate(1, (index) {
                return SizedBox(
                  width: cardWidth,
                  child: const ProjectCard(
                    title: 'Flutter Portfolio Website',
                    titleImage: 'assets/website.png',
                    githubUrl:
                        'https://github.com/your_github/portfolio_website',
                    description:
                        'A sleek portfolio website built with Flutter.',
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

// Function for IoT Projects tab
  Widget _buildIoTProjectsTabContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth;
        int itemsPerRow = maxWidth > 600
            ? 3
            : maxWidth > 800
                ? 2
                : 1;
        double cardWidth = (maxWidth - (itemsPerRow - 1) * 20) / itemsPerRow;

        return SingleChildScrollView(
          // Add scrollable view
          child: Center(
            child: Wrap(
              spacing: 20.0, // Space between cards
              runSpacing: 20.0, // Space between rows
              children: List.generate(3, (index) {
                switch (index) {
                  case 0:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Arduino RC Controller App',
                        titleImage: 'assets/arduino rc controller.png',
                        githubUrl: 'https://github.com/2003Rk/Arduino-Bt-App',
                        description:
                            'An Arduino RC car controller app built with Flutter.',
                      ),
                    );

                  case 1:
                    return SizedBox(
                      width: cardWidth,
                      child: const ProjectCard(
                        title: 'Arduino Line Follower Car',
                        titleImage: 'assets/linefollower.png',
                        githubUrl:
                            'https://github.com/2003Rk/Arduino-line-following-robot',
                        description:
                            'A line follower robot built using infrared sensors.',
                      ),
                    );
                  default:
                    return Container(); // Fallback
                }
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGetInTouchSection() {
    double screenWidth = MediaQuery.of(context).size.width;

    // Check if the screen width is for mobile or tablet
    bool isMobileOrTablet = screenWidth < 800;

    return RepaintBoundary(
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: _getInTouchOpacity,
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: SingleChildScrollView(
              // Wrap the entire content in a scrollable view
              child: Center(
                child: Container(
                  width: isMobileOrTablet
                      ? screenWidth * 0.9
                      : 700, // Reduced desktop widt
                  height: isMobileOrTablet
                      ? null // Let height adjust based on content for mobile/tablet
                      : 640, // Fixed height for desktop
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.black,
                        Color(0xFF3E1A78),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 4),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Colors.purple,
                            Colors.blue,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Text(
                          'Get In Touch 📩',
                          style: GoogleFonts.poppins(
                            fontSize: isMobileOrTablet
                                ? 36
                                : 46, // Responsive font size for mobile/tablet
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 59, 58, 58),
                            Colors.white,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "I'm currently looking for new opportunities, my inbox is always open. Whether you have a question or just want to say hi, I'll try my best to get back to you!",
                            style: GoogleFonts.poppins(
                              fontSize: isMobileOrTablet
                                  ? 16
                                  : 25, // Responsive font size for mobile/tablet
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        child: const Column(
                            // Add additional content here if needed
                            ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        child: isMobileOrTablet
                            ? Column(
                                children: [
                                  Container(
                                    width: screenWidth *
                                        0.9, // Full width on mobile/tablet
                                    child: TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        labelStyle: const TextStyle(
                                            color: Colors.white70),
                                        filled: true,
                                        fillColor: Colors.white24,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                      height:
                                          10), // Reduced spacing for mobile/tablet
                                  SizedBox(
                                    width: screenWidth *
                                        0.9, // Full width on mobile/tablet
                                    child: TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: const TextStyle(
                                            color: Colors.white70),
                                        filled: true,
                                        fillColor: Colors.white24,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 300, // Desktop width
                                    height: 100,
                                    child: TextField(
                                      controller: _nameController,
                                      decoration: InputDecoration(
                                        labelText: 'Full Name',
                                        labelStyle: const TextStyle(
                                            color: Colors.white70),
                                        filled: true,
                                        fillColor: Colors.white24,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  SizedBox(
                                    width: 300, // Desktop width
                                    height: 100,
                                    child: TextField(
                                      controller: _emailController,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                        labelStyle: const TextStyle(
                                            color: Colors.white70),
                                        filled: true,
                                        fillColor: Colors.white24,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: isMobileOrTablet
                            ? screenWidth * 0.9
                            : 500, // Adjust width for mobile/tablet
                        height: 100,
                        child: TextField(
                          controller: _messageController,
                          maxLines: 5,
                          decoration: InputDecoration(
                            labelText: 'Message',
                            labelStyle: const TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white24,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: isMobileOrTablet
                            ? screenWidth * 0.3
                            : 150, // Adjust button width for mobile/tablet
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),

                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              String name = _nameController.text;
                              String email = _emailController.text;
                              String message = _messageController.text;

                              // Check if the fields are not empty before sending email
                              if (name.isNotEmpty &&
                                  email.isNotEmpty &&
                                  message.isNotEmpty) {
                                sendEmail(context, name, email, message);
                              } else {
                                // Show an error dialog if fields are empty
                                _showErrorDialog(context);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 5.0,
                                horizontal: 5.0,
                              ),
                              child: Text(
                                'Send',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobileOrTablet
                                      ? 14
                                      : 16, // Responsive font size for button
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildFooterSection(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  double fontSizeName = screenWidth < 600 ? 16 : 22;
  double fontSizeText = screenWidth < 600 ? 8 : 12;
  double buttonFontSize = screenWidth < 600 ? 12 : 14;

  return Container(
    width: double.infinity,
    color: Colors.black54,
    height: 150, // Reduced height
    child: Stack(
      children: [
        // "Rahul Kumar" text
        Positioned(
          left: screenWidth < 600 ? 5 : 40,
          child: Padding(
            padding: const EdgeInsets.only(top: 20), // Reduced padding
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Colors.grey, Colors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds),
              child: Text(
                "Rahul Kumar",
                style: GoogleFonts.poppins(
                  fontSize: fontSizeName,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        // Contact Info
        Positioned(
          left: screenWidth < 600 ? 5 : 40,
          child: Padding(
            padding: const EdgeInsets.only(top: 50), // Reduced padding
            child: Text(
              'Mobile No - 9955581659',
              style: TextStyle(
                color: Colors.white54,
                fontSize: fontSizeText,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
        Positioned(
          left: screenWidth < 600 ? 5 : 40,
          child: Padding(
            padding: const EdgeInsets.only(top: 70), // Reduced padding
            child: Text(
              'Email - rahulkr99222@gmail.com',
              style: TextStyle(
                color: Colors.white54,
                fontSize: fontSizeText,
                fontFamily: 'Roboto',
              ),
            ),
          ),
        ),
        // "Download CV" button
        Positioned(
          right: screenWidth < 600 ? 10 : 20,
          child: Padding(
            padding: const EdgeInsets.only(top: 20), // Reduced padding
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(7),
              ),
              child: ElevatedButton(
                onPressed: () async {
                  const url =
                      'https://drive.google.com/file/d/1NchDpuSdfSHIhOFWcA3Tc7lt-bCPwb03/view?usp=sharing'; // Add your PDF link here

                  if (await canLaunch(url)) {
                    await launch(url); // Launch the PDF URL
                  } else {
                    throw 'Could not launch $url';
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 8), // Reduced padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Download CV',
                  style: TextStyle(
                    fontSize: buttonFontSize,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ),
          ),
        ),
        // Social Media Icons
        Positioned(
          bottom: 50, // Adjusted for reduced height
          left: 0,
          right: 2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Image.asset('assets/linkedin.png',
                    width: 25, height: 25), // Reduced size
                onPressed: () async {
                  const url = 'https://www.linkedin.com/in/rahul-kr2000/';
                  await _launchURL(url);
                },
              ),
              IconButton(
                icon: Image.asset('assets/Fiver.png',
                    width: 25, height: 25), // Reduced size
                onPressed: () async {
                  const url = 'https://www.fiverr.com/rahul_kr2003';
                  await _launchURL(url);
                },
              ),
              IconButton(
                icon: Image.asset('assets/Git.png',
                    width: 25, height: 25), // Reduced size
                onPressed: () async {
                  const url = 'https://github.com/2003Rk';
                  await _launchURL(url);
                },
              ),
              IconButton(
                icon: Image.asset('assets/email.png',
                    width: 25, height: 25), // Reduced size
                onPressed: () async {
                  const url = 'mailto:rahulkr99222@gmail.com';
                  await _launchURL(url);
                },
              ),
            ],
          ),
        ),
        // Copyright and Developer Info
        Positioned(
          bottom: 10, // Adjusted for reduced height
          left: 0,
          right: 0,
          child: Column(
            children: [
              Text(
                'Copyright © 2024 Rahul Kumar - All rights reserved.',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: fontSizeText,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 3),
              Text(
                'Designed & Developed by Rahul Kumar',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: fontSizeText,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// Experience Model
class Experience {
  final String date;
  final String title;
  final String company;
  final String description;
  final String imagePath; // Add this to hold the image path

  Experience({
    required this.date,
    required this.title,
    required this.company,
    required this.description,
    required this.imagePath, // Initialize the image path
  });
}

class ProjectCard extends StatefulWidget {
  final String title;
  final String githubUrl;
  final String titleImage; // Field for the title image
  final String description; // Field for description

  const ProjectCard({
    super.key,
    required this.title,
    required this.githubUrl,
    required this.titleImage, // Initialize the title image parameter
    required this.description, // Initialize the description parameter
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(bool hover) {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isHovered = hover;
      });
    }
  }

  void _openGithub() async {
    final Uri uri = Uri.parse(widget.githubUrl);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${widget.githubUrl}';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double textFontSize = screenWidth > 600 ? 16 : 14;
    double descFontSize = screenWidth > 600 ? 14 : 12;

    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 300,
        height: 290,
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.05)) // Scale slightly on hover
            : Matrix4.identity(),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.transparent, // Make the border transparent initially
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Gradient border effect
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  width: 5,
                  color: _isHovered
                      ? Colors.transparent
                      : Colors
                          .transparent, // Keep it transparent if not hovered
                ),
                gradient: LinearGradient(
                  colors: [
                    _isHovered
                        ? Colors.indigo.withOpacity(0.7)
                        : Colors.transparent,
                    _isHovered
                        ? Colors.green.withOpacity(0.7)
                        : Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // Arrange elements vertically
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Title image above the title
                      SizedBox(
                        width: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 90
                            : 120, // Increase width in landscape mode
                        height: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? 90
                            : 120, // Increase height in landscape mode

                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              15), // Rounded corners for image
                          child: Image.asset(
                            widget.titleImage,
                            fit: BoxFit.cover, // Image covers the container
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 5), // Space between title image and title
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.yellow, Colors.indigo],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds),
                        child: Center(
                          child: Text(
                            widget.title,
                            style: GoogleFonts.poppins(
                              fontSize: textFontSize,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                          height: 8), // Space between title and description
                      Text(
                        widget.description, // Display the description
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: descFontSize,
                          color: Colors.white60, // Slightly faded text color
                        ),
                      ),
                    ],
                  ),
                ),
                // Button with moving linear gradient
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return ShaderMask(
                        shaderCallback: (bounds) {
                          return LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: const [
                              Colors.purple,
                              Colors.blue,
                              Colors.red
                            ],
                            stops: [
                              _controller.value - 0.2,
                              _controller.value,
                              _controller.value + 0.2
                            ],
                          ).createShader(bounds);
                        },
                        child: ElevatedButton(
                          onPressed: _openGithub, // Open GitHub link on press
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(8), // Rounded corners
                            ),
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical:
                                    15), // Make background transparent for gradient
                          ),
                          child: const Text(
                            'Source Code',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Colors.white, // Text color should stay white
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
