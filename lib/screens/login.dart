import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dashboard.dart';
import 'add_user.dart';
import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoading = false;

  void _loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.get(
        Uri.parse("https://6690ea9a26c2a69f6e8da0f7.mockapi.io/data"),
      );

      setState(() => isLoading = false);

      if (response.statusCode == 200) {
        List<dynamic> users = json.decode(response.body);

        // Debugging: Print fetched users
        print("Fetched Users: $users");

        var user;
        try {
          user = users.firstWhere(
                (u) => u['email'] == email && u['password'] == password,
            orElse: () => null,
          );
        } catch (e) {
          user = null;
        }

        if (user != null) {
          print("User Found: $user");
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('user_data', json.encode(user));

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const DashBoard()),
          );
        } else {
          print("Invalid credentials. User not found.");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Invalid credentials")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to connect to server")),
        );
      }
    } catch (error) {
      setState(() => isLoading = false);
      print("Login Error: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $error")),
      );
    }
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitle(),
                const SizedBox(height: 30),
                _buildTextField(emailController, "Email Address", Icons.email, false),
                _buildTextField(passwordController, "Password", Icons.lock, true),
                const SizedBox(height: 20),
                _buildLoginButton(),
                const SizedBox(height: 15),
                _buildBottomLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      "Welcome Back 💕",
      style: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.pink.shade600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ? !isPasswordVisible : false,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.pink),
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
          )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : _loginUser,
      child: isLoading
          ? const CircularProgressIndicator(color: Colors.white)
          : Text("Login", style: GoogleFonts.lora(fontSize: 18, color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink.shade500,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
      ),
    );
  }

  Widget _buildBottomLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddUser()),
            );
          },
          child: const Text("Sign Up", style: TextStyle(color: Colors.blue)),
        ),
        const Text("|"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
            );
          },
          child: const Text("Forgot Password?", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
