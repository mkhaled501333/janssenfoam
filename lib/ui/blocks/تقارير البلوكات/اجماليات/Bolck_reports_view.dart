// ignore_for_file: must_be_immutable, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/ui/blocks/reportsForBlock/W.dart';
import 'package:provider/provider.dart';

class BlockReportsView extends StatelessWidget {
  const BlockReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        errmsg(context),
        const SizedBox(
          height: 15,
        ),
        //جدول الاجماليات
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              const HeaderOftable4(),
              TheTable2(),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 200,
            height: 60,
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(9))),
            child: const Center(
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "جرد مخزن البلوك",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_downward),
                        Icon(Icons.arrow_downward),
                        Icon(Icons.arrow_downward),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Consumer<BlockFirebasecontroller>(
          builder: (context, myType, child) {
            return DefaultTextStyle.merge(
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                      },
                      border: TableBorder.all(width: 1),
                      children: const [
                        TableRow(children: [Text("الصف"), Text("الكميه")])
                      ],
                    ),
                    Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                        },
                        border: TableBorder.all(width: 1),
                        children: myType.blocks.values
                            .toList()
                            .where((element) =>
                                element.actions.if_action_exist(
                                    BlockAction.consume_block.getactionTitle) ==
                                false)
                            .toList()
                            .filter_description()
                            .sortedBy<num>((element) => element.serial.to_int())
                            .sortedBy<String>((element) => element.discreption)
                            .map((e) => TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(e.discreption),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                        "${myType.blocks.values.toList().where((element) => element.actions.if_action_exist(BlockAction.consume_block.getactionTitle) == false).toList().where((element) => element.discreption == e.discreption).length}"),
                                  ),
                                ]))
                            .toList()),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                      },
                      border: TableBorder.all(width: 1),
                      children: [
                        TableRow(children: [
                          const Text("الاجمالى"),
                          Container(
                            color: Colors.grey[500],
                            child: Text(
                                "${myType.blocks.values.toList().where((element) => element.actions.if_action_exist(BlockAction.consume_block.getactionTitle) == false).toList().length}"),
                          )
                        ])
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        )

        //جرد مخزن البلوك
        // const blockstockInventory()
      ],
    );
  }
}
