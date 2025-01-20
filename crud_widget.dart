import 'package:flutter/material.dart';

class User {
  List<Map<String, dynamic>> userDetail = [];

  // Adding user
  void add_User(String name, String mail, int age) {
    Map<String, dynamic> map = Map();
    map['Name'] = name;
    map['Age'] = age;
    map['Email'] = mail;
    userDetail.add(map);
  }

  // Update user
  void update_user(String name, String mail, int age, int idx) {
    Map<String, dynamic> map = Map();
    map['Name'] = name;
    map['Age'] = age;
    map['Email'] = mail;
    userDetail[idx] = map;
  }

  // Delete user
  void delete_user(int idx) {
    userDetail.removeAt(idx);
  }

  // Get all user details
  List<Map<String, dynamic>> getUser_details() {
    return userDetail;
  }
}

void main() {
  runApp(MyCrud());
}

class MyCrud extends StatefulWidget {
  const MyCrud({Key? key}) : super(key: key);

  @override
  State<MyCrud> createState() => _MyCrudState();
}

class _MyCrudState extends State<MyCrud> {
  User userlist1 = User();
  var name = TextEditingController();
  var mail = TextEditingController();
  var age = TextEditingController();
  bool isEditing = false;
  int? editingIndex;

  // Function to add or update user
  void _addOrUpdateUser() {
    setState(() {
      if (isEditing) {
        // Update the existing user
        userlist1.update_user(name.text, mail.text, int.parse(age.text), editingIndex!);
        setState(() {
          isEditing = false; // Reset editing mode
          editingIndex = null;
        });
      } else {
        // Add new user
        userlist1.add_User(name.text, mail.text, int.parse(age.text));
      }

      setState(() {}); // Refresh UI
      // Clear the text fields after operation
      name.clear();
      mail.clear();
      age.clear();
    });
  }

  // Function to start editing a user
  void _startEditing(int index) {
    setState(() {
      isEditing = true;
      editingIndex = index;
      name.text = userlist1.getUser_details()[index]['Name'];
      mail.text = userlist1.getUser_details()[index]['Email'];
      age.text = userlist1.getUser_details()[index]['Age'].toString();
    });
  }

  // Function to delete user
  void _deleteUser(int index) {
    userlist1.delete_user(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.teal,
        textTheme: TextTheme(
          bodyText1: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.teal),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("User Registration Form"),
          backgroundColor: Colors.teal,
        ),
        body: Center(
          child: Container(
            height: 500, // Fixed height of the container
            width: 350, // Fixed width of the container
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white, // Background color of the container
              borderRadius: BorderRadius.circular(15), // Rounded corners for the container
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 6), // Shadow position
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // TextFields for adding or editing user
                _buildTextField(name, 'Name'),
                SizedBox(height: 16),
                _buildTextField(mail, 'Email'),
                SizedBox(height: 16),
                _buildTextField(age, 'Age', keyboardType: TextInputType.number),
                SizedBox(height: 24),
                // Add or Update button
                ElevatedButton(
                  onPressed: _addOrUpdateUser,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: Text(isEditing ? 'Update User' : 'Add User', style: TextStyle(fontSize: 16)),
                ),
                SizedBox(height: 24),
                // Displaying users and editing them directly
                Expanded(
                  child: ListView.builder(
                    itemCount: userlist1.getUser_details().length,
                    itemBuilder: (context, index) {
                      final user = userlist1.getUser_details()[index];
                      return _buildUserItem(context, user, index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method to create text fields
  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
    );
  }

  // Helper method to build a user item widget
  Widget _buildUserItem(BuildContext context, Map<String, dynamic> user, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
          user['Name'],
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(
          'Email: ${user['Email']}\nAge: ${user['Age']}',
          style: TextStyle(fontSize: 14),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Edit user
            IconButton(
              icon: Icon(Icons.edit, color: Colors.teal),
              onPressed: () {
                _startEditing(index); // Start editing this user
              },
              tooltip: 'Edit User',
            ),
            // Delete user
            IconButton(
              icon: Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () {
                _deleteUser(index);
              },
              tooltip: 'Delete User',
            ),
          ],
        ),
      ),
    );
  }
}
