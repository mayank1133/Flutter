import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Hello World From Mayank'),
        ),
        body: Center(
          child: Text(
            'Hello World',
            style: TextStyle(
              color: Colors.cyan, // Text color
              fontSize: 40,        // Text size
              fontWeight: FontWeight.bold, // Bold text
              fontStyle: FontStyle.italic, // Italic text
            ),
          ),
        ),
      ),
    );
  }
}
