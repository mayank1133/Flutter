import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mayank/Lab-13(B)/pages.dart';

class BottomNavigations extends StatefulWidget {
  const BottomNavigations({super.key});

  @override
  State<BottomNavigations> createState() => _BottomNavigationsState();
}

class _BottomNavigationsState extends State<BottomNavigations> {
  int idx=0;
  @override
  List<Widget> list = [
    Home(name: "Home"),
    About(name:"About"),
    Contact(name:"Contact")
  ];
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("This is Bottom NavigationBar"),),
      body: list[idx],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: idx,
        onTap: (value) {
          setState(() {
            idx = value;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.abc_outlined),label: "About"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit_sharp),label: "Contact"),
        ],
      ),
    );
  }
}
