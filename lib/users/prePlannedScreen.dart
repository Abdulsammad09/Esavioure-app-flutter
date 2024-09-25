import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Preplannedscreen extends StatefulWidget {
  const Preplannedscreen({super.key});

  @override
  _PreplannedscreenState createState() => _PreplannedscreenState();
}

class _PreplannedscreenState extends State<Preplannedscreen> {
  final _formKey = GlobalKey<FormState>();

  String? hospitalName;
  String? driverName;
  String? patientName;
  String? pickupLocation;
  String? dropoffLocation;
  String? contactNumber;
  DateTime? appointmentDate; // Change to DateTime
  String? serviceType;
  String? specialRequirements;

  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final response = await http.post(
        Uri.parse('$Url/user/add_pre_planned.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'hospital_name': hospitalName,
          'driver_name': driverName,
          'patient_name': patientName,
          'pickup_location': pickupLocation,
          'dropoff_location': dropoffLocation,
          'contact_number': contactNumber,
          'appointment_date': appointmentDate != null
              ? '${appointmentDate!.toIso8601String()}'
              : null, // Convert DateTime to String in ISO format
          'service_type': serviceType,
          'special_requirements': specialRequirements,
        }),
      );

      final responseData = json.decode(response.body);
      if (response.statusCode == 200 && responseData['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Data submitted successfully')),
        );
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${responseData['message']}')),
        );
      }
    }
  }

  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          appointmentDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Hospital Name',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter hospital name';
                    }
                    return null;
                  },
                  onSaved: (value) => hospitalName = value,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Driver Name',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter driver name';
                    }
                    return null;
                  },
                  onSaved: (value) => driverName = value,
                ),
                const SizedBox(height: 10),
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
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Pickup Location',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pickup location';
                    }
                    return null;
                  },
                  onSaved: (value) => pickupLocation = value,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Dropoff Location',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter dropoff location';
                    }
                    return null;
                  },
                  onSaved: (value) => dropoffLocation = value,
                ),
                const SizedBox(height: 10),
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
                    return null;
                  },
                  onSaved: (value) => contactNumber = value,
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _selectDateTime(context),
                  child: AbsorbPointer(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: appointmentDate == null
                            ? 'Appointment Date (tap to select)'
                            : 'Appointment Date: ${appointmentDate!.toLocal()}',
                        labelStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (appointmentDate == null) {
                          return 'Please select appointment date';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Service Type',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter service type';
                    }
                    return null;
                  },
                  onSaved: (value) => serviceType = value,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Special Requirements',
                    labelStyle: TextStyle(color: Colors.red),
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) => specialRequirements = value,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitData,
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
