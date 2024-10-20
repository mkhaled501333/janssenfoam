// ignore_for_file: non_constant_identifier_names, empty_catches, file_names, camel_case_types

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class StokCheck_Controller extends ChangeNotifier {
  Map<String, StockCheckModel> all = {};
  Map<String, StockCheckModel> stockChecks = {};
  Map<String, StockCheckModel> archived_stockChecks = {};
  Refresh_the_UI() {
    notifyListeners();
  }

  static late WebSocketChannel channel;

  get_StokCheck_data() {
    if (internet == true) {
    } else {
      stockchecks_From_Server();
    }
  }

  stockchecks_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/stockcheck');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      stockChecks.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var item = StockCheckModel.fromMap(element);
        if (item.actions.if_action_exist(
                StockCheckAction.archive_StockCheck.getTitle) ==
            false) {
          stockChecks.addAll({item.stockCheck_ID.toString(): item});
        }
      }
      Refresh_the_UI();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/stockcheck/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      StockCheckModel item = StockCheckModel.fromJson(u);
      if (item.actions
              .if_action_exist(StockCheckAction.archive_StockCheck.getTitle) ==
          false) {
        stockChecks.addAll({item.stockCheck_ID.toString(): item});
      }
      Refresh_the_UI();
    });
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      if (channel.closeCode != null && isserveronline == true) {
        channel = WebSocketChannel.connect(uri2);
        channel.stream.forEach((u) {
          StockCheckModel item = StockCheckModel.fromJson(u);
          if (item.actions.if_action_exist(
                  StockCheckAction.archive_StockCheck.getTitle) ==
              false) {
            stockChecks.addAll({item.stockCheck_ID.toString(): item});
          }
          Refresh_the_UI();
        });
      }
    }
  }

  addNewStockCheck(StockCheckModel stockCheck) async {
    channel.sink.add(stockCheck.toJson());
  }

  deleteStockCheck(StockCheckModel stockCheck) {
    stockCheck.actions.add(StockCheckAction.archive_StockCheck.add);
    channel.sink.add(stockCheck.toJson());
  }

  MakeRefreshOfData(StockCheckModel stockCheck) {
    stockCheck.actions.add(StockCheckAction.refrechDone.add);
    channel.sink.add(stockCheck.toJson());
  }

  undeleteFraction(StockCheckModel stockCheck) {
    int index = stockCheck.actions.indexWhere((element) =>
        element.action == StockCheckAction.archive_StockCheck.getTitle);
    stockCheck.actions.removeAt(index);
    FirebaseDatabase.instance
        .ref("FstockCheck/${stockCheck.stockCheck_ID}")
        .set(stockCheck.toJson());
    notifyListeners();
  }

  String? selectedreport;
  DateTime? pickedDateFrom;
  DateTime? pickedDateTo;
  List<DateTime> AllDatesOfOfData() {
    List<DateTime> v = stockChecks.values
        .where((e) => e.actions
            .if_action_exist(StockCheckAction.creat_new_StockCheck.getTitle))
        .map((e) => e.actions
            .get_Date_of_action(StockCheckAction.creat_new_StockCheck.getTitle))
        .toList();
    return v.isEmpty ? [DateTime.now()] : v;
  }
}
