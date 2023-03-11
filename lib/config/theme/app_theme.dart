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
  ),
  textTheme: TextTheme(
    labelLarge: const TextStyle(
        color: Color(0xFF0d74ba),
        fontSize: 28,
        fontWeight: FontWeight.bold
    ),
    labelMedium: const TextStyle(
      color: Color(0xFF0d74ba),
      fontSize: 15,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[700],
      fontSize: 16,
    ),
  ),
);