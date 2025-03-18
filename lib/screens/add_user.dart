import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddUser  extends StatefulWidget {
  final Map<String, dynamic>? existingUser ;

  const AddUser ({super.key, this.existingUser });

  @override
  State<AddUser>createState() => _AddUserState();
}

class _AddUserState extends State<AddUser > {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController hobbyController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? selectedGender;
  String? selectedCity;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  List<String> hobbiesList = [];

  final List<String> gujaratCities = [
    'Ahmedabad', 'Surat', 'Vadodara', 'Rajkot', 'Bhavnagar', 'Gandhinagar', 'Jamnagar',
    'Junagadh', 'Anand', 'Navsari', 'Bharuch', 'Mehsana', 'Morbi', 'Patan', 'Porbandar'
  ];

  @override
  void initState() {
    super.initState();
    if (widget.existingUser  != null) {
      fullNameController.text = widget.existingUser !['fullName'] ?? '';
      emailController.text = widget.existingUser !['email'] ?? '';
      mobileController.text = widget.existingUser !['mobile'] ?? '';
      dobController.text = widget.existingUser !['dob'] ?? '';
      selectedCity = widget.existingUser !['city'] ?? null;
      selectedGender = widget.existingUser !['gender'] ?? null;
      hobbiesList = widget.existingUser !['hobbies']?.split(', ') ?? [];
    }
  }

  void _addHobby() {
    String hobby = hobbyController.text.trim();
    if (hobby.isNotEmpty && !hobbiesList.contains(hobby)) {
      setState(() {
        hobbiesList.add(hobby);
        hobbyController.clear();
      });
    }
  }

  void _saveUser() async {
    if (_formKey.currentState!.validate()) {
      if (selectedGender == null || selectedCity == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select gender and city")),
        );
        return;
      }

      Map<String, dynamic> user = {
        'fullName': fullNameController.text.trim(),
        'email': emailController.text.trim(),
        'mobile': mobileController.text.trim(),
        'dob': dobController.text.trim(),
        'city': selectedCity,
        'gender': selectedGender,
        'hobbies': hobbiesList.join(', '),
        'isfav':false
      };

      try {
        final response = await http.post(
          Uri.parse("https://6690ea9a26c2a69f6e8da0f7.mockapi.io/data"),
          headers: {"Content-Type": "application/json"},
          body: json.encode(user),
        );

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("User saved successfully!")),
          );
          Navigator.pop(context, user);
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
                children: [
                  _buildTitleCard(),
                  const SizedBox(height: 20),
                  _buildUserForm(),
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
              widget.existingUser  == null ? 'Create Your Profile 💖' : 'Edit Your Profile 💖',
              style: GoogleFonts.playfairDisplay(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Fill in your details and find your perfect match!',
              style: GoogleFonts.lora(fontSize: 16, color: Colors.pink.shade400),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextField(fullNameController, 'Full Name', Icons.person, 'Enter your full name'),
          _buildTextField(emailController, 'Email Address', Icons.email, 'Enter a valid email', email: true),
          _buildTextField(mobileController, 'Mobile Number', Icons.phone, 'Enter a valid mobile number', number: true),
          _buildDatePickerField(dobController, 'Date of Birth', Icons.calendar_today),
          _buildGenderSelection(),
          _buildCityDropdown(),
          _buildHobbiesField(),
          if (widget.existingUser  == null) _buildPasswordField(passwordController, 'Password', true),
          if (widget.existingUser  == null) _buildPasswordField(confirmPasswordController, 'Confirm Password', false),
          const SizedBox(height: 20),
          widget.existingUser == null ?_buildSaveButton(): ElevatedButton(onPressed: ()async {
            if (_formKey.currentState!.validate()) {
              if (selectedGender == null || selectedCity == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please select gender and city")),
                );
                return;
              }

              Map<String, dynamic> user = {
                'fullName': fullNameController.text.trim(),
                'email': emailController.text.trim(),
                'mobile': mobileController.text.trim(),
                'dob': dobController.text.trim(),
                'city': selectedCity,
                'gender': selectedGender,
                'hobbies': hobbiesList.join(', '),
                'isfav':false
              };

              try {
                final response = await http.put(
                  Uri.parse("https://6690ea9a26c2a69f6e8da0f7.mockapi.io/data/${widget.existingUser!["id"]}"),
                  headers: {"Content-Type": "application/json"},
                  body: json.encode(user),
                );
                print(response.body);
                if (response.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("User edit successfully!")),
                  );
                  Navigator.pop(context, user);
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
          }, child: Text("edit")),
        ],
      ),
    );
  }

  Widget _buildCityDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DropdownButtonFormField<String>(
        value: selectedCity,
        onChanged: (value) => setState(() => selectedCity = value),
        items: gujaratCities.map((city) => DropdownMenuItem(value: city, child: Text(city))).toList(),
        decoration: InputDecoration(
          labelText: "Select City",
          prefixIcon: Icon(Icons.location_city, color: Colors.pink),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          filled: true,
          fillColor: Colors.white,
        ),
        validator: (value) => value == null ? 'Select a city' : null,
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String label,
      IconData icon,
      String errorMsg, {
        bool email = false,
        bool number = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        keyboardType: email
            ? TextInputType.emailAddress
            : number
            ? TextInputType.phone
            : TextInputType.text,
        inputFormatters: number
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
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
        validator: (value) => value == null || value.isEmpty ? 'Select a date' : null,
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Gender", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          DropdownButtonFormField<String>(
            value: selectedGender,
            onChanged: (value) => setState(() => selectedGender = value),
            items: ["Male", "Female", "Other"]
                .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                .toList(),
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
              filled: true,
              fillColor: Colors.white,
            ),
            hint: Text("Select Gender"),
            validator: (value) => value == null ? 'Select your gender' : null,
          ),
        ],
      ),
    );
  }

  Widget _buildHobbiesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Hobbies",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: hobbyController,
                decoration: InputDecoration(
                  labelText: "Enter a hobby",
                  prefixIcon: const Icon(Icons.sports, color: Colors.pink),
                  suffixIcon: IconButton(
                    onPressed: _addHobby,
                    icon: const Icon(Icons.add, color: Colors.pink),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          children: hobbiesList
              .map((hobby) => Chip(
            label: Text(hobby, style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.pink.shade300,
            deleteIcon: const Icon(Icons.close, color: Colors.white),
            onDeleted: () {
              setState(() {
                hobbiesList.remove(hobby);
              });
            },
          ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildPasswordField(TextEditingController controller, String label, bool isPasswordField) {
    if (widget.existingUser  != null && !isPasswordField) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPasswordField ? !isPasswordVisible : !isConfirmPasswordVisible,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(Icons.lock, color: Colors.pink),
          suffixIcon: IconButton(
            icon: Icon(isPasswordField
                ? (isPasswordVisible ? Icons.visibility : Icons.visibility_off)
                : (isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off)),
            onPressed: () {
              setState(() {
                if (isPasswordField) {
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

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveUser ,
      child: Text('Save Profile', style: GoogleFonts.lora(fontSize: 18, color: Colors.pink, fontWeight: FontWeight.bold)),
    );
  }
}