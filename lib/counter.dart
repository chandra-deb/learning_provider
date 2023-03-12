import 'package:flutter/material.dart';

class Counter with ChangeNotifier {
  int count = 0;

  void increaseCounter() {
    count++;
    notifyListeners();
  }
}
