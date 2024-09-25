import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For JSON encoding

class Nonemergencydetail extends StatefulWidget {
  final dynamic item;

  const Nonemergencydetail({super.key, required this.item});

  @override
  _NonemergencydetailState createState() => _NonemergencydetailState();
}

class _NonemergencydetailState extends State<Nonemergencydetail> {
  // List of available status options
  final List<String> _statusOptions = ['Pending', 'In Progress', 'Completed', 'Cancelled'];

  // Variable to hold the selected status
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    // Set the initial selected status to the status from the item, or default to the first valid option
    String itemStatus = widget.item['status'] ?? '';

    if (_statusOptions.contains(itemStatus)) {
      _selectedStatus = itemStatus;
    } else {
      // Add the dynamic status from item if not in options
      _statusOptions.insert(0, itemStatus);
      _selectedStatus = itemStatus; // Set it as the selected status
    }
  }

  // Function to update status on the server
  Future<void> _updateStatus(String newStatus) async {
    final url = Uri.parse('$Url/admin/update_status.php'); // Replace with your API endpoint
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'id': widget.item['id'].toString(), // Pass the ID of the non-emergency item
          'status': newStatus, // Pass the updated status
        },
      );

      if (response.statusCode == 200) {
        // Parse the response
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          // Successfully updated status
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Status updated successfully!'),
            backgroundColor: Colors.green,
          ));
        } else {
          // Handle error
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse['message'] ?? 'Failed to update status'),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        // Handle server error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to connect to the server'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      // Handle network error
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Non-Emergency Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              border: TableBorder.all(color: Colors.grey),
              children: [
                _buildTableRow('Hospital', widget.item['hospital_name']),
                _buildTableRow('Driver', widget.item['driver_name']),
                _buildTableRow('Patient Name', widget.item['patient_name']),
                _buildTableRow('Contact Number', widget.item['contact_number']),
                _buildTableRow('Special Requirements', widget.item['special_requirements']),
              ],
            ),
            const SizedBox(height: 16),
            // Dropdown for status selection
            Row(
              children: [
                const Text('Status:', style: TextStyle(fontSize: 18)),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: _selectedStatus,
                  items: _statusOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedStatus = newValue!;
                      _updateStatus(_selectedStatus!); // Call the update function
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the previous screen
                },
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String title, String? value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value ?? 'N/A', style: const TextStyle(fontSize: 16)),
        ),
      ],
    );
  }
}
