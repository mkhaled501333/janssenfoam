import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/models/moderls.dart';

extension A1 on List<BlockModel> {
  List<BlockModel> search(String value) {
    if (value.isEmpty) {
      return this;
    } else {
      return where((user) => user.number.toString().contains(value))
          .toList()
          .sortedBy<num>((element) => element.number)
          .reversed
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }
  }

  String size() {
    var x = map((e) => e.item.L * e.item.W * e.item.H / 1000000);
    return x.isEmpty ? "0" : x.reduce((a, b) => a + b).toStringAsFixed(1);
  }

  List<BlockModel> search2(String value) {
    if (value.isEmpty) {
      return this;
    } else {
      return where((user) => user.number.toString().contains(value))
          .toList()
          .sortedBy<num>((element) => element.number)
          .toList();

      // we use the toLowerCase() method to make it case-insensitive
    }
  }

  List<BlockModel> filterConsumeDateBetween(DateTimeRange initialDateRange) {
    return where((element) =>
        element.OutTo == "صالة الانتاج" &&
        element.actions
                .get_Date_of_action(BlockAction.consume_block.getactionTitle)
                .formatToInt() >=
            initialDateRange.start.formatToInt() &&
        element.actions
                .get_Date_of_action(BlockAction.consume_block.getactionTitle)
                .formatToInt() <=
            initialDateRange.end.formatToInt()).toList();
  }

  List<BlockModel> filterserials() {
    List<BlockModel> nonRepetitive = [];

    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].serial == nonRepetitive[j].serial) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> ffffffffffffff() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].Block_Id == nonRepetitive[j].Block_Id) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  //filter date and archive
  List<BlockModel> filter_date_consumed(BuildContext context) {
    DateFormat format = DateFormat('yyyy/MM/dd');
    return where((element) => element.actions
            .if_action_exist(BlockAction.consume_block.getactionTitle))
        .where((element) =>
            format.format(element.actions.get_Date_of_action(
                BlockAction.consume_block.getactionTitle)) ==
            DateTime.now().formatt())
        .toList();
  }

  List<BlockModel> filter_filter_type_and_density() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> filter_filter_type_and_density_color() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].item.density == nonRepetitive[j].item.density) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> filter_basedOn_Type(String? type) {
    if (type == null) {
      return this;
    } else {
      return where((test) => test.item.type == type).toList();
    }
  }

  List<BlockModel> filter_basedOn_color(String? color) {
    if (color == null) {
      return this;
    } else {
      return where((test) => test.item.color == color).toList();
    }
  }

  List<BlockModel> filter_basedOn_density(double? density) {
    if (density == null) {
      return this;
    } else {
      return where((test) => test.item.density == density.toDouble()).toList();
    }
  }

  List<BlockModel> filter_description() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].discreption == nonRepetitive[j].discreption) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> filter_filter_type_density_color_size() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density &&
            this[i].item.color == nonRepetitive[j].item.color &&

            // this[i].hight == nonRepetitive[j].hight &&

            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.W == nonRepetitive[j].item.W) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> filter_filter_type_density_color_size_serial() {
    List<BlockModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.density == nonRepetitive[j].item.density &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].serial == nonRepetitive[j].serial &&
            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.W == nonRepetitive[j].item.W &&
            this[i].item.H == nonRepetitive[j].item.H) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<BlockModel> consumedAndNotCuttedBeforeStartDate(DateTime from) {
    return where((element) =>
        element.actions
            .if_action_exist(BlockAction.consume_block.getactionTitle) &&
        element.Hscissor == 0 &&
        element.actions
                .get_Date_of_action(BlockAction.consume_block.getactionTitle)
                .formatToInt() <
            from.formatToInt()).toList();
  }
}
