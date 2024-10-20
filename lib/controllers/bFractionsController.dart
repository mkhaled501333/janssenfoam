// ignore_for_file: non_constant_identifier_names, empty_catches, file_names, camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/models/moderls.dart';

class Fractions_Controller extends ChangeNotifier {
  List<FractionModel> all = [];
  List<FractionModel> fractions = [];
  List<FractionModel> archived_fractions = [];

  get_Fractions_data() {
    FirebaseDatabase.instance
        .ref("fractions")
        .orderByKey()
        .onValue
        .first
        .then((event) {
      getInitialData(event.snapshot);
    }).whenComplete(() => FirebaseDatabase.instance
                .ref("fractions")
                .orderByKey()
                .startAfter(
                    "${fractions.isNotEmpty ? fractions.last.fraction_ID : 0}")
                .onChildAdded
                .listen((f) {
              refrech(f);
            }));

    FirebaseDatabase.instance.ref("fractions").onChildChanged.listen((vv) {
      refrech(vv);
    });
  }

  getInitialData(DataSnapshot v) async {
    all.clear();
    archived_fractions.clear();
    fractions.clear();
    for (var item in v.children) {
      all.add(FractionModel.fromJson(item.value.toString()));
    }

    fractions.addAll(all.where((element) =>
        element.actions
            .if_action_exist(FractionActon.archive_fraction.getTitle) ==
        false));
    archived_fractions.addAll(all.where((element) =>
        element.actions
            .if_action_exist(FractionActon.archive_fraction.getTitle) ==
        true));
    notifyListeners();
    if (kDebugMode) {
      print("get initial data of fractions");
    }
  }

  refrech(DatabaseEvent vv) async {
    FractionModel newvalue =
        FractionModel.fromJson(vv.snapshot.value as String);
    print(newvalue.fraction_ID);
//--------------------------------------------------
    all.removeWhere((element) => element.fraction_ID == newvalue.fraction_ID);
    all.add(newvalue);
//--------------------------------------------------

    fractions
        .removeWhere((element) => element.fraction_ID == newvalue.fraction_ID);

    if (newvalue.actions
            .if_action_exist(FractionActon.archive_fraction.getTitle) ==
        false) {
      fractions.add(newvalue);
    } else {
      archived_fractions.add(newvalue);
    }

    notifyListeners();
    print("refrech datata of fractions");
  }

  updateFraction(FractionModel fraction) {
    FirebaseDatabase.instance
        .ref("fractions/${fraction.fraction_ID}")
        .set(fraction.toJson());
  }

  Refresh_the_UI() {
    notifyListeners();
  }

  addfractionslist(List<FractionModel> fractionsss) async {
    for (var element in fractionsss) {
      updateFraction(element);
    }
  }

  deletefractions(FractionModel fraction) {
    fraction.actions.add(FractionActon.archive_fraction.add);
    updateFraction(fraction);
  }

  undeleteFraction(FractionModel fraction) {
    int index = fraction.actions.indexWhere(
        (element) => element.action == FractionActon.archive_fraction.getTitle);
    fraction.actions.removeAt(index);

    updateFraction(fraction);
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  cut_Fraction_on_R_scissor(
      {required FractionModel fractiond,
      required int lastStage,
      required int Rscissor}) {
    fractiond.Rscissor = Rscissor;
    fractiond.actions.add(FractionActon.cut_fraction_OnRscissor.add);
    fractiond.stagenum = lastStage;
    fractiond.underOperation = false;

    updateFraction(fractiond);
  }

  remove_cuttedFraction_from_R_scissor({
    required FractionModel fraction,
  }) {
    fraction.Rscissor = 0;
    fraction.actions
        .removeWhere((element) => element.action == "cut_fraction_OnRscissor");
    fraction.actions.add(FractionActon.Uncut_fraction_OnRscissor.add);
    fraction.stagenum = 0;
    fraction.underOperation = true;
    updateFraction(fraction);
  }

  cut_Fraction_on_A_scissor(
      {required FractionModel fractiond,
      required int lastStage,
      required int Ascissor}) {
    fractiond.Ascissor = Ascissor;
    fractiond.actions.add(FractionActon.cut_fraction_OnAscissor.add);
    fractiond.stagenum = lastStage;

    updateFraction(fractiond);
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

  void add_Not_final_ToFraction_cutted_On_R(
      {required FractionModel fractiond,
      required String type,
      required int Rscissord,
      required double wight}) {
    fractiond.notfinals.add(NotFinal(
        notFinal_ID: DateTime.now().microsecondsSinceEpoch,
        sapa_ID: fractiond.sapa_ID,
        block_ID: fractiond.block_ID,
        fraction_ID: fractiond.fraction_ID,
        StockRequisetionOrder_ID: 0,
        stage: fractiond.stagenum,
        wight: wight,
        type: type,
        scissor: 3 + fractiond.Rscissor,
        actions: [NotFinalAction.create_Not_final_cumingFrom_R.add]));
    fractiond.underOperation = false;
    updateFraction(fractiond);
  }

  void add_Not_final_ToFraction_cutted_on_A(
      {required FractionModel fractiond,
      required String type,
      required int Ascissord,
      required double wight}) {
    fractiond.notfinals.add(NotFinal(
        notFinal_ID: DateTime.now().microsecondsSinceEpoch,
        sapa_ID: fractiond.sapa_ID,
        block_ID: fractiond.block_ID,
        fraction_ID: fractiond.fraction_ID,
        StockRequisetionOrder_ID: 0,
        stage: fractiond.stagenum,
        wight: wight,
        type: type,
        scissor: 7,
        actions: [NotFinalAction.create_Not_final_cumingFrom_A.add]));
    fractiond.underOperation = false;
    updateFraction(fractiond);
  }
}
