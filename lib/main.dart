import 'package:flutter/material.dart';
import 'package:image/Screen/HomeScreen.dart';
import 'package:image/Screen/LoginScreen.dart';
import 'package:image/photo.dart';
// import 'package:my_app/screen/signin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
