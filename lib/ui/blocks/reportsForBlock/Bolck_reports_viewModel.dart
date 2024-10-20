// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/models/moderls.dart';

class BlockReportsViewModel extends BaseViewModel {
  double total_spend(
      BuildContext context, List<BlockModel> blocks, BlockModel block) {
    var x = blocks
        // .filter_date_consumed(context)
        .where((e) =>
            e.item.density == block.item.density &&
            e.item.type == block.item.type)
        .toList()
        .map((e) => e.item.W * e.item.L * e.item.W / 1000000)
        .toList();

    if (x.isNotEmpty) {
      return x.reduce((a, b) => a + b);
    } else {
      return 0.0;
    }
  }

  double Last_period_balance(
      BuildContext context, List<BlockModel> blocks, BlockModel block) {
    var x = blocks
        .where((element) =>
            element.actions
                .if_action_exist(BlockAction.consume_block.getactionTitle) ==
            false)
        .where((e) =>
            e.item.density == block.item.density &&
            e.item.type == block.item.type)
        .toList()
        .map((e) => e.item.H * e.item.L * e.item.W / 1000000);

    if (x.isNotEmpty) {
      return x.reduce((a, b) => a + b);
    } else {
      return 0.0;
    }
  }

  int total_amount_for_single_siz__(BlockModel e, List<BlockModel> blocks) {
    return blocks
        .where(
          (f) =>
              e.item.color == f.item.color &&
              e.item.density == f.item.density &&
              // e.hight == f.hight &&
              e.item.W == f.item.W &&
              e.item.L == f.item.L &&
              e.item.type == f.item.type,
        )
        .toList()
        .length;
  }

  List<BlockModel> sizes(BlockModel e, List<BlockModel> blocks) {
    return blocks
        .where(
          (f) =>
              e.item.color == f.item.color &&
              e.item.density == f.item.density &&
              e.item.type == f.item.type,
        )
        .toList();
  }
}
