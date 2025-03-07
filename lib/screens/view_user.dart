import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimonial_app/screens/add_user.dart';
import 'package:matrimonial_app/screens/user_details.dart';
import '../Utils/Data.dart';
import '../Utils/data_base_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ViewUser  extends StatefulWidget {
  final List<Map<String, dynamic>> userDetail;

  const ViewUser ({super.key, required this.userDetail});

  @override
  State<ViewUser > createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser > {
final Set<int> favoriteUsers = {};
String searchQuery = "";
String sortBy = "fullName";
bool isAscending = true;
final TextEditingController searchController = TextEditingController();

List<Map<String, dynamic>> users = []; // Store users in a local list

void _loadUsers() async {
  try {
    final response = await http.get(
        Uri.parse("https://67c90cf90acf98d070887488.mockapi.io/users")
    );
    if (response.statusCode == 200) {
      setState(() {
        users = List<Map<String, dynamic>>.from(json.decode(response.body));
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

void _editUser (BuildContext context, int index) async {
  final updatedUser  = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => AddUser(existingUser: widget.userDetail[index]),
    ),
  );

  if (updatedUser  != null) {
    setState(() {
      widget.userDetail[index] = updatedUser ;
    });
  }
}

void _deleteUser(int index) async {
  bool confirmDelete = await _showDeleteConfirmation();
  if (confirmDelete) {
    String userId = widget.userDetail[index]['id'].toString(); // MockAPI requires a string ID

    try {
      final response = await http.delete(
        Uri.parse("https://67c90cf90acf98d070887488.mockapi.io/users/$userId"),
      );

      if (response.statusCode == 200) {
        setState(() {
          widget.userDetail.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User deleted successfully!")),
        );
      } else {
        print("Delete Error: ${response.body}"); // Debugging
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to delete user.")),
        );
      }
    } catch (error) {
      print("Exception: $error"); // Debugging
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
  }
}

Future<bool> _showDeleteConfirmation() async {
  return await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Delete User"),
      content: const Text("Are you sure you want to delete this user?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text("Cancel", style: TextStyle(color: Colors.blue)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    ),
  ) ?? false;
}

List<Map<String, dynamic>> _filteredUsers() {
  return users.where((user) {
    return user.entries.any((entry) =>
        entry.value.toString().toLowerCase().contains(searchQuery.toLowerCase()));
  }).toList();
}

List<Map<String, dynamic>> _sortedUsers() {
  List<Map<String, dynamic>> filteredList = _filteredUsers();
  filteredList.sort((a, b) {
    var valueA = a[sortBy] ?? "";
    var valueB = b[sortBy] ?? "";

    if (sortBy == "age") {
      valueA = _calculateAge(a['dob']);
      valueB = _calculateAge(b['dob']);
    }

    return isAscending
        ? valueA.toString().compareTo(valueB.toString())
        : valueB.toString().compareTo(valueA.toString());
  });

  return filteredList;
}

void _toggleSorting() {
  setState(() {
    isAscending = !isAscending;
  });
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
            _buildSearchBar(),
            const SizedBox(height: 10),
            Expanded(child: _buildUserList()),
        ],
      ),
    ),
  ),
  ),
  floatingActionButton: FloatingActionButton(
  onPressed: _toggleSorting,
  backgroundColor: Colors.pink.shade400,
  child: Icon(
  isAscending ? Icons.arrow_upward : Icons.arrow_downward,
  color: Colors.white,
  ),
  ),
  );
}

Widget _buildTitleCard() {
  return Card(
    elevation: 12,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 50.0),
      child: Column(
        children: [
          Text(
            'User  Profiles 💖',
            style: GoogleFonts.playfairDisplay(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.pink.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            'Discover love, one profile at a time. 💕',
            style: GoogleFonts.lora(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.pink.shade400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}

Widget _buildSearchBar() {
  return TextField(
    controller: searchController,
    decoration: InputDecoration(
      hintText: "Search by Name, Email, Age, Hobbies...",
      prefixIcon: const Icon(Icons.search, color: Colors.pink),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      filled: true,
      fillColor: Colors.white,
    ),
    onChanged: (value) {
      setState(() {
        searchQuery = value;
      });
    },
  );
}

Widget _buildUserList() {
  List<Map<String, dynamic>> sortedUsers = _sortedUsers();

  if (sortedUsers.isEmpty) {
    return const Center(
      child: Text(
        'No users found!',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey),
      ),
    );
  }

  return ListView.builder(
    itemCount: sortedUsers.length,
    itemBuilder: (context, index) {
      final user = sortedUsers[index];

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
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  favoriteUsers.contains(index) ? Icons.favorite : Icons.favorite_border,
                  color: favoriteUsers.contains(index) ? Colors.pink : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    if (favoriteUsers.contains(index)) {
                      favoriteUsers.remove(index);
                    } else {
                      favoriteUsers.add(index);
                    }
                    Data.favoriteUsers.add(user);
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: () => _editUser (context, index),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteUser (index),
              ),
            ],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserDetails(user: user)),
          ),
        ),
      );
    },
  );
}

int _calculateAge(String dob) {
  final birthDate = DateTime.parse(dob);
  return DateTime.now().year - birthDate.year;
}
}