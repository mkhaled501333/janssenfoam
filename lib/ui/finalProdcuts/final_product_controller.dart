// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, empty_catches, camel_case_types

import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/ui/finalProdcuts/finalProdcutExtentions.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class final_prodcut_controller extends ChangeNotifier {
  Map<String, FinalProductModel> all = {};
  Map<String, FinalProductModel> finalproducts = {};
  Map<String, FinalProductModel> Archived_finalproducts = {};
  static late WebSocketChannel channel;
  getData() {
    if (internet == true) {
      finals_From_firebase();
    } else {
      finals_From_Server();
    }
  }

  finals_From_firebase() {
    if (Platform.isAndroid) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("finalprodcuts");
      ref.get().then((onValue) {
        if (onValue.value != null) {
          for (var e in onValue.children) {
            final record = FinalProductModel.fromJson(e.value.toString());
            if (record.actions.if_action_exist(
                    finalProdcutAction.archive_final_prodcut.getactionTitle) ==
                false) {
              finalproducts.addAll({record.finalProdcut_ID.toString(): record});
            } else {
              finalproducts.remove(record.finalProdcut_ID.toString());
              Archived_finalproducts.addAll(
                  {record.finalProdcut_ID.toString(): record});
            }
          }
          print("get finalprodcuts data");
          Refresh_Ui();
        }
      });
      ref.onChildChanged.listen((onData) {
        if (onData.snapshot.value != null) {
          final record =
              FinalProductModel.fromJson(onData.snapshot.value.toString());
          if (record.actions.if_action_exist(
                  finalProdcutAction.archive_final_prodcut.getactionTitle) ==
              false) {
            finalproducts.addAll({record.finalProdcut_ID.toString(): record});
          } else {}
          print("get blocks data");
          Refresh_Ui();
        }
      });
    }
  }

  finals_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/finalProducts');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      finalproducts.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var item = FinalProductModel.fromMap(element);
        if (item.actions.if_action_exist(
                finalProdcutAction.archive_final_prodcut.getactionTitle) ==
            false) {
          finalproducts.addAll({item.finalProdcut_ID.toString(): item});
        }
      }
      Refresh_Ui();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/finalProducts/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      FinalProductModel user = FinalProductModel.fromJson(u);

      if (user.actions.if_action_exist(
              finalProdcutAction.archive_final_prodcut.getactionTitle) ==
          false) {
        finalproducts.addAll({user.finalProdcut_ID.toString(): user});
      } else {
        finalproducts.remove(user.finalProdcut_ID.toString());
      }
      Refresh_Ui();
    });
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      if (channel.closeCode != null && isserveronline == true) {
        channel = WebSocketChannel.connect(uri2);
        channel.stream.forEach((u) {
          FinalProductModel user = FinalProductModel.fromJson(u);

          if (user.actions.if_action_exist(
                  finalProdcutAction.archive_final_prodcut.getactionTitle) ==
              false) {
            finalproducts.addAll({user.finalProdcut_ID.toString(): user});
          } else {
            finalproducts.remove(user.finalProdcut_ID.toString());
          }
          Refresh_Ui();
        });
      }
    }
  }

  updateFinalProdcut(FinalProductModel itme) async {
    if (internet == true) {
      await FirebaseDatabase.instance
          .ref("finalProducts/${itme.finalProdcut_ID}")
          .set(itme.toJson());
    } else {
      channel.sink.add(itme.toJson());
    }
  }

  updateItemsWith_actionAndInvioceNum(
      List<FinalProductModel> finalss, int invoiceNum) {
    for (var x in finalss) {
      x.invoiceNum = invoiceNum;
      x.actions.add(finalProdcutAction.createInvoice.add);
      updateFinalProdcut(x);
    }
  }

  Refresh_Ui() {
    notifyListeners();
  }

  List<FinalProductModel> nowBbalanceInStock() {
    List<FinalProductModel> finals = finalproducts.values.toList();
    List<FinalProductModel> instock = finals
        .where((e) => e.actions.if_action_exist(finalProdcutAction
            .recive_Done_Form_FinalProdcutStock.getactionTitle))
        .toList();

    return instock
        .filter_density_typ_color_size()
        .map((a) {
          int quantity = instock.countOf(a);
          double vol = quantity * a.item.L * a.item.W * a.item.H / 1000000;
          return FinalProductModel(
              finalProdcut_ID: 0,
              block_ID: 0,
              fraction_ID: 0,
              subfraction_ID: 0,
              sapa_ID: "0",
              sapa_desc: "0",
              item: FinalProdcutItme(
                  L: a.item.L,
                  W: a.item.W,
                  H: a.item.H,
                  density: a.item.density,
                  volume: vol,
                  theowight: vol * a.item.density,
                  realowight: 0,
                  color: a.item.color,
                  type: a.item.type,
                  amount: quantity,
                  priceforamount: 0),
              scissor: 0,
              stage: 0,
              worker: '',
              customer: '',
              notes: '',
              invoiceNum: 0,
              cuting_order_number: 0,
              actions: [],
              updatedat: 0);
        })
        .where((test) => test.item.amount != 0)
        .toList();
  }

  List<FinalProductModel> BalanceToDate(DateTime to) {
    List<FinalProductModel> finals = finalproducts.values.toList();
    List<FinalProductModel> TODate = finals
        .where((e) =>
            e.actions
                .get_Date_of_action(finalProdcutAction
                    .recive_Done_Form_FinalProdcutStock.getactionTitle)
                .formatToInt() <=
            to.formatToInt())
        .toList();

    return TODate.filter_density_typ_color_size().map((a) {
      int quantity = TODate.countOf(a);
      double vol = quantity * a.item.L * a.item.W * a.item.H / 1000000;
      return FinalProductModel(
          finalProdcut_ID: 0,
          block_ID: 0,
          fraction_ID: 0,
          subfraction_ID: 0,
          sapa_ID: "0",
          sapa_desc: "0",
          item: FinalProdcutItme(
              L: a.item.L,
              W: a.item.W,
              H: a.item.H,
              density: a.item.density,
              volume: vol,
              theowight: vol * a.item.density,
              realowight: 0,
              color: a.item.color,
              type: a.item.type,
              amount: quantity,
              priceforamount: 0),
          scissor: 0,
          stage: 0,
          worker: '',
          customer: '',
          notes: '',
          invoiceNum: 0,
          cuting_order_number: 0,
          actions: [],
          updatedat: 0);
    }).toList();
  }

  List<FinalProductModel> FirstPeriodBalanceToDate(DateTime to) {
    List<FinalProductModel> finals = finalproducts.values.toList();
    List<FinalProductModel> TODate = finals
        .where((e) =>
            e.actions
                .get_Date_of_action(finalProdcutAction
                    .recive_Done_Form_FinalProdcutStock.getactionTitle)
                .formatToInt() <
            to.formatToInt())
        .toList();

    return TODate.filter_density_typ_color_size().map((a) {
      int quantity = TODate.countOf(a);
      double vol = quantity * a.item.L * a.item.W * a.item.H / 1000000;
      return FinalProductModel(
          finalProdcut_ID: 0,
          block_ID: 0,
          fraction_ID: 0,
          subfraction_ID: 0,
          sapa_ID: "0",
          sapa_desc: "0",
          item: FinalProdcutItme(
              L: a.item.L,
              W: a.item.W,
              H: a.item.H,
              density: a.item.density,
              volume: vol,
              theowight: vol * a.item.density,
              realowight: 0,
              color: a.item.color,
              type: a.item.type,
              amount: quantity,
              priceforamount: 0),
          scissor: 0,
          stage: 0,
          worker: '',
          customer: '',
          notes: '',
          invoiceNum: 0,
          cuting_order_number: 0,
          actions: [],
          updatedat: 0);
    }).toList();
  }

  List<FinalProductModel> OUtBalanceBetween(DateTime from, DateTime to) {
    List<FinalProductModel> finals = finalproducts.values.toList();
    List<FinalProductModel> TODate = finals
        .where((e) =>
            e.item.amount < 0 &&
            e.actions
                    .get_Date_of_action(finalProdcutAction
                        .recive_Done_Form_FinalProdcutStock.getactionTitle)
                    .formatToInt() <=
                to.formatToInt() &&
            e.actions
                    .get_Date_of_action(finalProdcutAction
                        .recive_Done_Form_FinalProdcutStock.getactionTitle)
                    .formatToInt() >=
                from.formatToInt())
        .toList();

    return TODate.filter_density_typ_color_size().map((a) {
      int quantity = TODate.countOf(a);
      double vol = quantity * a.item.L * a.item.W * a.item.H / 1000000;
      return FinalProductModel(
          finalProdcut_ID: 0,
          block_ID: 0,
          fraction_ID: 0,
          subfraction_ID: 0,
          sapa_ID: "0",
          sapa_desc: "0",
          item: FinalProdcutItme(
              L: a.item.L,
              W: a.item.W,
              H: a.item.H,
              density: a.item.density,
              volume: vol,
              theowight: vol * a.item.density,
              realowight: 0,
              color: a.item.color,
              type: a.item.type,
              amount: quantity,
              priceforamount: 0),
          scissor: 0,
          stage: 0,
          worker: '',
          customer: '',
          notes: '',
          invoiceNum: 0,
          cuting_order_number: 0,
          actions: [],
          updatedat: 0);
    }).toList();
  }

  List<FinalProductModel> INBalanceBetween(DateTime from, DateTime to) {
    List<FinalProductModel> finals = finalproducts.values.toList();
    List<FinalProductModel> TODate = finals
        .where((e) =>
            e.item.amount > 0 &&
            e.actions
                    .get_Date_of_action(finalProdcutAction
                        .recive_Done_Form_FinalProdcutStock.getactionTitle)
                    .formatToInt() <=
                to.formatToInt() &&
            e.actions
                    .get_Date_of_action(finalProdcutAction
                        .recive_Done_Form_FinalProdcutStock.getactionTitle)
                    .formatToInt() >=
                from.formatToInt())
        .toList();

    return TODate.filter_density_typ_color_size().map((a) {
      int quantity = TODate.countOf(a);
      double vol = quantity * a.item.L * a.item.W * a.item.H / 1000000;
      return FinalProductModel(
          finalProdcut_ID: 0,
          block_ID: 0,
          fraction_ID: 0,
          subfraction_ID: 0,
          sapa_ID: "0",
          sapa_desc: "0",
          item: FinalProdcutItme(
              L: a.item.L,
              W: a.item.W,
              H: a.item.H,
              density: a.item.density,
              volume: vol,
              theowight: vol * a.item.density,
              realowight: 0,
              color: a.item.color,
              type: a.item.type,
              amount: quantity,
              priceforamount: 0),
          scissor: 0,
          stage: 0,
          worker: '',
          customer: '',
          notes: '',
          invoiceNum: 0,
          cuting_order_number: 0,
          actions: [],
          updatedat: 0);
    }).toList();
  }

  edit_cell(int id, String cell, String newvalue) {
    FinalProductModel user = finalproducts.values
        .where((element) => element.finalProdcut_ID == id)
        .first;

    user.actions.add(ActionModel(
        action: "edit $cell",
        who: Sharedprfs.getemail() ?? "",
        when: DateTime.now()));
    cell == "amount" ? user.item.amount = newvalue.to_int() : DoNothingAction();
    cell == "type" ? user.item.type = newvalue : DoNothingAction();
    cell == "density"
        ? user.item.density = newvalue.to_double()
        : DoNothingAction();
    cell == "color" ? user.item.color = newvalue : DoNothingAction();
    cell == "customer" ? user.customer = newvalue : DoNothingAction();
    updateFinalProdcut(user);
  }

  edit_cell_size(int id, String cell, List<String> newvalue) {
    FinalProductModel user = finalproducts.values
        .where((element) => element.finalProdcut_ID == id)
        .first;

    user.actions.add(ActionModel(
        action: "edit $cell",
        who: Sharedprfs.getemail() ?? "",
        when: DateTime.now()));
    user.item.L = newvalue[0].to_double();
    user.item.W = newvalue[1].to_double();
    user.item.H = newvalue[2].to_double();
    updateFinalProdcut(user);
  }

  String searchin_OutOFStock = "";
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  List<String> selctedcolors = [];
  List<String> selctedtybes = [];
  List<String> selctedDensities = [];
  List<String> selctedsizes = [];
  List<String> selctedcustomers = [];
  String? selectedreport;
  DateTime? pickedDateFrom;
  DateTime? pickedDateTo;
  List<DateTime> AllDatesOfOfData() {
    List<DateTime> a = finalproducts.values
        .where((e) => e.actions.if_action_exist(
            finalProdcutAction.incert_finalProduct_from_Others.getactionTitle))
        .map((e) => e.actions.get_Date_of_action(
            finalProdcutAction.incert_finalProduct_from_Others.getactionTitle))
        .toList();
    List<DateTime> b = finalproducts.values
        .where((e) => e.actions.if_action_exist(finalProdcutAction
            .incert_finalProduct_from_cutingUnit.getactionTitle))
        .map((e) => e.actions.get_Date_of_action(finalProdcutAction
            .incert_finalProduct_from_cutingUnit.getactionTitle))
        .toList();
    var v = a + b;
    return v.isEmpty ? [DateTime.now()] : v;
  }

  int indexOfRadioButon = 0;
}
