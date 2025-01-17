

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
String name;
Home({
  required this.name
});
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("this is Home page"),),
      body: Center(child: Text("this is $name "),),
    );
  }
}
class About extends StatelessWidget {
  String name;
  About({
    required this.name
  });
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("this is About page"),),
      body: Center(child: Text("this is $name "),),
    );
  }
}class Contact extends StatelessWidget {
  String name;
  Contact({
    required this.name
  });
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("this is Contact page"),),
      body: Center(child: Text("this is $name "),),
    );
  }
}
