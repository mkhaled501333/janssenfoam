// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/ui/not_final/non_final_controller.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/ui/not_final/not_final_viewModer.dart';
import 'package:provider/provider.dart';

class NotFinal extends StatelessWidget {
  const NotFinal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "مخزن دون التام",
        ),
        actions: [
          IconButton(
              onPressed: () {
                context.gonext(context, NonFinalHistory());
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          errmsg(context),
          Item001(
            type: "ارضيات",
          ),
          Item001(
            type: "جوانب ",
          ),
          Item001(
            type: " درجة ثانيه",
          ),
          Item001(
            type: " درجه ثانيه ممتازه",
          ),
          Item001(
            type: " هالك",
          ),
          Item001(
            type: " بواقى الدرجه الاولى",
          ),
        ],
      ),
    );
  }
}

class NonFinalHistory extends StatelessWidget {
  NonFinalHistory({super.key});
  NotFinalViewModer vm = NotFinalViewModer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('سجل الاضافه لليوم فى دون التام'),
      ),
      body: Column(children: [errmsg(context), TheTable0012(vm: vm)]),
    );
  }
}

class Item001 extends StatelessWidget {
  Item001({
    super.key,
    required this.type,
  });
  final String type;
  NotFinalViewModer vm = NotFinalViewModer();
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        return Container(
          margin: const EdgeInsets.only(top: 13, left: 15, right: 15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.teal,
                Colors.teal.shade200,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              Text(
                type,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const Form(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // IconButton(
                      //     onPressed: () {
                      //       showAlertDialog(context, vm, 1, type);
                      //     },
                      //     icon: const Icon(
                      //       Icons.remove_circle_outline,
                      //       color: Colors.red,
                      //     )),
                      // IconButton(
                      //     onPressed: () {
                      //       showAlertDialog(context, vm, 0, type);
                      //     },
                      //     icon: const Icon(Icons.add)),
                      Text("" "kg",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff3e5fb8)))
                    ]),
              )
            ],
          ),
        );
      },
    );
  }
}

class TheTable0012 extends StatelessWidget {
  const TheTable0012({
    super.key,
    required this.vm,
  });

  final NotFinalViewModer vm;
  @override
  Widget build(BuildContext context) {
    return Consumer<NonFinalController>(
      builder: (context, notfinals, child) {
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: [
                  const HeaderOftable001(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                      2: FlexColumnWidth(1),
                    },
                    children: notfinals.not_finals
                        .filter_date(context)
                        .map((user) {
                          return TableRow(
                              decoration: BoxDecoration(
                                color:
                                    notfinals.not_finals.indexOf(user) % 2 == 0
                                        ? Colors.blue[50]
                                        : Colors.amber[50],
                              ),
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          vm.delete(context, user.notFinal_ID);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(user.type.toString())),
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      user.wight.toString(),
                                      style: const TextStyle(color: Colors.red),
                                    )),
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

class HeaderOftable001 extends StatelessWidget {
  const HeaderOftable001({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
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
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('النوع'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Text('الكميه')),
            ])
      ],
    );
  }
}
