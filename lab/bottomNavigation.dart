import 'package:flutter/material.dart';
import 'Page1.dart';
import 'Page2.dart';
import 'Home.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _DemoState();
}

class _DemoState extends State<BottomNavigation> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      Home(),Page1(),Page2()
    ];
    return Scaffold(
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
          BottomNavigationBarItem(icon: Icon(Icons.abc_outlined),label: "Page1"),
          BottomNavigationBarItem(icon: Icon(Icons.ac_unit_sharp),label: "Page2"),
        ],
      ),
    );
  }
}