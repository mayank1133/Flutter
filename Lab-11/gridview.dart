import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ViewTogglePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ViewTogglePage extends StatefulWidget {
  @override
  _ViewTogglePageState createState() => _ViewTogglePageState();
}

class _ViewTogglePageState extends State<ViewTogglePage> {
  bool _isListView = true;

  // Sample data
  final List<String> data = List.generate(20, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toggle ListView/GridView"),
        actions: [
          Switch(
            value: _isListView,
            onChanged: (value) {
              setState(() {
                _isListView = value;
              });
            },
          ),
        ],
      ),
      body: _isListView ? _buildListView() : _buildGridView(),
    );
  }

  // Method to build ListView
  Widget _buildListView() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(data[index]),
        );
      },
    );
  }

  // Method to build GridView
  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns in the grid
      ),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.all(8),
          child: Center(
            child: Text(data[index]),
          ),
        );
      },
    );
  }
}
