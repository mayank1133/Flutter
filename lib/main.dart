import 'package:flutter/material.dart';
import 'package:matrimonial_app/screens/dashboard.dart';
import 'dart:convert'; // ✅ Required for json.encode() & json.decode()
import 'package:http/http.dart' as http; // ✅ Required for HTTP requests
import 'package:matrimonial_app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ For Shared Preferences (if needed)


void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures async operations complete
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashBoard(),
    );
  }
}

