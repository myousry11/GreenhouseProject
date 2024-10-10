import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/modules/login/login_screen.dart';
import 'package:untitled6/modules/profile/profile_screen.dart';
import 'package:untitled6/modules/settings_tasks/changepass.dart';
import 'package:untitled6/modules/settings_tasks/settings_widget.dart';


class SettingsScreen extends StatefulWidget {
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? firstName;
  String? lastName;
  String? email;
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
      email = prefs.getString('email');
      String? imagePath = prefs.getString('image');
      if (imagePath != null) {
        _image = File(imagePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.transparent,
                  backgroundImage: _image != null ? FileImage(_image!) : AssetImage('assets/images/profilee.jpg') as ImageProvider,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.lightGreen.withOpacity(.5),
                    width: 5.0,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '$firstName $lastName',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 20.0,
                        letterSpacing: 2.0
                    ),
                  ),
                  Text(
                    email ?? '',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor.withOpacity(.4),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ProfileWidget(
                        icon: Icons.person,
                        title: 'Edit Profile',
                        function: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileWidget(
                        icon: Icons.lock_outline,
                        title: 'Change Password',
                        function: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChangePasswordScreen(),
                            ),
                          );
                        },
                      ),
                      ProfileWidget(
                        icon: Icons.logout,
                        title: 'Log out',
                        function: () async {
                          final prefs = await SharedPreferences.getInstance();
                          prefs.setBool('isLoggedIn', false);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}