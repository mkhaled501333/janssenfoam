// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, use_super_parameters, must_be_immutable
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';

import 'package:provider/provider.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_imported/Widgets.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_imported/finalProductStock_viewmodel.dart';

class FinalProductView extends StatefulWidget {
  const FinalProductView({super.key});

  @override
  State<FinalProductView> createState() => _FinalProductViewState();
}

class _FinalProductViewState extends State<FinalProductView> {
  FinalProductStockViewModel vm = FinalProductStockViewModel();
  String chosenDate = format.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            // AddUnregular2().permition(context,
            //     UserPermition.incert_notFinal_in_importedfinal_prodcut),
            TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        setState(() {
                          String formattedDate = format.format(pickedDate);
                          chosenDate = formattedDate;
                        });
                      } else {}
                    },
                    child: Text(
                      chosenDate,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
                .permition(
                    context, UserPermition.show_date_in_finalProduct_imported),

            // AddUnregular().permition(context,
            //     UserPermition.incert_unregular_in_importedfinal_prodcut),
          ],
        ),
        body: Form(
          key: vm.formKey,
          child: Column(
            children: [
              errmsg(context),
              // FieldsINsertInFInalProdcut(vm: vm).permition(
              //     context, UserPermition.incert_in_finalProdcut_imorted),
              // Buttoms(vm: vm).permition(
              //     context, UserPermition.incert_in_finalProdcut_imorted),
              TheTable(vm: vm, chosenDate: chosenDate),
            ],
          ),
        ),
      ),
    );
  }
}

class TheTable extends StatelessWidget {
  TheTable({
    Key? key,
    required this.vm,
    required this.chosenDate,
  }) : super(key: key);
  final FinalProductStockViewModel vm;
  final String chosenDate;
  int x = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        int x = 0;

        return Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            reverse: true,
            child: SizedBox(
              width: 850,
              child: ListView(
                children: [
                  const HeaderOftable(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(.8),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(2),
                      5: FlexColumnWidth(.8),
                      6: FlexColumnWidth(.8),
                      7: FlexColumnWidth(.8),
                      8: FlexColumnWidth(2.2),
                      9: FlexColumnWidth(1),
                      10: FlexColumnWidth(.8),
                    },
                    children: finalproducts.finalproducts.values
                        .where((element) => element.actions.if_action_exist(
                            finalProdcutAction
                                .incert_finalProduct_from_cutingUnit
                                .getactionTitle))
                        .where((element) =>
                            DateFormat('yyyy/MM/dd').format(element.actions
                                .get_Date_of_action(finalProdcutAction
                                    .incert_finalProduct_from_cutingUnit
                                    .getactionTitle)) ==
                            chosenDate)
                        .sortedBy<num>(
                          (element) => element.finalProdcut_ID,
                        )
                        .map((user) {
                          x++;
                          return TableRow(
                              decoration: BoxDecoration(
                                color: x % 2 == 0
                                    ? Colors.teal[50]
                                    : Colors.amber[50],
                              ),
                              children: [
                                //المسح
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          if (user.actions.if_action_exist(
                                                  finalProdcutAction
                                                      .final_prodcut_DidQalityCheck
                                                      .getactionTitle) ==
                                              false) {
                                            showmyAlertDialog2333323242(
                                                context, user, "delete");
                                          }
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))).permition(
                                    context,
                                    UserPermition
                                        .delete_in_imported_finalprodcut),
                                //تم التخزين
                                GestureDetector(
                                  onTap: () {
                                    user.actions.if_action_exist(finalProdcutAction
                                                    .final_prodcut_DidQalityCheck
                                                    .getactionTitle) ==
                                                true &&
                                            permitionss(
                                                context,
                                                UserPermition
                                                    .can_aprove_from_recive_from_final_prodcut)
                                        ? showmyAlertDialog2333323242(
                                            context, user, "stock")
                                        : DoNothingAction();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          //icon true if stocked
                                          Icon(user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .recive_Done_Form_FinalProdcutStock
                                                          .getactionTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          // show date when stocked
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .recive_Done_Form_FinalProdcutStock
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(user.actions
                                                      .get_Date_of_action(
                                                          finalProdcutAction
                                                              .recive_Done_Form_FinalProdcutStock
                                                              .getactionTitle))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
                                          // show user who stocked
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .recive_Done_Form_FinalProdcutStock
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(user.actions
                                                  .get_finalProdcut_Who_Of(
                                                      finalProdcutAction
                                                          .recive_Done_Form_FinalProdcutStock))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                                //تم الجوده
                                GestureDetector(
                                  onTap: () {
                                    // user.actions.if_action_exist(finalProdcutAction
                                    //                 .incert_finalProduct_from_cutingUnit
                                    //                 .getactionTitle) ==
                                    //             true &&
                                    //         permitionss(context,UserPermition.can_aprove_from_quality) &&
                                    //         user.actions.if_action_exist(finalProdcutAction.final_prodcut_DidQalityCheck
                                    //                     .getactionTitle) ==
                                    //             false
                                    //     ?
                                    showmyAlertDialog2333323242(
                                        context, user, "q");
                                    // : DoNothingAction();
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .final_prodcut_DidQalityCheck
                                                          .getactionTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .final_prodcut_DidQalityCheck
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(user.actions
                                                      .get_Date_of_action(
                                                          finalProdcutAction
                                                              .final_prodcut_DidQalityCheck
                                                              .getactionTitle))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
                                          //اليوزر اذا تم الجوده
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .final_prodcut_DidQalityCheck
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(user.actions
                                                  .get_finalProdcut_Who_Of(
                                                      finalProdcutAction
                                                          .final_prodcut_DidQalityCheck))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                                //تم الاستلام
                                GestureDetector(
                                  onTap: () {
                                    //TOO:
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .incert_finalProduct_from_cutingUnit
                                                          .getactionTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .incert_finalProduct_from_cutingUnit
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(user.actions
                                                      .get_Date_of_action(
                                                          finalProdcutAction
                                                              .incert_finalProduct_from_cutingUnit
                                                              .getactionTitle))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
                                          //اليوزر اذا تم الاستلام
                                          user.actions.if_action_exist(
                                                      finalProdcutAction
                                                          .incert_finalProduct_from_cutingUnit
                                                          .getactionTitle) ==
                                                  true
                                              ? Text(user.actions
                                                  .get_finalProdcut_Who_Of(
                                                      finalProdcutAction
                                                          .incert_finalProduct_from_cutingUnit))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                                //ملاحظات
                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.notes.toString()))),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.stage.toString()))),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.scissor.toString()))),

                                Container(
                                    padding: const EdgeInsets.all(2),
                                    child: Center(
                                        child: Text(user.customer.toString()))),

                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "${user.item.H.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.L.removeTrailingZeros}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "${user.item.color} ${user.item.type} ك${user.item.density.removeTrailingZeros}",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),

                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Center(
                                      child: Text(
                                        user.item.amount.toString(),
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 221, 2, 75)),
                                      ).permition(
                                          context,
                                          UserPermition
                                              .show_total_in_finalproduct),
                                    )),

                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Center(child: Text("$x"))),
                              ]);
                        })
                        .toList()
                        .reversed
                        .toList(),
                    border: TableBorder.all(width: 1, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

showmyAlertDialog2333323242(
    BuildContext context, FinalProductModel item, String casefun) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('  ?'),
          content: const SizedBox(
            height: 200,
            child: Column(children: [
              Text('هل انت متاكد'),
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  if (casefun == "q") {
                    item.actions.add(
                        finalProdcutAction.final_prodcut_DidQalityCheck.add);
                    context
                        .read<final_prodcut_controller>()
                        .updateFinalProdcut(item);
                  }
                  if (casefun == "stock") {
                    item.actions.add(finalProdcutAction
                        .recive_Done_Form_FinalProdcutStock.add);
                    context
                        .read<final_prodcut_controller>()
                        .updateFinalProdcut(item);
                  }
                  if (casefun == "delete") {
                    item.actions
                        .add(finalProdcutAction.archive_final_prodcut.add);
                    context
                        .read<final_prodcut_controller>()
                        .updateFinalProdcut(item);
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'yes',
                )),
          ],
        );
      });
}
