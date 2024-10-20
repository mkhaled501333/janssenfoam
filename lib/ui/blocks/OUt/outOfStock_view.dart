// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, camel_case_types
// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/blocks/IN/outofStock_viewmoder.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/blocks/OUt/outOfStock_viewModel.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';

import 'package:janssenfoam/ui/scissors/sH/Widgets.dart';

class OutOfStockView extends StatefulWidget {
  const OutOfStockView({super.key});

  @override
  State<OutOfStockView> createState() => _OutOfStockViewState();
}

class _OutOfStockViewState extends State<OutOfStockView> {
  OutOfStockViewModel vm = OutOfStockViewModel();

  blocksStockViewModel vm2 = blocksStockViewModel();
  String chosenDate = format.format(DateTime.now());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                thedialog(context);
              },
              icon: const Icon(Icons.settings)),
          TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      setState(() {
                        String formattedDate = format.format(pickedDate);
                        chosenDate = formattedDate;
                      });
                    } else {}
                  },
                  child: Text(
                    chosenDate,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ))
              .permition(
                  context, UserPermition.show_date_in_block_out_of_stock),
        ],
        title: const Text("صرف بلوكات"),
      ),
      body: Consumer<BlockFirebasecontroller>(
        builder: (context, b, child) {
          return Column(
            children: [
              errmsg(context),
              SizedBox(
                height: 160,
                child: Form(
                  key: vm.formKey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Fieldss(
                            formKey: formKey,
                            vm: vm,
                          ),
                          Buttoms(
                            vm: vm,
                            formKey: formKey,
                          )
                        ],
                      ),
                      Column(
                        children: [
                          DropDdowenFor_blockColor(b: b.blocks.values.toList()),
                          const DropDdowen_forCode(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              TheTable0001(vm: vm2, vm2: vm, chosenDate: chosenDate)
            ],
          );
        },
      ),
    ));
  }
}

class Buttoms extends StatelessWidget {
  const Buttoms({
    super.key,
    required this.vm,
    required this.formKey,
  });

  final OutOfStockViewModel vm;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SearchForBlockIN_Consumed(),
        const SizedBox(
          width: 20,
        ),
        ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                vm.consumeBlock(context);
              }
            },
            child: const SizedBox(
              width: 90,
              height: 45,
              child: Center(
                child: Text(
                  "صرف",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            )),
      ],
    );
  }
}

class Fieldss extends StatelessWidget {
  const Fieldss({
    super.key,
    required this.vm,
    required this.formKey,
  });

  final OutOfStockViewModel vm;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              CustomTextFormField(
                keybordtupe: TextInputType.name,
                width: MediaQuery.of(context).size.width * .23,
                hint: "صالة الانتاج",
                label: "صادر الى",
                controller: vm.outTo,
              ),
              const SizedBox(
                width: 20,
              ),
              CustomTextFormField(
                autofocus: true,
                onsubmitted: (d) {
                  if (formKey.currentState!.validate()) {
                    vm.consumeBlock(context);
                  }
                  return null;
                },
                width: MediaQuery.of(context).size.width * .23,
                hint: "رقم البلوك",
                controller: vm.blocknumbercontroller,
                validator:
                    Validation.validate_if_block_in_Stock_or_already_consumed(
                        context, vm),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TheTable0001 extends StatelessWidget {
  const TheTable0001({
    super.key,
    required this.vm,
    required this.chosenDate,
    required this.vm2,
  });
  final String chosenDate;

  final blocksStockViewModel vm;
  final OutOfStockViewModel vm2;
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        List<BlockModel> b = blocks.blocks.values
            .toList()
            .reversed
            .toList()
            .where((element) =>
                format.format(element.actions.get_Date_of_action(
                    BlockAction.consume_block.getactionTitle)) ==
                chosenDate)
            .sortedBy<DateTime>((element) => element.actions
                .get_Date_of_action(BlockAction.consume_block.getactionTitle))
            .where((element) =>
                element.actions
                    .block_action_Stutus(BlockAction.consume_block) ==
                true)
            .toList()
            .search(blocks.searchinconsumed);
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 920,
              child: ListView(
                children: [
                  const HeaderOftable001(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(.8),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(1.8),
                      5: FlexColumnWidth(1),
                      6: FlexColumnWidth(1.2),
                      7: FlexColumnWidth(1.2),
                      8: FlexColumnWidth(2.8),
                      9: FlexColumnWidth(3),
                      10: FlexColumnWidth(1),
                    },
                    children: b
                        .toList()
                        .reversed
                        .take(context
                            .read<BlockFirebasecontroller>()
                            .amountofView)
                        .toList()
                        .reversed
                        .map((user) {
                          return TableRow(
                              decoration: BoxDecoration(
                                color: blocks.blocks.values
                                                .toList()
                                                .indexOf(user) %
                                            2 ==
                                        0
                                    ? Colors.blue[50]
                                    : Colors.amber[50],
                              ),
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (user.actions.if_action_exist(
                                                  BlockAction.cut_block_on_H
                                                      .getactionTitle) ==
                                              false) {
                                            vm2.unconsumeBlock(context, user);
                                          }
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))).permition(context,
                                    UserPermition.delete_in_consume_block),

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
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              scrollable: true,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              content: SizedBox(
                                                height: 120,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      CustomTextFormField(
                                                        keybordtupe:
                                                            TextInputType.name,
                                                        width: 120,
                                                        hint: "صالة الانتاج",
                                                        label: "صادر الى",
                                                        controller: vm.outTo,
                                                      ),
                                                      //buttons
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors
                                                                                .red)),
                                                                    onPressed:
                                                                        () {
                                                                      user.OutTo = vm
                                                                              .outTo
                                                                              .text
                                                                              .isEmpty
                                                                          ? "صالة الانتاج"
                                                                          : vm.outTo
                                                                              .text;
                                                                      blocks.updateBlock(
                                                                          user);
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        'تم')),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          Expanded(
                                                            child:
                                                                ElevatedButton(
                                                                    style: ButtonStyle(
                                                                        backgroundColor:
                                                                            WidgetStateProperty.all(Colors
                                                                                .blue)),
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context);
                                                                    },
                                                                    child: const Text(
                                                                        'الغاء')),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ).permition(context,
                                                UserPermition.can_edit_outTo));
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Center(
                                          child: Text(user.OutTo.toString()))),
                                ),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child:
                                            Text(user.cumingFrom.toString()))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.Hscissor.toString()))),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.item.volume
                                            .toStringAsFixed(1)))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.item.wight
                                            .toStringAsFixed(1)))),
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
                                        child: Text("${b.indexOf(user) + 1}"))),
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

class SearchForBlockIN_Consumed extends StatelessWidget {
  const SearchForBlockIN_Consumed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      child: Container(
        color: const Color.fromARGB(96, 230, 218, 218),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              hintText: "بحث", border: OutlineInputBorder()),
          onChanged: (v) {
            context.read<BlockFirebasecontroller>().searchinconsumed = v;

            context.read<BlockFirebasecontroller>().Refresh_the_UI();
          },
        ),
      ),
    );
  }
}

class HeaderOftable001 extends StatelessWidget {
  const HeaderOftable001({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(.8),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(1.8),
        5: FlexColumnWidth(1),
        6: FlexColumnWidth(1.2),
        7: FlexColumnWidth(1.2),
        8: FlexColumnWidth(2.8),
        9: FlexColumnWidth(3),
        10: FlexColumnWidth(1),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.amber[50],
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text(''))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('تم الصرف'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('تم الانشاء'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('صادر الى'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('وارد من'))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    'المقص',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    'حجم',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    'وزن',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('بيان البلوك'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Column(
                    children: [
                      Text('الرقم'),
                      Text('الكود'),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('م')),
            ])
      ],
    );
  }
}

class DropDdowenFor_blockColor extends StatelessWidget {
  const DropDdowenFor_blockColor({super.key, required this.b});
  final List<BlockModel> b;

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, myType, child) {
        myType.getblocks(context);

        return DropdownButton(
            value: context.read<ObjectBoxController>().initialcolor,
            items: myType
                .filtercolor(context
                    .read<BlockFirebasecontroller>()
                    .blocks
                    .values
                    .toList())
                .map((e) => e)
                .toList()
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                myType.getblocks(context);
                context.read<ObjectBoxController>().initialcolor = v;
                myType.serial = null;
                context.read<ObjectBoxController>().get();
              }
            });
      },
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
            value: context.read<ObjectBoxController>().serial,
            items: mytype.blocks
                .where((element) =>
                    element.actions.if_action_exist(
                        BlockAction.consume_block.getactionTitle) ==
                    false)
                .toList()
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
                mytype.getblocks(context);
                context.read<ObjectBoxController>().serial = v;
                mytype.getblocks(context);
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}
