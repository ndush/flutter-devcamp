import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devcamp_ui/firebase_options.dart';
import 'package:flutter_devcamp_ui/screens/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          // Show a loading spinner while Firebase is initializing
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors that occur during initialization
            return Center(
              child: Text('Error initializing Firebase: ${snapshot.error}'),
            );
          } else {
            // Firebase has been initialized successfully
            return  BootstrapApp();  // Corrected the name to BootstrapApp
          }
        },
      ),
    );
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      throw Exception('Unable to initialize Firebase: $e');
    }
  }
}
