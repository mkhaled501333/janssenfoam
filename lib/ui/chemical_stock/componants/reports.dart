// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
// ignore_for_file: camel_case_types, must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/controllers/setting_controller.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/ui/chemical_stock/ChemicalsController.dart';
import 'package:janssenfoam/ui/chemical_stock/ChemicalStock_viewModel.dart';

class R_FOR_onlyAvilableQuantity extends StatelessWidget {
  R_FOR_onlyAvilableQuantity({
    super.key,
  });
  ChemicalStockViewModel vm = ChemicalStockViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        int x = 0;
        return Expanded(
            child: SizedBox(
          width: 600,
          child: ListView(
            children: [
              Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(2),
                  2: FlexColumnWidth(1.7),
                  3: FlexColumnWidth(.7),
                },
                border: TableBorder.all(width: 1, color: Colors.black),
                children: [
                  TableRow(
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                      ),
                      children: const [
                        Center(child: Text("م")),
                        Center(child: Text("العائله")),
                        Center(child: Text("الصنف")),
                        Center(child: Text("الكميه")),
                      ].reversed.toList()),
                  ...vm
                      .getDataForReport(
                          context,
                          myType.selctedNames,
                          myType.selctedFamilys,
                          myType.chiemicals.FilterDateBetween_balance(
                              context.read<SettingController>().to2))
                      .map((e) {
                    x++;
                    return TableRow(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 236, 235, 235),
                        ),
                        children: [
                          Center(child: Text("$x")),
                          Center(child: Text(e.family.toString())),
                          Center(child: Text(e.name.toString())),
                          Center(
                              child: Text(e.totalQuantity.toStringAsFixed(1))),
                        ].reversed.toList());
                  })
                ],
              ),
            ],
          ),
        ));
      },
    );
  }
}

class R_FOR_stock_actions extends StatelessWidget {
  const R_FOR_stock_actions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
                width: 600,
                child: ListView(
                  children: [
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(.7),
                        1: FlexColumnWidth(.6),
                        2: FlexColumnWidth(.4),
                        3: FlexColumnWidth(1),
                        4: FlexColumnWidth(1),
                        5: FlexColumnWidth(.8),
                      },
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            children: const [
                              Center(
                                child: Text("العائله"),
                              ),
                              Center(
                                child: Text("الصنف"),
                              ),
                              Center(
                                child: Text("رصيد اول المده"),
                              ),
                              Center(
                                child: Text("الوارد"),
                              ),
                              Center(
                                child: Text("المنصرف"),
                              ),
                              Center(
                                child: Text("الكميه المتوفره"),
                              ),
                            ].reversed.toList()),
                        ...myType.chiemicals
                            .FilterChemicals()
                            .filterItemsPasedONFamilys(
                                context, myType.selctedFamilys)
                            .filterItemsPasedONnames(
                                context, myType.selctedNames)
                            .map((e) {
                          //اول المده
                          var a = myType.chiemicals.Data_Before_Starta_of_name(
                              myType.pickedDateFrom!, e.name);
                          var firstPeriod = a.isEmpty
                              ? 0
                              : a
                                  .map((e) => e.Totalquantity)
                                  .reduce((a, b) => a + b);

                          var b = myType.chiemicals
                              .Data_Between_TowDates_of_name(
                                  myType.pickedDateFrom!,
                                  myType.pickedDateTo!,
                                  e.name);
                          //الوارد
                          var c = b.where((element) =>
                              element.actions.if_action_exist(ChemicalAction
                                  .creat_new_ChemicalAction_item.getTitle) ==
                              true);
                          var iN = c.isEmpty
                              ? 0
                              : c
                                  .map((e) => e.Totalquantity)
                                  .reduce((a, b) => a + b);
                          //المنصرف
                          var d = b.where((element) =>
                              element.actions.if_action_exist(ChemicalAction
                                  .creat_Out_ChemicalAction_item.getTitle) ==
                              true);
                          var out = d.isEmpty
                              ? 0
                              : d
                                  .map((e) => e.Totalquantity)
                                  .reduce((a, b) => a + b);

                          return TableRow(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 236, 235, 235),
                              ),
                              children: [
                                Center(
                                  child: Text(e.family),
                                ),
                                Center(
                                  child: Text(e.name),
                                ),
                                Center(
                                  child: Text("$firstPeriod"),
                                ),
                                Center(
                                  child: Text("$iN"),
                                ),
                                Center(
                                  child: Text("$out"),
                                ),
                                Center(
                                  child: Text("${firstPeriod + iN + out}"),
                                ),
                              ].reversed.toList());
                        })
                      ],
                      border: TableBorder.all(width: 1, color: Colors.black),
                    ),
                    Center(
                        child: Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(), color: Colors.grey),
                            child: Text("تفاصيل الحركات"))),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(.7),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(.6),
                        3: FlexColumnWidth(.5),
                        4: FlexColumnWidth(1),
                        5: FlexColumnWidth(.8),
                      },
                      children: [
                        TableRow(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            children: const [
                              Center(
                                child: Text("العائله"),
                              ),
                              Center(
                                child: Text("الصنف"),
                              ),
                              Center(
                                child: Text("نوع الحركه"),
                              ),
                              Center(
                                child: Text("الكميه"),
                              ),
                              Center(
                                child: Text("بيان الحركه"),
                              ),
                              Center(
                                child: Text("من/الى"),
                              ),
                            ].reversed.toList()),
                        ...myType.chiemicals
                            .filterItemsPasedONFamilys(
                                context, myType.selctedFamilys)
                            .filterItemsPasedONnames(
                                context, myType.selctedNames)
                            .Data_Between_TowDates(
                                myType.pickedDateFrom!, myType.pickedDateTo!)
                            .sortedBy<num>((element) => element
                                .actions.first.when.microsecondsSinceEpoch)
                            .reversed
                            .map((e) {
                          return TableRow(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 236, 235, 235),
                              ),
                              children: [
                                Center(
                                  child: Text(e.family),
                                ),
                                Center(
                                  child: Text(e.name),
                                ),
                                Center(
                                  child: Text(
                                      e.Totalquantity < 0 ? "صرف" : "توريد"),
                                ),
                                Center(
                                  child: Text(
                                    "${e.Totalquantity}",
                                    style: TextStyle(
                                        color: e.Totalquantity < 0
                                            ? Color.fromARGB(255, 226, 15, 0)
                                            : Color.fromARGB(255, 23, 199, 0)),
                                  ),
                                ),
                                Center(
                                  child: Column(
                                    children: [
                                      if (e.Totalquantity > 0)
                                        Text(e.actions.get_Who_Of(ChemicalAction
                                            .creat_new_ChemicalAction_item
                                            .getTitle)),
                                      if (e.Totalquantity > 0)
                                        Text(e.actions
                                            .get_Date_of_action(ChemicalAction
                                                .creat_new_ChemicalAction_item
                                                .getTitle)
                                            .formatt2()),
                                      if (e.Totalquantity < 0)
                                        Text(e.actions.get_Who_Of(ChemicalAction
                                            .creat_Out_ChemicalAction_item
                                            .getTitle)),
                                      if (e.Totalquantity < 0)
                                        Text(e.actions
                                            .get_Date_of_action(ChemicalAction
                                                .creat_Out_ChemicalAction_item
                                                .getTitle)
                                            .formatt2()),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Text(e.cumingFrom + e.outTo),
                                ),
                              ].reversed.toList());
                        })
                      ],
                      border: TableBorder.all(width: 1, color: Colors.black),
                    ),
                  ],
                )),
          ),
        );
      },
    );
  }
}
