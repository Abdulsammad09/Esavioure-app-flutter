import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({super.key});

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  List<dynamic> ambulances = [];

  @override
  void initState() {
    super.initState();
    fetchAmbulances();
  }

  Future<void> fetchAmbulances() async {
    final response = await http.get(Uri.parse('$Url/user/get_driver.php'));
    if (response.statusCode == 200) {
      print(response.body); // Print the JSON response for debugging
      setState(() {
        ambulances = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load ambulances');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Ambulances'),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: ambulances.length,
        itemBuilder: (context, index) {
          final ambulance = ambulances[index];
          final ambulanceId = ambulance['ambulance_id'] ?? 'Unknown ID'; // Ambulance ID
          final driverName = ambulance['driver_name'] ?? 'No Driver'; // Driver name
          final driverPhone = ambulance['mobile'] ?? 'N/A'; // Driver phone

          return Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            color: Colors.red,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ambulance ID: $ambulanceId',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  'Driver: $driverName',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Phone: $driverPhone',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.white),
                      onPressed: () async {
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: '$driverPhone',
                        );
                        if(await canLaunchUrl(url)){

                          await launchUrl(url);
                        }else{
                          print('can not launch this url');
                        }

                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
