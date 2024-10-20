// ignore_for_file: non_constant_identifier_names, file_names

import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/models/moderls.dart';

class HReportsViewModel extends BaseViewModel {
  int total_amount_for_single_siz__(
      BlockModel e, List<BlockModel> blocks, int scissor) {
    return blocks
        .where(
          (f) =>
              f.hashCode == scissor &&
              e.item.color == f.item.color &&
              e.item.density == f.item.density &&
              e.serial == f.serial &&
              e.item.H == f.item.H &&
              e.item.W == f.item.W &&
              e.item.L == f.item.L &&
              e.item.type == f.item.type,
        )
        .toList()
        .length;
  }

  int total_amount_for_single_siz__fractions(
      FractionModel e, List<FractionModel> fractions, int scissor) {
    return fractions
        .where(
          (f) =>
              e.item.color == f.item.color &&
              e.item.density == f.item.density &&
              e.fraction_ID == f.fraction_ID &&
              e.item.H == f.item.H &&
              e.item.W == f.item.W &&
              e.item.L == f.item.L &&
              e.item.type == f.item.type,
        )
        .toList()
        .length;
  }
}
