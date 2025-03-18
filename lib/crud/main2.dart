import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserScreen(),
    );
  }
}

class User {
  String id;
  String name;
  String email;
  String age; // Change to String for API compatibility
  String mobile;

  User({required this.id, required this.name, required this.email, required this.age, required this.mobile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      age: json['age'].toString(), // Ensure age is a string
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'age': age, 'mobile': mobile};
  }
}

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final String apiUrl = "https://67cc3ba1dd7651e464eb5e6e.mockapi.io/users";
  List<User> users = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String? editingUserId;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      setState(() {
        users = body.map((json) => User.fromJson(json)).toList();
      });
    }
  }

  Future<void> addUser() async {
    if (nameController.text.isEmpty || emailController.text.isEmpty || ageController.text.isEmpty || mobileController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("All fields are required")));
      return;
    }

    final user = User(id: '', name: nameController.text, email: emailController.text, age: ageController.text, mobile: mobileController.text);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      await fetchUsers(); // Ensure UI updates correctly
      clearFields();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to add user")));
    }
  }

  Future<void> updateUser() async {
    if (editingUserId == null) return;

    final user = User(id: editingUserId!, name: nameController.text, email: emailController.text, age: ageController.text, mobile: mobileController.text);
    final response = await http.put(
      Uri.parse("$apiUrl/${user.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      await fetchUsers();
      clearFields();
    }
  }

  Future<void> deleteUser(String id) async {
    final response = await http.delete(Uri.parse("$apiUrl/$id"));
    if (response.statusCode == 200) {
      setState(() {
        users.removeWhere((user) => user.id == id);
      });
    }
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    ageController.clear();
    mobileController.clear();
    setState(() {
      editingUserId = null;
    });
  }

  void setUserForEdit(User user) {
    nameController.text = user.name;
    emailController.text = user.email;
    ageController.text = user.age;
    mobileController.text = user.mobile;
    setState(() {
      editingUserId = user.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Management")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: ageController, decoration: InputDecoration(labelText: "Age"), keyboardType: TextInputType.number),
            TextField(controller: mobileController, decoration: InputDecoration(labelText: "Mobile"), keyboardType: TextInputType.phone),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: editingUserId == null ? addUser : updateUser,
              child: Text(editingUserId == null ? "Add User" : "Update User"),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(user.name, style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text("Email: ${user.email}\nAge: ${user.age}\nMobile: ${user.mobile}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: () => setUserForEdit(user)),
                          IconButton(icon: Icon(Icons.delete, color: Colors.red), onPressed: () => deleteUser(user.id)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
