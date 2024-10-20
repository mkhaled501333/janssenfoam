// ignore_for_file: camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/ui/stockCheck/stockCheckController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/ui/stockCheck/reportBox.dart';
import 'package:provider/provider.dart';

class Report1_stockCheck extends StatelessWidget {
  Report1_stockCheck({super.key});
  TextStyle style = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle style2 = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 7, 11, 255));
  @override
  Widget build(BuildContext context) {
    return Consumer<StokCheck_Controller>(
      builder: (context, myType, child) {
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              errmsg(context),
              BoxOFReportForStockChek(),
              if (myType.selectedreport == 'تقرير عمليات الجرد')
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Table(
                          border:
                              TableBorder.all(width: 1, color: Colors.black),
                          columnWidths: const {
                            0: FlexColumnWidth(.3),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                          },
                          children: myType.stockChecks.values
                              .toList()
                              .beweenTowDates(
                                  myType.pickedDateFrom!.formatToInt(),
                                  myType.pickedDateTo!.formatToInt())
                              .reversed
                              .toList()
                              .map((e) {
                            return TableRow(
                                children: [
                              //البيان
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        "${e.item.H.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}",
                                        style: style2,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "${e.item.color} ${e.item.type} ك${e.item.density.removeTrailingZeros}",
                                        style: style,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //التاريخ و النتيحه
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Text(e.actions.get_Who_Of(
                                              StockCheckAction
                                                  .creat_new_StockCheck
                                                  .getTitle)),
                                          Text(e.actions
                                              .get_Date_of_action(
                                                  StockCheckAction
                                                      .creat_new_StockCheck
                                                      .getTitle)
                                              .formatt2()),
                                          Text(
                                              "الرصيد الدفترى: ${e.item.quantity}"),
                                          Text("الرصيد الفعلى: ${e.realamont}"),
                                          if (e.item.quantity - e.realamont > 0)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(' : فرق '),
                                                Text(
                                                  '${(e.item.quantity - e.realamont) * -1}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ].reversed.toList(),
                                            )
                                          else if (e.item.quantity -
                                                  e.realamont <
                                              0)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(' : زياده '),
                                                Text(
                                                  '${e.item.quantity - e.realamont * -1}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 1, 94, 1)),
                                                ),
                                              ].reversed.toList(),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              e.actions.if_action_exist(StockCheckAction
                                          .refrechDone.getTitle) ==
                                      true
                                  ? const Text("محدث")
                                  : DeleteButtonOFStochCheck(
                                      e: e,
                                    ),
                            ].reversed.toList());
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              if (myType.selectedreport == 'تقرير عمليات تحديث الكميات')
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Table(
                          border:
                              TableBorder.all(width: 1, color: Colors.black),
                          columnWidths: const {
                            0: FlexColumnWidth(1),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(.8),
                          },
                          children: myType.stockChecks.values
                              .toList()
                              .beweenTowDates(
                                  myType.pickedDateFrom!.formatToInt(),
                                  myType.pickedDateTo!.formatToInt())
                              .reversed
                              .toList()
                              .map((e) {
                            return TableRow(
                                children: [
                              //البيان
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .35,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        "${e.item.H.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}",
                                        style: style2,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        "${e.item.color} ${e.item.type} ك${e.item.density.removeTrailingZeros}",
                                        style: style,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //التاريخ و النتيحه
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .4,
                                child: Center(
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Text(e.actions.get_Who_Of(
                                              StockCheckAction
                                                  .creat_new_StockCheck
                                                  .getTitle)),
                                          Text(e.actions
                                              .get_Date_of_action(
                                                  StockCheckAction
                                                      .creat_new_StockCheck
                                                      .getTitle)
                                              .formatt2()),
                                          Text(
                                              "الرصيد الدفترى: ${e.item.quantity}"),
                                          Text("الرصيد الفعلى: ${e.realamont}"),
                                          if (e.item.quantity - e.realamont < 0)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(' : فرق '),
                                                Text(
                                                  '${(e.item.quantity - e.realamont)}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ].reversed.toList(),
                                            )
                                          else if (e.item.quantity -
                                                  e.realamont >
                                              0)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(' : زياده '),
                                                Text(
                                                  '+${(e.item.quantity - e.realamont)}',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          255, 1, 94, 1)),
                                                ),
                                              ].reversed.toList(),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              e.actions.if_action_exist(StockCheckAction
                                          .refrechDone.getTitle) ==
                                      true
                                  ? Column(
                                      children: [
                                        const Text("تم تحديث الكميه"),
                                        Text(e.actions.get_Who_Of(
                                            StockCheckAction
                                                .refrechDone.getTitle)),
                                        Text(e.actions
                                            .get_Date_of_action(StockCheckAction
                                                .refrechDone.getTitle)
                                            .formatt2()),
                                      ],
                                    )
                                  : ButtomOfRefreshQuantity(e: e),
                            ].reversed.toList());
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}

class DeleteButtonOFStochCheck extends StatelessWidget {
  const DeleteButtonOFStochCheck({
    super.key,
    required this.e,
  });
  final StockCheckModel e;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        scrollable: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        content: SizedBox(
                          height: 50,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () {
                                            context
                                                .read<StokCheck_Controller>()
                                                .deleteStockCheck(e);

                                            Navigator.pop(context);
                                          },
                                          child: const Text('حذف')),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.blue)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('الغاء')),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            )));
  }
}

class ButtomOfRefreshQuantity extends StatelessWidget {
  const ButtomOfRefreshQuantity({
    super.key,
    required this.e,
  });
  final StockCheckModel e;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(4),
        child: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text("هل انت متاكد من تحديث الكميه"),
                        scrollable: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        content: SizedBox(
                          height: 100,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                //buttons
                                Row(
                                  children: [
                                    Expanded(
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.red)),
                                          onPressed: () {
                                            context
                                                .read<StokCheck_Controller>()
                                                .MakeRefreshOfData(e);
                                            context
                                                .read<
                                                    final_prodcut_controller>()
                                                .updateFinalProdcut(FinalProductModel(
                                                    updatedat: DateTime.now()
                                                        .microsecondsSinceEpoch,
                                                    finalProdcut_ID: DateTime.now()
                                                        .millisecondsSinceEpoch,
                                                    block_ID: 0,
                                                    fraction_ID: 0,
                                                    subfraction_ID: 0,
                                                    sapa_ID: "",
                                                    sapa_desc: "",
                                                    item: FinalProdcutItme(
                                                        L: e.item.L,
                                                        W: e.item.W,
                                                        H: e.item.H,
                                                        density: e.item.density,
                                                        volume: (e.realamont -
                                                                e.item
                                                                    .quantity) *
                                                            e.item.L *
                                                            e.item.W *
                                                            e.item.H /
                                                            1000000,
                                                        theowight: e.item.density *
                                                            (e.realamont -
                                                                e.item
                                                                    .quantity) *
                                                            e.item.L *
                                                            e.item.W *
                                                            e.item.H /
                                                            1000000,
                                                        realowight: 0.0,
                                                        color: e.item.color,
                                                        type: e.item.type,
                                                        amount:
                                                            e.realamont - e.item.quantity,
                                                        priceforamount: 0.0),
                                                    scissor: 0,
                                                    stage: 0,
                                                    worker: "",
                                                    customer: "",
                                                    notes: "",
                                                    invoiceNum: 0,
                                                    cuting_order_number: 0,
                                                    actions: [
                                                      finalProdcutAction
                                                          .recive_Done_Form_FinalProdcutStock
                                                          .add,
                                                      finalProdcutAction
                                                          .incert_From_StockChekRefresh
                                                          .add
                                                    ]));
                                            Navigator.pop(context);
                                          },
                                          child: const Text('تحديث')),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStateProperty.all(
                                                      Colors.blue)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('الغاء')),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
            },
            child: const Icon(
              Icons.replay_circle_filled_outlined,
              color: Colors.green,
            )));
  }
}
