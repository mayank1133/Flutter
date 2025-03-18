import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user_details.dart';
class FavUser  extends StatefulWidget {


  const FavUser ({super.key,  });

  @override
  State<FavUser > createState() => _FavUserState();
}

class _FavUserState extends State<FavUser > {
  late List<Map<String, dynamic>> favUsers;

  @override
  void initState() {
    super.initState();
    // _loadFavoriteUsers();
    _loadUsers();
  }
  void _loadUsers() async {
    try {
      final response = await http.get(Uri.parse("https://6690ea9a26c2a69f6e8da0f7.mockapi.io/data"));
      print(response.body);
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          favUsers = List<Map<String, dynamic>>.from(json.decode(response.body));
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to load users")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }

  // void _loadFavoriteUsers() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? favoriteUserIds = prefs.getString('favorite_users');
  //   if (favoriteUserIds != null) {
  //     List<String> ids = favoriteUserIds.split(',');
  //     favUsers = await DatabaseHelper().getUsersByIds(ids);
  //     setState(() {
  //       favUsers = favUsers;
  //     });
  //   }
  // }

  void _removeFavorite(int index) async {
    bool confirmDelete = await _showDeleteConfirmation();
    if (confirmDelete) {
      int userId = favUsers[index]['id'];

      final response = await http.put(
        Uri.parse("https://6690ea9a26c2a69f6e8da0f7.mockapi.io/data/${userId}"), // Correct URL
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
  void favuser(Map<String,dynamic> map,String id) async {




    try {
      final response = await http.put(
        Uri.parse("https://6690ea9a26c2a69f6e8da0f7.mockapi.io/data/$id"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(map),
      );

      if (response.statusCode == 200) {
        _loadUsers();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User fav successfully!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to save user")),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }
  Widget _buildFavUserList() {
    if (favUsers.isEmpty) {
      return const Center(
        child: Text(
          'No favorite users found!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: favUsers.length,
      itemBuilder: (context, index) {
        final user = favUsers[index];

        if (!user["isfav"]) return Container(); // Skip non-favorite users

        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: ListTile(
            contentPadding: const EdgeInsets.all(15),
            leading: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.pink.shade300,
              child: Text(
                user['fullName'][0].toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            title: Text(
              user['fullName'],
              style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pink.shade700),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Age: ${_calculateAge(user['dob'])} | Gender: ${user['gender']}",
                    style: GoogleFonts.lora(fontSize: 14, color: Colors.grey.shade700)),
                Text("City: ${user['city']}", style: GoogleFonts.lora(fontSize: 14, color: Colors.grey.shade700)),
              ],
            ),
            trailing: IconButton(
              icon: Icon(
                user["isfav"] ? Icons.favorite : Icons.favorite_border,
                color: user["isfav"] ? Colors.pink : Colors.grey,
              ),
              onPressed: () {
                Map<String, dynamic> temp = Map.from(favUsers[index]);
                temp["isfav"] = !temp["isfav"];
                favuser(temp, temp["id"]);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserDetails(user: user),
                ),
              );
            },
          ),
        );
      },
    );
  }
  int _calculateAge(String dob) {
    try {
      DateTime birthDate = DateTime.parse(dob); // Convert DOB string to DateTime
      DateTime today = DateTime.now();
      int age = today.year - birthDate.year;

      // Adjust age if birthday hasn't occurred yet this year
      if (today.month < birthDate.month ||
          (today.month == birthDate.month && today.day < birthDate.day)) {
        age--;
      }

      return age;
    } catch (e) {
      return 0; // Return 0 if parsing fails
    }
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