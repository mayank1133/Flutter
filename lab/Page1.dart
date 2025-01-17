import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Column(
      children: [
        Center(child: Text("Page 1",style: TextStyle(fontSize: 100,
        color: Colors.orange),)),
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        }, child: Text("Back",style: TextStyle(fontSize: 25 ,color: Colors.blueAccent)))
      ],
    )
    );
  }
}