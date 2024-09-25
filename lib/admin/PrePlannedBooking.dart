import 'dart:convert';
import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'PreplannedBookingDetail.dart';

class PrePlannedBooking extends StatefulWidget {
  const PrePlannedBooking({super.key});

  @override
  _PrePlannedBookingState createState() => _PrePlannedBookingState();
}

class _PrePlannedBookingState extends State<PrePlannedBooking> {
  List<dynamic> preplannedData = [];

  @override
  void initState() {
    super.initState();
    fetchPreplannedData();
  }

  Future<void> fetchPreplannedData() async {
    try {
      final response = await http.get(Uri.parse('$Url/admin/fetch_pre_planned_bookings.php'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          preplannedData = data;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pre-Planned Bookings'),
      ),
      body: preplannedData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: preplannedData.length,
        itemBuilder: (context, index) {
          final item = preplannedData[index];
          return ListTile(
            title: Text(item['patient_name'] ?? 'Unknown'),
            subtitle: Text(item['contact_number'] ?? 'No contact number'),
            trailing: IconButton(
              icon: const Icon(Icons.info),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PreplannedBookingDetail(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
