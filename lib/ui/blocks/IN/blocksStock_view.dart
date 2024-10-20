// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/chips/constans_view.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/blocks/IN/bulkUpload.dart';
import 'package:janssenfoam/ui/blocks/IN/outofStock_viewmoder.dart';
import 'package:janssenfoam/ui/blocks/IN/widgets.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/ui/blocks/addCategoreys/CategorysController.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/controllers/setting_controller.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';

import 'package:provider/provider.dart';

import 'package:janssenfoam/app/validation.dart';

import 'package:janssenfoam/core/commen/textformfield.dart';

class blocksStock extends StatelessWidget {
  blocksStock({super.key});

  blocksStockViewModel vm = blocksStockViewModel();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.gonext(context, Archived());
                },
                icon: const Icon(Icons.archive_sharp)),
            IconButton(
                onPressed: () {
                  settingthedialog(context);
                },
                icon: const Icon(Icons.settings)),
            IconButton(
                onPressed: () =>
                    context.gonext(context, const bulkUploadForblocks()),
                icon: const Icon(Icons.explicit_outlined)),
          ],
          title: const Text("رصيد البلوكات"),
        ),
        body: Form(
            key: vm.formKey,
            child: Consumer<SettingController>(
              builder: (context, myType, child) {
                return Column(
                  children: [
                    errmsg(context),
                    const SizedBox(
                      height: 12,
                    ),
                    myType.GroupvalueofRadio != 1
                        ? const SizedBox()
                        : Column(
                            children: [
                              Fields(vm: vm),
                              Buttoms(vm: vm),
                            ],
                          ).permition(
                            context, UserPermition.incert_in_block_stock),
                    myType.GroupvalueofRadio != 2
                        ? const SizedBox()
                        : Column(
                            children: [
                              const DropDdowenFor_blockCategory(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .16,
                                    hint: "من ",
                                    keybordtupe: TextInputType.number,
                                    controller: vm.from,
                                    validator:
                                        Validation.validatefromTo(context, vm),
                                  ),
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .16,
                                    hint: "الى ",
                                    controller: vm.to,
                                    validator:
                                        Validation.validatefromTo(context, vm),
                                  ),
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .20,
                                    hint: "الطول ",
                                    controller: vm.lenthcontroller,
                                    validator: Validation.validateothers,
                                  ),
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .20,
                                    hint: "العرض",
                                    controller: vm.widthcontroller,
                                    validator: Validation.validateothers,
                                  ),
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .20,
                                    hint: "الارتفاع",
                                    controller: vm.hightncontroller,
                                    validator: Validation.validateothers,
                                  ),
                                ].reversed.toList(),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomTextFormField(
                                      keybordtupe: TextInputType.name,
                                      width: MediaQuery.of(context).size.width *
                                          .35,
                                      hint: "الكود ",
                                      controller: vm.codecontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      width: MediaQuery.of(context).size.width *
                                          .15,
                                      hint: "الوزن ",
                                      controller: vm.wightcontroller,
                                      validator: Validation.validateothers,
                                    ),
                                    CustomTextFormField(
                                      keybordtupe: TextInputType.name,
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      hint: " ملاحظات",
                                      controller: vm.notes,
                                    ),
                                    CustomTextFormField(
                                      keybordtupe: TextInputType.name,
                                      width: MediaQuery.of(context).size.width *
                                          .25,
                                      label: "وارد من",
                                      hint: "الصبه",
                                      controller: vm.cummingFrom,
                                    ),
                                  ].reversed.toList(),
                                ),
                              ),
                              const SearchForBlockIN_Blcokstock(),
                              ElevatedButton(
                                  onPressed: () {
                                    if (vm.formKey.currentState!.validate() &&
                                        context
                                                .read<Category_controller>()
                                                .initialFordropdowen !=
                                            null) {
                                      vm.incertblock2(
                                        context,
                                      );
                                      vm.clearfields();
                                    }
                                  },
                                  child: const SizedBox(
                                    width: 90,
                                    height: 45,
                                    child: Center(
                                      child: Text(
                                        "اضافة",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                    TheTable(vm: vm),
                  ],
                );
              },
            )),
      ),
    );
  }
}

class Buttoms extends StatelessWidget {
  const Buttoms({
    super.key,
    required this.vm,
  });

  final blocksStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ChipsForblocks(),
        ElevatedButton(
            onPressed: () {
              if (vm.formKey.currentState!.validate()) {
                vm.incertblock(context);
                vm.clearfields();
              }
            },
            child: const SizedBox(
              width: 90,
              height: 45,
              child: Center(
                child: Text(
                  "اضافة",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )),
        const SizedBox(
          width: 40,
        ),
        IconButton(
            onPressed: () {
              context.read<BlockFirebasecontroller>();
              context.read<BlockFirebasecontroller>().Refresh_the_UI();
            },
            icon: const Icon(Icons.search)),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class Fields extends StatelessWidget {
  const Fields({
    super.key,
    required this.vm,
  });

  final blocksStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SizedBox(
        height: 210,
        child: Column(
          children: [
            SizedBox(
              height: 105,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .16,
                    hint: " البيان",
                    controller: vm.blockdesription,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الكثافه",
                    controller: vm.densitycontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "اللون",
                    keybordtupe: TextInputType.text,
                    controller: vm.colercontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الكود ",
                    controller: vm.codecontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "النوع",
                    keybordtupe: TextInputType.name,
                    controller: vm.typecontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الوزن ",
                    controller: vm.wightcontroller,
                    validator: Validation.validateothers,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 105,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .16,
                    hint: " ملاحظات",
                    controller: vm.notes,
                  ),
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "وارد من",
                    controller: vm.cummingFrom,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الارتفاع",
                    controller: vm.hightncontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "العرض",
                    controller: vm.widthcontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "الطول ",
                    controller: vm.lenthcontroller,
                    validator: Validation.validateothers,
                  ),
                  CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .16,
                    hint: "رقم البلوك",
                    controller: vm.blocknumbercontroller,
                    validator: Validation.validate_if_block_exist(context, vm),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TheTable extends StatelessWidget {
  const TheTable({
    super.key,
    required this.vm,
  });
  final blocksStockViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 900,
              child: ListView(
                children: [
                  const HeaderOftable1(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(.8),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(1),
                      5: FlexColumnWidth(1),
                      6: FlexColumnWidth(1),
                      7: FlexColumnWidth(2.8),
                      8: FlexColumnWidth(2.8),
                      9: FlexColumnWidth(1),
                    },
                    children: blocks.blocks.values
                        .toList()
                        .reversed
                        .sortedBy<num>((element) => element.Block_Id)
                        .reversed
                        .toList()
                        .search2(blocks.searchin_blockstock)
                        .take(context
                            .read<SettingController>()
                            .amountofshowinaddBlock)
                        .toList()
                        .reversed
                        .toList()
                        .map((user) {
                          return TableRow(
                              decoration: BoxDecoration(
                                color: blocks.blocks.values
                                                .toList()
                                                .sortedBy<num>((element) =>
                                                    element.Block_Id)
                                                .indexOf(user) %
                                            2 ==
                                        0
                                    ? Colors.blue[50]
                                    : Colors.amber[50],
                              ),
                              children: [
                                //الحذف
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) => AlertDialog(
                                                    scrollable: true,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    content: SizedBox(
                                                      height: 50,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            //buttons
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                  child: ElevatedButton(
                                                                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
                                                                      onPressed: () {
                                                                        if (user.actions.if_action_exist(BlockAction.cut_block_on_H.getactionTitle) ==
                                                                            false) {
                                                                          user.actions.add(BlockAction
                                                                              .archive_block
                                                                              .add);

                                                                          context
                                                                              .read<BlockFirebasecontroller>()
                                                                              .updateBlock(user);
                                                                        }
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text('حذف')),
                                                                ),
                                                                const SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                  child: ElevatedButton(
                                                                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                                                                      onPressed: () {
                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                      child: const Text('الغاء')),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ));
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(child: Text(user.notes))),
                                Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Icon(user.actions
                                                .if_action_exist(BlockAction
                                                    .consume_block
                                                    .getactionTitle)
                                            ? Icons.check
                                            : Icons.close)),
                                    user.actions.if_action_exist(BlockAction
                                            .consume_block.getactionTitle)
                                        ? Text(DateFormat('dd-MM-yy/hh:mm a')
                                            .format(user.actions
                                                .get_Date_of_action(BlockAction
                                                    .consume_block
                                                    .getactionTitle))
                                            .toString()
                                            .toString()
                                            .toString())
                                        : const SizedBox(),
                                    user.actions.if_action_exist(BlockAction
                                                .consume_block
                                                .getactionTitle) ==
                                            true
                                        ? Text(user.actions.get_block_Who_Of(
                                            BlockAction.consume_block))
                                        : const SizedBox(),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Icon(user.actions
                                                .if_action_exist(BlockAction
                                                    .create_block
                                                    .getactionTitle)
                                            ? Icons.check
                                            : Icons.close)),
                                    user.actions.if_action_exist(BlockAction
                                            .create_block.getactionTitle)
                                        ? Text(DateFormat('dd-MM-yy/hh:mm a')
                                            .format(user.actions
                                                .get_Date_of_action(BlockAction
                                                    .create_block
                                                    .getactionTitle))
                                            .toString()
                                            .toString()
                                            .toString())
                                        : const SizedBox(),
                                    user.actions.if_action_exist(BlockAction
                                                .create_block.getactionTitle) ==
                                            true
                                        ? Text(user.actions.get_block_Who_Of(
                                            BlockAction.create_block))
                                        : const SizedBox(),
                                  ],
                                ),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.OutTo.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child:
                                            Text(user.cumingFrom.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.Hscissor.toString()))),

                                //البيان
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${user.item.H.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.L.removeTrailingZeros}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${user.item.color} ${user.item.type} ك${user.item.density.removeTrailingZeros}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                //الرقم و الكود
                                Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 9),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          user.number.toString(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 221, 2, 75)),
                                        ),
                                        Text(
                                          user.serial.toString(),
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    )),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(
                                            "${blocks.blocks.values.toList().indexOf(user) + 1}"))),
                              ]);
                        })
                        .toList()
                        .reversed
                        .toList(),
                    border: TableBorder.all(width: 1, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Archived extends StatelessWidget {
  Archived({super.key});
  blocksStockViewModel vm = blocksStockViewModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ارشيف المحزوفات"),
      ),
      body: ArchivedTheTable(vm: vm),
    );
  }
}

class ArchivedTheTable extends StatelessWidget {
  const ArchivedTheTable({
    super.key,
    required this.vm,
  });
  final blocksStockViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<BlockFirebasecontroller>(
          builder: (context, blocks, child) {
            var b = blocks.archived_blocks.values
                .toList()
                .reversed
                .sortedBy<num>((element) => element.actions
                    .get_Date_of_action(
                        BlockAction.archive_block.getactionTitle)
                    .microsecondsSinceEpoch)
                .reversed
                .toList();
            return Expanded(
              flex: 4,
              child: SingleChildScrollView(
                reverse: true,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: 900,
                  child: ListView(
                    children: [
                      const HeaderOftable1(),
                      Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(3),
                          3: FlexColumnWidth(3),
                          4: FlexColumnWidth(1),
                          5: FlexColumnWidth(1),
                          6: FlexColumnWidth(1),
                          7: FlexColumnWidth(2.8),
                          8: FlexColumnWidth(2.8),
                          9: FlexColumnWidth(1),
                        },
                        children: b
                            .take(context
                                .read<SettingController>()
                                .amountofshowinaddBlock)
                            .toList()
                            .reversed
                            .map((user) {
                              return TableRow(
                                  decoration: BoxDecoration(
                                    color:
                                        b.reversed.toList().indexOf(user) % 2 ==
                                                0
                                            ? Colors.blue[50]
                                            : Colors.amber[50],
                                  ),
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(4),
                                            child: GestureDetector(
                                                onTap: () {
                                                  int index = user.actions
                                                      .indexWhere((element) =>
                                                          element.action ==
                                                          BlockAction
                                                              .archive_block
                                                              .getactionTitle);
                                                  user.actions.removeAt(index);
                                                  context
                                                      .read<
                                                          BlockFirebasecontroller>()
                                                      .updateBlock(user);
                                                },
                                                child: const Icon(
                                                  Icons.unarchive_sharp,
                                                  color: Colors.red,
                                                ))),
                                        Container(
                                            padding: const EdgeInsets.all(2),
                                            child: Icon(user.actions
                                                    .if_action_exist(BlockAction
                                                        .archive_block
                                                        .getactionTitle)
                                                ? Icons.check
                                                : Icons.close)),
                                        user.actions.if_action_exist(BlockAction
                                                .archive_block.getactionTitle)
                                            ? Text(DateFormat(
                                                    'dd-MM-yy/hh:mm a')
                                                .format(user.actions
                                                    .get_Date_of_action(
                                                        BlockAction
                                                            .archive_block
                                                            .getactionTitle))
                                                .toString()
                                                .toString()
                                                .toString())
                                            : const SizedBox(),
                                        user.actions.if_action_exist(BlockAction
                                                    .archive_block
                                                    .getactionTitle) ==
                                                true
                                            ? Text(user.actions
                                                .get_block_Who_Of(
                                                    BlockAction.archive_block))
                                            : const SizedBox(),
                                      ],
                                    ),

                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(child: Text(user.notes))),
                                    Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(2),
                                            child: Icon(user.actions
                                                    .if_action_exist(BlockAction
                                                        .consume_block
                                                        .getactionTitle)
                                                ? Icons.check
                                                : Icons.close)),
                                        user.actions.if_action_exist(BlockAction
                                                .consume_block.getactionTitle)
                                            ? Text(DateFormat(
                                                    'dd-MM-yy/hh:mm a')
                                                .format(user.actions
                                                    .get_Date_of_action(
                                                        BlockAction
                                                            .consume_block
                                                            .getactionTitle))
                                                .toString()
                                                .toString()
                                                .toString())
                                            : const SizedBox(),
                                        user.actions.if_action_exist(BlockAction
                                                    .consume_block
                                                    .getactionTitle) ==
                                                true
                                            ? Text(user.actions
                                                .get_block_Who_Of(
                                                    BlockAction.consume_block))
                                            : const SizedBox(),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(2),
                                            child: Icon(user.actions
                                                    .if_action_exist(BlockAction
                                                        .create_block
                                                        .getactionTitle)
                                                ? Icons.check
                                                : Icons.close)),
                                        user.actions.if_action_exist(BlockAction
                                                .create_block.getactionTitle)
                                            ? Text(DateFormat(
                                                    'dd-MM-yy/hh:mm a')
                                                .format(user.actions
                                                    .get_Date_of_action(
                                                        BlockAction.create_block
                                                            .getactionTitle))
                                                .toString()
                                                .toString()
                                                .toString())
                                            : const SizedBox(),
                                        user.actions.if_action_exist(BlockAction
                                                    .create_block
                                                    .getactionTitle) ==
                                                true
                                            ? Text(user.actions
                                                .get_block_Who_Of(
                                                    BlockAction.create_block))
                                            : const SizedBox(),
                                      ],
                                    ),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child:
                                                Text(user.OutTo.toString()))),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                                user.cumingFrom.toString()))),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                                user.Hscissor.toString()))),

                                    //البيان
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${user.item.H.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.L.removeTrailingZeros}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            "${user.item.color} ${user.item.type} ك${user.item.density.removeTrailingZeros}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //الرقم و الكود
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 9),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              user.number.toString(),
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 221, 2, 75)),
                                            ),
                                            Text(
                                              user.serial.toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )),
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                                "${b.reversed.toList().indexOf(user) + 1}"))),
                                  ]);
                            })
                            .toList()
                            .reversed
                            .toList(),
                        border: TableBorder.all(width: 1, color: Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
