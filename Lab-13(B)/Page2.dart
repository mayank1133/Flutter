import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Column(
      children: [
        Center(child: Text("Contact",style: TextStyle(fontSize: 100,color: Colors.orange),
          )
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
                      "Contact",
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
    )
    );
  }
}