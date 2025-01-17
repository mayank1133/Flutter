//Write a flutter code scroll whole screen content using single child scrollview.

import 'package:flutter/material.dart';

class CityListScreen extends StatelessWidget {
  CityListScreen({super.key});

  List<String> cities = [
    'Ahmedabad',
    'Surat',
    'Vadodara',
    'Rajkot',
    'Bhavnagar',
    'Gandhinagar',
    'Junagadh',
    'Nadiad',
    'Anand',
    'Vapi',
    'Navsari',
    'Mehsana',
    'Patan',
    'Morbi',
    'Godhra',
    'Amreli',
    'Palitana',
    'Dahej',
    'Bharuch',
    'Dahod',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("City List "),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: cities.map((city) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(city, style: TextStyle(fontSize: 20)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
