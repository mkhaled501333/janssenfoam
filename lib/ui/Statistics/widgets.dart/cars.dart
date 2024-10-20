import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/controllers/biscol.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:provider/provider.dart';

import '../../reports/البسكول/reports.dart';

const backgrond = Color.fromARGB(255, 3, 21, 37);
const cartHeader = Color.fromARGB(255, 22, 44, 70);
const cartbody = Color.fromARGB(255, 33, 65, 99);
const textTittle = Color.fromARGB(255, 124, 172, 248);
const text = Color.fromARGB(255, 211, 227, 253);
const text1 = Color.fromARGB(255, 120, 138, 162);
const text2 = Color.fromARGB(255, 61, 77, 94);
const text3 = Color.fromARGB(255, 216, 90, 143);
const buttonbackground = Color.fromARGB(255, 8, 66, 160);
const notificationBackgroundbackground = Color.fromARGB(255, 23, 33, 34);
const notificationText = Color.fromARGB(255, 248, 170, 3);

class CartsStatistics extends StatelessWidget {
  const CartsStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 450,
          height: 410,
          decoration: const BoxDecoration(
              color: backgrond,
              borderRadius: BorderRadius.all(Radius.circular(11))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Consumer<Hivecontroller>(
              builder: (context, myType, child) {
                final daycars = myType.allrecords.values.where(
                  (element) =>
                      element.actions.if_action_exist(
                              WhigtTecketAction.archive_tecket.getTitle) ==
                          false &&
                      element.actions
                              .get_Date_of_action(
                                  WhigtTecketAction.create_newTicket.getTitle)
                              .formatt_yMd() ==
                          DateTime.now().formatt_yMd(),
                );
                final underword = daycars.where((element) =>
                    element.firstShot != 0.0 && element.secondShot == 0.0);
                final done = daycars.where((element) =>
                    element.firstShot != 0.0 && element.secondShot != 0.0);
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 215,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration:
                                    const BoxDecoration(color: cartHeader),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      "قيد التحميل : (${underword.length})",
                                      style: const TextStyle(
                                          color: text,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 325,
                                width: double.infinity,
                                decoration:
                                    const BoxDecoration(color: cartbody),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: underword
                                        .map((e) => Text(
                                              "${e.prodcutName}>${e.driverName} ${e.carNum} ${e.customerName}",
                                              style: const TextStyle(
                                                  color: text1,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 5,
                        ),
                        SizedBox(
                          width: 213,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                width: double.infinity,
                                decoration:
                                    const BoxDecoration(color: cartHeader),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Text(
                                      "تم التحميل : (${done.length})",
                                      style: const TextStyle(
                                          color: text,
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 325,
                                width: double.infinity,
                                decoration:
                                    const BoxDecoration(color: cartbody),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: done
                                        .map((e) => Text(
                                              "${e.prodcutName}>${e.driverName} ${e.carNum} ${e.customerName}",
                                              style: const TextStyle(
                                                  color: text1,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                        .toList(),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: notificationBackgroundbackground),
                      child: Center(
                        child: Text(
                          "Total : ${daycars.isEmpty ? 0 : daycars.map((e) => e.totalWeight).reduce(
                                (value, element) => value + element,
                              )}",
                          style: const TextStyle(
                              color: notificationText,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        IconButton(
            color: Colors.amber,
            onPressed: () {
              context.gonext(context, const biscolView());
            },
            icon: const Icon(Icons.open_in_browser_sharp))
      ],
    );
  }
}
