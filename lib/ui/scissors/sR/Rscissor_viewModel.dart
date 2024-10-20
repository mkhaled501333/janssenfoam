// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: camel_case_types, non_constant_identifier_names, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/controllers/bFractionsController.dart';
import 'package:janssenfoam/controllers/bSubfractions.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/cutting_order/Order_controller.dart';
import 'package:janssenfoam/controllers/dropDowen_controller.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';

class Rscissor_veiwModel extends BaseViewModel {
  List<FractionModel> getFractions_Cutted_On_Rscissor_today(
      Fractions_Controller fractrioncontroller, int Rscissor) {
    return fractrioncontroller.fractions
        .where((element) =>
            element.Rscissor == Rscissor &&
            element.actions
                    .get_Date_of_action(
                        FractionActon.cut_fraction_OnRscissor.getTitle)
                    .formatt() ==
                DateTime.now().formatt())
        .toList();
  }

  List<SubFraction> get_SUBfraction_Cutted_On_Rscissor(
      SubFractions_Controller Subfractrioncontroller, int Rscissor) {
    return Subfractrioncontroller.subfractions
        .where((element) =>
            element.Rscissor == Rscissor &&
            element.actions
                    .get_Date_of_action(
                        subfractionAction.create_new_subfraction.getTitle)
                    .formatt() ==
                DateTime.now().formatt())
        .toList();
  }

  List<FractionModel> getFractions_Cutted_On_Ascissor(
      Fractions_Controller fractrioncontroller, int Ascissor) {
    return fractrioncontroller.fractions
        .where((element) =>
            element.Ascissor == Ascissor &&
            element.actions
                    .get_Date_of_action(
                        FractionActon.cut_fraction_OnAscissor.getTitle)
                    .formatt() ==
                DateTime.now().formatt())
        .toList();
  }

  List<FractionModel> getfractions_Underoperation(
      Fractions_Controller fractrioncontroller) {
    return fractrioncontroller.fractions
        .where((element) => element.underOperation == true)
        .toList();
  }

  List<int> getAllStages(List<FractionModel> fractions, int Rscissor,
      List<FinalProductModel> finalproducts, List<SubFraction> subfractions) {
    List<int> allStagesOf_fractions =
        fractions.map((e) => e.stagenum).toSet().toList();

    List<int> allStagesOf_subfraction =
        subfractions.map((e) => e.Rstagenum).toSet().toList();

    List<int> allStagesOf_finalproduct =
        finalproducts.map((e) => e.stage).toSet().toList();

    List<int> all = [];
    all.addAll(allStagesOf_fractions);
    all.addAll(allStagesOf_subfraction);
    all.addAll(allStagesOf_finalproduct);
    return all
        .toSet()
        .toList()
        .sortedBy<num>((element) => element)
        .reversed
        .toList();
  }

  incert_finalProduct_from_cutingUnit(
      BuildContext context, int stage, int scissor) {
    OrderController orderController = context.read<OrderController>();
    if (orderController.order != null && orderController.item != null) {
      double volume = orderController.item!.widti *
          orderController.item!.lenth *
          orderController.item!.hight *
          int.parse(amountcontroller.text) /
          1000000;
      context
          .read<final_prodcut_controller>()
          .updateFinalProdcut(FinalProductModel(
            updatedat: DateTime.now().microsecondsSinceEpoch,
            block_ID: 0,
            fraction_ID: 0,
            sapa_ID: "",
            sapa_desc: "",
            subfraction_ID: 0,
            invoiceNum: 0,
            worker: "",
            stage: stage,
            notes: notes.text,
            cuting_order_number: orderController.order!.serial,
            actions: [
              finalProdcutAction.incert_finalProduct_from_cutingUnit.add
            ],
            finalProdcut_ID: DateTime.now().millisecondsSinceEpoch,
            item: FinalProdcutItme(
                L: orderController.item!.lenth,
                W: orderController.item!.widti,
                H: orderController.item!.hight,
                density: orderController.item!.density,
                volume: volume.toStringAsFixed(2).to_double(),
                theowight: volume.toStringAsFixed(2).to_double() *
                    orderController.item!.density,
                realowight: 0.0,
                color: orderController.item!.color,
                type: orderController.item!.type,
                amount: int.parse(amountcontroller.text),
                priceforamount: 0.0),
            scissor: scissor,
            customer: orderController.order!.customer,
          ));
      amountcontroller.clear();
      notes.clear();
      orderController.order = null;
      orderController.item = null;
      orderController.Refrsh_ui();
      context.read<dropDowenContoller>().Refrsh_ui();
    }
  }

  incert_finalProduct_from_cutingUnit_UnRegular_R2324(
      BuildContext context, int stageOFR, int Rscissor) {
    OrderController my = context.read<OrderController>();
    if (my.order != null && my.item != null) {
      double volume = my.item!.widti *
          my.item!.lenth *
          my.item!.hight *
          int.parse(amountcontroller.text) /
          1000000;
      context
          .read<final_prodcut_controller>()
          .updateFinalProdcut(FinalProductModel(
            updatedat: DateTime.now().microsecondsSinceEpoch,
            block_ID: 0,
            fraction_ID: 0,
            sapa_ID: "",
            sapa_desc: "",
            subfraction_ID: 0,
            invoiceNum: 0,
            worker: "",
            stage: stageOFR,
            notes: notes.text,
            cuting_order_number: my.order!.serial,
            actions: [
              finalProdcutAction.incert_finalProduct_from_cutingUnit.add
            ],
            finalProdcut_ID: DateTime.now().millisecondsSinceEpoch,
            item: FinalProdcutItme(
                L: my.item!.lenth,
                W: my.item!.widti,
                H: my.item!.hight,
                density: my.item!.density,
                volume: volume.toStringAsFixed(2).to_double(),
                theowight:
                    volume.toStringAsFixed(2).to_double() * my.item!.density,
                realowight: 0.0,
                color: my.item!.color,
                type: my.item!.type,
                amount: int.parse(amountcontroller.text),
                priceforamount: 0.0),
            scissor: Rscissor + 3,
            customer: my.order!.customer,
          ));
      amountcontroller.clear();
      notes.clear();
      my.order = null;
      my.item = null;
      my.Refrsh_ui();
      context.read<dropDowenContoller>().Refrsh_ui();
    }
  }

  List<FinalProductModel> getDataOF_finalProdcutOF_scissor(
      BuildContext context, int Rscissor) {
    return context
        .read<final_prodcut_controller>()
        .finalproducts
        .values
        .where((element) =>
            element.scissor == Rscissor + 3 &&
            element.actions
                    .get_Date_of_action(finalProdcutAction
                        .incert_finalProduct_from_cutingUnit.getactionTitle)
                    .formatt() ==
                DateTime.now().formatt())
        .toList();
  }

  List<BLockDetailsOf> getAllDetiails_OFscissor_OFstage(
      int StageOfR, List<FractionModel> fractions) {
    return fractions
        .where((element) => element.stagenum == StageOfR)
        .toList()
        .filter_Fractios___()
        .map((e) => BLockDetailsOf(
            sapadescriotion: e.sapa_desc,
            sapaId: e.sapa_ID,
            density: e.item.density,
            type: e.item.type,
            color: e.item.color,
            stageOfR: StageOfR))
        .toList();
  }

  add_UnderOperatin_subfractions(BuildContext context, int Rscissor) {
    var quantity = amountcontroller.text.to_int();
    BLockDetailsOf? sapadetails =
        context.read<ObjectBoxController>().selectedValueOfBLockDetailsOf;

    var L = lenthcontroller.text.to_double();
    var w = widthcontroller.text.to_double();
    var h = hightncontroller.text.to_double();
    var volume = L * w * h / 1000000;
    var wight = sapadetails!.density * volume;

    var item = Itme(
        L: L,
        W: w,
        H: h,
        density: sapadetails.density,
        volume: volume.toStringAsFixed(2).to_double(),
        wight: wight.toStringAsFixed(2).to_double(),
        color: sapadetails.color,
        type: sapadetails.type,
        price: 0);

    List<SubFraction> permanent = [];
    for (var i = 0; i < quantity.toInt(); i++) {
      permanent.add(SubFraction(
          subfraction_ID: DateTime.now().microsecondsSinceEpoch + i,
          fraction_ID: 0,
          sapa_ID: sapadetails.sapaId,
          block_ID: 0,
          sapa_desc: sapadetails.sapadescriotion,
          item: item,
          underOperation: true,
          Ascissor: 0,
          Hscissor: 0,
          Rscissor: Rscissor,
          quality: 0,
          notfinals: [],
          Rstagenum: sapadetails.stageOfR,
          Astagenum: 0,
          Hstagenum: 0,
          note: "",
          actions: [subfractionAction.create_new_subfraction.add]));
    }

    context.read<SubFractions_Controller>().addSubfractionslist(permanent);

    amountcontroller.clear();
    lenthcontroller.clear();
    widthcontroller.clear();
    hightncontroller.clear();
    context.read<ObjectBoxController>().selectedValueOfBLockDetailsOf = null;
    context.read<ObjectBoxController>().gdet();
  }
}

class BLockDetailsOf {
  String sapadescriotion;
  String sapaId;
  double density;
  String type;
  String color;
  int stageOfR;
  BLockDetailsOf({
    required this.sapadescriotion,
    required this.sapaId,
    required this.density,
    required this.type,
    required this.color,
    required this.stageOfR,
  });
}
