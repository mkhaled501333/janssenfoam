// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/services/pdfprevei.dart';
import 'package:janssenfoam/ui/industerial_security/r2PDF.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/industerial_security/industerialSecurityController.dart';

import '../../app/functions.dart';
import '../../models/moderls.dart';

class IndusterialSecutityReport2 extends StatelessWidget {
  const IndusterialSecutityReport2({
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
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    permission().then((value) async {
                      pdfinduserialSecurityr2
                          .generate(
                            point1,
                            point2,
                            point3,
                            point4,
                            point5,
                            point6,
                            point7,
                            point8,
                            point9,
                            point10,
                            point11,
                            point12,
                          )
                          .then((value) => context.gonext(
                              context,
                              PDfpreview(
                                v: value.save(),
                              )));
                    });
                  },
                  icon: const Icon(Icons.picture_as_pdf)),
            ],
          ),
          body: SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                pont(
                  p: point1,
                  tillte: "محطه مياه",
                ),
                pont(
                  p: point2,
                  tillte: "غرفة محول",
                ),
                pont(
                  p: point3,
                  tillte: "غرفة طلمبات",
                ),
                pont(
                  p: point4,
                  tillte: "كيماويات",
                ),
                pont(
                  p: point5,
                  tillte: "تانكات",
                ),
                pont(
                  p: point6,
                  tillte: "معمل",
                ),
                pont(
                  p: point7,
                  tillte: "صبه",
                ),
                pont(
                  p: point8,
                  tillte: "منشر",
                ),
                pont(
                  p: point9,
                  tillte: "بلوكات",
                ),
                pont(
                  p: point10,
                  tillte: "مقصات",
                ),
                pont(
                  p: point11,
                  tillte: "ميزان",
                ),
                pont(
                  p: point12,
                  tillte: "ش خلفى",
                ),
              ],
            ),
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
            width: 125,
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...p.map((e) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.who),
                        const Gap(5),
                        Text(
                          e.date.formatt_hm(),
                          style: p.toList().indexOf(e) != 0 &&
                                  (e.date.formatt_num().to_int() -
                                          p
                                              .elementAt(
                                                  p.toList().indexOf(e) - 1)
                                              .date
                                              .formatt_num()
                                              .to_int() >
                                      100)
                              ? const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Colors.red)
                              : const TextStyle(
                                  fontSize: 15, color: Colors.black),
                        ),
                        const Gap(3),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 125,
                        decoration: const BoxDecoration(color: Colors.grey),
                        child: Center(
                            child: Text(
                          p.length.toString(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
