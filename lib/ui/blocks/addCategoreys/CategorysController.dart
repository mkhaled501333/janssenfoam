// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types, empty_catches

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class Category_controller extends ChangeNotifier {
  List<BlockCategory> blockCategorys = [];
  static late WebSocketChannel channel;

  getData() {
    if (internet == true) {
      chemicals_From_firebase();
    } else {
      chmecals_From_Server();
    }
  }

  chemicals_From_firebase() {}

  chmecals_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/blockCategory');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      blockCategorys.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var item = BlockCategory.fromMap(element);
        if (item.actions.if_action_exist(
                BlockCategoryAction.archive_block_category.getTitle) ==
            false) {
          blockCategorys.add(item);
        }
      }
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/blockCategory/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      BlockCategory item = BlockCategory.fromJson(u);
      var index = blockCategorys
          .map((e) => e.blockCategory_ID)
          .toList()
          .indexOf(item.blockCategory_ID);
      if (index == -1) {
        if (item.actions.if_action_exist(
                BlockCategoryAction.archive_block_category.getTitle) ==
            false) {
          blockCategorys.add(item);
        }
      } else {
        blockCategorys.removeAt(index);
        if (item.actions.if_action_exist(
                ChemicalAction.archive_ChemicalAction_item.getTitle) ==
            false) {
          blockCategorys.add(item);
        }
      }
      print("get chemcasl $item");
      notifyListeners();
    });
  }

  int x = 0;

  updateBlockCategory(BlockCategory blockcategory) async {
    if (internet == true) {
      FirebaseFirestore.instance
          .collection('blockCategory')
          .doc(blockcategory.blockCategory_ID.toString())
          .set(blockcategory.toMap());
    } else {
      channel.sink.add(blockcategory.toJson());
    }
  }

  BlockCategory? initialFordropdowen;

  Refresh_Ui() {
    notifyListeners();
  }
}
