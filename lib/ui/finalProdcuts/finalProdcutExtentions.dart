// ignore_for_file: non_constant_identifier_names

import 'package:janssenfoam/core/recources/enums.dart';

import '../../app/extentions.dart';
import '../../models/moderls.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension Filter on List<FinalProductModel> {
  List<FinalProductModel> search(String value) {
    if (value.isEmpty) {
      return this;
    } else {
      return where((item) => (item.item.L.removeTrailingZeros +
              item.item.W.removeTrailingZeros +
              item.item.H.removeTrailingZeros)
          .toString()
          .contains(value)).toList().toList();

      // we use the toLowerCase() method to make it case-insensitive
    }
  }

  int countOf(FinalProductModel e) {
    var a = where((element) =>
        element.item.L == e.item.L &&
        element.item.W == e.item.W &&
        element.item.H == e.item.H &&
        element.item.color == e.item.color &&
        element.item.type == e.item.type &&
        element.item.density == e.item.density).map((e) => e.item.amount);

    return a.isEmpty ? 0 : a.reduce((a, b) => a + b);
  }

  List<FinalProductModel> filterItemsPasedOnDensites(
      BuildContext context, List<String> densities) {
    List<FinalProductModel> l = [];
    if (densities.isNotEmpty) {
      for (var f in densities) {
        for (var i in this) {
          if (i.item.density.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<FinalProductModel> filterItemsPasedOncolors(
      BuildContext context, List<String> colors) {
    List<FinalProductModel> l = [];
    if (colors.isNotEmpty) {
      for (var f in colors) {
        for (var i in this) {
          if (i.item.color.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<FinalProductModel> filterItemsPasedOntypes(
      BuildContext context, List<String> types) {
    List<FinalProductModel> l = [];
    if (types.isNotEmpty) {
      for (var f in types) {
        for (var i in this) {
          if (i.item.type.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<FinalProductModel> filterItemsPasedOnCustomers(
      BuildContext context, List<String> customers) {
    List<FinalProductModel> l = [];
    if (customers.isNotEmpty) {
      for (var f in customers) {
        for (var i in this) {
          if (i.customer.customername(context).toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<FinalProductModel> filterItemsPasedOnsizes(
      BuildContext context, List<String> sizes) {
    List<FinalProductModel> l = [];
    if (sizes.isNotEmpty) {
      for (var f in sizes) {
        for (var i in this) {
          if ("${i.item.L.removeTrailingZeros}*${i.item.W.removeTrailingZeros}*${i.item.H.removeTrailingZeros}" ==
              f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<FinalProductModel> filterFinalProductDateBetween(
    DateTime start,
    DateTime end,
  ) {
    return where((element) =>
        element.actions.if_action_exist(finalProdcutAction
                .incert_finalProduct_from_cutingUnit.getactionTitle) ==
            true &&
        element.actions
                .get_Date_of_action(finalProdcutAction
                    .incert_finalProduct_from_cutingUnit.getactionTitle)
                .formatToInt() >=
            start.formatToInt() &&
        element.actions
                .get_Date_of_action(finalProdcutAction
                    .incert_finalProduct_from_cutingUnit.getactionTitle)
                .formatToInt() <=
            end.formatToInt()).toList();
  }

  List<FinalProductModel> filterFinalProduct_out_DateBetween(
      DateTime start, DateTime end) {
    return where((element) =>
        element.actions
                .if_action_exist(finalProdcutAction.out_order.getactionTitle) ==
            true &&
        element.actions
                .get_Date_of_action(finalProdcutAction.out_order.getactionTitle)
                .formatToInt() >=
            start.formatToInt() &&
        element.actions
                .get_Date_of_action(finalProdcutAction.out_order.getactionTitle)
                .formatToInt() <=
            end.formatToInt()).toList();
  }

  List<FinalProductModel> filterFinalProduct_out_DateBetween_from(
      DateTime start, DateTime end, FinalProductModel e) {
    return where((element) =>
            element.item.color == e.item.color &&
            element.item.type == e.item.type &&
            element.item.density == e.item.density &&
            element.item.L == e.item.L &&
            element.item.W == e.item.W &&
            element.item.H == e.item.H)
        .where((element) =>
            element.actions.if_action_exist(
                    finalProdcutAction.out_order.getactionTitle) ==
                true &&
            element.actions
                    .get_Date_of_action(
                        finalProdcutAction.out_order.getactionTitle)
                    .formatToInt() >=
                start.formatToInt() &&
            element.actions
                    .get_Date_of_action(
                        finalProdcutAction.out_order.getactionTitle)
                    .formatToInt() <=
                end.formatToInt())
        .toList();
  }

  List<FinalProductModel> filterFinalProduct_IN_DateBetween(
      DateTime start, DateTime end) {
    return where((element) =>
        element.actions.if_action_exist(finalProdcutAction
                .incert_finalProduct_from_cutingUnit.getactionTitle) ==
            true &&
        element.actions
                .get_Date_of_action(finalProdcutAction
                    .incert_finalProduct_from_cutingUnit.getactionTitle)
                .formatToInt() >=
            start.formatToInt() &&
        element.actions
                .get_Date_of_action(finalProdcutAction
                    .incert_finalProduct_from_cutingUnit.getactionTitle)
                .formatToInt() <=
            end.formatToInt()).toList();
  }

  List<FinalProductModel> filterFinalProduct_IN_DateBetween_from(
      DateTime start, DateTime end, FinalProductModel e) {
    return where((element) =>
            element.item.color == e.item.color &&
            element.item.type == e.item.type &&
            element.item.density == e.item.density &&
            element.item.L == e.item.L &&
            element.item.W == e.item.W &&
            element.item.H == e.item.H)
        .where((element) =>
            element.actions.if_action_exist(finalProdcutAction
                    .incert_finalProduct_from_cutingUnit.getactionTitle) ==
                true &&
            element.actions
                    .get_Date_of_action(finalProdcutAction
                        .incert_finalProduct_from_cutingUnit.getactionTitle)
                    .formatToInt() >=
                start.formatToInt() &&
            element.actions
                    .get_Date_of_action(
                        finalProdcutAction.incert_finalProduct_from_cutingUnit.getactionTitle)
                    .formatToInt() <=
                end.formatToInt())
        .toList();
  }

  List<FinalProductModel> filteronfinalproductwithcsissor() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.H == nonRepetitive[j].item.H &&
            this[i].item.W == nonRepetitive[j].item.W &&
            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].item.type == nonRepetitive[j].item.type &&
            this[i].customer == nonRepetitive[j].customer &&
            this[i].scissor == nonRepetitive[j].scissor &&
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

  List<FinalProductModel> filteronfinalproduct() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.H == nonRepetitive[j].item.H &&
            this[i].item.W == nonRepetitive[j].item.W &&
            this[i].item.L == nonRepetitive[j].item.L &&
            this[i].item.color == nonRepetitive[j].item.color &&
            this[i].item.type == nonRepetitive[j].item.type &&
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

  List<FinalProductModel> filter_type_density() {
    List<FinalProductModel> nonRepetitive = [];
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

  List<FinalProductModel> filter_company() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].customer == nonRepetitive[j].customer) {
          repeated = true;
        }
      }
      if (!repeated) {
        nonRepetitive.add(this[i]);
      }
    }
    return nonRepetitive;
  }

  List<FinalProductModel> filter_density_type_size() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.density == nonRepetitive[j].item.density &&
            this[i].item.type == nonRepetitive[j].item.type &&
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

  List<FinalProductModel> filter_density_typ_color_size() {
    List<FinalProductModel> nonRepetitive = [];
    for (var i = 0; i < length; i++) {
      bool repeated = false;
      for (var j = 0; j < nonRepetitive.length; j++) {
        if (this[i].item.density == nonRepetitive[j].item.density &&
            this[i].item.type == nonRepetitive[j].item.type &&
            this[i].item.color == nonRepetitive[j].item.color &&
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

  List<FinalProductModel> testFilter() {
    List<FinalProductModel> data = this;
    List<FinalProductModel> nonRepetitive = [];
    for (var i in data) {
      nonRepetitive.add(i);
      data.removeWhere((element) =>
          i.item.density == element.item.density &&
          i.item.type == element.item.type &&
          i.item.L == element.item.L &&
          i.item.W == element.item.W &&
          i.item.H == element.item.H);
    }
    return nonRepetitive;
  }

  List<FinalProductModel> Data_form_CuttingUnit_today(
      BuildContext context, String chosenDate) {
    DateFormat format = DateFormat('yyyy/MM/dd');
    return where((element) =>
        element.actions.if_action_exist(finalProdcutAction
                .incert_finalProduct_from_cutingUnit.getactionTitle) ==
            true &&
        format.format(element.actions.get_Date_of_action(finalProdcutAction
                .incert_finalProduct_from_cutingUnit.getactionTitle)) ==
            chosenDate).toList();
  }

  List<FinalProdcutWithTOtal> ReturnItmeWithTotalAndRemovewhreTotalZeto() {
    List<FinalProdcutWithTOtal> a = filter_density_typ_color_size()
        .map((e) => FinalProdcutWithTOtal(
            L: e.item.L,
            W: e.item.W,
            H: e.item.H,
            density: e.item.density,
            customer: e.customer,
            color: e.item.color,
            type: e.item.type,
            amount: countOf(e)))
        .toList();
    a.removeWhere((element) => element.amount == 0);
    return a;
  }

  List<FinalProductModel> Remove_total_zero() {
    List<FinalProductModel> a = filter_density_typ_color_size()
        .map((e) => FinalProductModel(
              updatedat: DateTime.now().microsecondsSinceEpoch,
              customer: e.customer,
              actions: [],
              block_ID: 0,
              cuting_order_number: 0,
              finalProdcut_ID: 0,
              fraction_ID: 0,
              invoiceNum: 0,
              notes: "",
              sapa_ID: "",
              sapa_desc: "",
              scissor: 0,
              stage: 0,
              subfraction_ID: 0,
              worker: "",
              item: FinalProdcutItme(
                  L: e.item.L,
                  W: e.item.W,
                  H: e.item.H,
                  density: e.item.density,
                  volume: 0.0,
                  theowight: 0.0,
                  realowight: 0.0,
                  color: e.item.color,
                  type: e.item.type,
                  amount: countOf(e),
                  priceforamount: 0),
            ))
        .toList();
    a.removeWhere((element) => element.item.amount == 0);
    return a;
  }

  // List<FinalProductModel> data_until_date(DateTime to) {
  //   return where((element) =>
  //       (element.actions.if_action_exist(finalProdcutAction.recive_Done_Form_FinalProdcutStock.getactionTitle) == true &&
  //           element.actions
  //                   .get_Date_of_action(finalProdcutAction
  //                       .recive_Done_Form_FinalProdcutStock.getactionTitle)
  //                   .formatToInt() <=
  //               to.formatToInt()) ||
  //       (element.actions.if_action_exist(finalProdcutAction.incert_finalProduct_from_Others.getactionTitle) == true &&
  //           element.actions.get_Date_of_action(finalProdcutAction.incert_finalProduct_from_Others.getactionTitle).formatToInt() <=
  //               to.formatToInt()) ||
  //       (element.actions.if_action_exist(finalProdcutAction.incert_From_StockChekRefresh.getactionTitle) == true &&
  //           element.actions.get_Date_of_action(finalProdcutAction.incert_From_StockChekRefresh.getactionTitle).formatToInt() <=
  //               to.formatToInt()) ||
  //       (element.actions.if_action_exist(finalProdcutAction.out_order.getactionTitle) ==
  //               true &&
  //           element.actions
  //                   .get_Date_of_action(finalProdcutAction.out_order.getactionTitle)
  //                   .formatToInt() <=
  //               to.formatToInt())).toList();
  // }

  List<FinalProductModel> data_until_date_from(
      DateTime to, FinalProductModel e) {
    return where((element) =>
            element.item.color == e.item.color &&
            element.item.type == e.item.type &&
            element.item.density == e.item.density &&
            element.item.L == e.item.L &&
            element.item.W == e.item.W &&
            element.item.H == e.item.H)
        .where((element) =>
            (element.actions.if_action_exist(finalProdcutAction.recive_Done_Form_FinalProdcutStock.getactionTitle) == true &&
                element.actions.get_Date_of_action(finalProdcutAction.recive_Done_Form_FinalProdcutStock.getactionTitle).formatToInt() <=
                    to.formatToInt()) ||
            (element.actions.if_action_exist(finalProdcutAction.incert_finalProduct_from_Others.getactionTitle) == true &&
                element.actions.get_Date_of_action(finalProdcutAction.incert_finalProduct_from_Others.getactionTitle).formatToInt() <=
                    to.formatToInt()) ||
            (element.actions.if_action_exist(finalProdcutAction.incert_From_StockChekRefresh.getactionTitle) == true &&
                element.actions.get_Date_of_action(finalProdcutAction.incert_From_StockChekRefresh.getactionTitle).formatToInt() <=
                    to.formatToInt()) ||
            (element.actions.if_action_exist(finalProdcutAction.out_order.getactionTitle) == true &&
                element.actions.get_Date_of_action(finalProdcutAction.out_order.getactionTitle).formatToInt() <= to.formatToInt()))
        .toList();
  }

  List<FinalProductModel> Removefinalprodcuts_NOTrecevedFromStock() {
    var f = this;
    f.removeWhere((element) =>
        element.actions.if_action_exist(finalProdcutAction
                .incert_finalProduct_from_cutingUnit.getactionTitle) ==
            true &&
        element.actions.if_action_exist(finalProdcutAction
                .recive_Done_Form_FinalProdcutStock.getactionTitle) ==
            false);
    return f;
  }

  int totalamount() {
    var a = map((e) => e.item.amount);
    return a.isNotEmpty ? a.reduce((x, y) => x + y) : 0;
  }
}

class FinalProdcutWithTOtal {
  double L;
  double W;
  double H;
  double density;
  String color;
  String type;
  String customer;
  int amount;
  FinalProdcutWithTOtal({
    required this.L,
    required this.W,
    required this.H,
    required this.density,
    required this.color,
    required this.type,
    required this.customer,
    required this.amount,
  });
}

extension DSd on List<FinalProdcutWithTOtal> {
  double volumeOf(Itme e) {
    var a = where((element) =>
        element.color == e.color &&
        element.density == e.density &&
        element.type == e.type);
    return a.isEmpty
        ? 0
        : a
            .map((f) => f.amount * f.H * f.L * f.W / 1000000)
            .reduce((a, b) => a + b)
            .toStringAsFixed(1)
            .to_double();
  }

  List<FinalProdcutWithTOtal> searchforSize(String searchValue) {
    if (searchValue.isEmpty) {
      return [];
    } else {
      return where((element) => (element.L.removeTrailingZeros +
              element.W.removeTrailingZeros +
              element.H.removeTrailingZeros)
          .contains(searchValue)).toList();
    }
  }
}

extension Fe on List<FinalProdcutItme> {
  String volumeOf(Itme e) {
    var a = where((element) =>
        element.color == e.color &&
        element.density == e.density &&
        element.type == e.type);
    return a.isEmpty
        ? ""
        : a
            .map((f) => f.amount * f.H * f.L * f.W / 1000000)
            .reduce((a, b) => a + b)
            .toStringAsFixed(1);
  }
}
