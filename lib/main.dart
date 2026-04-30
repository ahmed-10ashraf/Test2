import 'package:flutter/material.dart';
import 'package:test2/screens/home_page/home_page.dart';
import 'package:test2/screens/profile/profile_screen.dart';
import 'screens/splash_screen/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Link',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
