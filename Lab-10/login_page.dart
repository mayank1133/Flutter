//Write a flutter code to create login screen login for username & password using Textfield,
// Button etc.,

import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  TextEditingController nameCont = TextEditingController();
  TextEditingController passCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('FORM'),
        ),
        body: Center(
          child: Form(
            key: _key,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.lightGreenAccent,
              ),
              height: 550,
              width: 450,
              child: Column(
                children: [
                  Text("Login"),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            validator: (value) {
                              if(value==null||value.isEmpty){
                                return "UserName is Required";
                              }
                              else if(value.length<=5){
                                return "Username should be greater than 5 letters";
                              }
                            },
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
                            validator: (value) {
                              if(value==null||value.isEmpty){
                                return "Password is Required";
                              }
                              else if(value.length<=8){
                                return "Password should be greater than 8 letters";
                              }
                            },
                            controller: passCont,
                            decoration: InputDecoration(
                                border:OutlineInputBorder(),
                                label: Text("Password"),
                            ),

                          ),
                        ),
                        ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: (){
                          if(_key.currentState!.validate()){
                            print("Log in successfully");
                          }                        },
                          child: Text("Submit"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
