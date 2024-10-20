import 'package:flutter/material.dart';

class ScissorsController extends ChangeNotifier {
  int indexOfRadioButon = 0;
  changeIndexOfRadioButoon(val) {
    indexOfRadioButon = val;
    notifyListeners();
  }

  List<String> fractions = [];

  get() {
    notifyListeners();
  }
}
