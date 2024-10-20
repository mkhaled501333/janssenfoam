// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';

import 'package:janssenfoam/ui/scissors/sR/Rscissor_viewModel.dart';
import 'package:provider/provider.dart';

class ObjectBoxController extends ChangeNotifier {
  int lenthInFilter = 0;
  Rfrech_ui() {
    notifyListeners();
  }

  get() {
    notifyListeners();
  }

  String? serial;
  //for reports
  String? serial2;
  String? initialcolor;

  String? serialforH;
  String? initialcolorforH;

  List<String> filtercolor(List<BlockModel> blocks) {
    return blocks.map((e) => e.item.color).toSet().toList();
  }

  List<String> filtercolorforH(List<BlockModel> blocks) {
    return blocks
        .where((element) =>
            element.actions.if_action_exist(
                    BlockAction.consume_block.getactionTitle) ==
                true &&
            element.Hscissor == 0)
        .map((e) => e.item.color)
        .toSet()
        .toList();
  }

  getblocks(BuildContext context) {
    List<BlockModel> x = context
        .read<BlockFirebasecontroller>()
        .blocks
        .values
        .toList()
        .where((element) =>
            element.actions
                .if_action_exist(BlockAction.consume_block.getactionTitle) ==
            false)
        .toList();

    initialcolor != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .values
            .toList()
            .where((element) => element.item.color == initialcolor)
            .toList()
        : DoNothingAction;
    serial != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .values
            .toList()
            .where((element) => element.serial == serial)
            .toList()
        : DoNothingAction;

    blocks = x;
  }

  getblocksConsumedAndNotCutted(BuildContext context) {
    List<BlockModel> x = context
        .read<BlockFirebasecontroller>()
        .blocks
        .values
        .toList()
        .where((element) =>
            element.actions.if_action_exist(
                    BlockAction.consume_block.getactionTitle) ==
                true &&
            element.Hscissor == 0)
        .toList();

    initialcolorforH != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .values
            .toList()
            .where((element) =>
                element.actions.if_action_exist(
                        BlockAction.consume_block.getactionTitle) ==
                    true &&
                element.Hscissor == 0)
            .toList()
            .where((element) => element.item.color == initialcolorforH)
            .toList()
        : DoNothingAction;
    serialforH != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .values
            .toList()
            .where((element) =>
                element.actions.if_action_exist(
                        BlockAction.consume_block.getactionTitle) ==
                    true &&
                element.Hscissor == 0)
            .toList()
            .where((element) => element.serial == serialforH)
            .toList()
        : DoNothingAction;

    blocksforH = x;
  }

  List<BlockModel> blocks = [];
  List<BlockModel> blocksforH = [];

  List<String> notfials = [
    "جوانب",
    "ارضيات",
    "هالك",
    "درجه ثانيه",
    "درجه ثانيه ممتازه"
  ];
  String initial = "جوانب";
  String initial2 = "ارضيات";
  BLockDetailsOf? selectedValueOfBLockDetailsOf;
  gdet() {
    switch (initial) {
      case "جوانب":
        return "aspects";
      case "ارضيات":
        return "floors";
      case "هالك":
        return "Halek";
      case "درجه ثانيه":
        return "secondDegree";
      case "درجه ثانيه ممتازه":
        return "ExcellentsecondDegree";
    }
  }

  gdet222() {
    switch (initial2) {
      case "جوانب":
        return "aspects";
      case "ارضيات":
        return "floors";
      case "هالك":
        return "Halek";
      case "درجه ثانيه":
        return "secondDegree";
      case "درجه ثانيه ممتازه":
        return "ExcellentsecondDegree";
    }
  }
}
