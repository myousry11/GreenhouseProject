import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/modules/login/login_screen.dart';
import 'package:untitled6/shared/components/components.dart';
import 'package:untitled6/shared/components/constants.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  bool isPassword = true;
  File? _image;

  Future<void> _getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  Future<void> registerUser(String firstName, String lastName, String email, String phone, String password, File? image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Store user information in SharedPreferences
    await prefs.setString('firstName', firstName);
    await prefs.setString('lastName', lastName);
    await prefs.setString('email', email);
    await prefs.setString('phone', phone);
    await prefs.setString('password', password);

    if (image != null) {
      await prefs.setString('image', image.path);
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Account created successfully'),
      backgroundColor: Color(0xFF248176),
    ));

    // Navigate to login screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'REGISTRATION',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF248176),
                    letterSpacing: 3.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10.0),
              defaultFormField(
                controller: firstNameController,
                type: TextInputType.name,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'First name must not be empty';
                  }
                  return null;
                },
                label: 'First Name',
                prefix: Icons.person_2_outlined,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              SizedBox(height: 5.0),
              defaultFormField(
                controller: lastNameController,
                type: TextInputType.name,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Last name must not be empty';
                  }
                  return null;
                },
                label: 'Last Name',
                prefix: Icons.person_2_outlined,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              SizedBox(height: 5.0),
              defaultFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email must not be empty';
                  }
                  return null;
                },
                label: 'Email Address',
                prefix: Icons.email,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              SizedBox(height: 5.0),
              defaultFormField(
                controller: phoneController,
                type: TextInputType.phone,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone must not be empty';
                  }
                  return null;
                },
                label: 'Phone',
                prefix: Icons.phone_android_outlined,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              SizedBox(height: 5.0),
              defaultFormField(
                controller: passwordController,
                label: 'Password',
                prefix: Icons.lock,
                suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                isPassword: isPassword,
                suffixPressed: () {
                  setState(() {
                    isPassword = !isPassword;
                  });
                },
                type: TextInputType.visiblePassword,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password must not be empty';
                  }
                  return null;
                },
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              SizedBox(height: 5.0),
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Choose Photo'),
              ),
              SizedBox(height: 5.0),
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: _image != null
                      ? DecorationImage(
                    image: FileImage(_image!),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
              ),
              defaultButton(
                function: () {
                  if (firstNameController.text.isNotEmpty &&
                      lastNameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      phoneController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    registerUser(
                      firstNameController.text.trim(),
                      lastNameController.text.trim(),
                      emailController.text.trim(),
                      phoneController.text.trim(),
                      passwordController.text.trim(),
                      _image,
                    );
                  } else {
                    // Handle form validation failure
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Error"),
                          content: Text("Please fill all fields."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                background: Theme.of(context).scaffoldBackgroundColor,
                text: 'Create Account',
                color: Theme.of(context).primaryColor,
                radius: 10.0,
                colors: Color(0xFF248176),
                borderWidth: 1.0,
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
