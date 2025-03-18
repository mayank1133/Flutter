import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isLoading = false;

  void _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        final response = await http.get(
          Uri.parse("https://6690ea9a26c2a69f6e8da0f7.mockapi.io/data"),
        );

        setState(() => isLoading = false);

        if (response.statusCode == 200) {
          List<dynamic> users = json.decode(response.body);
          var user = users.firstWhere(
                (u) =>
            u['fullName'] == fullNameController.text.trim() &&
                u['email'] == emailController.text.trim() &&
                u['dob'] == dobController.text.trim() &&
                u['city'] == cityController.text.trim(),
            orElse: () => null,
          );

          if (user != null) {
            await http.put(
              Uri.parse("https://6690ea9a26c2a69f6e8da0f7.mockapi.io/data/${user['id']}"),
              headers: {"Content-Type": "application/json"},
              body: json.encode({'password': newPasswordController.text.trim()}),
            );

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Password updated successfully!")),
            );
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("User verification failed")),
            );
          }
        }
      } catch (error) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $error")),
        );
      }
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildTitleCard(),
                  const SizedBox(height: 20),
                  _buildForm(),
                  const SizedBox(height: 20),
                  _buildResetButton(),
                ],
              ),
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
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column(
          children: [
            Text(
              'Forgot Password? 🔒',
              style: GoogleFonts.playfairDisplay(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Verify your identity to reset your password.',
              style: GoogleFonts.lora(fontSize: 16, color: Colors.pink.shade400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(fullNameController, "Full Name", Icons.person, "Enter your full name"),
          _buildTextField(emailController, "Email Address", Icons.email, "Enter your email", email: true),
          _buildDatePickerField(dobController, "Date of Birth", Icons.calendar_today),
          _buildTextField(cityController, "City", Icons.location_city, "Enter your city"),
          _buildPasswordField(newPasswordController, "New Password", true),
          _buildPasswordField(confirmPasswordController, "Confirm Password", false),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, String errorMsg, {bool email = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: email ? TextInputType.emailAddress : TextInputType.text,
        validator: (value) => value == null || value.isEmpty ? errorMsg : null,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.pink),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDatePickerField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        readOnly: true,
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now().subtract(const Duration(days: 6570)),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            setState(() {
              controller.text = "${picked.toLocal()}".split(' ')[0];
            });
          }
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.pink),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value == null || value.isEmpty ? 'Select your date of birth' : null,
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool isNewPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isNewPassword ? !isPasswordVisible : !isConfirmPasswordVisible,
        validator: (value) {
          if (value == null || value.isEmpty) return "Enter your password";
          if (isNewPassword && value.length < 6) return "Password must be at least 6 characters";
          if (!isNewPassword && value != newPasswordController.text) return "Passwords do not match";
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const Icon(Icons.lock, color: Colors.pink),
          suffixIcon: IconButton(
            icon: Icon(isNewPassword
                ? (isPasswordVisible ? Icons.visibility : Icons.visibility_off)
                : (isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off)),
            onPressed: () {
              setState(() {
                if (isNewPassword) {
                  isPasswordVisible = !isPasswordVisible;
                } else {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                }
              });
            },
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: isLoading ? null : _resetPassword,
      child: isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Reset Password"),
    );
  }
}
