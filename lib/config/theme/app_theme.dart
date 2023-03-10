import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey[300],
  textTheme: TextTheme(
    labelLarge: const TextStyle(
        color: Color(0xFF0d74ba),
        fontSize: 28,
        fontWeight: FontWeight.bold
    ),
    labelMedium: const TextStyle(
      color: Color(0xFF0d74ba),
      fontSize: 14,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.grey[700],
      fontSize: 16,
    ),
  ),
);