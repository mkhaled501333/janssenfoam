// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types
// ignore_for_file: file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/services/pdfprevei.dart';
import 'package:janssenfoam/ui/blocks/OUt/outOfStock_viewModel.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';

import 'package:janssenfoam/ui/blocks/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D8%A8%D9%84%D9%88%D9%83%D8%A7%D8%AA/%D8%AA%D9%82%D8%B1%D9%8A%D8%B1%20%D8%A7%D8%B6%D8%A7%D9%81%D8%A7%D8%AA%20%D8%A7%D9%84%D8%A8%D9%84%D9%88%D9%83%D8%A7%D8%AA/featues.dart';
import 'package:janssenfoam/ui/blocks/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D8%A8%D9%84%D9%88%D9%83%D8%A7%D8%AA/%D8%AA%D9%82%D8%B1%D9%8A%D8%B1%20%D8%A7%D8%B6%D8%A7%D9%81%D8%A7%D8%AA%20%D8%A7%D9%84%D8%A8%D9%84%D9%88%D9%83%D8%A7%D8%AA/pdf.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/models/moderls.dart';

//تقرير كل صبه
class BlockReport3 extends StatelessWidget {
  const BlockReport3({super.key});

  @override
  Widget build(BuildContext context) {
    OutOfStockViewModel vm = OutOfStockViewModel();
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<BlockModel> blocks = myType.blocks.values
            .toList()
            .where((element) =>
                element.serial == context.read<ObjectBoxController>().serial2)
            .sortedBy<num>((element) => element.number)
            .toList();
        var consumed = blocks
            .where((element) => element.actions
                .if_action_exist(BlockAction.consume_block.getactionTitle))
            .toList();
        var remain = blocks
            .where((element) =>
                element.actions.if_action_exist(
                    BlockAction.consume_block.getactionTitle) ==
                false)
            .toList();
        return Column(
          children: [
            errmsg(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    if (blocks.isNotEmpty) {
                      vm.codecontroller.text = blocks.first.serial;
                      vm.N.text = blocks.first.discreption;
                      vm.densitycontroller.text =
                          blocks.first.item.density.toString();
                      vm.colercontroller.text =
                          blocks.first.item.color.toString();
                    }
                    showDialog(
                        context: context,
                        builder: (c) => AlertDialog(
                              content: SizedBox(
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: vm.formKey,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            CustomTextFormField(
                                                validator:
                                                    Validation.validateIFimpty,
                                                hint: "الى",
                                                width: 120,
                                                controller: vm.to),
                                            CustomTextFormField(
                                                validator:
                                                    Validation.validateIFimpty,
                                                hint: "من",
                                                width: 120,
                                                controller: vm.from),
                                          ],
                                        ),
                                        const Gap(14),
                                        Row(
                                          children: [
                                            CustomTextFormField(
                                                hint: "كود",
                                                width: 180,
                                                controller: vm.codecontroller),
                                            CustomTextFormField(
                                                hint: "بيان",
                                                width: 180,
                                                controller: vm.N),
                                          ],
                                        ),
                                        const Gap(14),
                                        Row(
                                          children: [
                                            CustomTextFormField(
                                                hint: "كثافه",
                                                width: 120,
                                                controller:
                                                    vm.densitycontroller),
                                            CustomTextFormField(
                                                hint: "لون",
                                                width: 120,
                                                controller: vm.colercontroller),
                                          ],
                                        ),
                                        const Gap(14),
                                        Row(
                                          children: [
                                            CustomTextFormField(
                                                hint: "طول",
                                                width: 120,
                                                controller: vm.lenthcontroller),
                                            CustomTextFormField(
                                                hint: "عرض",
                                                width: 120,
                                                controller: vm.widthcontroller),
                                            CustomTextFormField(
                                                hint: "ارتفاع",
                                                width: 120,
                                                controller:
                                                    vm.hightncontroller),
                                          ],
                                        ),
                                        const Gap(22),
                                        ElevatedButton(
                                            onPressed: () {
                                              if (vm.validate()) {
                                                for (var element
                                                    in blocks.where((test) =>
                                                        test.number >=
                                                            vm.from.text
                                                                .to_int() &&
                                                        test.number <=
                                                            vm.to.text
                                                                .to_int())) {
                                                  element.serial =
                                                      vm.codecontroller.text;

                                                  element.discreption =
                                                      vm.N.text;

                                                  element.item.density = vm
                                                      .densitycontroller.text
                                                      .to_double();

                                                  element.item.color =
                                                      vm.colercontroller.text;

                                                  if (vm.lenthcontroller.text
                                                      .isNotEmpty) {
                                                    element.item.L = vm
                                                        .lenthcontroller.text
                                                        .to_double();
                                                  }
                                                  if (vm.widthcontroller.text
                                                      .isNotEmpty) {
                                                    element.item.W = vm
                                                        .widthcontroller.text
                                                        .to_double();
                                                  }
                                                  if (vm.hightncontroller.text
                                                      .isNotEmpty) {
                                                    element.item.H = vm
                                                        .hightncontroller.text
                                                        .to_double();
                                                  }

                                                  context
                                                      .read<
                                                          BlockFirebasecontroller>()
                                                      .updateBlock(element);
                                                }
                                              }
                                              context
                                                  .read<
                                                      BlockFirebasecontroller>()
                                                  .Refresh_the_UI();
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('تم'))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ));
                  },
                  icon: const Icon(Icons.edit),
                ).permition(context, UserPermition.can_edit_saba),
                IconButton(
                  onPressed: () async {
                    generateAndSaveExcel(blocks);
                  },
                  icon: const Icon(Icons.explicit_outlined),
                ),
                IconButton(
                    onPressed: () {
                      permission().then((value) async {
                        PdfBlockReport2.generate(context, blocks)
                            .then((value) => context.gonext(
                                context,
                                PDfpreview(
                                  v: value.save(),
                                )));
                      });
                    },
                    icon: const Icon(Icons.picture_as_pdf)),
                const DropDdowen_forCode(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        sizeWidget(blocks),
                        Text("اجمالى الصبه : ${blocks.length}"),
                      ],
                    ),
                    Row(
                      children: [
                        sizeWidget(consumed),
                        Text("اجمالى المنصرف : ${consumed.length}"),
                      ],
                    ),
                    Row(
                      children: [
                        sizeWidget(remain),
                        Text("المتبقى  : ${remain.length}"),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const Headerr(),
            Column(
              children: blocks
                  .map((e) => RowItem(item: e, i: blocks.indexOf(e)))
                  .toList(),
            )
          ],
        );
      },
    );
  }

  Padding sizeWidget(List<BlockModel> data) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Text(
        'حجم : ${data.size()}',
        style: TextStyle(background: Paint(), color: Colors.white),
      ),
    );
  }
}

class DropDdowen_forCode extends StatelessWidget {
  const DropDdowen_forCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, mytype, child) {
        mytype.getblocks(context);
        return DropdownButton(
            value: context.read<ObjectBoxController>().serial2,
            items: mytype.blocks
                .filterserials()
                .map((e) => e.serial)
                .toList()
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context.read<ObjectBoxController>().serial2 = v;
                context.read<ObjectBoxController>().get();
                context.read<BlockFirebasecontroller>().Refresh_the_UI();
              }
            });
      },
    );
  }
}

class Headerr extends StatelessWidget {
  const Headerr({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("م")),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("رقم")),
          ),
          Container(
            width: 120,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("كود")),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("كثافه")),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("لون")),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("طول")),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("عرض")),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("ارتفاع")),
          ),
          Container(
            width: 150,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("بيان")),
          ),
          Container(
            width: 130,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("ملاحظات")),
          ),
          Container(
            width: 130,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: const Center(child: Text("تاريخ الصرف")),
          ),
        ].reversed.toList(),
      ),
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem({
    super.key,
    required this.item,
    required this.i,
  });
  final BlockModel item;
  final int i;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: i % 2 == 1
              ? Colors.white
              : const Color.fromARGB(255, 153, 210, 218)),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text("${i + 1}")),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text("${item.number}")),
          ),
          Container(
            width: 120,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.serial)),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.density.toString())),
          ),
          Container(
            width: 50,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.color)),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.L.removeTrailingZeros)),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.W.removeTrailingZeros)),
          ),
          Container(
            width: 80,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.item.H.removeTrailingZeros)),
          ),
          Container(
            width: 150,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.discreption)),
          ),
          Container(
            width: 130,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(child: Text(item.notes)),
          ),
          Container(
            width: 130,
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Center(
                child: Text(item.actions.if_action_exist(
                            BlockAction.consume_block.getactionTitle) ==
                        false
                    ? "غير منصرف"
                    : item.actions
                        .get_Date_of_action(
                            BlockAction.consume_block.getactionTitle)
                        .formatt())),
          ),
        ].reversed.toList(),
      ),
    );
  }
}
