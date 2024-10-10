import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system; // تهيئة themeMode بقيمة افتراضية

  ThemeProvider() {
    loadTheme(); // تحميل الثيم عند بدء التطبيق
  }

  bool get isDarkMode => themeMode == ThemeMode.dark;

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    _saveThemePreference(isOn);
  }

  Future<void> _saveThemePreference(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isDarkMode = prefs.getBool('isDarkMode'); // اضافة رمز الاستفهام (?) للسماح بقيمة null
    if (isDarkMode != null) {
      themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    } else {
      // إذا لم يكن هناك ثيم محفوظ، افتراضيًا استخدم الثيم النظامي
      themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}



class MyThemes {
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    primaryColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.teal,
      ),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
    ),

  );
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: ColorScheme.dark(),
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    appBarTheme: AppBarTheme(
      color: Colors.grey.shade900,
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        color: Colors.teal,
      ),
    ),
  );
}
