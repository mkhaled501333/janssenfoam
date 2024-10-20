// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, camel_case_types
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:janssenfoam/controllers/bFractionsController.dart';
import 'package:janssenfoam/controllers/bSubfractions.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_imported/Widgets.dart';
import 'package:janssenfoam/ui/scissors/sH/H1_veiwModel.dart';
import 'package:janssenfoam/ui/scissors/sR/Rscissor_view.dart';
import 'package:janssenfoam/ui/scissors/sR/Rscissor_viewModel.dart';

showmyAlertDialog1_for_ading_fractions414(BuildContext context,
    Fractions_Controller fractrioncontroller, int scissor, int lastStage) {
  Rscissor_veiwModel vm = Rscissor_veiwModel();
  List<FractionModel> fractionsNotCutOnRscissor =
      vm.getfractions_Underoperation(fractrioncontroller);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
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
                    children: fractionsNotCutOnRscissor
                        .filter_Fractios___()
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (vm.amountcontroller.text.isNotEmpty) {
                                for (var element in fractionsNotCutOnRscissor
                                    .where((f) =>
                                        f.item.W == e.item.W &&
                                        f.item.type == e.item.type &&
                                        f.item.density == e.item.density &&
                                        f.item.color == e.item.color &&
                                        f.item.H == e.item.H &&
                                        f.item.L == e.item.L)
                                    .take(vm.amountcontroller.text.to_int())) {
                                  context
                                      .read<Fractions_Controller>()
                                      .cut_Fraction_on_R_scissor(
                                        lastStage: lastStage,
                                        fractiond: element,
                                        Rscissor: scissor,
                                      );
                                }
                              }
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              // width: 180,
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
                                    "${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}*${e.item.H.removeTrailingZeros} ${e.item.color} ${e.item.type} D${e.item.density.removeTrailingZeros}    ",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    fractionsNotCutOnRscissor
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

showmyAlertDialog_forAddingFinalProductToRscissor(BuildContext context,
    int Rscissor, int stageOfR, List<FractionModel> fractions) {
  Rscissor_veiwModel vm = Rscissor_veiwModel();

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
            Row(
              children: [
                AddUnderOperation(
                  fractions: fractions,
                  stateOfR: stageOfR,
                  Rscissor: Rscissor,
                ).permition(context, UserPermition.incert_underoperation),
                AddUnregular().permition(context,
                    UserPermition.incert_unregular_in_importedfinal_prodcut)
              ],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  if (vm.formKey.currentState!.validate()) {
                    vm.incert_finalProduct_from_cutingUnit(
                        context, stageOfR, Rscissor + 3);
                    Navigator.pop(context);
                  }
                },
                child: const Text('ok')),
          ],
        );
      });
}

dialogOfAddNotFinalToBlock4544(BuildContext context,
    List<FractionModel> fractions //الفرد المقصوصه على هذا المقص فى هئا الدور
    ) {
  H1VeiwModel vm = H1VeiwModel();
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
                  for (var e in fractions) {
                    context
                        .read<Fractions_Controller>()
                        .add_Not_final_ToFraction_cutted_On_R(
                            fractiond: e,
                            type: context.read<ObjectBoxController>().initial2,
                            Rscissord: e.Rscissor,
                            wight: vm.wightcontroller.text.to_double() /
                                fractions.length);
                  }

                  Navigator.pop(context);
                },
                child: const Text('تم')),
          ],
        );
      });
}

//شغل مرحله اخرى تحت التشغيل(غير تام)'
class AddUnderOperation extends StatelessWidget {
  AddUnderOperation({
    super.key,
    required this.fractions,
    required this.stateOfR,
    required this.Rscissor,
  });

  Rscissor_veiwModel vm = Rscissor_veiwModel();
  final List<FractionModel> fractions;
  final int stateOfR;
  final int Rscissor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: SizedBox(
                      height: 450,
                      child: SingleChildScrollView(
                        child: Form(
                          key: vm.formKey,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.blue[900],
                                height: 30,
                                child: const Center(
                                  child: Text(
                                    'شغل مرحله اخرى تحت التشغيل(غير تام)',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),

                              CustomTextFormField(
                                  hint: "عددد",
                                  width: 120,
                                  validator: Validation.validateothers,
                                  controller: vm.amountcontroller),
                              const Text("من"),

                              DropDdowenForList_of_blocks_In_Rstage(
                                  data: vm.getAllDetiails_OFscissor_OFstage(
                                      stateOfR, fractions)),

                              Row(
                                children: [
                                  CustomTextFormField(
                                      hint: "طول ",
                                      width: 70,
                                      validator: Validation.validateothers,
                                      controller: vm.lenthcontroller),
                                  CustomTextFormField(
                                      hint: "عرض",
                                      width: 70,
                                      validator: Validation.validateothers,
                                      controller: vm.widthcontroller),
                                  CustomTextFormField(
                                      hint: "ارتفاع",
                                      width: 70,
                                      validator: Validation.validateothers,
                                      controller: vm.hightncontroller)
                                ],
                              ),

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
                                          if (vm.validate() &&
                                              context
                                                      .read<
                                                          ObjectBoxController>()
                                                      .selectedValueOfBLockDetailsOf !=
                                                  null) {
                                            vm.add_UnderOperatin_subfractions(
                                                context, Rscissor);
                                          }
                                        },
                                        child: const Text('أضافه')),
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
                    ),
                  ));
        },
        icon: const Icon(color: Colors.red, Icons.add_box_sharp));
  }
}

class DropDdowenForList_of_blocks_In_Rstage extends StatelessWidget {
  const DropDdowenForList_of_blocks_In_Rstage({
    super.key,
    required this.data,
  });
  final List<BLockDetailsOf> data;
  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, v, child) {
        return DropdownButton(
            value: context
                .read<ObjectBoxController>()
                .selectedValueOfBLockDetailsOf,
            items: data
                .toSet()
                .toList()
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.sapadescriotion.toString()),
                    ))
                .toList(),
            onChanged: (v) {
              if (v != null) {
                context
                    .read<ObjectBoxController>()
                    .selectedValueOfBLockDetailsOf = v;
                context.read<ObjectBoxController>().get();
              }
            });
      },
    );
  }
}

deletefractons_cutted_FromRscissr(
    BuildContext context, List<FractionModel> fractions) {
  for (var element in fractions) {
    context
        .read<Fractions_Controller>()
        .remove_cuttedFraction_from_R_scissor(fraction: element);
  }
}

delete_SUBfractons_cutted_FromRscissr(
    BuildContext context, List<SubFraction> subfraction) {
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
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      WidgetStateProperty.all(Colors.red)),
                              onPressed: () {
                                for (var element in subfraction) {
                                  context
                                      .read<SubFractions_Controller>()
                                      .delete_SUBfraction(element);
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
