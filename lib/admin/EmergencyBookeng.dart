import 'package:esavier/admin/EmergencyDetail.dart';
import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:url_launcher/url_launcher.dart';

class Emergencybookeng extends StatefulWidget {
  const Emergencybookeng({super.key});

  @override
  _EmergencybookengState createState() => _EmergencybookengState();
}

class _EmergencybookengState extends State<Emergencybookeng> {
  List<Map<String, dynamic>> emergencyContacts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEmergencyContacts();
  }


  Future<void> fetchEmergencyContacts() async {
    final response = await http.get(Uri.parse('$Url/admin/fetch_emergency.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        emergencyContacts = data.map((item) {
          print("Fetched Status: ${item['status']}"); // Print status when fetched
          return {
            "id": item['id'],
            "title": item['hospital_name'],
            "subtitle": "Emergency number: ${item['number']}",
            "number": item['number'],
            "patient_name": item['patient_name'],
            "basic_and_advance_type": item['basic_and_advance_type'],
            "zip_code": item['zip_code'],
            "status": item['status'],
            "icon": Icons.local_hospital,
          };
        }).toList();
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Emergency Contacts"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: emergencyContacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(emergencyContacts[index]["icon"]),
            title: Text(emergencyContacts[index]["patient_name"]),
            subtitle: Text(emergencyContacts[index]["subtitle"]),
            trailing: IconButton(
              icon: Icon(Icons.remove_red_eye_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmergencyDetailPage(
                      id: emergencyContacts[index]["id"],
                      title: emergencyContacts[index]["title"],
                      number: emergencyContacts[index]["number"],
                      patient_name: emergencyContacts[index]["patient_name"],
                      zip_code: emergencyContacts[index]["zip_code"],
                      basic_and_advance_type: emergencyContacts[index]["basic_and_advance_type"],
                      status: emergencyContacts[index]["status"], // Pass the current status
                    ),
                  ),
                );
              },
            ),
            onTap: () {
              // Print the status when the contact is tapped
              print("Tapped on: ${emergencyContacts[index]["title"]}");
              print("Status: ${emergencyContacts[index]["status"]}"); // Print status
            },
          );
        },
      ),
    );
  }
}
