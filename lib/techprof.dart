import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TechnicalProficiencySection extends StatefulWidget {
  @override
  _TechnicalProficiencySectionState createState() =>
      _TechnicalProficiencySectionState();
}

class _TechnicalProficiencySectionState
    extends State<TechnicalProficiencySection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: Text(
            'Technical Proficiency',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // The four main expandable cards
        _buildExpandableCard(
          'Languages',
          Icons.code,
          [
            Skill('C', 75),
            Skill('Python', 85),
            Skill('Dart', 80),
          ],
        ),
        const SizedBox(height: 10),
        _buildExpandableCard(
          'Frameworks',
          Icons.settings,
          [
            Skill('Flutter', 80),
            Skill('Django', 75),
          ],
        ),
        const SizedBox(height: 10),
        _buildExpandableCard(
          'Technologies',
          Icons.data_usage,
          [
            Skill('IoT', 70),
            Skill('TensorFlow', 60),
          ],
        ),
        const SizedBox(height: 10),
        _buildExpandableCard(
          'Education',
          Icons.school,
          [
            Skill('B.Tech (Pursuing)', 90),
          ],
        ),
      ],
    );
  }

  Widget _buildExpandableCard(String title, IconData icon, List<Skill> skills) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.purple, size: 30),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        children: skills.map((skill) => _buildSkillRow(skill)).toList(),
      ),
    );
  }

  Widget _buildSkillRow(Skill skill) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            skill.name,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
          // Progress Bar for skill percentage
          LinearProgressIndicator(
            value: skill.percentage / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
          ),
          const SizedBox(height: 5),
          Text(
            '${skill.percentage}%',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class Skill {
  final String name;
  final int percentage;

  Skill(this.name, this.percentage);
}
