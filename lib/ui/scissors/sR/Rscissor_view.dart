// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, camel_case_types, file_names
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/finalProdcuts/finalProdcutExtentions.dart';
import 'package:janssenfoam/controllers/bFractionsController.dart';
import 'package:janssenfoam/controllers/bSubfractions.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/scissors/sR/Rscissor_viewModel.dart';
import 'package:janssenfoam/ui/scissors/sR/componants.dart';

class RVeiw2 extends StatelessWidget {
  RVeiw2({
    super.key,
    required this.Rscissor,
  });
  final int Rscissor;
  Rscissor_veiwModel vm = Rscissor_veiwModel();

  @override
  Widget build(BuildContext context) {
    return Consumer4<BlockFirebasecontroller, final_prodcut_controller,
        SubFractions_Controller, Fractions_Controller>(
      builder: (context, blocks, finalprodcuts, SubFractions,
          fractrioncontroller, child) {
        List<FractionModel> fractions =
            vm.getFractions_Cutted_On_Rscissor_today(
                fractrioncontroller, Rscissor);
        List<SubFraction> subfraction =
            vm.get_SUBfraction_Cutted_On_Rscissor(SubFractions, Rscissor);
        List<FinalProductModel> finalproducts =
            vm.getDataOF_finalProdcutOF_scissor(context, Rscissor);
        List<int> AllStages =
            vm.getAllStages(fractions, Rscissor, finalproducts, subfraction);
        int lastStage = AllStages.isEmpty ? 0 : AllStages.first;

        return Column(
          children: [
            scissorNameAndNum(Rscissor: Rscissor),
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: ListView(
                  children: [
                    const HeaderOfThable(),
                    // ازرار الدور
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                                onPressed: () {
                                  showmyAlertDialog_forAddingFinalProductToRscissor(
                                      context,
                                      Rscissor,
                                      lastStage + 1,
                                      fractions);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 40,
                                  color: Color.fromARGB(255, 64, 124, 255),
                                ))
                            .permition(context,
                                UserPermition.Rshow_bottomOFfinalproduct),
                        IconButton(
                                onPressed: () {
                                  showmyAlertDialog1_for_ading_fractions414(
                                      context,
                                      fractrioncontroller,
                                      Rscissor,
                                      lastStage + 1);
                                },
                                icon: const Icon(
                                  Icons.add,
                                  size: 40,
                                  color: Color.fromARGB(255, 39, 123, 3),
                                ))
                            .permition(
                                context, UserPermition.Rshow_bottomOFFractions),
                      ],
                    ),

                    Column(
                      children: AllStages.map((e) => Container(
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
                                      MediaQuery.of(context).size.width * .05,
                                  child: Center(
                                      child: Text(
                                    textAlign: TextAlign.center,
                                    "$e",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                //الوارد
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .58,
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                          vertical: BorderSide()),
                                      color:
                                          Color.fromARGB(255, 231, 223, 223)),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      Column(
                                        children: fractions
                                            .where((element) =>
                                                element.stagenum == e)
                                            .toList()
                                            .filter_Fractios___()
                                            .map((f) => GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (_) => AlertDialog(
                                                                  scrollable:
                                                                      true,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                  ),
                                                                  content:
                                                                      SizedBox(
                                                                    height: 120,
                                                                    child:
                                                                        SingleChildScrollView(
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          const Text(
                                                                              "هل تريد حذف"),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Text("${fractions.first.item.color} ${fractions.first.item.type} ك${fractions.first.item.density.removeTrailingZeros}"),
                                                                              Text("  ${fractions.first.item.L.removeTrailingZeros}*${fractions.first.item.W.removeTrailingZeros}*${fractions.first.item.H.removeTrailingZeros} من "),
                                                                              Text("${fractions.map((e) => e.item).toList().countOf(fractions.first.item)} "),
                                                                            ],
                                                                          ),
                                                                          Row(
                                                                            children: [
                                                                              Expanded(
                                                                                child: ElevatedButton(
                                                                                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
                                                                                    onPressed: () {
                                                                                      if (fractions.first.notfinals.isEmpty) {
                                                                                        deletefractons_cutted_FromRscissr(context, fractons_cutted_on_Rstage_rscossor(fractions, f).toList());
                                                                                        Navigator.pop(context);
                                                                                      } else {
                                                                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(duration: Duration(seconds: 7), content: Text('لا يمكن حذف بسبب اضافة دون تام')));
                                                                                      }
                                                                                    },
                                                                                    child: const Text('حذف')),
                                                                              ).permition(context, UserPermition.can_delete_fractons_cutted_on_R),
                                                                              const SizedBox(
                                                                                width: 5,
                                                                              ),
                                                                              Expanded(
                                                                                child: ElevatedButton(
                                                                                    style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
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
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                          "${f.item.color} ${f.item.type} ك${f.item.density.removeTrailingZeros}"),
                                                      Text(
                                                          "  ${f.item.L.removeTrailingZeros}*${f.item.W.removeTrailingZeros}*${f.item.H.removeTrailingZeros} من "),
                                                      Text(
                                                          "${fractons_cutted_on_Rstage_rscossor(fractions, f).length} "),
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
                                                    showmyAlertDialog1_for_ading_fractions414(
                                                        context,
                                                        fractrioncontroller,
                                                        Rscissor,
                                                        e);
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
                                                      .Rshow_bottomOFFractions)
                                        ],
                                      )
                                    ],
                                  )),
                                ),
                                //الصادر
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .58,
                                  decoration: const BoxDecoration(
                                      border: Border.symmetric(
                                          vertical: BorderSide()),
                                      color:
                                          Color.fromARGB(255, 231, 223, 223)),
                                  child: Center(
                                      child: Column(
                                    children: [
                                      //المنتج
                                      Column(
                                        children: finalproducts
                                            .where(
                                                (element) => element.stage == e)
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
                                                        "${totalOfFinalProdcut(finalproducts, f)} "),
                                                  ],
                                                ))
                                            .toList(),
                                      ),

                                      //الشغل المرحله الاخرى
                                      Column(
                                        children: subfraction
                                            .where((element) =>
                                                element.Rscissor == Rscissor &&
                                                element.Rstagenum == e)
                                            .toList()
                                            .filtersubfractions()
                                            .map((w) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        delete_SUBfractons_cutted_FromRscissr(
                                                            context,
                                                            subfractions_cuttedon_R(
                                                                subfraction,
                                                                w));
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                      ),
                                                      color: Colors.red,
                                                    ).permition(
                                                        context,
                                                        UserPermition
                                                            .can_delete_fractons_cutted_on_R),
                                                    Text(
                                                        "${w.item.color} ${w.item.type} ك${w.item.density.removeTrailingZeros}"),
                                                    Text(
                                                        "  ${w.item.L.removeTrailingZeros}*${w.item.W.removeTrailingZeros}*${w.item.H.removeTrailingZeros} من "),
                                                    Text(
                                                        "${subfractions_cuttedon_R(subfraction, w).length} "),
                                                  ],
                                                ))
                                            .toList(),
                                      ),
                                      //button
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                                  onPressed: () {
                                                    showmyAlertDialog_forAddingFinalProductToRscissor(
                                                        context,
                                                        Rscissor,
                                                        e,
                                                        fractions);
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
                                                      .Rshow_bottomOFfinalproduct)
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
                                        children: fractions
                                            .where((element) =>
                                                element.stagenum == e)
                                            .expand((s) => s.notfinals)
                                            .toList()
                                            .filter_notfinals___()
                                            .map((f) => Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              .29,
                                                      child: Text(
                                                        "${f.type} kg ${fractions.where((element) => element.stagenum == e).expand((s) => s.notfinals).where((element) => element.type == f.type).map((e) => e.wight).reduce((n, m) => n + m).toStringAsFixed(2)}",
                                                      ),
                                                    ),
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
                                                    dialogOfAddNotFinalToBlock4544(
                                                        context,
                                                        fractions
                                                            .where((element) =>
                                                                element
                                                                    .stagenum ==
                                                                e)
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

  Iterable<FractionModel> fractons_cutted_on_Rstage_rscossor(
          List<FractionModel> fractions, FractionModel f) =>
      fractions.where((element) =>
          element.stagenum == f.stagenum &&
          element.item.color == f.item.color &&
          element.item.type == f.item.type &&
          element.item.W == f.item.W &&
          element.item.L == f.item.L &&
          element.item.H == f.item.H);

  int totalOfFinalProdcut(
          List<FinalProductModel> finalproducts, FinalProductModel f) =>
      finalproducts
          .where((element) =>
              element.stage == f.stage &&
              element.item.color == f.item.color &&
              element.item.type == f.item.type &&
              element.item.W == f.item.W &&
              element.item.L == f.item.L &&
              element.item.H == f.item.H)
          .map((e) => e.item.amount)
          .reduce((value, element) => value + element);

  List<SubFraction> subfractions_cuttedon_R(
          List<SubFraction> subfractions, SubFraction f) =>
      subfractions
          .where((v) =>
              v.Rstagenum == f.Rstagenum &&
              v.item.color == f.item.color &&
              v.item.type == f.item.type &&
              v.item.density == f.item.density &&
              v.item.W == f.item.W &&
              v.item.L == f.item.L &&
              v.item.H == f.item.H)
          .toList();
}

class scissorNameAndNum extends StatelessWidget {
  const scissorNameAndNum({
    super.key,
    required this.Rscissor,
  });

  final int Rscissor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(),
          color: const Color.fromARGB(255, 175, 132, 132)),
      child: Text(
        "      مقص دائرى ( $Rscissor )     ",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

class HeaderOfThable extends StatelessWidget {
  const HeaderOfThable({
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
