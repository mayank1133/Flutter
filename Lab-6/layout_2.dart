import 'package:flutter/material.dart';

class Layout2 extends StatelessWidget {
  const Layout2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("1.Write a flutter code to divide Vertical space of screen in 3 different equal parts with different colors."),backgroundColor: Colors.red,),
      body: Column(
        children: [
          Expanded(child:Container(color: Colors.blue,),),
          Expanded(child:Container(color: Colors.white,),),
          Expanded(child:Container(color: Colors.green,),),
        ],
      ),
    );
  }
}

