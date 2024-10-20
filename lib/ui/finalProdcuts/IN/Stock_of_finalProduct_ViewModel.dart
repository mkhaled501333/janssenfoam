// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/finalProdcuts/finalProdcutExtentions.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:provider/provider.dart';

class stockOfFinalProductsViewModel extends BaseViewModel {
  //ارجاع قائمه باسم العميل والمقاسات الموجوده بها
  List<GroupModel> source(List<FinalProductModel> finalproducts) {
    var x = finalproducts;
    return x
        .filter_company()
        .map((e) => GroupModel(
            name: e.customer,
            items: x
                .where((element) => element.customer == e.customer)
                .toList()
                .filter_density_type_size()
                .map((e) => ItemModel(
                    e.item.density,
                    e.item.type,
                    e.item.L,
                    e.item.W,
                    e.item.H,
                    get_total(finalproducts, e),
                    e.customer,
                    e.item.color))
                .toList()))
        .toList();
  }

//ارجاع اجمالى العدد لكل مقاس
  get_total(List<FinalProductModel> finalproducts, FinalProductModel e) {
    return finalproducts
        .where((element) =>
            element.item.density == e.item.density &&
            element.customer == e.customer &&
            element.item.type == e.item.type &&
            element.item.W == e.item.W &&
            element.item.H == e.item.H &&
            element.item.L == e.item.L)
        .map((e) => e.item.amount)
        .reduce((a, b) => a + b);
  }

  //اضافة مقاس جديد عند عمل الجرد
  incertfinalProduct(BuildContext context) {
    double voluem = int.parse(amountcontroller.text) *
        double.parse(widthcontroller.text) *
        double.parse(lenthcontroller.text) *
        double.parse(hightncontroller.text);

    context
        .read<final_prodcut_controller>()
        .updateFinalProdcut(FinalProductModel(
          updatedat: DateTime.now().microsecondsSinceEpoch,
          block_ID: 0,
          fraction_ID: 0,
          sapa_ID: "",
          sapa_desc: "",
          subfraction_ID: 0,
          item: FinalProdcutItme(
              L: double.parse(lenthcontroller.text),
              W: double.parse(widthcontroller.text),
              H: double.parse(hightncontroller.text),
              density: double.parse(densitycontroller.text),
              volume: voluem.toStringAsFixed(2).to_double(),
              theowight: voluem.toStringAsFixed(2).to_double() *
                  double.parse(densitycontroller.text),
              realowight: 0.0,
              color: colercontroller.text,
              type: typecontroller.text,
              amount: int.parse(amountcontroller.text),
              priceforamount: 0.0),
          invoiceNum: 0,
          worker: "",
          stage: 0,
          notes: notes.text,
          cuting_order_number: 0,
          actions: [finalProdcutAction.incert_finalProduct_from_Others.add],
          finalProdcut_ID: DateTime.now().millisecondsSinceEpoch,
          scissor: int.tryParse(scissorcontroller.text) ?? 0,
          customer: companycontroller.text,
        ));
  }

  void add(BuildContext context) {
    if (formKey.currentState!.validate()) {
      incertfinalProduct(context);
      clearfields();
    }
  }

//الخاصه بالاضافه الى هذا المقاس
  void addtocertinsize(
      BuildContext context, ItemModel itemData, GroupModel headerData) {
    double voluem = int.parse(amountcontroller.text) *
        double.parse(widthcontroller.text) *
        double.parse(lenthcontroller.text) *
        double.parse(hightncontroller.text);

    if (formKey.currentState!.validate() && itemData.total > 0) {
      context
          .read<final_prodcut_controller>()
          .updateFinalProdcut(FinalProductModel(
            updatedat: DateTime.now().microsecondsSinceEpoch,
            block_ID: 0,
            fraction_ID: 0,
            sapa_ID: "",
            sapa_desc: "",
            subfraction_ID: 0,
            item: FinalProdcutItme(
                L: itemData.lenth,
                W: itemData.width,
                H: itemData.hight,
                density: itemData.density,
                volume: voluem.toStringAsFixed(2).to_double(),
                theowight:
                    voluem.toStringAsFixed(2).to_double() * itemData.density,
                realowight: 0.0,
                color: itemData.color,
                type: itemData.type,
                amount: int.parse(amountcontroller.text),
                priceforamount: 0.0),
            invoiceNum: 0,
            worker: "",
            stage: 0,
            notes: notes.text,
            cuting_order_number: 0,
            actions: [finalProdcutAction.incert_finalProduct_from_Others.add],
            finalProdcut_ID: DateTime.now().millisecondsSinceEpoch,
            scissor: int.tryParse(scissorcontroller.text) ?? 0,
            customer: headerData.name,
          ));
      clearfields();
    }
  }
}

abstract interface class SerializableModel {}

class GroupModel extends SerializableModel {
  final String name;
  final List<ItemModel> items;
  GroupModel({required this.name, required this.items});
}

class ItemModel {
  final double density;
  final String type;
  final String color;
  final String company;
  final double lenth;
  final double width;
  final double hight;
  final int total;
  ItemModel(
    this.density,
    this.type,
    this.lenth,
    this.width,
    this.hight,
    this.total,
    this.company,
    this.color,
  );
}
