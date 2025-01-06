import 'package:flutter/material.dart';

class AssetImg extends StatelessWidget {
  const AssetImg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Asset Image'),),
      body: Center(
        child: Image.asset("assets/peacock leaf.jpg"),
      ),
    );
  }
}
