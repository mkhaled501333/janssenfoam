// ignore_for_file: non_constant_identifier_names, empty_catches, file_names, camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/models/moderls.dart';

class SubFractions_Controller extends ChangeNotifier {
  get_SubFractions_data() {
    FirebaseDatabase.instance.ref("subfractions").onValue.listen((event) {
      getInitialData(event.snapshot);
    });
  }

  getInitialData(DataSnapshot v) async {
    all.clear();
    archived_subfractions.clear();
    subfractions.clear();
    for (var item in v.children) {
      all.add(SubFraction.fromJson(item.value.toString()));
    }

    subfractions.addAll(all.where((element) =>
        element.actions
            .if_action_exist(subfractionAction.archive_subfraction.getTitle) ==
        false));
    archived_subfractions.addAll(all.where((element) =>
        element.actions
            .if_action_exist(subfractionAction.archive_subfraction.getTitle) ==
        true));
    notifyListeners();
    print("get initial data of subfractions");
  }

  refrech(DatabaseEvent vv) async {
    SubFraction newvalue = SubFraction.fromJson(vv.snapshot.value as String);

//--------------------------------------------------
    all.removeWhere(
        (element) => element.subfraction_ID == newvalue.subfraction_ID);
    all.add(newvalue);
//--------------------------------------------------

    subfractions.removeWhere(
        (element) => element.subfraction_ID == newvalue.subfraction_ID);

    if (newvalue.actions
            .if_action_exist(subfractionAction.archive_subfraction.getTitle) ==
        false) {
      subfractions.add(newvalue);
    } else {
      archived_subfractions.add(newvalue);
    }

    notifyListeners();
    print("refrech datata of subfraction");
  }

  List<SubFraction> all = [];
  List<SubFraction> subfractions = [];
  List<SubFraction> archived_subfractions = [];

  Refresh_the_UI() {
    notifyListeners();
  }

  add_SUb_fractions(SubFraction subFraction) async {
    try {
      await FirebaseDatabase.instance
          .ref("subfractions/${subFraction.subfraction_ID}")
          .set(subFraction.toJson())
          .whenComplete(() => get_SubFractions_data());
    } catch (e) {}
  }

  addSubfractionslist(List<SubFraction> suba) async {
    try {
      // if (all.isNotEmpty) {
      all.addAll(suba);
      var s = {};
      s.addEntries(all.map(
          (el) => MapEntry("${el.subfraction_ID}", el.toJson().toString())));

      FirebaseDatabase.instance.ref("subfractions").set(s);
      // }
    } catch (e) {}
  }

  delete_SUBfraction(SubFraction subfraction) {
    subfraction.actions.add(subfractionAction.archive_subfraction.add);
    try {
      FirebaseDatabase.instance
          .ref("subfractions/${subfraction.subfraction_ID}")
          .set(subfraction.toJson());
    } catch (e) {}
  }

  UncutOnA_SUBfraction(SubFraction subfraction) {
    subfraction.Ascissor = 0;
    subfraction.Astagenum = 0;
    subfraction.underOperation = true;
    subfraction.actions
        .removeWhere((element) => element.action == "cut_subfraction_on_A");
    try {
      FirebaseDatabase.instance
          .ref("subfractions/${subfraction.subfraction_ID}")
          .set(subfraction.toJson());
    } catch (e) {}
  }

  undeleteSubFraction(SubFraction subfraction) {
    int index = subfraction.actions.indexWhere((element) =>
        element.action == subfractionAction.archive_subfraction.getTitle);
    subfraction.actions.removeAt(index);

    try {
      FirebaseDatabase.instance
          .ref("subfractions/${subfraction.subfraction_ID}")
          .set(subfraction.toJson());
      notifyListeners();
    } catch (e) {}
  }

  cut_subfractions_on_A(SubFraction subfractionn, int Ascissor, int Astagenum) {
    subfractionn.Ascissor = Ascissor;
    subfractionn.Astagenum = Astagenum;
    subfractionn.underOperation = false;
    subfractionn.actions.add(subfractionAction.cut_subfraction_on_A.add);
    try {
      FirebaseDatabase.instance
          .ref("subfractions/${subfractionn.subfraction_ID}")
          .set(subfractionn.toJson());
    } catch (e) {}
  }

  add_notfinals(SubFraction subfractionn, NotFinal value) {
    subfractionn.notfinals.add(value);
    subfractionn.actions
        .add(subfractionAction.add_not_final_toSubfractions.add);

    FirebaseDatabase.instance
        .ref("subfractions/${subfractionn.subfraction_ID}")
        .set(subfractionn.toJson());
  }

  remove_notfinals(SubFraction subfractionn) {
    subfractionn.notfinals.clear();
    subfractionn.actions
        .add(subfractionAction.remove_not_final_fromSubfractions.add);
    FirebaseDatabase.instance
        .ref("subfractions/${subfractionn.subfraction_ID}")
        .set(subfractionn.toJson());
  }
}
