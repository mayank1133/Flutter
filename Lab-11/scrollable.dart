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
        title: Text('City List'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cities[index],style: TextStyle(fontSize: 100),),
          );
        },
      ),
    );
  }
}



