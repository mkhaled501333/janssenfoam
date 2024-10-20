// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/strings_manager.dart';
import 'package:janssenfoam/ui/customers/Customer_controller.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/ui/cutting_order/Order_controller.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:provider/provider.dart';

class CuttingOrderViewModel extends BaseViewModel {
  String date(DateTime d) {
    return DateFormat("yyyy-MM-dd").format(d);
  }

  addOrder(BuildContext context) async {
    if (temp.isNotEmpty) {
      cutingOrder order = cutingOrder(
          updatedat: DateTime.now().microsecondsSinceEpoch,
          notes: [notes.text],
          dateTOOrder:
              DateTime.fromMillisecondsSinceEpoch(datecontroller.text.to_int()),
          cuttingOrder_ID: DateTime.now().millisecondsSinceEpoch,
          serial: context.read<OrderController>().cuttingOrders.length + 1,
          customer: context
              .read<Customer_controller>()
              .customers
              .values
              .firstWhere((element) =>
                  element.name ==
                  context.read<Customer_controller>().initialForRaido)
              .serial
              .toString(),
          actions: [OrderAction.create_order.add],
          items: temp);
      context
          .read<OrderController>()
          .add_order(order, "امر شغل جديد", SringsManager.myemail);
      context.read<ObjectBoxController>().get();
      clearfields();
      temp.clear();
    }
  }

  addItem(BuildContext context, read) {
    temp.add(OperationOrederItems(
      id: DateTime.now().millisecondsSinceEpoch,
      color: read.initialcolor,
      type: read.initialtype,
      density: read.initialdensity,
      lenth: lenthcontroller.text.to_double(),
      widti: widthcontroller.text.to_double(),
      hight: hightncontroller.text.to_double(),
      Qantity: amountcontroller.text.to_int(),
    ));
    clearfields();
    context.read<ObjectBoxController>().get();
  }

  List<OperationOrederItems> temp = [];

  double petcentage_of_cutingOrder(
      BuildContext context, cutingOrder order, OperationOrederItems item) {
    var a = context
        .read<final_prodcut_controller>()
        .finalproducts
        .values
        .where((e) =>
            e.cuting_order_number == order.serial &&
            e.item.L == item.lenth &&
            e.item.W == item.widti &&
            e.item.type == item.type &&
            e.item.density == item.density &&
            e.item.color == item.color &&
            e.item.H == item.hight)
        .map((e) => e.item.amount);
    var b;

    if (a.isNotEmpty) {
      b = a.reduce((a, b) => a + b);
    }
    return b == null ? 0 : b / item.Qantity * 100;
  }

  double Total_done_of_cutting_order(
      BuildContext context, cutingOrder order, OperationOrederItems item) {
    var a = context
        .read<final_prodcut_controller>()
        .finalproducts
        .values
        .where((e) =>
            e.cuting_order_number == order.serial &&
            e.item.L == item.lenth &&
            e.item.W == item.widti &&
            e.item.H == item.hight &&
            e.item.type == item.type &&
            e.item.density == item.density &&
            e.item.color == item.color)
        .map((e) => e.item.amount);
    var b;

    if (a.isNotEmpty) {
      b = a.reduce((a, b) => a + b).toDouble();
    }
    return b ?? 0.0;
  }

  num Total_Notdone_of_cutting_order(
      BuildContext context, cutingOrder order, OperationOrederItems item) {
    var done = context
        .read<final_prodcut_controller>()
        .finalproducts
        .values
        .where((e) =>
            e.cuting_order_number == order.serial &&
            e.item.L == item.lenth &&
            e.item.W == item.widti &&
            e.item.type == item.type &&
            e.item.density == item.density &&
            e.item.color == item.color &&
            e.item.H == item.hight)
        .map((e) => e.item.amount);
    var TotalDone;

    if (done.isNotEmpty) {
      TotalDone = done.reduce((a, b) => a + b).toDouble();
    }
    return TotalDone == null ? 0.0 : item.Qantity - TotalDone;
  }

  List<BlockModel> filterd = [];
  String whatfilter = "";
}
