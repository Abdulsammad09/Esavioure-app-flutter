import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Define primary colors
    const Color primaryRed = Colors.redAccent;
    const Color primaryWhite = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: primaryRed, // Primary theme color
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: primaryWhite, // Background color
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ambulance Image
              Center(
                child: Image.asset(
                  'assets/images/g1.jpg', // Path to your local image
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 24),
              // About Section
              const Text(
                'About Our Ambulance Service',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryRed,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'We provide 24/7 emergency ambulance services dedicated to saving lives. '
                    'Our trained medical professionals and state-of-the-art ambulances ensure '
                    'that you receive the best care in critical times.',
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 24),
              // Why Choose Us Section
              const Text(
                'Why Choose Us?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryRed,
                ),
              ),
              const SizedBox(height: 8),
              // Features List
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  FeatureItem(text: 'Fast Response Times'),
                  FeatureItem(text: 'Highly Trained Paramedics'),
                  FeatureItem(
                      text:
                      'Modern Ambulances Equipped with Life-Saving Technology'),
                  FeatureItem(text: '24/7 Availability'),
                ],
              ),
              const SizedBox(height: 24),
              // Contact Us Section
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryRed,
                ),
              ),
              const SizedBox(height: 8),
              // Contact Information with Icons
              ContactInfo(
                icon: Icons.phone,
                text: '+123 456 7890',
              ),
              const SizedBox(height: 8),
              ContactInfo(
                icon: Icons.email,
                text: 'support@ambulanceapp.com',
              ),
              const SizedBox(height: 8),
              ContactInfo(
                icon: Icons.location_on,
                text: '123 Emergency Lane, City, Country',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for Feature Items
class FeatureItem extends StatelessWidget {
  final String text;

  const FeatureItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          const Icon(
            Icons.check_circle,
            color: Colors.redAccent,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for Contact Information
class ContactInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const ContactInfo({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.redAccent,
        ),
        const SizedBox(width: 12),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }
}
