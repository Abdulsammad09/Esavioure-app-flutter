  import 'package:esavier/main.dart';
  import 'package:esavier/splash.dart';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:shared_preferences/shared_preferences.dart';
  import 'dart:convert';
  // Import your main file or the file containing the login screen.
  
  class ProfileScreen extends StatefulWidget {
    @override
    _ProfileScreenState createState() => _ProfileScreenState();
  }
  
  class _ProfileScreenState extends State<ProfileScreen> {
    String name = '';
    String email = '';
    String phone = '';
    bool isLoading = true;
    String errorMessage = '';
  
    @override
    void initState() {
      super.initState();
      fetchUserProfile();
    }
  
    Future<void> fetchUserProfile() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
  
      if (userId == null) {
        setState(() {
          isLoading = false;
          errorMessage = 'User ID not found.';
        });
        return;
      }
  
      try {
        final response = await http.get(Uri.parse('$Url/user/get_profile_data.php?id=$userId'));
  
        print('API URL: $Url/user/get_profile_data.php?id=$userId'); // Debugging
  
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          print('Response body: ${response.body}'); // Debugging
  
          if (data['success']) {
            setState(() {
              name = data['user']['name'];
              email = data['user']['email'];
              phone = data['user'].containsKey('phone') ? data['user']['phone'] : 'N/A';
              isLoading = false;
            });
          } else {
            setState(() {
              isLoading = false;
              errorMessage = data['message'];
            });
          }
        } else {
          setState(() {
            isLoading = false;
            errorMessage = 'Failed to load profile data.';
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
          errorMessage = 'An error occurred while fetching profile data: $e';
        });
      }
    }
  
    Future<void> logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear(); // Clear all stored user data
  
      // Navigate to the login screen and remove all previous routes
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()), // Replace LoginScreen with your actual login screen
            (Route<dynamic> route) => false,
      );
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.red,
          elevation: 0,
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : errorMessage.isNotEmpty
            ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.red)))
            : Column(
          children: [
            // Profile Header Section
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Colors.red,
                      size: 60,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    name.isNotEmpty ? name : 'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // Profile Information Section
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(16),
                children: [
                  _buildProfileInfoItem(Icons.person, name),
                   // Update with actual data if available
                  _buildProfileInfoItem(Icons.phone, phone),
                   // Add actual data if available
                  _buildProfileInfoItem(Icons.email, email),
                  // Handle this securely
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        // Edit profile action
                      },
                      child: Text(
                        'Edit profile',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        logout(); // Logout action
                      },
                      child: Text(
                        'Logout',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  
    Widget _buildProfileInfoItem(IconData icon, String info) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.red),
            SizedBox(width: 20),
            Text(
              info.isNotEmpty ? info : 'Loading...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }
  }
