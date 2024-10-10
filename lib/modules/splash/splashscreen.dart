import 'package:flutter/material.dart';
import 'package:untitled6/modules/onboarding/ob1_screen.dart';

import '../../layout/home_layout.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  bool isFirstInstall ;
  bool isLoggedIn;
  SplashScreen({required this.isFirstInstall ,required this.isLoggedIn});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState()
  {
    super.initState();
    _navigatetolog();
  }
  _navigatetolog() async {



    Future<void> hideScreen() async{
      await Future.delayed(Duration(seconds: 5), () {

        if (widget.isFirstInstall) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => OnboardingScreen1()),
          );
        } else {
          if (widget.isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeLayout()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          }
        }
      });
    }
  }


  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/ic_launcher.png'),
                    height: 250,
                    width: double.infinity,
                    // fit: BoxFit.cover,
                  ),
                ),
            ),
          ],
        ),
      ),

    );
  }
}
