import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primaryColor: const Color(0xFF1A73E8),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF1A73E8),
      background: Colors.white,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF1A73E8),
    ),
  );

  static final darkTheme = ThemeData(
    primaryColor: const Color(0xFF1A73E8),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1A73E8),
      background: Colors.grey,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.grey[900],
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF1A73E8),
    ),
  );
}