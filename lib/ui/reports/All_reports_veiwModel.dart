// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/ui/finalProdcuts/finalProdcutExtentions.dart';
import 'package:janssenfoam/ui/finalProdcuts/Reports/vm.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/models/moderls.dart';

class AllReportsViewModel {
  //  كل المقصوص من هذا المقاس  على هذا المقص لكل دور
  List<NumAndDescrioption> getIncomingOnScissor(
      BuildContext context, int rcissor, List<FractionModel> fractions) {
    return fractions
        .toList()
        .filter_Fractios___()
        .map((e) => NumAndDescrioption(
              voluem: e.item.W * e.item.L * e.item.H,
              total: total_amount_for_single_siz__fractions(e, fractions),
              descrioption:
                  "${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}*${e.item.H.removeTrailingZeros} ${e.item.color} ${e.item.type} D${e.item.density.removeTrailingZeros}",
            ))
        .toList();
  }

  int total_amount_for_single_siz__fractions(
      FractionModel e, List<FractionModel> fractions) {
    return fractions
        .where(
          (f) =>
              e.item.color == f.item.color &&
              e.item.density == f.item.density &&
              e.item.H == f.item.H &&
              e.item.W == f.item.W &&
              e.item.L == f.item.L &&
              e.item.type == f.item.type,
        )
        .toList()
        .length;
  }

  List<NumAndDescriptionOfFinal> totalAndDescriptionOfFinal(
      BuildContext context,
      List<FinalProductModel> finalProducts,
      int stage,
      int scissor) {
    ReportsViewModel vm2 = ReportsViewModel();
    List<FinalProductModel> finalProduc = finalProducts
        .where((element) =>
            element.stage == stage && element.scissor == scissor + 3)
        .toList();

    return finalProduc
        .filteronfinalproduct()
        .map((e) => NumAndDescriptionOfFinal(
            total: vm2.totalofSingleSize(e, finalProduc),
            description:
                "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros} ${e.item.color} ${e.item.type} D${e.item.density.removeTrailingZeros}",
            volume: e.item.H * e.item.L * e.item.W / 1000000))
        .toList();
  }

  List<NumAndDescriptionOfFinal> totalAndDescriptionOfFinalWithNoStage(
      BuildContext context,
      List<FinalProductModel> finalProducts,
      int scissor) {
    ReportsViewModel vm2 = ReportsViewModel();
    List<FinalProductModel> finalProduc = finalProducts
        .where((element) => element.scissor == scissor + 3)
        .toList();

    return finalProduc
        .filteronfinalproduct()
        .map((e) => NumAndDescriptionOfFinal(
            total: vm2.totalofSingleSize(e, finalProduc),
            description:
                "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros} ${e.item.color} ${e.item.type} D${e.item.density.removeTrailingZeros}",
            volume: e.item.H * e.item.L * e.item.W / 1000000))
        .toList();
  }
}

class NumAndDescriptionOfFinal {
  final int total;
  final String description;
  final double volume;

  NumAndDescriptionOfFinal(
      {required this.total, required this.description, required this.volume});
}

class All {
  int stage;
  List<NumAndDescrioption> itemsInEeachStage;
  All({
    required this.stage,
    required this.itemsInEeachStage,
  });
}

class NumAndDescrioption {
  final int total;
  double voluem;

  final String descrioption;

  NumAndDescrioption(
      {required this.total, required this.voluem, required this.descrioption});
}
