import 'package:flutter/material.dart';
// Themes of whole app

ThemeData theme() => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        color: Colors.deepPurple,
        fontWeight: FontWeight.w700,
      ),
      displaySmall: TextStyle(
        color: Colors.grey,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
    ),
    appBarTheme: const AppBarTheme(
        color: Colors.white,
        titleTextStyle: TextStyle(
            color: Colors.purple, fontSize: 20, fontWeight: FontWeight.w700)));
