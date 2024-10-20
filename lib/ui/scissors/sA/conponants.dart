// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/validation.dart';

import 'package:janssenfoam/controllers/bSubfractions.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_imported/Widgets.dart';
import 'package:janssenfoam/ui/scissors/sA/Ascissor_Viewmodel.dart';

import 'package:provider/provider.dart';

dialog_CuttSubfractions_ON_A(BuildContext context,
    SubFractions_Controller subfractioncontroller, int Acissor, int lastStage) {
  AscissorViewModel vm = AscissorViewModel();
  List<SubFraction> subfractionsUnderOperation =
      vm.getSubfractions_Underoperation(subfractioncontroller);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(''),
          content: SizedBox(
            height: 400,
            child: SingleChildScrollView(
              child: Column(children: [
                CustomTextFormField(
                    validator: Validation.validateothe,
                    hint: "عدد",
                    width: 60,
                    controller: vm.amountcontroller),
                const Text("من"),
                SingleChildScrollView(
                  child: Column(
                    children: subfractionsUnderOperation
                        .filtersubfractions()
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (vm.amountcontroller.text.isNotEmpty) {
                                for (var element in subfractionsUnderOperation
                                    .where((f) =>
                                        f.item.W == e.item.W &&
                                        f.item.type == e.item.type &&
                                        f.item.density == e.item.density &&
                                        f.item.color == e.item.color &&
                                        f.item.H == e.item.H &&
                                        f.item.L == e.item.L)
                                    .take(vm.amountcontroller.text.to_int())) {
                                  context
                                      .read<SubFractions_Controller>()
                                      .cut_subfractions_on_A(
                                          element, Acissor, lastStage);
                                }
                              }
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: 180,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: ShapeDecoration(
                                color: const Color.fromARGB(255, 46, 158, 149),
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    width: 2,
                                    color: Colors.green[200]!,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}*${e.item.H.removeTrailingZeros} ${e.item.color} ${e.item.type} D${e.item.density.removeTrailingZeros}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    subfractionsUnderOperation
                                        .where((element) =>
                                            element.item.color ==
                                                e.item.color &&
                                            element.item.type == e.item.type &&
                                            element.item.density ==
                                                e.item.density &&
                                            element.item.W == e.item.W &&
                                            element.item.L == e.item.L &&
                                            element.item.H == e.item.H)
                                        .toList()
                                        .length
                                        .toString(),
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 191, 7, 236),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
              ]),
            ),
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ok')),
          ],
        );
      });
}

Dialog_forAddingFinalProductTo_A(
    BuildContext context, int Ascissor, int stageOfA) {
  AscissorViewModel vm = AscissorViewModel();

  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          title: const Text('اضافة منتج تام'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: SingleChildScrollView(
              child: Form(
                key: vm.formKey,
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextFormField(
                        keybordtupe: TextInputType.name,
                        width: MediaQuery.of(context).size.width * .40,
                        hint: "ملاحظات ",
                        controller: vm.notes,
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
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  if (vm.formKey.currentState!.validate()) {
                    vm.incert_finalProduct_from_cutingUnit_A;
                    Navigator.pop(context);
                  }
                },
                child: const Text('ok')),
          ],
        );
      });
}
