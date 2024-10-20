// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/cutting_order/Order_controller.dart';
import 'package:janssenfoam/controllers/bSubfractions.dart';
import 'package:janssenfoam/controllers/dropDowen_controller.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:provider/provider.dart';

class AscissorViewModel extends BaseViewModel {
  List<SubFraction> getSubfractions_Underoperation(
      SubFractions_Controller subfractioncontroller) {
    return subfractioncontroller.subfractions
        .where((element) => element.underOperation == true)
        .toList();
  }

  List<SubFraction> getSubfractions_cuttedOn_A(
      SubFractions_Controller subfractioncontroller, int Ascissor) {
    return subfractioncontroller.subfractions
        .where((element) =>
            element.Ascissor == Ascissor &&
            element.actions
                    .get_Date_of_action(
                        subfractionAction.cut_subfraction_on_A.getTitle)
                    .formatt() ==
                DateTime.now().formatt())
        .toList();
  }

  List<SubFraction> getSubfractions_cuttedOn_A_OFAstage(
      List<SubFraction> subfractions, int Astage) {
    return subfractions
        .where((element) => element.Astagenum == Astage)
        .toList();
  }

  List<FinalProductModel> get_finalprodcuts_cuttedON_A(
      List<FinalProductModel> finalprodcuts) {
    return finalprodcuts
        .where((element) =>
            element.scissor == 7 &&
            element.actions
                    .get_Date_of_action(finalProdcutAction
                        .incert_finalProduct_from_cutingUnit.getactionTitle)
                    .formatt() ==
                DateTime.now().formatt())
        .toList();
  }

  incert_finalProduct_from_cutingUnit_A(
      BuildContext context, int stageOFA, int Ascissor) {
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
            stage: stageOFA,
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
            scissor: 7,
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
}
