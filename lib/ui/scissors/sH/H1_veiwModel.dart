// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/controllers/bFractionsController.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:provider/provider.dart';

class H1VeiwModel extends BaseViewModel {
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController hightcontroller = TextEditingController();
  TextEditingController constantserial = TextEditingController();
  int amountofView = 5;
  BlockModel get_block_of_num_in_controller(
      List<BlockModel> b, BuildContext context) {
    BlockModel m = b
        .where((e) =>
            e.number == int.parse(numbercontroller.text) &&
            e.serial == context.read<ObjectBoxController>().serialforH)
        .toList()[0];
    return m;
  }

  List<FractionModel> getFractinsOFABlock(BuildContext context, BlockModel b) {
    return context
        .read<Fractions_Controller>()
        .fractions
        .where((element) => element.block_ID == b.Block_Id)
        .toList();
  }

  validate_if_ExistforH(List<BlockModel> b, BuildContext context) {
    // standerd validation
    return (String? value) {
      if (value!.isEmpty) {
        return "فارغ";
      }
      // validate on number of block
      var condition = !b.map((e) => e.number).contains(int.parse(value));
      if (condition) {
        return "غير موجود";
      }
      // validate on serial
      var condition3 = !b
          .map((e) => e.serial)
          .contains(context.read<ObjectBoxController>().serialforH);

      if (condition3) {
        return "غير موجود";
      }

      // validate on number and serial
      List<bool> condition5 = b
          .where((e) =>
              e.number == int.parse(value) &&
              e.serial == context.read<ObjectBoxController>().serialforH)
          .map((e) => e.actions
              .if_action_exist(BlockAction.cut_block_on_H.getactionTitle))
          .toList();

      if (condition5.isEmpty) {
        return "غير موجود";
      }
      // validate if cutted
      bool condition2 = b
          .where((e) =>
              e.number == int.parse(value) &&
              e.serial == context.read<ObjectBoxController>().serialforH)
          .map((e) => e.actions
              .if_action_exist(BlockAction.cut_block_on_H.getactionTitle))
          .toList()[0];

      if (condition2) {
        return "تم التصنيع ";
      }

      return null;
    };
  }

  List<FractionModel> permanentFractons = [];

  addpermanentFractons(
      BuildContext context, List<BlockModel> b, int scissor, ChipFraction e) {
    var block = get_block_of_num_in_controller(b, context);
    var L = e.lenth.removeTrailingZeros.to_double();
    var w = e.width.removeTrailingZeros.to_double();
    var h = e.hight.removeTrailingZeros.to_double();
    var volume = L * w * h / 1000000;
    var wight = block.item.density * L * w * h / 1000000;

    var item = Itme(
        L: L,
        W: w,
        H: h,
        density: block.item.density,
        volume: volume,
        wight: wight,
        color: block.item.color,
        type: block.item.type,
        price: 0);

    var fraction = FractionModel(
        fraction_ID: DateTime.now().microsecondsSinceEpoch,
        sapa_ID: block.serial,
        block_ID: block.Block_Id,
        sapa_desc: block.discreption,
        item: item,
        underOperation: true,
        Ascissor: 0,
        Hscissor: scissor,
        Rscissor: 0,
        notfinals: [],
        SubFractions: [],
        stagenum: 1,
        quality: 0,
        note: "",
        actions: []);

    permanentFractons.add(fraction);
  }

  addpermanentFractonsforNewview(
      BuildContext context, BlockModel block, int scissor, ChipFraction e) {
    var L = e.lenth.removeTrailingZeros.to_double();
    var w = e.width.removeTrailingZeros.to_double();
    var h = e.hight.removeTrailingZeros.to_double();
    var volume = L * w * h / 1000000;
    var wight = block.item.density * L * w * h / 1000000;

    var item = Itme(
        L: L,
        W: w,
        H: h,
        density: block.item.density,
        volume: volume,
        wight: wight,
        color: block.item.color,
        type: block.item.type,
        price: 0);

    var fraction = FractionModel(
        fraction_ID: DateTime.now().microsecondsSinceEpoch,
        sapa_ID: block.serial,
        block_ID: block.Block_Id,
        sapa_desc: block.discreption,
        item: item,
        underOperation: true,
        Ascissor: 0,
        Hscissor: scissor,
        Rscissor: 0,
        notfinals: [],
        SubFractions: [],
        stagenum: 1,
        quality: 0,
        note: "",
        actions: [FractionActon.creat_fraction.add]);

    permanentFractons.add(fraction);
  }

//قص
  cut_block(BuildContext context, BlockModel blockToCutted, int scissor) async {
    if (permanentFractons.isNotEmpty) {
      double vloumeOfFractions;
      int vloumeOfblock;

      vloumeOfblock = blockToCutted.item.W.toInt() *
          blockToCutted.item.L.toInt() *
          blockToCutted.item.H.toInt();
      vloumeOfFractions = permanentFractons
          .map((e) => e.item.W * e.item.H * e.item.L)
          .reduce((a, b) => a + b);
      if (vloumeOfblock < vloumeOfFractions) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('حجم النواتج اكبر من حجم البلوك')));
        permanentFractons.clear();
      } else {
        blockToCutted.Hscissor = scissor;
        blockToCutted.actions.add(BlockAction.cut_block_on_H.add);
        context
            .read<Fractions_Controller>()
            .addfractionslist(permanentFractons);
        await context
            .read<BlockFirebasecontroller>()
            .updateBlock(blockToCutted);
        permanentFractons.clear();
        Navigator.of(context, rootNavigator: true).pop();
      }
    }
  }

  Add_not_finalTo_block(BuildContext context, BlockModel b) {
    var notFinal = NotFinal(
        sapa_ID: b.serial,
        notFinal_ID: DateTime.now().microsecondsSinceEpoch,
        fraction_ID: 0,
        block_ID: b.Block_Id,
        scissor: b.Hscissor,
        stage: 0,
        StockRequisetionOrder_ID: 0,
        wight: wightcontroller.text.to_double(),
        type: context.read<ObjectBoxController>().gdet(),
        actions: [NotFinalAction.create_Not_final_cumingFrom_H.add]);
    b.notFinals.add(notFinal);
    context.read<BlockFirebasecontroller>().updateBlock(b);
  }

  @override
  clearfields() {
    lenthcontroller.clear();
    hightcontroller.clear();
    widthcontroller.clear();
  }

  List<String> filterserials(List<BlockModel> blocks) {
    return blocks.filterserials().map((e) => e.serial).toList();
  }

//delete fraction and unfinish block
  void delete(List<FractionModel> fractions, FractionModel fraction,
      BuildContext context) {}

  double wight_of_fractions(BuildContext context, BlockModel block) {
    var f = getFractinsOFABlock(context, block);
    return f.isNotEmpty
        ? f
            .map((e) =>
                e.item.W * e.item.L * e.item.L * e.item.density / 1000000)
            .reduce((a, b) => a + b)
            .removeTrailingZeros
            .to_double()
        : 0;
  }

  double wight_of_notfinal(BlockModel block) {
    var notfinalsOfBlock = block.notFinals.map((e) => e);
    return notfinalsOfBlock.isNotEmpty
        ? notfinalsOfBlock
            .map((e) => e.wight)
            .reduce((a, b) => a + b)
            .removeTrailingZeros
            .to_double()
        : 0;
  }

  double difrence(BuildContext context, BlockModel block) {
    return block.item.wight -
        wight_of_fractions(context, block) -
        wight_of_notfinal(block);
  }

  double percentage(BlockModel block) {
    return 100 * wight_of_notfinal(block) / block.item.wight;
  }

  UNcutBlockFromH({
    required BuildContext context,
    required BlockModel block,
  }) {
    Fractions_Controller fractioncontroller = Fractions_Controller();
    H1VeiwModel vm = H1VeiwModel();
    int index = block.actions.indexWhere((element) =>
        element.action == BlockAction.cut_block_on_H.getactionTitle);
    block.actions.removeAt(index);
    block.actions.add(BlockAction.UN_cut_block_on_H.add);

    block.Hscissor = 0;
    // clear the fractions
    vm.getFractinsOFABlock(context, block).forEach((element) {
      fractioncontroller.deletefractions(element);
    });
    block.notFinals.clear();
    context.read<BlockFirebasecontroller>().updateBlock(block);
  }
}
