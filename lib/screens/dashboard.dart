import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'about_us.dart';
import 'add_user.dart';
import 'fav_user.dart';
import 'view_user.dart';
import 'package:matrimonial_app/Utils/data_base_helper.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Map<String, dynamic>> userDetail = [];

  @override
  void initState() {
    super.initState();
    _loadUsers(); // Load users from the database
  }

  void _loadUsers() async {
    userDetail = await DatabaseHelper().getUsers();
    setState(() {});
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(), // ✅ Smooth scrolling effect
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTitleCard(),
                  const SizedBox(height: 20),

                  _buildDecorativeSeparator(),
                  const SizedBox(height: 20),

                  // ✅ Modern Grid Layout for Features
                  GridView.builder(
                    shrinkWrap: true, // ✅ Adapts to content size
                    physics: const NeverScrollableScrollPhysics(), // ✅ Prevents nested scrolling issues
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return _buildFeatureCard(index);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Title Card with Elegant Pink Theme
  Widget _buildTitleCard() {
    return Card(
      elevation: 12,
      shadowColor: Colors.pink.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column(
          children: [
            Text(
              'Perfect 💞 Match .com',
              style: GoogleFonts.playfairDisplay(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Find your soulmate with ease. The best matchmaking platform for true connections.',
              style: GoogleFonts.lora(
                fontSize: 16,
                color: Colors.pink.shade400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Decorative Separator for Aesthetic Look
  Widget _buildDecorativeSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        '· ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ✧ ✦ ·',
        style: GoogleFonts.lora(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.pink.shade500,
          letterSpacing: 4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // ✅ Function to determine which feature card to build
  Widget _buildFeatureCard(int index) {
    switch (index) {
      case 0:
        return _buildNavigationCard(Icons.person_add_alt_1, 'Add User', _navigateToAddUser);
      case 1:
        return _buildCard(Icons.people_alt, 'User List', () => ViewUser(userDetail: userDetail));
      case 2:
        return _buildCard(
          Icons.favorite_rounded,
          'Favorite',
              () => FavUser(
            favoriteUsers: userDetail.where((user) => user['isFavorite'] == true).toList(),
          ),
        );

      case 3:
        return _buildCard(Icons.info_rounded, 'About Us', () => const AboutUs());
      default:
        return const SizedBox.shrink();
    }
  }

  // ✅ Navigation Function for Add User
  void _navigateToAddUser() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const AddUser()),
    );

    if (result != null && result is Map<String, dynamic>) {
      await DatabaseHelper().insertUser(result); // Save to SQLite
      setState(() {}); // Reload dashboard after adding a user
    }
  }

  // ✅ Function for Feature Cards Navigating to Pages
  Widget _buildCard(IconData icon, String title, Widget Function() page) {
    return _buildInteractiveCard(icon, title, () {
      Navigator.of(context).push(_createRoute(page()));
    });
  }

  // ✅ Function for Add User Navigation Card
  Widget _buildNavigationCard(IconData icon, String title, VoidCallback action) {
    return _buildInteractiveCard(icon, title, action);
  }

  // ✅ Generalized Interactive Card with Ripple Effect
  Widget _buildInteractiveCard(IconData icon, String title, VoidCallback action) {
    return Card(
      elevation: 8,
      shadowColor: Colors.pink.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: action,
        splashColor: Colors.pink.withOpacity(0.3), // ✅ Adds tap effect
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.pink.shade300,
                child: Icon(icon, size: 40, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Modern & Attractive Page Transition Animation
  PageRouteBuilder _createRoute(Widget page) {
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var fadeTween = Tween<double>(begin: 0.0, end: 1.0);
        var fadeAnimation = animation.drive(CurveTween(curve: Curves.easeInOut)).drive(fadeTween);

        var scaleTween = Tween<double>(begin: 0.9, end: 1.0);
        var scaleAnimation = animation.drive(CurveTween(curve: Curves.easeOutExpo)).drive(scaleTween);

        return FadeTransition(
          opacity: fadeAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
