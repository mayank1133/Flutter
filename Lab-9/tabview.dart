//Write a flutter code to use TabView and display different pages on different tab clicks.
import 'package:flutter/material.dart';

import '../Lab-6/layout_1.dart';
import '../Lab-6/layout_3.dart';
import '../Lab-6/layout_4.dart';
import '../Lab-7/a_2.dart';
import '../Lab-7/a_3.dart';
import '../Lab-7/text_1.dart';
import '../Lab-8/asset_img.dart';
import '../Lab-8/stsck_img.dart';

class Tabview extends StatelessWidget {
  const Tabview({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 6,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Tab View'),
            backgroundColor: Colors.lightBlue,
            bottom: TabBar(

              tabs: [
                Tab(
                  icon: Icon(Icons.home_filled),
                  text: "Home",
                ),
                Tab(
                  icon: Icon(Icons.add_business),
                  text: "Shop",
                ),
                Tab(
                  icon: Icon(Icons.account_box_outlined),
                  text: "Account",
                ),
                Tab(
                  icon: Icon(Icons.alarm),
                  text: "Alarm",
                ),
                Tab(
                  icon: Icon(Icons.accessibility),
                  text: "Accessibility",
                ),
                Tab(
                  icon: Icon(Icons.ac_unit_sharp),
                  text: "Feedback",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(child: Layout4()),
              Center(child: Layout()),
              Center(child: Layout3()),
              Center(child: MyHomePage()),
              Center(child: CustomTextWidget()),
              Center(child: MyText()),
            ],
          ),
        )
    );
  }
}
