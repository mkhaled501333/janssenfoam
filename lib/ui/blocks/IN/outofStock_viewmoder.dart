// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/blocks/addCategoreys/CategorysController.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:provider/provider.dart';

class blocksStockViewModel extends BaseViewModel {
  fillFields(ChipBlockModel chi) {
    codecontroller.text = chi.serial;
    colercontroller.text = chi.color.toString();
    densitycontroller.text = chi.density.removeTrailingZeros.toString();
    hightncontroller.text = chi.hight.removeTrailingZeros.toString();
    lenthcontroller.text = chi.lenth.removeTrailingZeros.toString();
    typecontroller.text = chi.type.toString();
    widthcontroller.text = chi.width.removeTrailingZeros.toString();
    scissorcontroller.text = chi.scissor.removeTrailingZeros.toString();
    wightcontroller.text = chi.wight.removeTrailingZeros.toString();
    blockdesription.text = chi.description.toString();
  }

  @override
  clearfields() {
    blocknumbercontroller.clear();
    codecontroller.clear();
    colercontroller.clear();
    densitycontroller.clear();
    hightncontroller.clear();
    lenthcontroller.clear();
    typecontroller.clear();
    widthcontroller.clear();
    scissorcontroller.clear();
    wightcontroller.clear();
    cummingFrom.clear();
    blockdesription.clear();
    outTo.clear();
    from.clear();
    to.clear();
  }

  incertblock(BuildContext context) {
    var L = double.parse(lenthcontroller.text);
    var w = double.parse(widthcontroller.text);
    var H = double.parse(hightncontroller.text);
    BlockWetOutput wetOutPut =
        BlockWetOutput(L: 0, W: 0, H: 0, density: 0, volume: 0, wight: 0);
    var volume = L * w * H / 1000000;

    Itme item = Itme(
        L: L,
        W: w,
        H: H,
        density: double.parse(densitycontroller.text),
        volume: volume,
        wight: wightcontroller.text.isEmpty
            ? volume * double.parse(densitycontroller.text)
            : wightcontroller.text.to_double(),
        color: colercontroller.text,
        type: typecontroller.text,
        price: 0);
    context.read<BlockFirebasecontroller>().addblock(BlockModel(
        updatedat: DateTime.now().microsecondsSinceEpoch,
        item: item,
        discreption: blockdesription.text,
        actions: [BlockAction.create_block.add],
        OutTo: outTo.text.isEmpty ? "" : outTo.text,
        cumingFrom: cummingFrom.text.isEmpty ? "الصبه" : cummingFrom.text,
        fractions: [],
        Block_Id: DateTime.now().millisecondsSinceEpoch,
        Hscissor: int.tryParse(scissorcontroller.text) ?? 0,
        serial: codecontroller.text,
        number: int.parse(blocknumbercontroller.text),
        Rcissor: 0,
        notes: notes.text.isEmpty ? "" : notes.text,
        wetOutPut: wetOutPut,
        notFinals: []));
  }

  incertblock2(BuildContext context) {
    BlockCategory blockcategory =
        context.read<Category_controller>().initialFordropdowen!;
    List<BlockModel> s = [];
    for (var i = from.text.to_int(); i < to.text.to_int() + 1; i++) {
      var L = double.parse(lenthcontroller.text);
      var w = double.parse(widthcontroller.text);
      var H = double.parse(hightncontroller.text);
      var volume = L * w * H / 1000000;
      Itme item = Itme(
          L: L,
          W: w,
          H: H,
          density: double.parse(blockcategory.density),
          volume: volume,
          wight: wightcontroller.text.isEmpty
              ? volume * double.parse(densitycontroller.text)
              : wightcontroller.text.to_double(),
          color: blockcategory.color,
          type: blockcategory.type,
          price: 0);
      BlockWetOutput wetOutPut =
          BlockWetOutput(L: 0, W: 0, H: 0, density: 0, volume: 0, wight: 0);

      BlockModel block = BlockModel(
          updatedat: DateTime.now().microsecondsSinceEpoch,
          item: item,
          notFinals: [],
          wetOutPut: wetOutPut,
          discreption: blockcategory.description,
          actions: [BlockAction.create_block.add],
          OutTo: "",
          cumingFrom: cummingFrom.text.isEmpty ? "الصبه" : cummingFrom.text,
          fractions: [],
          Block_Id: DateTime.now().microsecondsSinceEpoch + i,
          Hscissor: 0,
          serial: codecontroller.text,
          number: i,
          Rcissor: 0,
          notes: notes.text.isEmpty ? "" : notes.text);
      s.add(block);
    }
    context.read<BlockFirebasecontroller>().addblocklist(s);
  }

  incertblockformchip(BuildContext context, ChipBlockModel chi) {
    // var L = double.parse(lenthcontroller.text);
    // var w = double.parse(widthcontroller.text);
    // var H = double.parse(hightncontroller.text);
    // BlockWetOutput wetOutPut =
    //     BlockWetOutput(L: 0, W: 0, H: 0, density: 0, volume: 0, wight: 0);

    // Itme item = Itme(
    //     L: chi.lenth.removeTrailingZeros.to_double(),
    //     W: chi.width.removeTrailingZeros.to_double(),
    //     H: chi.hight.removeTrailingZeros.to_double(),
    //     density: chi.density,
    //     volume: L * w * H / 1000000,
    //     wight: chi.wight,
    //     color: chi.color,
    //     type: chi.type,
    //     price: 0);
    // context.read<BlockFirebasecontroller>().addblock(
    //       BlockModel(
    //         item: item,
    //         notFinals: [],
    //         wetOutPut: wetOutPut,
    //         discreption: chi.description,
    //         OutTo: outTo.text.isEmpty ? "" : outTo.text,
    //         cumingFrom: cummingFrom.text.isEmpty ? "المصنع" : cummingFrom.text,
    //         fractions: [],
    //         actions: [BlockAction.create_block.add],
    //         Hscissor: 0,
    //         Rcissor: 0,
    //         Block_Id: DateTime.now().millisecondsSinceEpoch,
    //         serial: chi.serial,
    //         number: num,
    //         notes: chi.notes,
    //       ),
    //     );
  }
}
