import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image/Provider.dart';
import 'package:image/Screen/HomeScreen.dart';
import 'package:image/Screen/LoginScreen.dart';
import 'package:provider/provider.dart';

// import 'package:my_app/screen/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance.currentUser;
    return ChangeNotifierProvider(
      create: (context) => ShareProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: auth != null ? HomePage() : LoginPage(),
      ),
    );
  }
}
