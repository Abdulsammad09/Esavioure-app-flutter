import 'dart:convert';
import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PreplannedBookingDetail extends StatefulWidget {
  final dynamic item;

  const PreplannedBookingDetail({super.key, required this.item});

  @override
  _PreplannedBookingDetailState createState() => _PreplannedBookingDetailState();
}

class _PreplannedBookingDetailState extends State<PreplannedBookingDetail> {
  final List<String> _statusOptions = ['Pending', 'In Progress', 'Completed', 'Cancelled'];
  String? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.item['status'] ?? _statusOptions.first;
  }

  Future<void> _updateStatus(String newStatus) async {
    final url = Uri.parse('$Url/admin/update_status_pre_planned.php');
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'id': widget.item['id'].toString(),
          'status': newStatus,
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['status'] == 'success') {
          // Update the local status immediately
          setState(() {
            _selectedStatus = newStatus;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Status updated successfully!'),
            backgroundColor: Colors.green,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse['message'] ?? 'Failed to update status'),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to connect to the server'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
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
        title: const Text('Pre-Planned Detail'),
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
                _buildTableRow('Current Status', _selectedStatus), // Use _selectedStatus
              ],
            ),
            const SizedBox(height: 16),
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
                    if (newValue != null) {
                      _updateStatus(newValue); // Update status immediately
                    }
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
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
