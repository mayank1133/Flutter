import 'package:flutter/material.dart';

class BirthdayCardPage extends StatelessWidget {
  // Dynamic values for the Birthday Card
  final String name = 'John'; // Replace with dynamic data or input
  final int age = 25; // Replace with dynamic age data
  final String message = 'Wishing you a wonderful year ahead!';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Birthday, $name!'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 10.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.pink[50],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.cake,
                    size: 100,
                    color: Colors.pink,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Happy Birthday, $name!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[800],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'You are $age years old today!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.pink[600],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.pink[700],
                    ),
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Action to perform after birthday (e.g., return to home page or close)
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                    ),
                    child: Text(
                      'Back to Home',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
