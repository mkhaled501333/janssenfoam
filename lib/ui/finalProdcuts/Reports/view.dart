// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/finalProdcuts/finalProdcutExtentions.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:provider/provider.dart';

class FinalprodcutsReportsView extends StatelessWidget {
  const FinalprodcutsReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BoxOFReportForfinalProdcutsReport(),
        Consumer<final_prodcut_controller>(
          builder: (context, myType, child) {
            return Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    errmsg(context),
                    if (myType.selectedreport == 'تقرير المنصرف فقط')
                      const FinalprodcutReport1(),
                    if (myType.selectedreport == 'تقرير الوارد فقط')
                      const FinalprodcutReport2(),
                    if (myType.selectedreport == 'الكميه المتوفره فقط')
                      const FinalprodcutReport3(),
                    if (myType.selectedreport == 'تقرير حركة المخزون')
                      const FinalprodcutReport4()
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

//المنصرف
class FinalprodcutReport1 extends StatelessWidget {
  const FinalprodcutReport1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalprodcuts, child) {
        List<FinalProductModel> f = finalprodcuts.OUtBalanceBetween(
            finalprodcuts.pickedDateFrom!, finalprodcuts.pickedDateTo!);
        List<FinalProductModel> finalproductsBetweenTowDates = f
            .filterItemsPasedOncolors(context, finalprodcuts.selctedcolors)
            .filterItemsPasedOnDensites(context, finalprodcuts.selctedDensities)
            .filterItemsPasedOntypes(context, finalprodcuts.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, finalprodcuts.selctedcustomers)
            .filterItemsPasedOnsizes(context, finalprodcuts.selctedsizes);
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
                            Text("اجمالى المصروف  "),
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
                              finalproductsBetweenTowDates
                                  .countOf(e)
                                  .toString(),
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

//الوارد
class FinalprodcutReport2 extends StatelessWidget {
  const FinalprodcutReport2({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalprodcuts, child) {
        List<FinalProductModel> f = finalprodcuts.INBalanceBetween(
            finalprodcuts.pickedDateFrom!, finalprodcuts.pickedDateTo!);
        List<FinalProductModel> finalproductsBetweenTowDates = f
            .filterItemsPasedOncolors(context, finalprodcuts.selctedcolors)
            .filterItemsPasedOnDensites(context, finalprodcuts.selctedDensities)
            .filterItemsPasedOntypes(context, finalprodcuts.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, finalprodcuts.selctedcustomers)
            .filterItemsPasedOnsizes(context, finalprodcuts.selctedsizes);
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
                            Text("اجمالى الوارد  "),
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
                              finalproductsBetweenTowDates
                                  .countOf(e)
                                  .toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 11, 134, 0)),
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

//الكمية المتوفره
class FinalprodcutReport3 extends StatelessWidget {
  const FinalprodcutReport3({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalprodcuts, child) {
        List<FinalProductModel> f =
            finalprodcuts.BalanceToDate(finalprodcuts.pickedDateTo!);
        List<FinalProductModel> finalproductsBetweenTowDates = f
            .filterItemsPasedOncolors(context, finalprodcuts.selctedcolors)
            .filterItemsPasedOnDensites(context, finalprodcuts.selctedDensities)
            .filterItemsPasedOntypes(context, finalprodcuts.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, finalprodcuts.selctedcustomers)
            .filterItemsPasedOnsizes(context, finalprodcuts.selctedsizes);
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
                            Text("الكميه المتوفره فقط "),
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
                              e.item.amount.toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 11, 134, 0)),
                            ),
                          ),
                        ]))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}

//حركة المخزون
class FinalprodcutReport4 extends StatelessWidget {
  const FinalprodcutReport4({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalprodcuts, child) {
        List<FinalProductModel> aa = finalprodcuts.OUtBalanceBetween(
            finalprodcuts.pickedDateFrom!, finalprodcuts.pickedDateTo!);
        List<FinalProductModel> OUT = aa
            .filterItemsPasedOncolors(context, finalprodcuts.selctedcolors)
            .filterItemsPasedOnDensites(context, finalprodcuts.selctedDensities)
            .filterItemsPasedOntypes(context, finalprodcuts.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, finalprodcuts.selctedcustomers)
            .filterItemsPasedOnsizes(context, finalprodcuts.selctedsizes);
        List<FinalProductModel> bb = finalprodcuts.INBalanceBetween(
            finalprodcuts.pickedDateFrom!, finalprodcuts.pickedDateTo!);
        List<FinalProductModel> IN = bb
            .filterItemsPasedOncolors(context, finalprodcuts.selctedcolors)
            .filterItemsPasedOnDensites(context, finalprodcuts.selctedDensities)
            .filterItemsPasedOntypes(context, finalprodcuts.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, finalprodcuts.selctedcustomers)
            .filterItemsPasedOnsizes(context, finalprodcuts.selctedsizes);
        List<FinalProductModel> cc = finalprodcuts.FirstPeriodBalanceToDate(
            finalprodcuts.pickedDateFrom!);
        List<FinalProductModel> First = cc
            .filterItemsPasedOncolors(context, finalprodcuts.selctedcolors)
            .filterItemsPasedOnDensites(context, finalprodcuts.selctedDensities)
            .filterItemsPasedOntypes(context, finalprodcuts.selctedtybes)
            .filterItemsPasedOnCustomers(
                context, finalprodcuts.selctedcustomers)
            .filterItemsPasedOnsizes(context, finalprodcuts.selctedsizes);
        var all = IN + OUT + First;
        return SizedBox(
          width: 500,
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
                            Text("hh"),
                          ],
                        ),
                      ]),
                ],
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(3),
                },
                border: TableBorder.all(),
                children: [
                  TableRow(
                      children: [
                    const Center(
                      child: Text("الصنف"),
                    ),
                    const Center(
                      child: Text("رصيد اول المده"),
                    ),
                    const Center(
                      child: Text("الوارد"),
                    ),
                    const Center(
                      child: Text("المنصرف"),
                    ),
                    const Center(
                      child: Text("الكميه المتوفره"),
                    ),
                  ].reversed.toList()),
                ],
              ),
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                  2: FlexColumnWidth(1),
                  3: FlexColumnWidth(1),
                  4: FlexColumnWidth(3),
                },
                border: TableBorder.all(),
                children: all.filteronfinalproduct().map((e) {
                  var first = First.countOf(e);
                  var out = OUT.countOf(e);
                  var come = IN.countOf(e);
                  return TableRow(
                      children: [
                    //الصنف
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
                    //رصيد اول المده
                    Center(
                      child: Text(
                        '$first',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 11, 134, 0)),
                      ),
                    ),
                    //الوارد
                    Center(
                      child: Text(
                        "$come",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 11, 134, 0)),
                      ),
                    ),
                    //المنصرف
                    Center(
                      child: Text(
                        "$out",
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    //الكميه المتوفره
                    Center(
                      child: Text(
                        "${first + come + out}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 11, 134, 0)),
                      ),
                    ),
                  ].reversed.toList());
                }).toList(),
              ),

              //تفاصيل الحراكات

              // Table(
              //   border: TableBorder.all(),
              //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              //   children: const [
              //     TableRow(
              //         decoration: BoxDecoration(color: Colors.grey),
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text("تفاصيل الحركات"),
              //             ],
              //           ),
              //         ]),
              //   ],
              // ),
              // Table(
              //   columnWidths: const {
              //     0: FlexColumnWidth(3),
              //     1: FlexColumnWidth(1),
              //   },
              //   border: TableBorder.all(),
              //   children: const [
              //     TableRow(children: [
              //       Center(
              //         child: Text("من"),
              //       ),
              //       Center(
              //         child: Text("عدد"),
              //       )
              //     ]),
              //   ],
              // ),
              // Table(
              //   columnWidths: const {
              //     0: FlexColumnWidth(3),
              //     1: FlexColumnWidth(1),
              //   },
              //   border: TableBorder.all(),
              //   children: all
              //       .sortedBy<num>((element) => element.finalProdcut_ID)
              //       .map((e) => TableRow(children: [
              //             Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text(
              //                     textDirection: TextDirection.rtl,
              //                     "      ${e.item.color} ${e.item.type} ك ${e.item.density.removeTrailingZeros}"),
              //                 Text(
              //                     textDirection: TextDirection.rtl,
              //                     "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}"),
              //               ],
              //             ),
              //             Center(
              //               child: Text(
              //                 e.item.amount.toString(),
              //                 style: TextStyle(
              //                     color: e.item.amount > 0
              //                         ? const Color.fromARGB(255, 11, 134, 0)
              //                         : Colors.red),
              //               ),
              //             ),
              //           ]))
              //       .toList(),
              // ),
            ],
          ),
        );
      },
    );
  }
}

class BoxOFReportForfinalProdcutsReport extends StatelessWidget {
  BoxOFReportForfinalProdcutsReport({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<final_prodcut_controller>().pickedDateFrom = DateTime.now();
    context.read<final_prodcut_controller>().pickedDateTo = DateTime.now();
    final List<String> items = [
      'الكميه المتوفره فقط',
      'تقرير حركة المخزون',
      'تقرير الوارد فقط',
      'تقرير المنصرف فقط',
    ];
    //value of report type

    return Container(
      // height: MediaQuery.of(context).size.height * .33,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 204, 241, 252),
              Color.fromARGB(255, 202, 243, 239),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(width: 2, color: Colors.teal),
          borderRadius: BorderRadius.circular(5)),
      child: Consumer<final_prodcut_controller>(
        builder: (context, myType, child) {
          List<FinalProductModel> f = [];

          if (myType.selectedreport == 'الكميه المتوفره فقط') {
            f = myType.finalproducts.values.toList().filteronfinalproduct()
                // .data_until_date(myType.pickedDateTo!)
                // .filterItemsPasedOncolors(context, myType.selctedcolors)
                // .filterItemsPasedOnDensites(context, myType.selctedDensities)
                // .filterItemsPasedOntypes(context, myType.selctedtybes)
                // .filterItemsPasedOnCustomers(context, myType.selctedcustomers)
                // .filterItemsPasedOnsizes(context, myType.selctedsizes);
                ;
          }
          if (myType.selectedreport == 'تقرير الوارد فقط') {
            f = myType.finalproducts.values
                .toList()
                .filteronfinalproduct()
                .filterFinalProduct_IN_DateBetween(
                    myType.pickedDateFrom!, myType.pickedDateTo!)
                .filterItemsPasedOncolors(context, myType.selctedcolors)
                .filterItemsPasedOnDensites(context, myType.selctedDensities)
                .filterItemsPasedOntypes(context, myType.selctedtybes)
                .filterItemsPasedOnCustomers(context, myType.selctedcustomers)
                .filterItemsPasedOnsizes(context, myType.selctedsizes);
          }
          if (myType.selectedreport == 'تقرير المنصرف فقط') {
            f = myType.finalproducts.values
                .toList()
                .filteronfinalproduct()
                .filterFinalProduct_out_DateBetween(
                    myType.pickedDateFrom!, myType.pickedDateTo!)
                .filterItemsPasedOncolors(context, myType.selctedcolors)
                .filterItemsPasedOnDensites(context, myType.selctedDensities)
                .filterItemsPasedOntypes(context, myType.selctedtybes)
                .filterItemsPasedOnCustomers(context, myType.selctedcustomers)
                .filterItemsPasedOnsizes(context, myType.selctedsizes);
          }

          if (myType.selectedreport == 'تقرير حركة المخزون') {
            //رصيد اول المده كيمته ليست بصفر
            var a = myType.finalproducts.values
                .toList()
                // .data_until_date(myType.pickedDateFrom!)
                .Remove_total_zero();
            //الوارد
            var b = myType.finalproducts.values
                .toList()
                .filterFinalProduct_IN_DateBetween(
                    myType.pickedDateFrom!, myType.pickedDateTo!);
            //المنصرف
            var c = myType.finalproducts.values
                .toList()
                .filterFinalProduct_out_DateBetween(
                    myType.pickedDateFrom!, myType.pickedDateTo!);
            var all2 = b + c + a;

            f = all2
                .filteronfinalproduct()
                .filterItemsPasedOncolors(context, myType.selctedcolors)
                .filterItemsPasedOnDensites(context, myType.selctedDensities)
                .filterItemsPasedOntypes(context, myType.selctedtybes)
                .filterItemsPasedOnCustomers(context, myType.selctedcustomers)
                .filterItemsPasedOnsizes(context, myType.selctedsizes);
          }

          return Row(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //نوع التقرير
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      hint: const Center(
                        child: Text(
                          'نوع التقرير',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurpleAccent,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      items: items
                          .map((String item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                          .toList(),
                      value: myType.selectedreport,
                      onChanged: (String? value) {
                        myType.selectedreport = value;
                        myType.Refresh_Ui();
                      },
                      buttonStyleData: ButtonStyleData(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        height: 50,
                        width: MediaQuery.of(context).size.width * .8,
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        height: 40,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      DropdownButton2<String>(
                          isExpanded: true,
                          hint: Center(
                            child: Text(
                              'كل الالوان',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: f
                              .map((e) => e.item.color)
                              .toSet()
                              .toList()
                              .map((item) {
                            return DropdownMenuItem(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected =
                                      myType.selctedcolors.contains(item);
                                  return InkWell(
                                    onTap: () {
                                      isSelected
                                          ? myType.selctedcolors.remove(item)
                                          : myType.selctedcolors.add(item);

                                      //This rebuilds the StatefulWidget to update the button's text
                                      myType.Refresh_Ui();
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          if (isSelected)
                                            const Icon(Icons.check_box_outlined)
                                          else
                                            const Icon(
                                                Icons.check_box_outline_blank),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: myType.selctedcolors.isEmpty
                              ? null
                              : myType.selctedcolors.last,
                          onChanged: (value) {},
                          selectedItemBuilder: (context) {
                            return f
                                .map((e) => e.item.color)
                                .toSet()
                                .toList()
                                .map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    myType.selctedcolors.join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              },
                            ).toList();
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                color:
                                    const Color.fromARGB(255, 204, 225, 241)),
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            height: 50,
                            width: MediaQuery.of(context).size.width * .3,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.zero,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for an item...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .contains(searchValue);
                            },
                          )),
                      DropdownButton2<String>(
                          isExpanded: true,
                          hint: Center(
                            child: Text(
                              'كل الانواع',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: f
                              .map((e) => e.item.type)
                              .toSet()
                              .toList()
                              .map((item) {
                            return DropdownMenuItem(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected =
                                      myType.selctedtybes.contains(item);
                                  return InkWell(
                                    onTap: () {
                                      isSelected
                                          ? myType.selctedtybes.remove(item)
                                          : myType.selctedtybes.add(item);

                                      //This rebuilds the StatefulWidget to update the button's text
                                      myType.Refresh_Ui();
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          if (isSelected)
                                            const Icon(Icons.check_box_outlined)
                                          else
                                            const Icon(
                                                Icons.check_box_outline_blank),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: myType.selctedtybes.isEmpty
                              ? null
                              : myType.selctedtybes.last,
                          onChanged: (value) {},
                          selectedItemBuilder: (context) {
                            return f.toSet().toList().map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    myType.selctedtybes.join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              },
                            ).toList();
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                color:
                                    const Color.fromARGB(255, 204, 225, 241)),
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            height: 50,
                            width: MediaQuery.of(context).size.width * .3,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.zero,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for an item...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .contains(searchValue);
                            },
                          )),
                      //كل الكثافات
                      DropdownButton2<String>(
                          isExpanded: true,
                          hint: Center(
                            child: Text(
                              'كل الكثافات',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: f
                              .map((e) => e.item.density.toString())
                              .toSet()
                              .toList()
                              .sortedBy((element) => element)
                              .map((item) {
                            return DropdownMenuItem(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected =
                                      myType.selctedDensities.contains(item);
                                  return InkWell(
                                    onTap: () {
                                      isSelected
                                          ? myType.selctedDensities.remove(item)
                                          : myType.selctedDensities.add(item);

                                      //This rebuilds the StatefulWidget to update the button's text
                                      myType.Refresh_Ui();
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          if (isSelected)
                                            const Icon(Icons.check_box_outlined)
                                          else
                                            const Icon(
                                                Icons.check_box_outline_blank),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: myType.selctedDensities.isEmpty
                              ? null
                              : myType.selctedDensities.last,
                          onChanged: (value) {},
                          selectedItemBuilder: (context) {
                            return f
                                .map((e) => e.item.density)
                                .toSet()
                                .toList()
                                .map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    myType.selctedDensities.join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              },
                            ).toList();
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                color:
                                    const Color.fromARGB(255, 204, 225, 241)),
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            height: 50,
                            width: MediaQuery.of(context).size.width * .33,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.zero,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for an item...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .contains(searchValue);
                            },
                          )),
                    ],
                  ),

                  Row(
                    children: [
                      DropdownButton2<String>(
                          isExpanded: true,
                          hint: Center(
                            child: Text(
                              'كل العملاء',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: f
                              .map((e) => e.customer.customername(context))
                              .toSet()
                              .toList()
                              .map((item) {
                            return DropdownMenuItem(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected =
                                      myType.selctedcustomers.contains(item);
                                  return InkWell(
                                    onTap: () {
                                      isSelected
                                          ? myType.selctedcustomers.remove(item)
                                          : myType.selctedcustomers.add(item);

                                      //This rebuilds the StatefulWidget to update the button's text
                                      myType.Refresh_Ui();
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          if (isSelected)
                                            const Icon(Icons.check_box_outlined)
                                          else
                                            const Icon(
                                                Icons.check_box_outline_blank),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: myType.selctedcustomers.isEmpty
                              ? null
                              : myType.selctedcustomers.last,
                          onChanged: (value) {},
                          selectedItemBuilder: (context) {
                            return f.toSet().toList().map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    myType.selctedcustomers.join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              },
                            ).toList();
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                color:
                                    const Color.fromARGB(255, 204, 225, 241)),
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            height: 50,
                            width: MediaQuery.of(context).size.width * .5,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.zero,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for an item...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .contains(searchValue);
                            },
                          )),
                      DropdownButton2<String>(
                          isExpanded: true,
                          hint: Center(
                            child: Text(
                              'كل المقاسات',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: f
                              .map((e) =>
                                  "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}")
                              .toSet()
                              .toList()
                              .sortedBy((element) => element)
                              .map((item) {
                            return DropdownMenuItem(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected =
                                      myType.selctedsizes.contains(item);
                                  return InkWell(
                                    onTap: () {
                                      isSelected
                                          ? myType.selctedsizes.remove(item)
                                          : myType.selctedsizes.add(item);

                                      //This rebuilds the StatefulWidget to update the button's text
                                      myType.Refresh_Ui();
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          if (isSelected)
                                            const Icon(Icons.check_box_outlined)
                                          else
                                            const Icon(
                                                Icons.check_box_outline_blank),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }).toList(),
                          //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                          value: myType.selctedsizes.isEmpty
                              ? null
                              : myType.selctedsizes.last,
                          onChanged: (value) {},
                          selectedItemBuilder: (context) {
                            return f
                                .map((e) =>
                                    "${e.item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.H.removeTrailingZeros}")
                                .toSet()
                                .toList()
                                .map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    myType.selctedsizes.join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    maxLines: 1,
                                  ),
                                );
                              },
                            ).toList();
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                color:
                                    const Color.fromARGB(255, 204, 225, 241)),
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            height: 50,
                            width: MediaQuery.of(context).size.width * .4,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                            padding: EdgeInsets.zero,
                          ),
                          dropdownSearchData: DropdownSearchData(
                            searchController: textEditingController,
                            searchInnerWidgetHeight: 50,
                            searchInnerWidget: Container(
                              height: 50,
                              padding: const EdgeInsets.only(
                                top: 8,
                                bottom: 4,
                                right: 8,
                                left: 8,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                expands: true,
                                maxLines: null,
                                controller: textEditingController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 8,
                                  ),
                                  hintText: 'Search for an item...',
                                  hintStyle: const TextStyle(fontSize: 12),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ),
                            searchMatchFn: (item, searchValue) {
                              return item.value
                                  .toString()
                                  .replaceAll(RegExp('[^0-9]'), '')
                                  .contains(searchValue);
                            },
                          )),
                    ],
                  ),
                  //التاريخ
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const DatepickerTo4(),
                      if (myType.selectedreport != 'الكميه المتوفره فقط')
                        const DatepickerFrom4(),
                    ],
                  ),

                  const Gap(9)
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class DatepickerFrom4 extends StatelessWidget {
  const DatepickerFrom4({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<final_prodcut_controller>().pickedDateFrom = DateTime.now();
    return Consumer<final_prodcut_controller>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.pickedDateFrom,
                      firstDate: myType.AllDatesOfOfData().min,
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    myType.pickedDateFrom = pickedDate;
                    myType.Refresh_Ui();
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
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.pickedDateFrom!.formatt(),
                        style: const TextStyle(
                            fontSize: 15,
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

class DatepickerTo4 extends StatelessWidget {
  const DatepickerTo4({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<final_prodcut_controller>().pickedDateFrom = DateTime.now();

    context.read<final_prodcut_controller>().pickedDateTo = DateTime.now();
    return Consumer<final_prodcut_controller>(
      builder: (context, myType, child) {
        if (myType.pickedDateFrom!.microsecondsSinceEpoch >
            myType.pickedDateTo!.microsecondsSinceEpoch) {
          myType.pickedDateTo = myType.pickedDateFrom;
        }
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.pickedDateTo!,
                      firstDate: myType.selectedreport == "الكميه المتوفره فقط"
                          ? myType.AllDatesOfOfData().min
                          : myType.pickedDateFrom!,
                      lastDate: myType.AllDatesOfOfData().max);

                  if (pickedDate != null) {
                    myType.pickedDateTo = pickedDate;
                    myType.Refresh_Ui();
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
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.pickedDateTo!.formatt(),
                        style: const TextStyle(
                            fontSize: 15,
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
