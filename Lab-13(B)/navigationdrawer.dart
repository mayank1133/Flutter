import 'package:flutter/material.dart';
import 'Page1.dart';
import 'Page2.dart';
import 'Home.dart';

class BottomNavigationWithDrawer extends StatefulWidget {
  const BottomNavigationWithDrawer({super.key});

  @override
  State<BottomNavigationWithDrawer> createState() => _DemoState();
}

class _DemoState extends State<BottomNavigationWithDrawer> {
  int idx = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      Home(),
      Page1(),
      Page2(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation Drawer "),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Navigation Drawer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                setState(() {
                  idx = 0; // Set to Home page
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.abc_outlined),
              title: Text('Page1'),
              onTap: () {
                setState(() {
                  idx = 1; // Set to Page1
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.ac_unit_sharp),
              title: Text('Page2'),
              onTap: () {
                setState(() {
                  idx = 2; // Set to Page2
                });
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: list[idx],
    );
  }
}
