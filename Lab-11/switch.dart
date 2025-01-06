import 'package:flutter/material.dart';

class ToggleViewScreen extends StatefulWidget {
  @override
  _ToggleViewScreenState createState() => _ToggleViewScreenState();
}

class _ToggleViewScreenState extends State<ToggleViewScreen> {
  bool _isGridView = false;
  final List<String> data = List.generate(20, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toggle View'),
        actions: [
          Switch(
            value: _isGridView,
            onChanged: (value) {
              setState(() {
                _isGridView = value;
              });
            },
          ),
        ],
      ),
      body: _isGridView
          ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  data[index],
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          );
        },
      )
          : ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: ListTile(
              contentPadding: EdgeInsets.all(8),
              title: Text(
                data[index],
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        },
      ),
    );
  }
}
