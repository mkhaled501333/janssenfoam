// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, camel_case_types
// ignore_for_file: file_names, must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/core/chips/constans_view.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/blocks/IN/outofStock_viewmoder.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/scissors/sH/H1_veiwModel.dart';
import 'package:janssenfoam/ui/scissors/sH/h1_veiw.dart';

class ReportwForHView extends StatefulWidget {
  const ReportwForHView({
    super.key,
    required this.scissor,
  });
  final int scissor;

  @override
  State<ReportwForHView> createState() => _ReportwForHViewState();
}

class _ReportwForHViewState extends State<ReportwForHView> {
  blocksStockViewModel vm = blocksStockViewModel();
  String chosenDate = format.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
              )),
          const SearchForBlockIN_H(),
          IconButton(
              onPressed: () {
                thedialog(context);
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(
        children: [
          errmsg(context),
          TheTable0001(
            vm: vm,
            scissor: widget.scissor,
            chosenDate: chosenDate,
          )
        ],
      ),
    );
  }
}

class SearchForBlockIN_H extends StatelessWidget {
  const SearchForBlockIN_H({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Container(
        color: const Color.fromARGB(96, 230, 218, 218),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
              icon: Icon(Icons.search), border: OutlineInputBorder()),
          onChanged: (v) {
            context.read<BlockFirebasecontroller>().searchin_H = v;
            context.read<BlockFirebasecontroller>().Refresh_the_UI();
          },
        ),
      ),
    );
  }
}

thedialog(BuildContext context) {
  H1VeiwModel vm = H1VeiwModel();
  TextEditingController c = TextEditingController();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('  ?'),
          content: SizedBox(
            height: 200,
            child: Column(children: [
              const Text("كميه العرض"),
              SizedBox(
                width: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  controller: c,
                ),
              ),
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  vm.amountofView = c.text.to_int();
                  context.read<BlockFirebasecontroller>().amountofView =
                      c.text.to_int();
                  context.read<BlockFirebasecontroller>().Refresh_the_UI();
                  Navigator.pop(context);
                },
                child: const Text('تم')),
          ],
        );
      });
}

diolg_ForSettingIN_mainveiwOF_H(BuildContext context) {
  H1VeiwModel vm = H1VeiwModel();
  TextEditingController c = TextEditingController();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('  ?'),
          content: SizedBox(
            height: 200,
            child: Column(children: [
              const Text("كميه العرض"),
              SizedBox(
                width: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  controller: c,
                ),
              ),
              Selector<BlockFirebasecontroller, bool>(
                selector: (_, myType) => myType.veiwCuttedAndimpatyNotfinals,
                builder: (context, m, child) {
                  return CheckboxListTile(
                      title: const Text(
                          "عرض البلوكات التى لم يتم اضافة هوالك لها"),
                      value: m,
                      onChanged: (v) {
                        context
                            .read<BlockFirebasecontroller>()
                            .veiwCuttedAndimpatyNotfinals = v!;
                        context
                            .read<BlockFirebasecontroller>()
                            .Refresh_the_UI();
                      });
                },
              )
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  vm.amountofView = c.text.to_int();
                  context
                      .read<BlockFirebasecontroller>()
                      .amountofViewForMinVeiwIn_H = c.text.to_int();
                  context.read<BlockFirebasecontroller>().Refresh_the_UI();
                  Navigator.pop(context);
                },
                child: const Text('تم')),
          ],
        );
      });
}

//تقرير المقص الراسى
class TheTable0001 extends StatelessWidget {
  TheTable0001({
    super.key,
    required this.vm,
    required this.scissor,
    required this.chosenDate,
  });
  final blocksStockViewModel vm;
  final int scissor;
  String chosenDate;
  H1VeiwModel vm2 = H1VeiwModel();

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        int x = 0;
        List<BlockModel> b = getBloksCuttedOnThisScissor(blocks);
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1370,
              child: ListView(
                children: [
                  const HeaderOftable0011(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1.1),
                      2: FlexColumnWidth(1.1),
                      3: FlexColumnWidth(1.1),
                      4: FlexColumnWidth(1.1),
                      5: FlexColumnWidth(1.1),
                      6: FlexColumnWidth(3),
                      7: FlexColumnWidth(3),
                      8: FlexColumnWidth(3),
                      9: FlexColumnWidth(3),
                      10: FlexColumnWidth(2),
                      11: FlexColumnWidth(1),
                      12: FlexColumnWidth(3),
                      13: FlexColumnWidth(3),
                      14: FlexColumnWidth(1),
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
                          x++;
                          return TableRow(
                              decoration: BoxDecoration(
                                color: x.isEven
                                    ? Colors.blue[50]
                                    : Colors.amber[50],
                              ),
                              children: [
                                //الحذف
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          vm2.UNcutBlockFromH(
                                              context: context, block: user);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(vm2
                                            .percentage(user)
                                            .removeTrailingZeros))),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(vm2
                                            .difrence(context, user)
                                            .toStringAsFixed(2)))),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(vm2
                                            .wight_of_notfinal(user)
                                            .toStringAsFixed(2)))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(vm2
                                            .wight_of_fractions(context, user)
                                            .toStringAsFixed(2)))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.item.wight
                                            .toStringAsFixed(2)))),
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
                                Column(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(user.Hscissor.toString())),
                                    user.actions.if_action_exist(BlockAction
                                            .cut_block_on_H.getactionTitle)
                                        ? Text(DateFormat('dd-MM-yy/hh:mm a')
                                            .format(user.actions
                                                .get_Date_of_action(BlockAction
                                                    .cut_block_on_H
                                                    .getactionTitle))
                                            .toString()
                                            .toString()
                                            .toString())
                                        : const SizedBox(),
                                    user.actions.if_action_exist(BlockAction
                                                .cut_block_on_H
                                                .getactionTitle) ==
                                            true
                                        ? Text(user.actions.get_block_Who_Of(
                                            BlockAction.cut_block_on_H))
                                        : const SizedBox(),
                                  ],
                                ),
                                Column(
                                  children: vm2
                                      .getFractinsOFABlock(context, user)
                                      .map(
                                        (e) => Container(
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                                "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}")),
                                      )
                                      .toList(),
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

                                //بيان البلوك
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                      child: Column(
                                        children: [
                                          Text(
                                              "${user.item.H.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.L.removeTrailingZeros}"),
                                          Text(
                                              "${user.item.color} ${user.item.type} ك${user.item.density.removeTrailingZeros}"),
                                        ],
                                      ),
                                    )),

                                //بيان الرقم و الكود
                                GestureDetector(
                                  onTap: () {
                                    dialogOfAddNotFinalToBlock(context, user);
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              user.number.toString(),
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 221, 2, 75)),
                                            ),
                                            Text(
                                              user.serial.toString(),
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            )
                                          ],
                                        ),
                                      )),
                                ),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text("${b.indexOf(user) + 1}")))
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

  List<BlockModel> getBloksCuttedOnThisScissor(BlockFirebasecontroller blocks) {
    List<BlockModel> b = blocks.blocks.values
        .toList()
        .where((element) =>
            format.format(element.actions.get_Date_of_action(
                BlockAction.cut_block_on_H.getactionTitle)) ==
            chosenDate)
        .where((element) => element.Hscissor == scissor)
        .toList()
        .where((element) =>
            element.actions.block_action_Stutus(BlockAction.consume_block) ==
            true)
        .sortedBy<num>((element) => element.actions
            .get_Date_of_action(BlockAction.cut_block_on_H.getactionTitle)
            .millisecondsSinceEpoch);
    return b;
  }
}

dialogOfAddNotFinalToBlock(
  BuildContext context,
  BlockModel user,
) {
  H1VeiwModel vm = H1VeiwModel();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اضافة هوالك الى هذا البلوك'),
          content: SizedBox(
            height: 200,
            child: Column(children: [
              const DropDdowen002(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 18),
                child: CustomTextFormField(
                    hint: " وزن دون التام",
                    width: 120,
                    validator: Validation.validateothers,
                    controller: vm.wightcontroller),
              ),
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  vm.Add_not_finalTo_block(context, user);
                  Navigator.pop(context);
                },
                child: const Text('تم')),
          ],
        );
      });
}

class HeaderOftable0011 extends StatelessWidget {
  const HeaderOftable0011({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.1),
        2: FlexColumnWidth(1.1),
        3: FlexColumnWidth(1.1),
        4: FlexColumnWidth(1.1),
        5: FlexColumnWidth(1.1),
        6: FlexColumnWidth(3),
        7: FlexColumnWidth(3),
        8: FlexColumnWidth(3),
        9: FlexColumnWidth(3),
        10: FlexColumnWidth(2),
        11: FlexColumnWidth(1),
        12: FlexColumnWidth(3),
        13: FlexColumnWidth(3),
        14: FlexColumnWidth(1),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.blue[50],
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text(' حذف'))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    '% نسبة الهالك ',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(1),
                  child: const Center(
                      child: Text(
                    'فرق الانتاج كج',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('وزن الهوالك'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('وزن النواتج'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text('وزن البلوك')),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('تم الصرف'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('تم الانشاء'))),
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
                    'النواتج',
                    style: TextStyle(fontSize: 12),
                  ))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('صادر الى'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('وارد من'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('بيان البلوك'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Column(
                    children: [
                      Text('رقم'),
                      Text('كود'),
                    ],
                  )),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('م')),
            ])
      ],
    );
  }
}

class NewVeiw extends StatelessWidget {
  NewVeiw({
    super.key,
    required this.Hscissor,
  });
  final int Hscissor;
  int x = 0;

  @override
  Widget build(BuildContext context) {
    int x = 0;

    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<BlockModel> blocksConsumedaAndNotCuttedOn_H = myType.blocks.values
            .toList()
            .where((element) =>
                element.OutTo == "صالة الانتاج" &&
                element.actions.if_action_exist(
                        BlockAction.consume_block.getactionTitle) ==
                    true)
            .sortedBy<num>((element) => element.actions
                .get_Date_of_action(BlockAction.consume_block.getactionTitle)
                .millisecondsSinceEpoch)
            .search(myType.searchin_H)
            .toList();

        List<BlockModel> blockswithNO_Notfinals =
            blocksConsumedaAndNotCuttedOn_H
                .where((element) =>
                    element.Hscissor != 15 && element.notFinals.isEmpty)
                .toList();

        List<BlockModel> actualview =
            myType.veiwCuttedAndimpatyNotfinals == false
                ? blocksConsumedaAndNotCuttedOn_H
                    .where((element) => element.Hscissor == 0)
                    .toList()
                : blockswithNO_Notfinals;
        H1VeiwModel vm = H1VeiwModel();

        return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: SizedBox(
              width: 480,
              child: ListView(
                children: [
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1.8),
                      1: FlexColumnWidth(1.8),
                      2: FlexColumnWidth(2.5),
                      3: FlexColumnWidth(2.5),
                    },
                    children: actualview.reversed
                        .take(context
                            .read<BlockFirebasecontroller>()
                            .amountofViewForMinVeiwIn_H)
                        .toList()
                        .reversed
                        .map((user) {
                          x++;
                          return TableRow(
                              decoration: BoxDecoration(
                                color: x % 2 == 0
                                    ? Colors.teal[50]
                                    : Colors.amber[50],
                              ),
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(
                                            "${actualview.indexOf(user) + 1}"))),
                                GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        Text(user.number.toString(),
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 234, 42, 109))),
                                        Text(
                                          user.serial,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: SizedBox(
                                    child: Column(
                                      children: [
                                        Text(
                                            "${user.item.color} ${user.item.type} ك${user.item.density.removeTrailingZeros}"),
                                        Text("${user.item.L.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.H.removeTrailingZeros}")
                                            .permition(
                                                context,
                                                UserPermition
                                                    .Hide_sizeofblock_formmainviewin_H),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    dialog_chipsAndResults(
                                        context, user, Hscissor);
                                  },
                                  child: SizedBox(
                                    child: vm
                                            .getFractinsOFABlock(context, user)
                                            .isEmpty
                                        ? const Center(
                                            child: Text("اضافة نواتج"),
                                          )
                                        : Column(
                                            children: vm
                                                .getFractinsOFABlock(
                                                    context, user)
                                                .map(
                                                  (e) => Text(
                                                      "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}"),
                                                )
                                                .toList(),
                                          ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    dialogOfAddNotFinalToBlock(context, user);
                                  },
                                  child: SizedBox(
                                    child: user.notFinals.isEmpty
                                        ? const Center(
                                            child: Text("اضافة هوالك"),
                                          )
                                        : Column(
                                            children: user.notFinals
                                                .map(
                                                  (e) => Text(
                                                      "${e.type} ${e.wight.removeTrailingZeros}"),
                                                )
                                                .toList(),
                                          ),
                                  ),
                                ),
                              ].reversed.toList());
                        })
                        .toList()
                        .reversed
                        .toList(),
                    border: TableBorder.all(width: 1, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

//مقاسات الفرد و النواتج
dialog_chipsAndResults(
    BuildContext context, final BlockModel blockToCutted, final int Hscissor) {
  H1VeiwModel vm = H1VeiwModel();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ChipsForH123(),
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    vm.cut_block(context, blockToCutted, Hscissor);
                  },
                  child: const Text('قص')),
            ],
          ),
          content: SizedBox(
            height: 340,
            child: Column(children: [
              Row(
                children: [
                  Results(vm: vm),
                ].reversed.toList(),
              )
            ]),
          ),
        );
      });
}
