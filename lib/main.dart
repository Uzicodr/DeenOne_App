import 'package:flutter/material.dart';
import 'splash_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.dark()),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}