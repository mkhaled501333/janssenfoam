// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/finalProdcuts/finalProdcutExtentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/controllers/bSubfractions.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_imported/Widgets.dart';

import 'package:janssenfoam/ui/scissors/sA/Ascissor_Viewmodel.dart';
import 'package:janssenfoam/ui/scissors/sA/conponants.dart';
import 'package:provider/provider.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/scissors/sR/Rscissor_viewModel.dart';

import '../../../core/recources/enums.dart';

class RVeiw23 extends StatelessWidget {
  RVeiw23({
    super.key,
    required this.Ascissor,
  });
  final int Ascissor;
  Rscissor_veiwModel vm = Rscissor_veiwModel();
  AscissorViewModel vm2 = AscissorViewModel();

  @override
  Widget build(BuildContext context) {
    return Consumer2<final_prodcut_controller, SubFractions_Controller>(
      builder:
          (context, finalprodcutcontroller, subfractionecontroller, child) {
        //----------------------------------------------------------------------------------------
        List<SubFraction> subfractionsCuttedON_A =
            vm2.getSubfractions_cuttedOn_A(subfractionecontroller, 1);
        List<FinalProductModel> finalProdcuts_cuttedON_A =
            vm2.get_finalprodcuts_cuttedON_A(
                finalprodcutcontroller.finalproducts.values.toList());
        //----------------------------------------------------------------------------------------

        List<int> AllStages = List<int>.from([
          finalProdcuts_cuttedON_A.map((e) => e.stage).toList() +
              subfractionsCuttedON_A.map((e) => e.Astagenum).toList()
        ].expand((element) => element).toList())
            .toSet()
            .toList()
            .sortedBy<num>((element) => element)
            .reversed
            .toList();
        int lastStage = AllStages.isEmpty ? 0 : AllStages.first;
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  border: Border.all(),
                  color: const Color.fromARGB(255, 175, 132, 132)),
              child: const Text(
                "      المقص الاونوماتيك      ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1.5,
                child: ListView(
                  children: [
                    const HeaderOfThableOfA(),
                    // ازرار الدور
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 40,
                              color: Color.fromARGB(255, 64, 124, 255),
                            ))
                        // .permition(context,
                        //     UserPermition.Rshow_bottomOFfinalproduct),
                        ,
                        IconButton(
                            onPressed: () {
                              dialog_CuttSubfractions_ON_A(
                                  context,
                                  subfractionecontroller,
                                  Ascissor,
                                  lastStage + 1);
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 40,
                              color: Color.fromARGB(255, 39, 123, 3),
                            ))
                        // .permition(
                        //     context, UserPermition.Rshow_bottomOFFractions),
                      ],
                    ),

                    Column(
                      children: AllStages.map((stage) => Container(
                            decoration: BoxDecoration(
                                border: Border.all(),
                                color:
                                    const Color.fromARGB(255, 231, 223, 223)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //رقم الدور
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .01,
                                  child: Center(
                                      child: Text(
                                    textAlign: TextAlign.center,
                                    "$stage",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                //الوارد
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .55,
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                          vertical: BorderSide()),
                                      color:
                                          Color.fromARGB(255, 231, 223, 223)),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Column(
                                        children: subfractionsCuttedON_A
                                            .where((element) =>
                                                element.Astagenum == stage)
                                            .toList()
                                            .filtersubfractions()
                                            .map((f) {
                                          var getSubfractions_cuttedOn_A_OFAstage =
                                              vm2.getSubfractions_cuttedOn_A_OFAstage(
                                                  subfractionsCuttedON_A,
                                                  stage);
                                          return GestureDetector(
                                            onTap: () {
                                              deleteButtonOfIN(context,
                                                  getSubfractions_cuttedOn_A_OFAstage);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "${f.item.color} ${f.item.type} ك${f.item.density.removeTrailingZeros}"),
                                                Text(
                                                    "  ${f.item.L.removeTrailingZeros}*${f.item.W.removeTrailingZeros}*${f.item.H.removeTrailingZeros} من "),
                                                Text(
                                                    "${getSubfractions_cuttedOn_A_OFAstage.map((e) => e.item).toList().countOf(f.item)} "),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                      //button
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                dialog_CuttSubfractions_ON_A(
                                                    context,
                                                    subfractionecontroller,
                                                    Ascissor,
                                                    stage);
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 30,
                                                color: Colors.deepOrangeAccent,
                                              ))
                                        ],
                                      )
                                    ],
                                  )),
                                ),
                                //الصادر
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .55,
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                          vertical: BorderSide()),
                                      color:
                                          Color.fromARGB(255, 231, 223, 223)),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      //انتاج المقص من الممنتج التام
                                      Column(
                                        children: finalProdcuts_cuttedON_A
                                            .where((element) =>
                                                element.stage == stage)
                                            .toList()
                                            .filteronfinalproduct()
                                            .map((f) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "${f.item.color} ${f.item.type} ك${f.item.density.removeTrailingZeros}"),
                                                    Text(
                                                        "  ${f.item.L.removeTrailingZeros}*${f.item.W.removeTrailingZeros}*${f.item.H.removeTrailingZeros} من "),
                                                    Text(
                                                        "${finalProdcuts_cuttedON_A.countOf(f)} "),
                                                  ],
                                                ))
                                            .toList(),
                                      ),

                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Rscissor_veiwModel vm =
                                                    Rscissor_veiwModel();

                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        clipBehavior: Clip
                                                            .antiAliasWithSaveLayer,
                                                        title: const Text(
                                                            'اضافة منتج تام'),
                                                        content: SizedBox(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 200,
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Form(
                                                              key: vm.formKey,
                                                              child: Column(
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      children: [
                                                                        CustomTextFormField(
                                                                          keybordtupe:
                                                                              TextInputType.name,
                                                                          width:
                                                                              MediaQuery.of(context).size.width * .40,
                                                                          hint:
                                                                              "ملاحظات ",
                                                                          controller:
                                                                              vm.notes,
                                                                        ),
                                                                        Column(
                                                                          children: [
                                                                            CustomTextFormField(
                                                                              width: MediaQuery.of(context).size.width * .23,
                                                                              hint: "عدد",
                                                                              controller: vm.amountcontroller,
                                                                              validator: Validation.validateothers,
                                                                            ),
                                                                            const Text(
                                                                              "من",
                                                                              style: TextStyle(fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SearchForSize(),
                                                                  ]),
                                                            ),
                                                          ),
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                              style: ElevatedButton
                                                                  .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .green),
                                                              onPressed: () {
                                                                if (vm.formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  vm.incert_finalProduct_from_cutingUnit(
                                                                      context,
                                                                      stage,
                                                                      7);
                                                                  Navigator.pop(
                                                                      context);
                                                                }
                                                              },
                                                              child: const Text(
                                                                  'ok')),
                                                        ],
                                                      );
                                                    });
                                              },
                                              icon: const Icon(
                                                Icons.add,
                                                size: 30,
                                                color: Colors.deepOrangeAccent,
                                              ))
                                        ],
                                      )
                                    ],
                                  )),
                                ),
                                // دون التام
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * .32,
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Column(
                                        children: subfractionsCuttedON_A
                                            .where((element) =>
                                                element.Astagenum == stage)
                                            .expand((s) => s.notfinals)
                                            .toList()
                                            .filter_notfinals___()
                                            .map((f) => GestureDetector(
                                                  onTap: () {
                                                    dialog_Remove_NotFinalTo_subfractions(
                                                        context,
                                                        subfractionsCuttedON_A
                                                            .where((element) =>
                                                                element
                                                                    .Astagenum ==
                                                                stage)
                                                            .toList());
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            .29,
                                                        child: Text(
                                                          "${f.type} kg ${subfractionsCuttedON_A.where((element) => element.Astagenum == stage).expand((s) => s.notfinals).where((element) => element.type == f.type).map((e) => e.wight).reduce((n, m) => n + m).toStringAsFixed(2)}",
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                            .toList(),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                                  onPressed: () {
                                                    dialog_Add_NotFinalTo_subfractions(
                                                        context,
                                                        subfractionsCuttedON_A
                                                            .where((element) =>
                                                                element
                                                                    .Astagenum ==
                                                                stage)
                                                            .toList());
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 30,
                                                    color:
                                                        Colors.deepOrangeAccent,
                                                  ))
                                              .permition(
                                                  context,
                                                  UserPermition
                                                      .Rshow_bottomOFNotfinl)
                                        ],
                                      )
                                    ],
                                  )),
                                ),
                              ].reversed.toList(),
                            ),
                          )).toList(),
                    ),
                  ],
                ),
              ),
            )),
          ],
        );
      },
    );
  }
}

class DropDdowen0023 extends StatelessWidget {
  const DropDdowen0023({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, v, child) {
        return DropdownButton(
            value: context.read<ObjectBoxController>().initial2,
            items: v.notfials
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context.read<ObjectBoxController>().initial2 = v;
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}

class HeaderOfThableOfA extends StatelessWidget {
  const HeaderOfThableOfA({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .12,
          height: 40,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text(
            "الدور",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .50,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text(" الوارد ",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .50,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text(" الصادر ",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width * .32,
          decoration: BoxDecoration(
              border: Border.all(),
              color: const Color.fromARGB(255, 170, 164, 164)),
          child: const Center(
              child: Text("دون التام",
                  style: TextStyle(fontWeight: FontWeight.bold))),
        ),
      ].reversed.toList(),
    );
  }
}

deleteButtonOfIN(BuildContext context, List<SubFraction> f) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: SizedBox(
              height: 120,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text("هل تريد حذف"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "${f.first.item.color} ${f.first.item.type} ك${f.first.item.density.removeTrailingZeros}"),
                        Text(
                            "  ${f.first.item.L.removeTrailingZeros}*${f.first.item.W.removeTrailingZeros}*${f.first.item.H.removeTrailingZeros} من "),
                        Text(
                            "${f.map((e) => e.item).toList().countOf(f.first.item)} "),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.red)),
                              onPressed: () {
                                if (f.first.notfinals.isEmpty) {
                                  for (var element in f) {
                                    context
                                        .read<SubFractions_Controller>()
                                        .UncutOnA_SUBfraction(element);
                                  }
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          duration: Duration(seconds: 7),
                                          content: Text(
                                              'لا يمكن حذف بسبب اضافة دون تام')));
                                }
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
                                      WidgetStateProperty.all(Colors.blue)),
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
}

dialog_Add_NotFinalTo_subfractions(BuildContext context,
    List<SubFraction> subfractions //الفرد المقصوصه على هذا المقص فى هئا الدور
    ) {
  AscissorViewModel vm = AscissorViewModel();
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اضافة هوالك الى هذا الدور'),
          content: SizedBox(
            height: 200,
            child: Column(children: [
              const DropDdowen0023(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 2, vertical: 18),
                child: CustomTextFormField(
                    hint: " وزن دون التام",
                    width: 120,
                    validator: Validation.validateothers,
                    controller: vm.wightcontroller),
              ),
            ]),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  for (var e in subfractions) {
                    context.read<SubFractions_Controller>().add_notfinals(
                        e,
                        NotFinal(
                            notFinal_ID: DateTime.now().microsecondsSinceEpoch,
                            sapa_ID: e.sapa_ID,
                            block_ID: e.block_ID,
                            fraction_ID: e.fraction_ID,
                            StockRequisetionOrder_ID: 0,
                            stage: e.Astagenum,
                            wight: vm.wightcontroller.text.to_double() /
                                subfractions.length,
                            type: context.read<ObjectBoxController>().initial2,
                            scissor: 7,
                            actions: [
                              NotFinalAction.create_Not_final_cumingFrom_A.add
                            ]));
                  }
                  Navigator.pop(context);
                },
                child: const Text('تم')),
          ],
        );
      });
}

dialog_Remove_NotFinalTo_subfractions(
    BuildContext context, List<SubFraction> f) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: SizedBox(
              height: 120,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text("هل تريد حذف"),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.red)),
                              onPressed: () {
                                for (var element in f) {
                                  context
                                      .read<SubFractions_Controller>()
                                      .remove_notfinals(element);
                                }
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
                                      WidgetStateProperty.all(Colors.blue)),
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
}
