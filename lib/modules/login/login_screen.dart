import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/OTP_Screens/OTP_SC1.dart';
import 'package:untitled6/layout/home_layout.dart';
import 'package:untitled6/modules/signup/signup_screen.dart';
import 'package:untitled6/shared/components/components.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:untitled6/shared/components/constants.dart';

import '../../OTP_Screens/otp_verify_page.dart';
import '../../shared/network/connection.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formkey = GlobalKey<FormState>();
  bool isPassword = true;

  Future<void> loginUser(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    print('Stored Email: $storedEmail');
    print('Stored Password: $storedPassword');
    print('Entered Email: $email');
    print('Entered Password: $password');

    if (email == storedEmail && password == storedPassword) {
      await prefs.setBool('isLoggedIn', true);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeLayout(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OfflineBuilder(
        connectivityBuilder: (
            BuildContext connectivityContext,
            ConnectivityResult connectivity,
            Widget child,
            ) {
          if (connectivity == ConnectivityResult.none) {
            return ConnectionScreen();
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image(
                        image: AssetImage('assets/images/login.png'),
                        height: 400,
                        width: 400,
                      ),
                    ],
                  ),
                  Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }
                            return null;
                          },
                          label: 'Email Address',
                          prefix: Icons.email,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          label: 'Password',
                          prefix: Icons.lock,
                          suffix: isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          isPassword: isPassword,
                          suffixPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          type: TextInputType.visiblePassword,
                          validate: (value) {
                            if (value.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: TextButton(
                        //     onPressed: () {
                        //       Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //           builder: (context) => PhoneAuthScreen(),
                        //         ),
                        //       );
                        //     },
                        //     child: Text(
                        //       'Forget Password?',
                        //       style: TextStyle(
                        //         color: Theme.of(context).primaryColor,
                        //         decoration: TextDecoration.underline,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        defaultButton(
                          function: () async {
                            if (formkey.currentState!.validate()) {
                              await loginUser(
                                emailController.text,
                                passwordController.text,
                              );
                            }
                          },
                          background: Theme.of(context).scaffoldBackgroundColor,
                          width: 200,
                          text: 'Log in',
                          color: Theme.of(context).primaryColor,
                          radius: 10.0,
                          colors: Color(0xFF248176),
                          borderWidth: 3.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Center(
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Constants.primaryColor,
                            ),
                          ),
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                              ),
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => SignUpScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
        child: SizedBox(), // Placeholder if needed
      ),
    );
  }
}
