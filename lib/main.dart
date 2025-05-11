import 'package:flutter/material.dart';
import 'package:regreenai/splash_screen.dart';
import 'package:regreenai/login.dart';
import 'package:regreenai/signup.dart';
import 'package:regreenai/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Farm App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const HomePage(),
      // routes: {
      //   '/signup': (context) => const SignUpPage(),
      //   '/login': (context) => const LoginPage(),
      // },
    );
  }
}
