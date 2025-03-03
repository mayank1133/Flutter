import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/Utils/Data.dart';
import 'package:matrimonial_app/Utils/data_base_helper.dart';


class FavUser extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteUsers;
  final Function(int)? onRemoveFavorite;

  const FavUser({super.key, required this.favoriteUsers, this.onRemoveFavorite});

  @override
  State<FavUser> createState() => _FavUserState();
}

class _FavUserState extends State<FavUser> {
  late List<Map<String, dynamic>> favUsers;

  @override
  void initState() {
    super.initState();
    _loadFavoriteUsers();
  }

  void _loadFavoriteUsers() async {
    List<Map<String, dynamic>> users = await DatabaseHelper().getFavoriteUsers();
    setState(() {
      favUsers = users;
    });
  }



  void _removeFavorite(int index) async {
    bool confirmDelete = await _showDeleteConfirmation();
    if (confirmDelete) {
      int userId = favUsers[index]['id'];
      await DatabaseHelper().updateUser({'isFavorite': 0}, userId);
      setState(() {
        favUsers.removeAt(index);
      });
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
    ) ??
        false;
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
      return const Center(
        child: Text(
          'No favorite users yet!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: favUsers.length,
      itemBuilder: (context, index) {
        final user = favUsers[index];

        return Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.pink.shade300,
                    child: Text(
                      user['fullName'][0].toUpperCase(),
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    user['fullName'],
                    style: GoogleFonts.lora(fontSize: 20, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    user['city'],
                    style: GoogleFonts.lora(fontSize: 14, color: Colors.grey.shade700),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () => _removeFavorite(index),
                  ),
                ),
                const SizedBox(height: 10),
                _buildDetailRow(Icons.calendar_today, "DOB: ${user['dob']}"),
                _buildDetailRow(Icons.cake, "Age: ${user['age']}"),
                _buildDetailRow(Icons.male, "Gender: ${user['gender']}"),
                _buildDetailRow(Icons.email, "Email: ${user['email']}"),
                _buildDetailRow(Icons.favorite, "Hobbies: ${user['hobbies']}"),
              ],
            ),
          ),
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
