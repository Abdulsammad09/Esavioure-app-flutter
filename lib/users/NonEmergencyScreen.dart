import 'dart:convert';
import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NonEmergencyScreen extends StatefulWidget {
  const NonEmergencyScreen({super.key});

  @override
  _NonEmergencyScreenState createState() => _NonEmergencyScreenState();
}

class _NonEmergencyScreenState extends State<NonEmergencyScreen> {
  final _formKey = GlobalKey<FormState>();

  String? hospitalName;
  String? selectedTime;
  String? patientName;
  String? contactNumber;
  String? specialRequirements;

  // List of hospitals for the dropdown
  final List<String> hospitals = [
    'Hospital A',
    'Hospital B',
    'Hospital C',
    'Hospital D',
  ];

  // List of time intervals for the dropdown
  final List<String> timeIntervals = [
    '30 minutes',
    '1 hour',
  ];

  // Function to submit the form data
  Future<void> submitData() async {
    final url = Uri.parse('$Url/user/add_non_emergency.php'); // Replace with your server URL

    try {
      final response = await http.post(
        url,
        body: {
          'hospital_name': hospitalName!,
          'driver_name': selectedTime!, // Use selectedTime for driver time
          'patient_name': patientName!,
          'contact_number': contactNumber!,
          'special_requirements': specialRequirements ?? '',
        },
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Data submitted successfully')),
          );
          // Optionally, clear the form
          _formKey.currentState!.reset();
          setState(() {
            hospitalName = null;
            selectedTime = null; // Reset selectedTime
          });
        } else {
          // Show error message from server
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result['message'] ?? 'Failed to submit data')),
          );
        }
      } else {
        // Handle non-200 responses
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Server error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      // Handle network or other errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Non-Emergency'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hospital Name (Dropdown)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Hospital Name',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  value: hospitalName,
                  items: hospitals.map((hospital) {
                    return DropdownMenuItem(
                      value: hospital,
                      child: Text(hospital),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      hospitalName = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a hospital';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Driver Time (Dropdown)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Select Time Interval',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  value: selectedTime,
                  items: timeIntervals.map((time) {
                    return DropdownMenuItem(
                      value: time,
                      child: Text(time),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTime = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a time interval';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                // Patient Name
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Patient Name',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter patient name';
                    }
                    return null;
                  },
                  onSaved: (value) => patientName = value,
                  onChanged: (value) => patientName = value,
                ),
                const SizedBox(height: 10),

                // Contact Number
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a contact number';
                    }
                    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
                      return 'Please enter a valid contact number';
                    }
                    return null;
                  },
                  onSaved: (value) => contactNumber = value,
                  onChanged: (value) => contactNumber = value,
                ),
                const SizedBox(height: 10),

                // Special Requirements
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Special Requirements',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onSaved: (value) => specialRequirements = value,
                  onChanged: (value) => specialRequirements = value,
                ),
                const SizedBox(height: 20),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Save form fields
                      _formKey.currentState!.save();
                      // Submit data to the PHP backend
                      submitData();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
