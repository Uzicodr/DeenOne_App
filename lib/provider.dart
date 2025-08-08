import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppProvider extends ChangeNotifier {
  var _count = 0;
  bool _isdark = false;
  int get count => _count;
  bool get isdark => _isdark;

  void increment() {
    _count++;
    notifyListeners();
  }

  void reset() {
    _count = 0;
    notifyListeners();
  }

  void changetheme() {
    _isdark = !_isdark;
    notifyListeners();
  }

  ThemeData get currentTheme {
    return _isdark ? ThemeData.dark() : ThemeData.light();
  }
}
