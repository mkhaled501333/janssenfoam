// ignore_for_file: non_constant_identifier_names, empty_catches, file_names, unused_element
import 'dart:convert';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

class BlockFirebasecontroller extends ChangeNotifier {
  Map<String, BlockModel> all = {};

  Map<String, BlockModel> blocks = {};
  Map<String, BlockModel> archived_blocks = {};
  static late WebSocketChannel channel;
  getData() {
    if (internet == true) {
      blocks_From_firebase();
    } else {
      blocks_From_Server();
    }
  }

  blocks_From_firebase() {
    if (Platform.isAndroid) {
      DatabaseReference ref = FirebaseDatabase.instance.ref("blocks");
      ref.get().then((onValue) {
        if (onValue.value != null) {
          for (var e in onValue.children) {
            final record = BlockModel.fromJson(e.value.toString());
            if (record.actions.if_action_exist(
                    BlockAction.archive_block.getactionTitle) ==
                false) {
              blocks.addAll({record.Block_Id.toString(): record});
            } else {
              blocks.addAll({record.Block_Id.toString(): record});
            }
          }
          print("get blocks data");
          Refresh_the_UI();
        }
      });
      ref.onChildChanged.listen((onData) {
        if (onData.snapshot.value != null) {
          for (var e in onData.snapshot.children) {
            final record = BlockModel.fromJson(e.value.toString());
            if (record.actions.if_action_exist(
                    BlockAction.archive_block.getactionTitle) ==
                false) {
              blocks.addAll({record.Block_Id.toString(): record});
            } else {
              blocks.addAll({record.Block_Id.toString(): record});
            }
          }
          print("get blocks data");
          Refresh_the_UI();
        }
      });
    }
  }

  blocks_From_Server() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/blocks');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      blocks.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var block = BlockModel.fromMap(element);
        if (block.actions
                .if_action_exist(BlockAction.archive_block.getactionTitle) ==
            false) {
          blocks.addAll({block.Block_Id.toString(): block});
        }
      }
      notifyListeners();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/blocks/ws').replace(queryParameters: {
      'username': Sharedprfs.getemail(),
      'password': Sharedprfs.getpassword()
    });

    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      BlockModel record = BlockModel.fromJson(u);
      if (record.actions
              .if_action_exist(BlockAction.archive_block.getactionTitle) ==
          false) {
        blocks.addAll({record.Block_Id.toString(): record});
      }
      notifyListeners();
    });

    while (true) {
      print(channel.closeCode);
      await Future.delayed(const Duration(seconds: 1));
      if (channel.closeCode != null && isserveronline == true) {
        print("reconnect blocks");

        channel = WebSocketChannel.connect(uri2);
        channel.stream.forEach((u) {
          BlockModel record = BlockModel.fromJson(u);
          if (record.actions
                  .if_action_exist(BlockAction.archive_block.getactionTitle) ==
              false) {
            blocks.addAll({record.Block_Id.toString(): record});
          }
          notifyListeners();
        });
      }
    }
  }

  addblock(BlockModel block) async {
    if (internet == true) {
      await FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());

      await FirebaseDatabase.instance
          .ref("temps/${block.Block_Id}")
          .set(jsonEncode("{'blocks':${block.Block_Id}}"));
    } else {
      print('add ${block.number}');
      channel.sink.add(block.toJson());
    }
  }

  addblocklist(List<BlockModel> blocks) async {
    if (internet == true) {
      for (var b in blocks) {
        await FirebaseDatabase.instance
            .ref("blocks/${b.Block_Id}")
            .set(b.toJson());
      }
    } else {
      for (var b in blocks) {
        channel.sink.add(b.toJson());
      }
    }
  }

  updateBlock(BlockModel block) async {
    if (internet == true) {
      await FirebaseDatabase.instance
          .ref("blocks/${block.Block_Id}")
          .set(block.toJson());
    } else {
      channel.sink.add(block.toJson());
    }
  }

  c() {
    if (all.isNotEmpty) {
      // for (var element in all) {
      //   element.Hscissor = 0;
      // }
      // for (var element in all) {
      //   element.Hscissor=15;
      // }
      // for (var element in all.where((element) =>
      //     element.actions
      //             .if_action_exist(BlockAction.consume_block.getactionTitle) ==
      //         false
      //     //     &&
      //     // element.actions
      //     //         .get_Date_of_action(BlockAction.consume_block.getactionTitle)
      //     //         .formatToInt() ==
      //     //     DateTime.now().formatToInt()
      //         )
      //         ) {
      //   element.Hscissor = 0;
      // }

      //   var s = {};
      //   s.addEntries(
      //       all.map((el) => MapEntry("${el.Block_Id}", el.toJson().toString())));
      //   FirebaseDatabase.instance.ref("blocks").set(s);
      //   FirebaseDatabase.instance.ref("blocks").onValue.first.then((value) {
      //     getInitialData(value.snapshot);
      //   });
    }
  }

  Refresh_the_UI() {
    notifyListeners();
  }

  String searchinconsumed = "";
  String searchin_H = "";
  String searchin_blockstock = "";
  int amountofView = 5;
  int amountofViewForMinVeiwIn_H = 5;
  bool veiwCuttedAndimpatyNotfinals = false;

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz

  int initialDateRange2 = DateTime.now().formatToInt();

  List<BlockModel> filterblocksBalanceBetweenTowDates2() {
    List<BlockModel> f = blocks.values
        .toList()
        .where((element) =>
            element.actions
                .get_Date_of_action(BlockAction.create_block.getactionTitle)
                .formatToInt() <=
            initialDateRange2)
        .toList();
    f.removeWhere((element) =>
        element.actions
                .if_action_exist(BlockAction.consume_block.getactionTitle) ==
            true &&
        element.actions
                .get_Date_of_action(BlockAction.consume_block.getactionTitle)
                .formatToInt() <=
            initialDateRange2);
    return f;
  }

  edit_cell_size(dynamic oldvalue, int id, String cell, List<String> newvalue) {
    BlockModel user =
        blocks.values.toList().where((element) => element.Block_Id == id).first;

    user.actions.add(ActionModel(
        action:
            "edit $cell of block  ${user.serial}/${user.number}/  from  $oldvalue  to  $newvalue",
        who: Sharedprfs.getemail() ?? "",
        when: DateTime.now()));
    user.item.L = newvalue[0].to_double();
    user.item.W = newvalue[1].to_double();
    user.item.H = newvalue[2].to_double();
    updateBlock(user);
  }

  edit_cell(int id, String cell, String newvalue) {
    BlockModel user =
        blocks.values.toList().where((element) => element.Block_Id == id).first;

    user.actions.add(ActionModel(
        action: "edit $cell",
        who: Sharedprfs.getemail() ?? "",
        when: DateTime.now()));
    cell == "color" ? user.item.color = newvalue : DoNothingAction();
    cell == "type" ? user.item.type = newvalue : DoNothingAction();
    cell == "density"
        ? user.item.density = newvalue.to_double()
        : DoNothingAction();
    cell == "serial" ? user.serial = newvalue : DoNothingAction();
    cell == "num" ? user.number = newvalue.to_int() : DoNothingAction();
    cell == "description" ? user.discreption = newvalue : DoNothingAction();
    cell == "wight"
        ? user.item.wight = newvalue.to_double()
        : DoNothingAction();
    updateBlock(user);
  }

//zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz
  String? selectedReport;
  String? selectedtype;
  String? selectedcolor;
  double? selectedDensity;
}
