//Write a flutter code to create login screen login for username & password using Textfield,
// Button etc.,

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey _key = new GlobalKey<FormState>();
  TextEditingController nameCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FORM'),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.red,
            ),
            height: 550,
            width: 450,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Login"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: nameCont,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            label: Text("User Name"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: passCont,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(),
                            label: Text("Password"),
                          ),

                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
