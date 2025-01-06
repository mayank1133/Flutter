import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BirthdayCard(),
    );
  }
}

class BirthdayCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Birthday Card"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Birthday image (optional)
            Container(
              height: 500,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/Lab-8/birthdaycard.dart'), // Replace with your image path
                  fit: BoxFit.contain,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            SizedBox(height: 20), // Spacing between image and text

            // Birthday message
            Text(
              'Happy Birthday Mayank',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.purple,
                fontFamily: 'Cursive',
              ),
            ),
            SizedBox(height: 10), // Spacing between text and subheading

            Text(
              'Wishing you a day filled with love, joy, and laughter!',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30), // Space for decorative elements

            // Birthday Card Decorations (balloons, hearts, etc.)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, color: Colors.red, size: 40),
                SizedBox(width: 10),
                Icon(Icons.card_giftcard, color: Colors.green, size: 40),
                SizedBox(width: 10),
                Icon(Icons.cake, color: Colors.orange, size: 40),
              ],
            ),
            SizedBox(height: 30), // Space at the bottom

            // Footer or Closing message
            Text(
              'Have a fantastic celebration!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black45,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
