import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'matrimonial.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE users (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          fullName TEXT,
          email TEXT UNIQUE,
          mobile TEXT,
          dob TEXT,
          city TEXT,
          gender TEXT,
          hobbies TEXT,
          password TEXT,  -- ✅ Added password column
          isFavorite INTEGER DEFAULT 0
        )
      ''');
      },
    );
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    try {
      final db = await database;
      int result = await db.insert('users', user, conflictAlgorithm: ConflictAlgorithm.replace);
      print("User inserted successfully: $result"); // Debugging log
      return result;
    } catch (e) {
      print("Error inserting user: $e"); // Debugging log
      return -1; // Return error code
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> users = await db.query('users');
    print("Fetched Users: $users"); // Debugging log
    return users;
  }

  Future<int> updateUser(Map<String, dynamic> user, int id) async {
    final db = await database;
    return await db.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getFavoriteUsers() async {
    final db = await database;
    return await db.query('users', where: 'isFavorite = ?', whereArgs: [1]);
  }
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query("users", where: "email = ?", whereArgs: [email]);
    return result.isNotEmpty ? result.first : null;
  }

}
