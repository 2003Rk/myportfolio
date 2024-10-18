import 'package:flutter/material.dart';

class ServiceGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3, // Number of columns
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(serviceList.length, (index) {
        return ServiceCard(service: serviceList[index]);
      }),
    );
  }
}

// Model class for a service
class Service {
  final String title;
  final String description;
  final IconData icon;

  Service({required this.title, required this.description, required this.icon});
}

// Data for services
List<Service> serviceList = [
  Service(
      title: 'Web Development',
      description: 'Building responsive websites',
      icon: Icons.web),
  Service(
      title: 'Mobile App Development',
      description: 'Android and iOS apps',
      icon: Icons.phone_android),
  Service(
      title: 'UI/UX Design',
      description: 'Designing user-friendly interfaces',
      icon: Icons.design_services),
  Service(
      title: 'SEO Optimization',
      description: 'Improve website ranking',
      icon: Icons.search),
  Service(
      title: 'Digital Marketing',
      description: 'Grow your business online',
      icon: Icons.mark_email_read),
  Service(
      title: 'Cloud Services',
      description: 'Cloud hosting and management',
      icon: Icons.cloud),
];

// Widget for displaying each service card
class ServiceCard extends StatelessWidget {
  final Service service;

  ServiceCard({required this.service});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(service.icon, size: 48, color: Colors.blueAccent),
            SizedBox(height: 10),
            Text(
              service.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              service.description,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
