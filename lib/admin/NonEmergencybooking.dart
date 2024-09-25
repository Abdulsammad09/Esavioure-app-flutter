import 'dart:convert'; // To handle JSON decoding
import 'package:esavier/admin/NonEmergencyDetail.dart';
import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NonEmergencybooking extends StatefulWidget {
  const NonEmergencybooking({super.key});

  @override
  _NonEmergencybookingState createState() => _NonEmergencybookingState();
}

class _NonEmergencybookingState extends State<NonEmergencybooking> {
  List<dynamic> nonEmergencyData = []; // To store the data

  @override
  void initState() {
    super.initState();
    fetchNonEmergencyData();
  }

  // Function to fetch non-emergency data from the backend
  Future<void> fetchNonEmergencyData() async {
    try {
      final response = await http.get(Uri.parse('$Url/admin/fetch_nonemergency.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body); // Parse the JSON
        setState(() {
          nonEmergencyData = data; // Store the fetched data
        });
      } else {
        // Handle error
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  // Function to launch WhatsApp with a dynamically passed contact number
  void sandWhatsApp(String contactNumber) {
    // Remove any special characters or spaces from the number
    String phoneNumber = contactNumber.replaceAll(RegExp(r'\D'), '');

    if (phoneNumber.startsWith('0')) {
      // If the number starts with 0, replace it with the country code, e.g., Pakistan +92
      phoneNumber = '92' + phoneNumber.substring(1);
    }

    String url = "https://wa.me/$phoneNumber"; // WhatsApp URL format

    // Try launching the URL
    launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Non-Emergency Bookings'),
      ),
      body: nonEmergencyData.isEmpty
          ? const Center(child: CircularProgressIndicator()) // Show a loading indicator if data is empty
          : ListView.builder(
        itemCount: nonEmergencyData.length, // Number of items in the list
        itemBuilder: (context, index) {
          final item = nonEmergencyData[index]; // Get the item
          return ListTile(
            leading: IconButton(
              icon: const Icon(Icons.call), // Call icon in leading position
              onPressed: () {
                // Pass the contact number dynamically to sandWhatsApp
                String contactNumber = item['contact_number'] ?? ''; // Make sure to handle null case
                if (contactNumber.isNotEmpty) {
                  sandWhatsApp(contactNumber); // Call WhatsApp with dynamic contact number
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('No contact number available')),
                  );
                }
              },
            ),
            title: Text(item['patient_name'] ?? 'Unknown'), // Display patient_name as title
            subtitle: Text(item['contact_number'] ?? 'No contact number'), // Display contact_number as subtitle
            trailing: IconButton(
              icon: const Icon(Icons.info), // More info icon
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Nonemergencydetail(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  // Function to show more info in a dialog
  void showMoreInfoDialog(BuildContext context, dynamic item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('More Info'),
          content: Text(
            'Hospital: ${item['hospital_name']}\n'
                'Driver: ${item['driver_name']}\n'
                'Special Requirements: ${item['special_requirements']}\n'
                'Status: ${item['status']}',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
