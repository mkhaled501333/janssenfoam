// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:janssenfoam/models/moderls.dart';

class Rscissor_viewmodel {
  double volOfConsumed(List<BlockModel> blocks, BlockModel e) {
    var b = blocks
        .where((element) =>
            element.item.density == e.item.density &&
            element.item.type == e.item.type &&
            element.item.color == e.item.color)
        .map((e) => e.item.L * e.item.H * e.item.W / 1000000);
    return b.isEmpty ? 0 : b.reduce((a, b) => a + b);
  }

  double volOfResults(List<FinalProductModel> f, BlockModel e) {
    var i = f
        .where((element) =>
                element.item.density == e.item.density &&
                element.item.type == e.item.type
            //  &&
            // element.color == e.color
            )
        .map((e) => e.item.amount * e.item.L * e.item.W * e.item.H / 1000000);
    return i.isEmpty ? 0 : i.reduce((a, b) => a + b);
  }

  double TotalvolOfConsumed(List<BlockModel> blocks) {
    var b = blocks.map((e) => e.item.L * e.item.H * e.item.W / 1000000);
    return b.isEmpty ? 0 : b.reduce((a, b) => a + b);
  }

  double TotalvolOfResults(List<FinalProductModel> f) {
    var i =
        f.map((e) => e.item.amount * e.item.L * e.item.W * e.item.H / 1000000);
    return i.isEmpty ? 0 : i.reduce((a, b) => a + b);
  }
}
