// ignore_for_file: must_be_immutable, camel_case_types, file_names

import 'package:advanced_search/advanced_search.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/customers/Customer_controller.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/customers/customers_viewModel.dart';

import 'package:provider/provider.dart';

class Customers_view extends StatelessWidget {
  Customers_view({super.key});
  Customer_viewmodel vm = Customer_viewmodel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Consumer<Customer_controller>(
          builder: (context, myType, child) {
            return Form(
              key: vm.formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    errmsg(context),
                    const SizedBox(
                      height: 20,
                    ),
                    AdvancedSearch(
                      searchItems: context
                          .read<Customer_controller>()
                          .customers
                          .values
                          .map((e) => '${e.name} : ${e.serial}')
                          .toList(),
                      maxElementsToDisplay: 4,
                      singleItemHeight: 50,
                      borderColor: Colors.grey,
                      minLettersForSearch: 1,
                      selectedTextColor: const Color(0xFF3363D9),
                      fontSize: 14,
                      borderRadius: 12.0,
                      hintText: ' ابحث عن عميل',
                      cursorColor: Colors.blueGrey,
                      autoCorrect: false,
                      focusedBorderColor: Colors.blue,
                      searchResultsBgColor: const Color(0x00fafafa),
                      disabledBorderColor: Colors.cyan,
                      enabledBorderColor: Colors.black,
                      enabled: true,
                      caseSensitive: false,
                      inputTextFieldBgColor: Colors.white10,
                      clearSearchEnabled: true,
                      itemsShownAtStart: 2,
                      searchMode: SearchMode.CONTAINS,
                      showListOfResults: true,
                      unSelectedTextColor: Colors.black54,
                      verticalPadding: 10,
                      horizontalPadding: 10,
                      hideHintOnTextInputFocus: true,
                      hintTextColor: Colors.grey,
                      onItemTap: (index, value) {
                        vm.customerName.text = value;
                      },
                      onSearchClear: () {},
                      onSubmitted: (searchText, listOfResults) {},
                      onEditingProgress: (searchText, listOfResults) {},
                    ).permition(
                        context, UserPermition.show_search_in_customers),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 100,
                          child: TextFormField(
                              validator: Validation.validateothers,
                              controller: vm.customerName,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 2, color: Colors.teal)),
                                  border: OutlineInputBorder(),
                                  hintText: "اسم العميل",
                                  labelText: "اسم العميل",
                                  labelStyle: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  fillColor: Color.fromARGB(31, 184, 161, 161),
                                  filled: true)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        CustomTextFormField(
                            validator:
                                Validation.if_cusomer_serial_already_exist(
                                    context, vm),
                            hint: "كود العميل ",
                            width: 100,
                            controller: vm.customerSerial),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (vm.formKey.currentState!.validate()) {
                                CustomerModel customer = CustomerModel(
                                    updatedat:
                                        DateTime.now().microsecondsSinceEpoch,
                                    customer_id:
                                        DateTime.now().millisecondsSinceEpoch,
                                    serial: vm.customerSerial.text.to_int(),
                                    name: vm.customerName.text,
                                    actions: [
                                      customerAction.create_new_customer.add
                                    ]);
                                myType.Add_new_customer(customer);
                                vm.clearfields();
                              }
                            },
                            child: const Text("اضافه"))
                      ],
                    ).permition(context, UserPermition.incert_in_customers),
                    Table(
                        columnWidths: const {
                          0: FlexColumnWidth(3),
                        },
                        border: TableBorder.all(width: 1),
                        children: myType.customers.values
                            .sortedBy<num>((element) => element.serial)
                            .map((e) => TableRow(children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e.name,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      e.serial.toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]))
                            .toList()),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
