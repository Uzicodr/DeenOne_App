import 'package:flutter/material.dart';
import 'package:quran_app/colorscheme.dart';
import 'splash_screen.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor:primaryColorGold)),
    home: SplashScreen(),
  ));
}