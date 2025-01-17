import 'package:flutter/material.dart';
import 'Page1.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Home",
              style: TextStyle(fontSize: 100,color: Colors.orange),

            ),
          ),
          ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 200,
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(child:
                      Text(
                        "Home",
                        style: TextStyle(fontSize: 25 ,color: Colors.orange),)),
                    );
                  },
                );
              },
              child: Text(
                  "Show",
                style: TextStyle(fontSize: 25 ,color: Colors.orange),
              )
          )
        ],
      ),
    );
  }
}