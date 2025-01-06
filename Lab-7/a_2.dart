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
          title: Text('Custom Font Example by KK'),
        ),
        body: Center(
          child: CustomTextWidget(),
        ),
      ),
    );
  }
}

class CustomTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Hello World with Custom Font!',
      style: TextStyle(
        fontFamily: 'Roboto', // Custom font
        fontSize: 30,         // Text size
        fontWeight: FontWeight.bold, // Text weight
        color: Colors.purple, // Text color
      ),
    );
  }
}




