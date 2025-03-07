import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/Utils/Data.dart';
import 'package:matrimonial_app/Utils/data_base_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FavUser  extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteUsers;
  final Function(int)? onRemoveFavorite;

  const FavUser ({super.key, required this.favoriteUsers, this.onRemoveFavorite});

  @override
  State<FavUser > createState() => _FavUserState();
}

class _FavUserState extends State<FavUser > {
late List<Map<String, dynamic>> favUsers;

@override
void initState() {
  super.initState();
  _loadFavoriteUsers();
}

void _loadFavoriteUsers() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? favoriteUserIds = prefs.getString('favorite_users');
  if (favoriteUserIds != null) {
    List<String> ids = favoriteUserIds.split(',');
    favUsers = await DatabaseHelper().getUsersByIds(ids);
    setState(() {
      favUsers = favUsers;
    });
  }
}

void _removeFavorite(int index) async {
  bool confirmDelete = await _showDeleteConfirmation();
  if (confirmDelete) {
    int userId = favUsers[index]['id'];

    final response = await http.put(
      Uri.parse("https://67c90cf90acf98d070887488.mockapi.io/users/$userId"),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'isFavorite': false}),
    );

    if (response.statusCode == 200) {
      setState(() {
        favUsers.removeAt(index);
      });
    }
  }
}

Future<bool> _showDeleteConfirmation() async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Remove Favorite"),
      content: const Text("Are you sure you want to remove this user from favorites?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Remove", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  ) ?? false;
}

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade300, Colors.white],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                children: [
                _buildTitleCard(),
            const SizedBox(height: 10),
            Expanded(child: _buildFavUserList()),
        ],
      ),
    ),
  ),
  ),
  );
}

Widget _buildTitleCard() {
  return Card(
    elevation: 12,
    shadowColor: Colors.pink.withOpacity(0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Column(
        children: [
          Text(
            'Favorite Profiles 💖',
            style: GoogleFonts.playfairDisplay(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Your most cherished connections, all in one place. 💕',
            style: GoogleFonts.lora(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              color: Colors.pink.shade400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget _buildFavUserList() {
  if (favUsers.isEmpty) {
    return const Center(child: Text("No favorite users found"));
  }
  return ListView.builder(
    itemCount: favUsers.length,
    itemBuilder: (context, index) {
      final user = favUsers[index];
      return ListTile(
        title: Text(user['fullName']),
        subtitle: Text(user['city']),
      );
    },
  );
}

Widget _buildDetailRow(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 5.0),
    child: Row(
      children: [
        Icon(icon, color: Colors.pink.shade300, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.lora(fontSize: 16, color: Colors.grey.shade800),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}
}