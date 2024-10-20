// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class Customer_controller extends ChangeNotifier {
  Map<String, CustomerModel> customers = {};
  Map<String, CustomerModel> initalData = {};
  static late WebSocketChannel channel;

  getData() {
    if (internet == true) {
      customers_From_firebase();
    } else {
      customers_From_Server();
    }
  }

  customers_From_firebase() {
    if (Platform.isAndroid) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("customers");
      ref.get().then((onValue) {
        if (onValue.value != null) {
          for (var e in onValue.children) {
            final record = CustomerModel.fromJson(e.value.toString());
            if (record.actions.if_action_exist(
                    customerAction.archive_customer.getTitle) ==
                false) {
              customers.addAll({record.customer_id.toString(): record});
            } else {
              customers.addAll({record.customer_id.toString(): record});
            }
          }
          print("get custoers data");
          Refrsh_ui();
        }
      });
      ref.onChildChanged.listen((onData) {
        if (onData.snapshot.value != null) {
          for (var e in onData.snapshot.children) {
            final record = CustomerModel.fromJson(e.value.toString());
            if (record.actions.if_action_exist(
                    customerAction.archive_customer.getTitle) ==
                false) {
              customers.addAll({record.customer_id.toString(): record});
            } else {}
          }
          print("get blocks data");
          Refrsh_ui();
        }
      });
    }
  }

  customers_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/customers');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      customers.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var customer = CustomerModel.fromMap(element);
        if (customer.actions
                .if_action_exist(BlockAction.archive_block.getactionTitle) ==
            false) {
          customers.addAll({customer.customer_id.toString(): customer});
        }
      }
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/customers/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      CustomerModel customer = CustomerModel.fromJson(u);

      if (customer.actions
              .if_action_exist(customerAction.archive_customer.getTitle) ==
          false) {
        customers.addAll({customer.customer_id.toString(): customer});
      } else {}
      notifyListeners();
    });
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      if (channel.closeCode != null && isserveronline == true) {
        channel = WebSocketChannel.connect(uri2);

        channel.stream.forEach((u) {
          CustomerModel customer = CustomerModel.fromJson(u);

          if (customer.actions
                  .if_action_exist(customerAction.archive_customer.getTitle) ==
              false) {
            customers.addAll({customer.customer_id.toString(): customer});
          } else {}
          notifyListeners();
        });
      }
    }
  }

  Add_new_customer(CustomerModel customer) {
    if (internet == true) {
      FirebaseFirestore.instance
          .collection('customers')
          .doc(customer.customer_id.toString())
          .set(customer.toMap());
    } else {
      channel.sink.add(customer.toJson());
    }
  }

  String? initialForRaido;
  // String? initialForcustomer;
  Refrsh_ui() {
    notifyListeners();
  }
}
