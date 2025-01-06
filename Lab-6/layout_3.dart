import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Layout3 extends StatelessWidget {
  const Layout3({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("1.Write a flutter code to divide horizontal space of screen in 3 different equal parts with different colors."),backgroundColor: Colors.white,),
      body: Row(
        children: [
          Expanded(
            child:Column(
              children: [
                Expanded(child:Container(color: Colors.purple,)),
                Expanded(child:Container(color: Colors.blue,),),
                Expanded(child:Container(color: Colors.lightBlue,),),
              ],
            ),
    ),
          Expanded(
            child:Column(
              children: [
                Expanded(child:Container(color: Colors.red,),),
                Expanded(child:Container(color: Colors.redAccent,),),
                Expanded(child:Container(color: Colors.green,),),
              ],
            ),
      ),
          Expanded(
            child:Column(
              children: [
                Expanded(child:Container(color: Colors.green,),),
                Expanded(child:Container(color: Colors.lightGreen,),),
                Expanded(child:Container(color: Colors.lightGreenAccent,),),
              ],
            ),
          ),
    ])
    );
  }
}
