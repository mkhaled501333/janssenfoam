// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables, use_function_type_syntax_for_parameters, camel_case_types

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/cutting_order/cutting_ordera_viewModer.dart';

import 'package:provider/provider.dart';

class dropDowenContoller extends ChangeNotifier {
  int? initialForRaido;
  Refrsh_ui() {
    notifyListeners();
  }

  TextEditingController N = TextEditingController();
  int? initioalFor_Scissors;
  List<int> scissors = [1, 2, 3, 4, 5, 6, 7];
  get_label(int e) {
    switch (e) {
      case 1:
        return const Text("مقص راسى 1");
      case 2:
        return const Text("مقص راسى 2");
      case 3:
        return const Text("مقص راسى 3");
      case 4:
        return const Text("مقص دائرى 1");
      case 5:
        return const Text("مقص دائرى 2");
      case 6:
        return const Text("مقص دائرى 3");
      case 7:
        return const Text("مقص اوتوماتيك");
    }
  }

  int? initioalFor_ScissorsReports;
  List<int> scissorsReports = [1, 2, 3];
  get_labelReports(int e) {
    switch (e) {
      case 1:
        return const Text("مقص راسى 1");
      case 2:
        return const Text("مقص راسى 2");
      case 3:
        return const Text("مقص راسى 3");
    }
  }

  int? initioalFor_RScissorsReports;
  List<int> scissorsRReports = [1, 2, 3];
  get_RlabelReports(int e) {
    switch (e) {
      case 1:
        return const Text("مقص دائرى 1");
      case 2:
        return const Text("مقص دائرى 2");
      case 3:
        return const Text("مقص دائرى 3");
    }
  }

  getblocks(BuildContext context, CuttingOrderViewModel vm) {
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
    initialdensity != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .values
            .toList()
            .where((element) =>
                element.actions.if_action_exist(
                    BlockAction.consume_block.getactionTitle) ==
                false)
            .where((element) => element.item.density == initialdensity)
            .toList()
        : DoNothingAction;
    initialcolor != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .values
            .toList()
            .where((element) =>
                element.actions.if_action_exist(
                    BlockAction.consume_block.getactionTitle) ==
                false)
            .where((element) => element.item.color == initialcolor)
            .toList()
        : DoNothingAction;
    initialtype != null
        ? x = context
            .read<BlockFirebasecontroller>()
            .blocks
            .values
            .toList()
            .where((element) =>
                element.actions.if_action_exist(
                    BlockAction.consume_block.getactionTitle) ==
                false)
            .where((element) => element.item.type == initialtype)
            .toList()
        : DoNothingAction;
    if (initialtype != null && initialcolor != null) {
      x = context
          .read<BlockFirebasecontroller>()
          .blocks
          .values
          .toList()
          .where((element) =>
              element.actions
                  .if_action_exist(BlockAction.consume_block.getactionTitle) ==
              false)
          .where((element) =>
              element.item.color == initialcolor &&
              element.item.type == initialtype)
          .toList();
    }
    if (initialtype != null && initialdensity != null) {
      x = context
          .read<BlockFirebasecontroller>()
          .blocks
          .values
          .toList()
          .where((element) =>
              element.actions
                  .if_action_exist(BlockAction.consume_block.getactionTitle) ==
              false)
          .where((element) =>
              element.item.density == initialdensity &&
              element.item.type == initialtype)
          .toList();
    }
    if (initialdensity != null && initialcolor != null) {
      x = context
          .read<BlockFirebasecontroller>()
          .blocks
          .values
          .toList()
          .where((element) =>
              element.actions
                  .if_action_exist(BlockAction.consume_block.getactionTitle) ==
              false)
          .where((element) =>
              element.item.density == initialdensity &&
              element.item.color == initialcolor)
          .toList();
    }

    blocks = x;
  }

  List<BlockModel> blocks = [];

  String? initialtype;
  List<String> filterType() {
    return blocks.map((e) => e.item.type).toSet().toList();
  }

  String? initialcolor;
  List<String> filtercolor() {
    return blocks.map((e) => e.item.color).toSet().toList();
  }

  double? initialdensity;
  List<double> filterdensity() {
    return blocks.map((e) => e.item.density.toDouble()).toSet().toList();
  }

  String? selectedreport;
}
