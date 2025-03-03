import 'package:flutter/material.dart';
import 'package:matrimonial_app/screens/dashboard.dart';
import 'package:matrimonial_app/screens/login.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matrimonial App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashBoard(),
    );
  }
}
