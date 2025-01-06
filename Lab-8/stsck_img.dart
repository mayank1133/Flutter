import 'package:flutter/material.dart';

class MyStackImage extends StatelessWidget {
  const MyStackImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Using Stack'),),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/stack img.jpg',fit: BoxFit.contain,),
          Text('This is Text'),
        ],
      ),
    );
  }
}
