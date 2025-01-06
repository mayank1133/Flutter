import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatefulWidget {
  const MyText({super.key});

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  TextEditingController nameCont= TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameCont,
                decoration: InputDecoration(border:OutlineInputBorder()),
              ),
            ),
          ),
          ElevatedButton(onPressed: (){
            print(nameCont.text);
            setState(() {
              nameCont.text=nameCont.text;
            });
          }, child: Text("Submit")),
          Text(nameCont.text,style: TextStyle(fontSize: 100,fontFamily: "Mayank"))
      ]),
    );
  }
}
