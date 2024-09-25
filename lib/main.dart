import 'package:esavier/splash.dart';
import 'package:flutter/material.dart';
import 'auth/LoginScreen.dart';
import 'auth/RegisterScreen.dart';

var Url = 'http://192.168.10.156/esaviour/';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ambulance App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.red,
          onPrimary: Colors.white,
          secondary: Colors.redAccent,
        ),
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headlineSmall: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red,
            fontSize: 24,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            textStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}


