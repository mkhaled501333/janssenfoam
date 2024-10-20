// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable, camel_case_types

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_imported/finalProductStock_viewmodel.dart';
import 'package:janssenfoam/ui/finalProdcuts/IN/Stock_of_finalProduct_ViewModel.dart';

class AddToStock extends StatelessWidget {
  AddToStock({super.key});
  stockOfFinalProductsViewModel vm = stockOfFinalProductsViewModel();

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
                                    ' اضافة الى المخزن    ',
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "النوع",
                                        keybordtupe: TextInputType.name,
                                        controller: vm.typecontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "الكثافه",
                                        controller: vm.densitycontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.number,
                                        hint: "العميل",
                                        controller: vm.companycontroller,
                                        validator:
                                            Validation.if_cusomer_serial_exist(
                                                context),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        validator: Validation.validateothers,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.number,
                                        hint: "الكميه",
                                        controller: vm.amountcontroller,
                                      ),
                                      CustomTextFormField(
                                        validator: Validation.validateothers,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.name,
                                        hint: "اللون",
                                        controller: vm.colercontroller,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "الارتفاع",
                                        controller: vm.hightncontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "العرض",
                                        controller: vm.widthcontroller,
                                        validator: Validation.validateothers,
                                      ),
                                      CustomTextFormField(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        hint: "الطول ",
                                        controller: vm.lenthcontroller,
                                        validator: Validation.validateothers,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.red)),
                                        onPressed: () {
                                          vm.add(context);
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
        icon: const Icon(Icons.add));
  }
}

class HistoryOfAdingToStock extends StatelessWidget {
  HistoryOfAdingToStock({
    super.key,
  });
  FinalProductStockViewModel vm = FinalProductStockViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        List<FinalProductModel> scorce = finalproducts.finalproducts.values
            .where((e) =>
                e.actions.if_action_exist(
                    finalProdcutAction.archive_final_prodcut.getactionTitle) ==
                false)
            .where((e) =>
                e.actions.if_action_exist(finalProdcutAction
                    .incert_finalProduct_from_Others.getactionTitle) ==
                true)
            .sortedBy<num>(
              (element) => element.finalProdcut_ID,
            )
            .toList();
        return Scaffold(
          appBar: AppBar(
            title: const Text("سجل "),
          ),
          body: Column(
            children: [
              errmsg(context),
              Expanded(
                child: SingleChildScrollView(
                  child: Table(
                    columnWidths: const {
                      4: FlexColumnWidth(2),
                    },
                    children: scorce.map((user) {
                      return TableRow(
                          decoration: BoxDecoration(color: Colors.teal[50]),
                          children: [
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: GestureDetector(
                                    onTap: () {
                                      user.actions.add(finalProdcutAction
                                          .archive_final_prodcut.add);
                                      context
                                          .read<final_prodcut_controller>()
                                          .updateFinalProdcut(user);
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ))),
                            Container(
                                padding: const EdgeInsets.all(2),
                                child: Text(user.item.density.toString())),
                            Container(
                                padding: const EdgeInsets.all(2),
                                child: Text(user.customer.toString())),
                            Container(
                                padding: const EdgeInsets.all(1),
                                child: Text(user.item.type.toString())),
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                    "${user.item.H.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.L.removeTrailingZeros}")),
                            Container(
                                padding: const EdgeInsets.all(4),
                                child: Text(
                                  user.item.amount.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 221, 2, 75)),
                                )),
                          ]);
                    }).toList(),
                    border: TableBorder.all(width: 1, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

dialog(BuildContext context, stockOfFinalProductsViewModel vm,
    ItemModel itemData, GroupModel headerData) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: SizedBox(
              height: 250,
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
                            'اضافه الى هذا المقاس',
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomTextFormField(
                                autovalidate: true,
                                validator: Validation.validateothers,
                                width: MediaQuery.of(context).size.width * .18,
                                keybordtupe: TextInputType.number,
                                hint: "الكميه",
                                controller: vm.amountcontroller,
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const SizedBox(height: 15),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.red)),
                                onPressed: () {
                                  vm.addtocertinsize(
                                      context, itemData, headerData);
                                  Navigator.pop(context);
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
            ),
          ));
}
