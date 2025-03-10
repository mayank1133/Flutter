import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = p.join(await getDatabasesPath(), 'users.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        fullname TEXT,
        email TEXT,
        age INTEGER,
        mobile_number TEXT
      )
    ''');
  }

  // Insert a new user
  Future<int> insertUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.insert('users', user);
  }

  // Get all users
  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await database;
    return await db.query('users');
  }

  // Update a user
  Future<int> updateUser(Map<String, dynamic> user) async {
    Database db = await database;
    return await db.update(
      'users',
      user,
      where: 'id = ?',
      whereArgs: [user['id']],
    );
  }

  // Delete a user
  Future<int> deleteUser(int id) async {
    Database db = await database;
    return await db.delete(
      'users',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserList(),
    );
  }
}

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _refreshUserList();
  }

  void _refreshUserList() async {
    final data = await _dbHelper.getUsers();
    setState(() {
      _users = data;
    });
  }

  String _fullname = '';
  String _email = '';
  String _age = '';
  String _mobileNumber = '';

  void _addUser() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Full Name'),
              onChanged: (value) => _fullname = value,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) => _email = value,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _age = value,
            ),
            TextField(
              decoration: InputDecoration(hintText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) => _mobileNumber = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_fullname.isNotEmpty && _email.isNotEmpty && _age.isNotEmpty && _mobileNumber.isNotEmpty) {
                await _dbHelper.insertUser({
                  'fullname': _fullname,
                  'email': _email,
                  'age': int.parse(_age),
                  'mobile_number': _mobileNumber,
                });
                _refreshUserList();
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  void _editUser(Map<String, dynamic> user) async {
    _fullname = user['fullname'];
    _email = user['email'];
    _age = user['age'].toString();
    _mobileNumber = user['mobile_number'];

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: _fullname),
              decoration: InputDecoration(hintText: 'Full Name'),
              onChanged: (value) => _fullname = value,
            ),
            TextField(
              controller: TextEditingController(text: _email),
              decoration: InputDecoration(hintText: 'Email'),
              onChanged: (value) => _email = value,
            ),
            TextField(
              controller: TextEditingController(text: _age),
              decoration: InputDecoration(hintText: 'Age'),
              keyboardType: TextInputType.number,
              onChanged: (value) => _age = value,
            ),
            TextField(
              controller: TextEditingController(text: _mobileNumber),
              decoration: InputDecoration(hintText: 'Mobile Number'),
              keyboardType: TextInputType.phone,
              onChanged: (value) => _mobileNumber = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (_fullname.isNotEmpty && _email.isNotEmpty && _age.isNotEmpty && _mobileNumber.isNotEmpty) {
                await _dbHelper.updateUser({
                  'id': user['id'],
                  'fullname': _fullname,
                  'email': _email,
                  'age': int.parse(_age),
                  'mobile_number': _mobileNumber,
                });
                _refreshUserList();
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteUser(int id) async {
    await _dbHelper.deleteUser(id);
    _refreshUserList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user['fullname']),
            subtitle: Text('Email: ${user['email']}, Age: ${user['age']}, Mobile: ${user['mobile_number']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editUser(user),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteUser(user['id']),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addUser,
        child: Icon(Icons.add),
      ),
    );
  }
}
