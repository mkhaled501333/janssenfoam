// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/notification.dart';

import 'package:http/http.dart' as http;

import 'package:web_socket_channel/web_socket_channel.dart';

class OrderController extends ChangeNotifier {
  Map<String, cutingOrder> cuttingOrders = {};
  Map<String, cutingOrder> initalData = {};
  static late WebSocketChannel channel;

  List<cutingOrder> get opendOrders => cuttingOrders.values
      .where((element) =>
          element.actions.if_action_exist(OrderAction.order_colosed.getTitle) ==
          false)
      .sortedBy<num>((element) => element.serial)
      .reversed
      .toList();
  getData() {
    if (internet == true) {
      cuttingOrders_From_firebase();
    } else {
      cuttingOrders_From_Server();
    }
  }

  cuttingOrders_From_firebase() {
    if (Platform.isAndroid) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("cuttingorders");
      ref.get().then((onValue) {
        if (onValue.value != null) {
          for (var e in onValue.children) {
            final record = cutingOrder.fromJson(e.value.toString());
            if (record.actions
                    .if_action_exist(OrderAction.Archive_order.getTitle) ==
                false) {
              cuttingOrders.addAll({record.cuttingOrder_ID.toString(): record});
            } else {
              cuttingOrders.addAll({record.cuttingOrder_ID.toString(): record});
            }
          }
          print("get orders data");
          Refrsh_ui();
        }
      });
      ref.onChildChanged.listen((onData) {
        if (onData.snapshot.value != null) {
          final record = cutingOrder.fromJson(onData.snapshot.value.toString());
          if (record.actions
                  .if_action_exist(OrderAction.Archive_order.getTitle) ==
              false) {
            cuttingOrders.addAll({record.cuttingOrder_ID.toString(): record});
          } else {}
          print("get orders data");
          Refrsh_ui();
        }
      });
    }
  }

  cuttingOrders_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/cuttingOrders');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      cuttingOrders.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var cittingorder = cutingOrder.fromMap(element);
        if (cittingorder.actions
                .if_action_exist(OrderAction.Archive_order.getTitle) ==
            false) {
          cuttingOrders
              .addAll({cittingorder.cuttingOrder_ID.toString(): cittingorder});
        }
      }
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/cuttingOrders/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      cutingOrder order = cutingOrder.fromJson(u);

      if (order.actions.if_action_exist(OrderAction.Archive_order.getTitle) ==
          false) {
        cuttingOrders.addAll({order.cuttingOrder_ID.toString(): order});
      } else {
        cuttingOrders.addAll({order.cuttingOrder_ID.toString(): order});
      }
      notifyListeners();
    });
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      if (channel.closeCode != null && isserveronline == true) {
        channel = WebSocketChannel.connect(uri2);
        channel.stream.forEach((u) {
          cutingOrder order = cutingOrder.fromJson(u);

          if (order.actions
                  .if_action_exist(OrderAction.Archive_order.getTitle) ==
              false) {
            cuttingOrders.addAll({order.cuttingOrder_ID.toString(): order});
          } else {
            cuttingOrders.addAll({order.cuttingOrder_ID.toString(): order});
          }
          notifyListeners();
        });
      }
    }
  }

  add_order(cutingOrder order, String notificationTittle, String who) async {
    if (internet == true) {
      FirebaseFirestore.instance
          .collection('cuttingorders')
          .doc(order.cuttingOrder_ID.toString())
          .set(order.toMap());
      sendnotification(order, notificationTittle, who);
    } else {
      channel.sink.add(order.toJson());
      sendnotification(order, notificationTittle, who);
    }

    notifyListeners();
  }

  sendnotification(
      cutingOrder order, String notificationTittle, String who) async {
    String dataNotifications = '{ '
        ' "to" : "/topics/myTopic1" , '
        ' "notification" : {'
        ' "title":"(${order.serial})$notificationTittle    " , '
        ' "body":"$who " '
        ' "sound":"default" '
        ' } '
        ' } ';
    await http.post(
      Uri.parse(Constants.BASE_URL),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key= ${Constants.KEY_SERVER}',
      },
      body: dataNotifications,
    );
  }

  OperationOrederItems? item;
  cutingOrder? order;

  Refrsh_ui() {
    notifyListeners();
  }

  bool showAproves = false;
  bool showButtoms = false;
}
