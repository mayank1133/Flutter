import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dashboard.dart';
import 'add_user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      final response = await http.post(
        Uri.parse("https://your-api.com/login"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> user = json.decode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user_data', json.encode(user));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashBoard()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid email or password!")));
      }
    }
  }

  void _navigateToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const AddUser ()));
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
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 30),
                  _buildLoginForm(),
                  const SizedBox(height: 20),
                  _buildLoginButton(),
                  const SizedBox(height: 15),
                  _buildRegisterLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Welcome to Perfect 💞 Match',
      style: GoogleFonts.playfairDisplay(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.pink.shade600,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(emailController, "Email", Icons.email, true),
          const SizedBox(height: 10),
          _buildPasswordField(),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, bool isEmail) {
    return TextFormField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.pink),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return "Enter your $label";
        if (isEmail && !value.contains("@")) return "Enter a valid email";
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: passwordController,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
        labelText: "Password",
        prefixIcon: const Icon(Icons.lock, color: Colors.pink),
        suffixIcon: IconButton(
          icon: Icon(isPasswordVisible ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) => value == null || value.isEmpty ? "Enter your password" : null,
    );
  }

  Widget _buildLoginButton() {
    return ElevatedButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pink.shade500,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
        child: Text("Login", style: TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return TextButton(
      onPressed: _navigateToRegister,
      child: const Text("Don't have an account? Register", style: TextStyle(color: Colors.pink)),
    );
  }
}