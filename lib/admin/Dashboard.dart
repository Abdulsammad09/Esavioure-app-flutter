import 'package:esavier/admin/AmbulanceScreen.dart';
import 'package:esavier/admin/EmergencyBookeng.dart';
import 'package:esavier/admin/NonEmergencybooking.dart';
import 'package:esavier/admin/PrePlannedBooking.dart';
import 'package:esavier/admin/RegisterDriver.dart';
import 'package:esavier/splash.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import your login or main screen
import 'package:esavier/main.dart'; // Replace with your actual login screen

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  // Logout function
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear all stored user data

    // Navigate to the login screen and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()), // Replace MainScreen with your actual login screen
          (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.redAccent,
              ),
              child: Text(
                'Admin Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard, color: Colors.redAccent),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_hospital, color: Colors.redAccent),
              title: const Text('Manage Ambulances'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageAmbulancesPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.people, color: Colors.redAccent),
              title: const Text('Manage Staff'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ManageStaffPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.redAccent),
              title: const Text('Service History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ServiceHistoryPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Logout'),
              onTap: () {
                // Confirm logout with the user
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Are you sure you want to logout?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                        ),
                        TextButton(
                          child: const Text('Logout'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            _logout(context); // Perform logout
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: <Widget>[
            _buildDashboardCard(
              context,
              "Add Ambulances",
              Icons.local_hospital,
              Colors.redAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AmbulanceForm()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              "Add Driver",
              Icons.people,
              Colors.redAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registerdriver()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              "Emergency booking",
              Icons.people,
              Colors.redAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Emergencybookeng()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              "Non Emergency",
              Icons.people,
              Colors.redAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NonEmergencybooking()),
                );
              },
            ),
            _buildDashboardCard(
              context,
              "Pre Planned",
              Icons.people,
              Colors.redAccent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrePlannedBooking()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
      BuildContext context,
      String title,
      IconData icon,
      Color color, {
        required Function() onTap,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: color, width: 2),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 50,
                color: color,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.redAccent,
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

// Define the placeholder classes for your target pages
class ManageAmbulancesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Ambulances")),
      body: Center(child: const Text("Manage Ambulances Page")),
    );
  }
}

class ManageStaffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Manage Staff")),
      body: Center(child: const Text("Manage Staff Page")),
    );
  }
}

class ServiceHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Service History")),
      body: Center(child: const Text("Service History Page")),
    );
  }
}

class TotalAmbulancesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Total Ambulances")),
      body: Center(child: const Text("Total Ambulances Page")),
    );
  }
}

class TotalStaffPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Total Staff")),
      body: Center(child: const Text("Total Staff Page")),
    );
  }
}

class ActiveServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Active Services")),
      body: Center(child: const Text("Active Services Page")),
    );
  }
}
