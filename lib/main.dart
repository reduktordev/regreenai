import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:regreenai/splash_screen.dart';
import 'package:regreenai/login.dart';
import 'package:regreenai/signup.dart';
import 'package:regreenai/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    print('Environment variables loaded: AI_API');
  } catch (e) {
    print('Error loading environment variables: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Farm App',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const SplashScreen(),
      routes: {
        '/signup': (context) => const SignUpPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
