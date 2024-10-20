// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UpdatesController extends ChangeNotifier {
  Updates_up() {
    try {
      FirebaseDatabase.instance
          .ref("updates")
          .orderByKey()
          .onValue
          .listen((event) {
        if (event.snapshot.value != null) {
          int map = event.snapshot.value as int;
          updates = map;
        }

        updates != 0 ? notifyListeners() : DoNothingAction();
      });
    } catch (e) {}
  }

  int updates = 0;

  Add_new_customer() {
    try {
      FirebaseDatabase.instance.ref("updates").set(1);
    } catch (e) {}
  }
}
