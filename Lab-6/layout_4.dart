import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Layout4 extends StatelessWidget {
  const Layout4({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(title: Text("1.Write a flutter code to divide horizontal space of screen in 3 different equal parts with different colors."),backgroundColor: Colors.white,),
        body: Row(
            children: [
              Expanded(
                child:Column(
                  children: [
                    Expanded(flex:1,child:Container(color: Colors.purple,)),
                    Expanded(flex:1,child:Container(color: Colors.blue,),),
                    Expanded(flex:1,child:Container(color: Colors.lightBlue,),),
                  ],
                ),
              ),
              Expanded(
                child:Column(
                  children: [
                    Expanded(flex:2,child:Container(color: Colors.red,),),
                    Expanded(flex:2,child:Container(color: Colors.redAccent,),),
                    Expanded(flex:1,child:Container(color: Colors.green,),),
                  ],
                ),
              ),
              Expanded(
                child:Column(
                  children: [
                    Expanded(flex:1,child:Container(color: Colors.green,),),
                    Expanded(flex:2,child:Container(color: Colors.lightGreen,),),
                    Expanded(flex:3,child:Container(color: Colors.lightGreenAccent,),),
                  ],
                ),
              ),
            ])
    );
  }
}
