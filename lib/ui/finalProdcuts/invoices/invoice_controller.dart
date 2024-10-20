// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class Invoice_controller extends ChangeNotifier {
  static late WebSocketChannel channel;
  List<Invoice> invoices = [];

  getData() {
    if (internet == true) {
      finals_From_firebase();
    } else {
      finals_From_Server();
    }
  }

  finals_From_firebase() {}

  finals_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/invoices');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      invoices.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var item = Invoice.fromMap(element);
        if (item.actions
                .if_action_exist(InvoiceAction.archive_invoice.getTitle) ==
            false) {
          invoices.add(item);
        }
      }
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/invoices/ws').replace(queryParameters: {
      'username': Sharedprfs.getemail(),
      'password': Sharedprfs.getpassword()
    });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      Invoice user = Invoice.fromJson(u);
      var index =
          invoices.map((e) => e.invoice_ID).toList().indexOf(user.invoice_ID);
      if (user.actions
              .if_action_exist(InvoiceAction.archive_invoice.getTitle) ==
          false) {
        if (index == -1) {
          invoices.add(user);
        } else {
          invoices.removeAt(index);
          invoices.add(user);
        }
      }
      notifyListeners();
    });
  }

  List<Invoice> edits = [];
  int x = 0;

  addInvoice(Invoice invoice) async {
    if (internet == true) {
      FirebaseDatabase.instance
          .ref("invoices/${invoice.invoice_ID}")
          .set(invoice.toJson());
    } else {
      channel.sink.add(invoice.toJson());
    }
  }
}
