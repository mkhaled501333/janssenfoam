// ignore_for_file: non_constant_identifier_names

import 'package:janssenfoam/models/moderls.dart';

class ReportsViewModel {
  //اجمالى وارد تام الصنع
  double total_finalprodut(
      List<FinalProductModel> blocks, FinalProductModel block) {
    return blocks
        .where((e) =>
            e.item.density == block.item.density &&
            e.item.type == block.item.type)
        .map((e) => (e.item.H * e.item.L * e.item.W / 1000000) * e.item.amount)
        .reduce((a, b) => a + b);
  }

  int totalofSingleSize(
      FinalProductModel e, List<FinalProductModel> finalproducts) {
    return finalproducts
        .where(
          (f) =>
              e.item.color == f.item.color &&
              e.customer == f.customer &&
              e.item.density == f.item.density &&
              e.item.H == f.item.H &&
              e.item.W == f.item.W &&
              e.item.L == f.item.L &&
              e.item.type == f.item.type,
        )
        .map((e) => e.item.amount)
        .reduce((value, element) => value + element);
  }

  int totalofSingleSizeOfsingleScissor(
      FinalProductModel e, List<FinalProductModel> finalproducts) {
    return finalproducts
        .where(
          (f) =>
              e.item.color == f.item.color &&
              e.customer == f.customer &&
              e.item.density == f.item.density &&
              e.item.H == f.item.H &&
              e.item.W == f.item.W &&
              e.item.L == f.item.L &&
              e.scissor == f.scissor &&
              e.item.type == f.item.type,
        )
        .map((e) => e.item.amount)
        .reduce((value, element) => value + element);
  }
}
