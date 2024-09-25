import 'dart:convert';
import 'package:esavier/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AmbulanceForm extends StatefulWidget {
  @override
  _AmbulanceFormState createState() => _AmbulanceFormState();
}

class _AmbulanceFormState extends State<AmbulanceForm> {
  final _formKey = GlobalKey<FormState>();
  String? hospitalName, mobile, ambulanceType, zipCode, status, driverId;
  List<Map<String, dynamic>> drivers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchDrivers();
  }

  Future<void> fetchDrivers() async {
    try {
      final response = await http.get(Uri.parse('$Url/admin/get_drivers.php'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          drivers = List<Map<String, dynamic>>.from(data);
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        _showSnackBar('Failed to fetch drivers');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showSnackBar('Error fetching drivers');
    }
  }

  Future<void> addAmbulance() async {
    final response = await http.post(
      Uri.parse('$Url/admin/add_ambulance.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'hospital_name': hospitalName,
        'mobile': mobile,
        'ambulance_type': ambulanceType,
        'zip_code': zipCode,
        'driver_id': driverId,
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['success']) {
        _showSnackBar('Ambulance added successfully!');
        _formKey.currentState!.reset();
        setState(() {
          driverId = null;
        });
      } else {
        _showSnackBar(data['error']);
      }
    } else {
      _showSnackBar('Server error. Please try again.');
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Ambulance"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Hospital Name'),
                  onSaved: (value) => hospitalName = value,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter hospital name' : null,
                ),
                SizedBox(height: 10),
                isLoading
                    ? CircularProgressIndicator()
                    : DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Driver Name'),
                  items: drivers.map((driver) {
                    return DropdownMenuItem<String>(
                      value: driver['id'],
                      child: Text(driver['name']),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      driverId = value;
                    });
                  },
                  value: driverId,
                  validator: (value) => value == null ? 'Please select a driver' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Mobile Address'),
                  onSaved: (value) => mobile = value,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter mobile address' : null,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Ambulance Type'),
                  items: [
                    DropdownMenuItem(value: 'Basic Life Support', child: Text('Basic Life Support')),
                    DropdownMenuItem(value: 'Advanced Life Support', child: Text('Advanced Life Support')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      ambulanceType = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select ambulance type' : null,
                ),
                SizedBox(height: 10),
                TextFormField(
                  decoration: InputDecoration(labelText: 'ZIP Code'),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => zipCode = value,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter ZIP code' : null,
                ),
                SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Status'),
                  items: [
                    DropdownMenuItem(value: 'Available', child: Text('Available')),
                    DropdownMenuItem(value: 'Unavailable', child: Text('Unavailable')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      status = value;
                    });
                  },
                  validator: (value) => value == null ? 'Please select status' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      addAmbulance();
                    }
                  },
                  child: Text('Add Ambulance'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
