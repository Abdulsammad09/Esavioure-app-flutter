import 'package:flutter/material.dart';
import 'AboutScreen.dart';
import 'ContactScreen.dart';
import 'EmergencyScreen.dart';
import 'GreallyScreenm.dart';
import 'NonEmergencyScreen.dart';
import 'prePlannedScreen.dart';
import 'ProfileScreen.dart'; // Make sure to import your ProfileScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    ProfileScreen(), // Ensure your ProfileScreen is correctly named
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.red,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildDashboardCard(
            context,
            'Emergency',
            Colors.red,
            Colors.white,
            Icons.warning,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmergencyScreen()),
              );
            },
          ),
          _buildDashboardCard(
            context,
            'Non-Emergency',
            Colors.white,
            Colors.red,
            Icons.info,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NonEmergencyScreen()),
              );
            },
          ),
          _buildDashboardCard(
            context,
            'Pre-Planned Booking',
            Colors.red,
            Colors.white,
            Icons.calendar_today,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Preplannedscreen()),
              );
            },
          ),
          _buildDashboardCard(
            context,
            'Gallery',
            Colors.red,
            Colors.white,
            Icons.image,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  GalleryScreen()),
              );
            },
          ),
          _buildDashboardCard(
            context,
            'About Us',
            Colors.red,
            Colors.white,
            Icons.info,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
          _buildDashboardCard(
            context,
            'Contact',
            Colors.white,
            Colors.red,
            Icons.contact_page,
                () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Contactscreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
      BuildContext context,
      String title,
      Color bgColor,
      Color textColor,
      IconData icon,
      VoidCallback onPressed,
      ) {
    return Card(
      color: bgColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.red, width: 2),
      ),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: textColor),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
