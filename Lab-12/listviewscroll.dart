//Write a flutter code to use listview/gridview inside single child scrollview.

import 'package:flutter/material.dart';

class CityListInScroll extends StatelessWidget {
  CityListInScroll({super.key});

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
        title: Text("Cities in ListView/GridView"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 500, // Height for ListView
              child: ListView.builder(
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(cities[index],style: TextStyle(fontSize: 50),),
                  );
                },
              ),
            ),
            Container(
              height: 500, // Height for GridView
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: cities.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Center(child: Text(cities[index])),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
