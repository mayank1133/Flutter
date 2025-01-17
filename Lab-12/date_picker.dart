//Write a flutter code get date frod date picker dialog and display in textview.
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  @override
  _DatePickerExampleState createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePicker> {
  String selectedDate = "Select a date";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Date Picker",style: TextStyle(fontSize: 50),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextButton(
              onPressed: () => _selectDate(context),
              child: Text("Pick a date",style: TextStyle(fontSize: 50),),
            ),
            SizedBox(height: 200),
            Text(
              "Selected Date: $selectedDate",
              style: TextStyle(fontSize: 50),
            ),
          ],
        ),
      ),
    );
  }
}
