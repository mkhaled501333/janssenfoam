// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/ui/finalProdcuts/finalProdcutExtentions.dart';
import 'package:janssenfoam/controllers/bFractionsController.dart';
import 'package:janssenfoam/controllers/bSubfractions.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/controllers/setting_controller.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:janssenfoam/ui/reports/%D8%A7%D9%84%D9%85%D8%B5%D8%B1%D9%88%D9%81%20%D9%85%D9%82%D8%A7%D8%A8%D9%84%20%D8%A7%D9%84%D8%A7%D9%86%D8%AA%D8%A7%D8%AC/Report10_viewMdel.dart';

class Report10View extends StatelessWidget {
  Report10View({super.key});
  Rscissor_viewmodel vm = Rscissor_viewmodel();

  @override
  Widget build(BuildContext context) {
    return Consumer5<
        SettingController,
        BlockFirebasecontroller,
        final_prodcut_controller,
        Fractions_Controller,
        SubFractions_Controller>(
      builder: (context, settingController, blockscontroller, finalprodcuts,
          fractionsController, subfractionscontroller, fd) {
        //---------------------------------------------------------------------------
        //رصيد اول المده تحت التشغيل سواء بلوكات او فراكشن او فرد
        List<Itme> allunderoberationofFirstPeriod =
            allUnderOperationOfFirstPeriod(settingController, context);
        //---------------------------------------------------------------------------
        //المصروف خلال فتره
        List<BlockModel> blocksconsumedBetweenTowDates = blockscontroller
            .blocks.values
            .toList()
            .filterConsumeDateBetween(DateTimeRange(
                start: settingController.from, end: settingController.to));
        //---------------------------------------------------------------------------
        //المتبقى من تحت التشغيل سواء بلوكات او فراكشن او فرد
        List<Itme> totalRemian = allUnderOperationBetweenperiod(
            settingController, context, blocksconsumedBetweenTowDates);
        //---------------------------------------------------------------------------
        //الانتاح خلال فتره
        List<FinalProductModel> finalproductsBetweenTowDates = finalprodcuts
            .finalproducts.values
            .toList()
            .filterFinalProductDateBetween(
                finalprodcuts.from, finalprodcuts.to);
        //---------------------------------------------------------------------------
        return Scaffold(
          appBar: AppBar(
            title: const Text("مقارنة الانتاج بالمصروف"),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                errmsg(context),
                const Text("تقرير الانتاج مقابل المصروف "),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DatepickerTo(),
                    DatePickerFrom(),
                  ],
                ),
//جدول الاجماليات
                TableOfTotals(
                    allunderoberationofFirstPeriod,
                    blocksconsumedBetweenTowDates,
                    finalproductsBetweenTowDates,
                    totalRemian),
                TotalINDetails(
                    allunderoberationofFirstPeriod,
                    blocksconsumedBetweenTowDates,
                    finalproductsBetweenTowDates,
                    totalRemian),
//اول المده تفصيلى من تحت التشغيل
                TableOfFiretPeriodUnderOperationInDetals(
                    allunderoberationofFirstPeriod),
//تفصيلى الانتاج
                DetailsOfFinlProdcuts(finalproductsBetweenTowDates),
                TotalRemain(totalRemian)
              ],
            ),
          ),
        );
      },
    );
  }

//رصيد اول المده تحت التشغيل سواء بلوكات او فراكشن او فرد
  List<Itme> allUnderOperationOfFirstPeriod(
      SettingController myType, BuildContext context) {
    List<BlockModel> blocksUnderOperation = context
        .read<BlockFirebasecontroller>()
        .blocks
        .values
        .toList()
        .consumedAndNotCuttedBeforeStartDate(myType.from);
    //---------------------------------------------------------------------------
    List<FractionModel>
        fractionsUnderOperation = //رصيد اول المده من تحت التشغيل
        context
            .read<Fractions_Controller>()
            .fractions
            .toList()
            .ReturnFirstPiriodBalanceOFUnderoperationFractons(myType.from);
    //---------------------------------------------------------------------------

    List<SubFraction>
        subfractionsUnderoperation = //رصيد اول المده من تحت التشغيل
        context
            .read<SubFractions_Controller>()
            .subfractions
            .ReturnFirstPiriodBalanceOFUnderoperationSubFractons(myType.from);
    //---------------------------------------------------------------------------

    List<Itme> allunderoberationofFirstPeriod =
        fractionsUnderOperation.map((element) => element.item).toList() +
            blocksUnderOperation.map((element) => element.item).toList() +
            subfractionsUnderoperation.map((element) => element.item).toList();
    return allunderoberationofFirstPeriod;
  }

  //المتبقى من تحت التشغيل سواء بلوكات او فراكشن او فرد
  List<Itme> allUnderOperationBetweenperiod(SettingController myType,
      BuildContext context, List<BlockModel> blocksconsumedBetweenTowDates) {
    List<BlockModel> blocksUnderOperationinperiod =
        blocksconsumedBetweenTowDates
            .where((element) => element.Hscissor == 0)
            .toList();
    //---------------------------------------------------------------------------
    List<FractionModel> fractionsUnderOperation = context
        .read<Fractions_Controller>()
        .fractions
        .where((element) => element.underOperation == true)
        .where((element) =>
            element.actions
                .if_action_exist(FractionActon.creat_fraction.getTitle) &&
            element.actions
                    .get_Date_of_action(FractionActon.creat_fraction.getTitle)
                    .formatToInt() <=
                myType.to.formatToInt())
        .toList();
    //---------------------------------------------------------------------------

    List<SubFraction> subfractionsUnderoperation = context
        .read<SubFractions_Controller>()
        .subfractions
        .where((element) => element.underOperation == true)
        .where((element) =>
            element.actions.if_action_exist(
                subfractionAction.create_new_subfraction.getTitle) &&
            element.actions
                    .get_Date_of_action(
                        subfractionAction.create_new_subfraction.getTitle)
                    .formatToInt() <=
                myType.to.formatToInt())
        .toList();
    //---------------------------------------------------------------------------

    List<Itme> allunderoberationofFirstPeriod = fractionsUnderOperation
            .map((element) => element.item)
            .toList() +
        blocksUnderOperationinperiod.map((element) => element.item).toList() +
        subfractionsUnderoperation.map((element) => element.item).toList();
    return allunderoberationofFirstPeriod;
  }
}

class DetailsOfFinlProdcuts extends StatelessWidget {
  const DetailsOfFinlProdcuts(this.finalproductsBetweenTowDates, {super.key});

  final List<FinalProductModel> finalproductsBetweenTowDates;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("اجمالى الانتاج تفصيلى "),
                      ],
                    ),
                  ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: const [
              TableRow(children: [
                Center(
                  child: Text("من"),
                ),
                Center(
                  child: Text("عدد"),
                )
              ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: finalproductsBetweenTowDates
                .filteronfinalproduct()
                .sortedBy<num>((element) => element.item.density)
                .map((e) => TableRow(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              textDirection: TextDirection.rtl,
                              "      ${e.item.color} ${e.item.type} ك ${e.item.density.removeTrailingZeros}"),
                          Text(
                              textDirection: TextDirection.rtl,
                              "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}"),
                        ],
                      ),
                      Center(
                        child: Text(
                            finalproductsBetweenTowDates.countOf(e).toString()),
                      ),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class TableOfFiretPeriodUnderOperationInDetals extends StatelessWidget {
  const TableOfFiretPeriodUnderOperationInDetals(
      this.allunderoberationofFirstPeriod,
      {super.key});

  final List<Itme> allunderoberationofFirstPeriod;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" رصيد اول المده (تحت التشغيل) تفصيلى"),
                      ],
                    ),
                  ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: const [
              TableRow(children: [
                Center(
                  child: Text("من"),
                ),
                Center(
                  child: Text("عدد"),
                )
              ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: allunderoberationofFirstPeriod
                .filterRepeats()
                .sortedBy<num>((element) => element.density)
                .map((e) => TableRow(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              textDirection: TextDirection.rtl,
                              "      ${e.color} ${e.type} ك ${e.density.removeTrailingZeros}"),
                          Text(
                              textDirection: TextDirection.rtl,
                              "${e.L.removeTrailingZeros}*${e.W.removeTrailingZeros}*${e.H.removeTrailingZeros}"),
                        ],
                      ),
                      Center(
                        child: Text(allunderoberationofFirstPeriod
                            .countOf(e)
                            .toString()),
                      ),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class TotalRemain extends StatelessWidget {
  const TotalRemain(this.totalRemain, {super.key});

  final List<Itme> totalRemain;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" المتبقى (تحت التشغيل)"),
                      ],
                    ),
                  ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: const [
              TableRow(children: [
                Center(
                  child: Text("من"),
                ),
                Center(
                  child: Text("عدد"),
                )
              ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
            },
            border: TableBorder.all(),
            children: totalRemain
                .filterRepeats()
                .sortedBy<num>((element) => element.density)
                .map((e) => TableRow(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                              textDirection: TextDirection.rtl,
                              "      ${e.color} ${e.type} ك ${e.density.removeTrailingZeros}"),
                          Text(
                              textDirection: TextDirection.rtl,
                              "${e.L.removeTrailingZeros}*${e.W.removeTrailingZeros}*${e.H.removeTrailingZeros}"),
                        ],
                      ),
                      Center(
                        child: Text(totalRemain.countOf(e).toString()),
                      ),
                    ]))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class TableOfTotals extends StatelessWidget {
  const TableOfTotals(
      this.allunderoberationofFirstPeriod,
      this.blocksconsumedBetweenTowDates,
      this.finalproductsBetweenTowDates,
      this.totalRemain,
      {super.key});

  final List<Itme> allunderoberationofFirstPeriod;
  final List<BlockModel> blocksconsumedBetweenTowDates;
  final List<FinalProductModel> finalproductsBetweenTowDates;
  final List<Itme> totalRemain;

  final TextStyle textStyle =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w700);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        children: [
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("تقرير اجمالى  حجم"),
                      ],
                    ),
                  ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1),
              1: FlexColumnWidth(2),
            },
            border: TableBorder.all(),
            children: [
              TableRow(
                  children: [
                Center(
                  child: Text(
                    "رصيد اول المده (تحت التشغيل)",
                    style: textStyle,
                  ),
                ),
                Center(
                    child: Text(allunderoberationofFirstPeriod
                        .volume()
                        .removeTrailingZeros)),
              ].reversed.toList()),
              TableRow(
                  children: [
                Center(
                  child: Text(
                    "اجمالى المنصرف (بلوكات )",
                    style: textStyle,
                  ),
                ),
                Center(
                    child: Text(blocksconsumedBetweenTowDates
                        .map((e) => e.item)
                        .toList()
                        .volume()
                        .removeTrailingZeros)),
              ].reversed.toList()),
              TableRow(
                  children: [
                Center(
                  child: Text(
                    "اجمالى الانتاج (منتج تام)",
                    style: textStyle,
                  ),
                ),
                Center(
                    child: Text(
                        "${finalproductsBetweenTowDates.isEmpty ? 0 : finalproductsBetweenTowDates.map((e) => e.item.amount * e.item.L * e.item.W * e.item.H / 1000000).reduce((a, b) => a + b).toStringAsFixed(1)}")),
              ].reversed.toList()),
              TableRow(
                  children: [
                Center(
                    child: Text(
                  "اجمالى المتبقى (تحت التشغيل)",
                  style: textStyle,
                )),
                Center(child: Text(totalRemain.volume().removeTrailingZeros)),
              ].reversed.toList()),
            ],
          ),
        ],
      ),
    );
  }
}

class TotalINDetails extends StatelessWidget {
  const TotalINDetails(
      this.allunderoberationofFirstPeriod,
      this.blocksconsumedBetweenTowDates,
      this.finalproductsBetweenTowDates,
      this.totalRemain,
      {super.key});
  final List<Itme> allunderoberationofFirstPeriod;
  final List<BlockModel> blocksconsumedBetweenTowDates;
  final List<FinalProductModel> finalproductsBetweenTowDates;
  final List<Itme> totalRemain;
  final TextStyle textStyle =
      const TextStyle(fontSize: 14, fontWeight: FontWeight.w700);
  @override
  Widget build(BuildContext context) {
    List<Itme> ss = totalRemain +
        allunderoberationofFirstPeriod +
        finalproductsBetweenTowDates
            .map((e) => Itme(
                L: 0.0,
                W: 0.0,
                H: 0.0,
                density: e.item.density,
                volume: 0.0,
                wight: 0.0,
                color: e.item.color,
                type: e.item.type,
                price: 0.0))
            .toList();

    return SizedBox(
      child: Column(
        children: [
          Table(
            border: TableBorder.all(),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const [
              TableRow(
                  decoration: BoxDecoration(color: Colors.grey),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("تقرير تفصيل  حجم"),
                      ],
                    ),
                  ]),
            ],
          ),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(1.4),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1.4),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(2.3),
            },
            border: TableBorder.all(),
            children: [
              TableRow(
                  children: [
                const Center(child: Text("البيان")),
                const Center(child: Text("المصروف")),
                const Center(
                    child: Column(
                  children: [
                    Text("تحت التشغيل"),
                    Text("اول المده"),
                  ],
                )),
                const Center(child: Text("الانتاج")),
                const Center(
                    child: Column(
                  children: [
                    Text("تحت التشغيل"),
                    Text("المتبقى"),
                  ],
                )),
              ].reversed.toList()),
              ...ss.filter_T_D_C().map((e) => TableRow(
                      children: [
                    Center(
                        child: Text(
                            textDirection: TextDirection.rtl,
                            "${e.color} ${e.type} ك ${e.density.removeTrailingZeros}")),
                    Center(
                        child: Text(blocksconsumedBetweenTowDates
                            .map((e) => e.item)
                            .toList()
                            .volumeOf(e)
                            .toString())),
                    Center(
                        child:
                            Text(allunderoberationofFirstPeriod.volumeOf(e))),
                    Center(
                        child: Text(finalproductsBetweenTowDates
                            .map((e) => e.item)
                            .toList()
                            .volumeOf(e))),
                    Center(child: Text(totalRemain.volumeOf(e))),
                  ].reversed.toList())),
            ],
          ),
        ],
      ),
    );
  }
}

class DatepickerTo extends StatelessWidget {
  const DatepickerTo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: context.read<SettingController>().from,
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    context.read<SettingController>().to = pickedDate;
                    context.read<SettingController>().Refresh_Ui();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "الى",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.to.formatt(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}

class DatePickerFrom extends StatelessWidget {
  const DatePickerFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingController>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    context.read<SettingController>().from = pickedDate;
                    context.read<SettingController>().Refresh_Ui();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "من",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.from.formatt(),
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
