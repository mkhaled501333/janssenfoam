// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/ui/chemical_stock/chemialsApi.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/chemical_stock/chemecalsModels.dart';

class Chemicals_controller extends ChangeNotifier with ChemicalsServerApi {
  getdata() {
    getChemicalsDataFromServer(Refresh_Ui);
    getChemicalsCategoryesDataFromServer(Refresh_Ui);
    getsyplyers(Refresh_Ui);
    getcustomers(Refresh_Ui);
    getunits(Refresh_Ui);
  }

  addChemical(ChemicalsModel Chemical) async {
    if (internet == true) {
    } else {
      channel.sink.add(Chemical.toJson());
    }
  }

  Refresh_Ui() {
    notifyListeners();
  }

  DateTime firstDateOfData() {
    List<DateTime> v = chiemicals
        .where((e) => e.actions.if_action_exist(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .map((e) => e.actions.get_Date_of_action(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .toList();
    return v.isEmpty ? DateTime(2101) : v.min;
  }

  //lllllllllllllllllllllllllllllllllllllllllllllllllllllll

  addChemicalCategory(ChemicalCategory item) async {
    if (internet == true) {
    } else {
      channel2.sink.add(item.toJson());
    }
  }

  addunit(Units unit) async {
    if (internet == true) {
    } else {
      unitchanel.sink.add(unit.toJson());
    }
  }

  addcustomer(ChemicalsCustomers item) async {
    if (internet == true) {
    } else {
      customerchanel.sink.add(item.toJson());
    }
  }

  addsyplyers(ChemicalsSyplyers item) async {
    if (internet == true) {
    } else {
      syplyerchannel.sink.add(item.toJson());
    }
  }
//lllllllllllllllllllllllllllllllllllllllllllllllllllllll

  List<String> selctedFamilys = [];
  List<String> filterdedNames = [];
  List<String> selctedNames = [];

  DateTime? pickedDateFrom;
  DateTime? pickedDateTo;
  List<DateTime> AllDatesOfOfData() {
    var d = chemicalsCategorys;
    List<DateTime> v = [];
    v.addAll(chiemicals
        .where((e) => e.actions.if_action_exist(
            ChemicalAction.creat_Out_ChemicalAction_item.getTitle))
        .map((e) => e.actions.get_Date_of_action(
            ChemicalAction.creat_Out_ChemicalAction_item.getTitle))
        .toList());
    v.addAll(d
        .where((e) => e.actions.if_action_exist(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .map((e) => e.actions.get_Date_of_action(
            ChemicalAction.creat_new_ChemicalAction_item.getTitle))
        .toList());
    return v.isEmpty ? [DateTime.now()] : v;
  }
}
