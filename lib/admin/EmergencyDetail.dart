import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EmergencyDetailPage extends StatefulWidget {
  final String id;
  final String title;
  final String number;
  final String patient_name;
  final String basic_and_advance_type;
  final String zip_code;
  final String status;

  const EmergencyDetailPage({
    Key? key,
    required this.id,
    required this.title,
    required this.number,
    required this.patient_name,
    required this.basic_and_advance_type,
    required this.zip_code,
    required this.status,
  }) : super(key: key);

  @override
  _EmergencyDetailPageState createState() => _EmergencyDetailPageState();
}

class _EmergencyDetailPageState extends State<EmergencyDetailPage> {
  String? selectedStatus;
  final List<String> statusOptions = ['waiting_list', 'accept', 'complete'];

  Future<void> _updateStatus() async {
    final response = await http.post(
      Uri.parse('$Url/admin/status_update.php'),
      body: {
        'id': widget.id,  // Emergency ID
        'status': selectedStatus ?? widget.status,  // Selected status
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, handle the success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Status updated successfully')),
      );
    } else {
      // If the server returns any error response, handle the error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Emergency Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Field', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Value', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Hospital Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.title),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Emergency Number'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.number),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Patient Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.patient_name),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Zip Code'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.zip_code),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Basic and Advance Type'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.basic_and_advance_type),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Status'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        value: selectedStatus,
                        hint: Text('Select Status'),
                        isExpanded: true,
                        items: statusOptions.map((String status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStatus = newValue;
                          });
                          _updateStatus(); // Call update status function
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
