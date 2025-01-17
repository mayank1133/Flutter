//Write a flutter code to get current date from system and format into different date formats.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateFormats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();

    String formattedDate1 = DateFormat('dd/MM/yyyy').format(now);
    String formattedDate2 = DateFormat('dd-MM-yyyy').format(now);
    String formattedDate3 = DateFormat('dd-MMM-yyyy').format(now);
    String formattedDate4 = DateFormat('dd-MM-yy').format(now);
    String formattedDate5 = DateFormat('dd MMM, yyyy').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text("Date Formats "),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('dd/MM/yyyy: $formattedDate1',style: TextStyle(fontSize: 75),),
            Text('dd-MM-yyyy: $formattedDate2',style: TextStyle(fontSize: 75),),
            Text('dd-MMM-yyyy: $formattedDate3',style: TextStyle(fontSize: 75),),
            Text('dd-MM-yy: $formattedDate4',style: TextStyle(fontSize: 75),),
            Text('dd MMM, yyyy: $formattedDate5',style: TextStyle(fontSize: 75),),
          ],
        ),
      ),
    );
  }
}
