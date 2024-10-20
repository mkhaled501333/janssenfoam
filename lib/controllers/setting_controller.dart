// ignore_for_file: file_names, non_constant_identifier_names, unused_field

import 'package:flutter/material.dart';

class SettingController extends ChangeNotifier {
  Refresh_Ui() {
    notifyListeners();
  }

  bool switch1 = false;

//block setting

  int amountofshowinaddBlock = 5;

  int GroupvalueofRadio = 2;

  DateTime from = DateTime.now();
  DateTime to = DateTime.now();

  DateTime from2 = DateTime.now();
  DateTime to2 = DateTime.now();
}
