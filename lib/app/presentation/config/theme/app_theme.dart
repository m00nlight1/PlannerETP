import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[300],
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
    backgroundColor: Colors.transparent,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    toolbarTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  ),
  textTheme: TextTheme(
    labelLarge: const TextStyle(
        color: Color(0xFF0d74ba), fontSize: 28, fontWeight: FontWeight.bold),
    labelMedium: const TextStyle(
      color: Color(0xFF0d74ba),
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    labelSmall: TextStyle(
        color: Colors.grey[700], fontSize: 22, fontWeight: FontWeight.bold),
    displaySmall: const TextStyle(
      color: Color(0xFF0d74ba),
      fontSize: 13,
      fontWeight: FontWeight.bold,
    ),
    bodyLarge: const TextStyle(
      color: Colors.white,
      fontSize: 35,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[700],
      fontSize: 15,
    ),
    bodySmall: const TextStyle(
      color: Colors.white,
      fontSize: 18,
    ),
    headlineSmall: const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    headlineLarge: const TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
  ),
);
