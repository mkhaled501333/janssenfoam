// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/industerial_security/industerialSecurityController.dart';
import 'package:janssenfoam/ui/industerial_security/report2.dart';
import 'package:provider/provider.dart';

class industerialSecurityreportwidgetStatistics extends StatelessWidget {
  const industerialSecurityreportwidgetStatistics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<IndusterialSecuritycontroller>(
      builder: (context, myType, child) {
        List<IndusterialSecurityModel> all = myType.all.values
            .where((test) =>
                test.date.formatt_yMd() == DateTime.now().formatt_yMd())
            .toList();
        // .filterFinalProductDateBetween(
        //     myType.pickedDateFrom!, myType.pickedDateTO!);
        final point1 = all.where((test) => test.place == "1");
        final point2 = all.where((test) => test.place == "2");
        final point3 = all.where((test) => test.place == "3");
        final point4 = all.where((test) => test.place == "4");
        final point5 = all.where((test) => test.place == "05");
        final point6 = all.where((test) => test.place == "06");
        final point7 = all.where((test) => test.place == "07");
        final point8 = all.where((test) => test.place == "08");
        final point9 = all.where((test) => test.place == "09");
        final point10 = all.where((test) => test.place == "10");
        final point11 = all.where((test) => test.place == "11");
        final point12 = all.where((test) => test.place == "12");
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Card(
                      color: Colors.amber[50],
                      child: SingleChildScrollView(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            pont(
                              p: point1,
                              tillte: "1",
                            ),
                            pont(
                              p: point2,
                              tillte: "2",
                            ),
                            pont(
                              p: point3,
                              tillte: "3",
                            ),
                            pont(
                              p: point4,
                              tillte: "4",
                            ),
                            pont(
                              p: point5,
                              tillte: "5",
                            ),
                            pont(
                              p: point6,
                              tillte: "6",
                            ),
                            pont(
                              p: point7,
                              tillte: "7",
                            ),
                            pont(
                              p: point8,
                              tillte: "8",
                            ),
                            pont(
                              p: point9,
                              tillte: "9",
                            ),
                            pont(
                              p: point10,
                              tillte: "10",
                            ),
                            pont(
                              p: point11,
                              tillte: "11",
                            ),
                            pont(
                              p: point12,
                              tillte: "12",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            context.gonext(
                                context, const IndusterialSecutityReport2());
                          },
                          icon: const Icon(
                            color: Color.fromARGB(255, 2, 6, 230),
                            Icons.open_in_browser_rounded,
                            size: 22,
                          )),
                    ],
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class pont extends StatelessWidget {
  const pont({
    super.key,
    required this.p,
    required this.tillte,
  });
  final Iterable<IndusterialSecurityModel> p;
  final String tillte;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 3),
      child: Column(
        children: [
          Container(
            width: 37,
            decoration: BoxDecoration(
                border: Border.all(width: 1),
                color: const Color.fromARGB(66, 151, 73, 158)),
            child: Center(
                child: Text(
              tillte,
              style: const TextStyle(fontSize: 18),
            )),
          ),
          Container(
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: Column(
              children: [
                ...p.map((e) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          e.date.formatt_hm(),
                          style: TextStyle(
                              fontSize: 15,
                              color: p.toList().indexOf(e) != 0 &&
                                      (e.date.formatt_num().to_int() -
                                              p
                                                  .elementAt(
                                                      p.toList().indexOf(e) - 1)
                                                  .date
                                                  .formatt_num()
                                                  .to_int() >
                                          100)
                                  ? Colors.red
                                  : Colors.black),
                        )
                      ],
                    )),
                Container(
                    width: 37,
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: Center(
                        child: Text(
                      p.length.toString(),
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
