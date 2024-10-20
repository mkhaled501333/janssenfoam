// ignore_for_file: file_names, non_constant_identifier_names, empty_catches, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/models/moderls.dart';

class NonFinalController extends ChangeNotifier {
  getdataOfnotFinals() {
    try {
      FirebaseFirestore.instance
          .collection('nonFinal')
          .orderBy("date")
          .snapshots()
          .listen((event) {
        not_finals.clear();
        not_finals.addAll(
            event.docs.map((doc) => NotFinal.fromMap(doc.data())).toList());
        notifyListeners();
      });
    } catch (e) {}
  }

  List<NotFinal> not_finals = [];

  add_to_not_FInals(NotFinal notfinal) async {
    try {
      await FirebaseFirestore.instance
          .collection('nonFinal')
          .add(notfinal.toMap());
    } catch (e) {}
  }

  delete_not_FInals(id) {
    try {
      FirebaseFirestore.instance
          .collection('nonFinal')
          .where('id', isEqualTo: id)
          .get()
          .then((value) => value.docs.forEach((element) {
                element.reference.delete();
              }));
    } catch (e) {}
  }
}
