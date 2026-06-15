import 'package:flutter/material.dart';
import 'screeens/onboardning/welcome_screen.dart';

void main() {
  runApp(const InnerSkyApp());
}

class InnerSkyApp extends StatelessWidget {
  const InnerSkyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InnerSky',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const WelcomeScreen(),
    );
  }
}
