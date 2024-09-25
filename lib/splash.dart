import 'package:esavier/auth/LoginScreen.dart';
import 'package:esavier/auth/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'main.dart'; // Assuming your MainScreen is in main.dart

import 'admin/Dashboard.dart';
import 'users/HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playSound();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Timer(const Duration(seconds: 5), () {
      if (isLoggedIn) {
        String userRole = prefs.getString('userRole') ?? 'user';

        // Navigate based on user role
        if (userRole == 'admin') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminDashboard()),
          );
        } else if (userRole == 'user') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (userRole == 'driver') {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DriverScreen()),
          );
        } else {
          // Fallback to MainScreen if role is unrecognized
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      } else {
        // Navigate to MainScreen if not logged in
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    });
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.setSource(AssetSource('audio/b.mp3')); // Corrected path
      await _audioPlayer.setVolume(1.0);
      await _audioPlayer.resume();
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween<double>(
              begin: MediaQuery.of(context).size.width,
              end: -200,
            ),
            duration: const Duration(seconds: 4),
            builder: (context, value, child) {
              return Positioned(
                left: value,
                top: MediaQuery.of(context).size.height * 0.4,
                child: child!,
              );
            },
            child: Image.asset(
              'assets/images/ambulance2.png',
              height: 150,
            ),
          ),
        ],
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Esaviour',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image at the top
            Image.asset(
              'assets/images/ambulance.jpg',
              width: 800, // Adjust width as needed
              height: 200, // Adjust height as needed
            ),
            SizedBox(height: 20),
            // Title text
            // Text(
            //   'Esaviour',
            //   style: Theme.of(context).textTheme.headlineSmall,
            // ),
            SizedBox(height: 40),
            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Loginscreen()),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 20),
            // Register Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Registerscreen()),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
