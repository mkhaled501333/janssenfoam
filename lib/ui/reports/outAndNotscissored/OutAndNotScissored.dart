// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';

import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/ui/blocks/OUt/outOfStock_viewModel.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:provider/provider.dart';

//بلوكات منصرفه ومل تصنع
class OutAnsNorScissored extends StatelessWidget {
  const OutAnsNorScissored({super.key});

  @override
  Widget build(BuildContext context) {
    OutOfStockViewModel vm = OutOfStockViewModel();

    return Scaffold(
      appBar: AppBar(
        title: const Text("بلوكات منصرفه ولم تصنع"),
      ),
      body: Column(
        children: [errmsg(context), const HeaderOftable9(), TheTable9(vm: vm)],
      ),
    );
  }
}

class HeaderOftable9 extends StatelessWidget {
  const HeaderOftable9({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        1: FlexColumnWidth(1.4),
        2: FlexColumnWidth(.6),
        3: FlexColumnWidth(.7),
        4: FlexColumnWidth(.5),
        6: FlexColumnWidth(2.3),
        7: FlexColumnWidth(.9),
        8: FlexColumnWidth(.7),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.amber[50],
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("حذف")),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('كود')),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text('نوع',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text('كثافه',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Text('مقص',
                      style: TextStyle(
                          fontSize: 10, fontWeight: FontWeight.bold))),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('لون')),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('مقاس'))),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('رقم')),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('م')),
            ])
      ],
    );
  }
}

class TheTable9 extends StatelessWidget {
  const TheTable9({
    super.key,
    required this.vm,
  });
  final OutOfStockViewModel vm;
  @override
  Widget build(BuildContext context) {
    int x = 0;
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            child: Table(
              columnWidths: const {
                1: FlexColumnWidth(1.4),
                2: FlexColumnWidth(.6),
                3: FlexColumnWidth(.7),
                4: FlexColumnWidth(.5),
                6: FlexColumnWidth(2.3),
                7: FlexColumnWidth(.9),
                8: FlexColumnWidth(.7),
              },
              children: blocks.blocks.values
                  .toList()
                  .filter_date_consumed(context)
                  .map((user) {
                x++;
                return TableRow(
                    decoration: BoxDecoration(
                      color: blocks.blocks.values
                                      .toList()
                                      .filter_date_consumed(context)
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
                                vm.unconsumeBlock(context, user);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))),
                      Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            user.serial.toString(),
                            style: const TextStyle(fontSize: 14),
                          )),
                      Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(user.item.type.toString(),
                              style: const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600))),
                      Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            user.item.density.toString(),
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w400),
                          )),
                      Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(user.hashCode.toString())),
                      Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(user.item.color.toString())),
                      Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                              "${user.item.H.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.L.removeTrailingZeros}")),
                      Container(
                          padding: const EdgeInsets.all(2),
                          child: Text(
                            user.number.toString(),
                            style: const TextStyle(
                                color: Color.fromARGB(255, 221, 2, 75)),
                          )),
                      Container(
                          padding: const EdgeInsets.all(2), child: Text("$x")),
                    ]);
              }).toList(),
              border: TableBorder.all(width: 1, color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
