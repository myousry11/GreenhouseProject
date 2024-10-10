import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled6/OTP_Screens/OTP_SC1.dart';
import 'package:untitled6/OTP_Screens/otp_verify_page.dart';
import 'package:untitled6/OTP_Screens/reset_password.dart';
import 'package:untitled6/modules/splash/splashscreen.dart';
import 'package:untitled6/shared/business_logic/Provider/DataProvider.dart';
import 'package:untitled6/shared/business_logic/Provider/theme_provider.dart';
import 'package:untitled6/shared/business_logic/bloc/bloc_observer.dart';

import 'layout/home_layout.dart';
import 'modules/login/login_screen.dart';
import 'modules/onboarding/ob1_screen.dart';
import 'modules/report_tasks/report_tasks_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isFirstInstall = prefs.getBool('isFirstInstall') ?? true;
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  Bloc.observer = MyBlocObserver();
  runApp(MyApp(
    isFirstInstall: isFirstInstall,
    isLoggedIn: isLoggedIn,
  ));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatefulWidget {
  // constructor
  // build
  final bool isLoggedIn;
  final bool isFirstInstall;
  const MyApp({super.key, this.isLoggedIn = false, this.isFirstInstall = true});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DataProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterModel(),
          )
        ],
        builder: (context, child) {
          Provider.of<DataProvider>(context).initData();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            home: _getNextScreenWidget(),
            theme: MyThemes.lightTheme,
            darkTheme: MyThemes.darkTheme,
          );
        });
  }

  Widget _getNextScreenWidget() {
    if (widget.isFirstInstall) {
      return OnboardingScreen1();
    } else {
      if (widget.isLoggedIn) {
        return HomeLayout();
      } else {
        return LoginScreen();
      }
    }
  }
}
