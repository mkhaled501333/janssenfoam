// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/ui/stockCheck/stockCheckController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/buttoms.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/stockCheck/Reports.dart';
import 'package:janssenfoam/ui/stockCheck/stockchek_veiwModel.dart';
import 'package:provider/provider.dart';

class Stockcheck extends StatelessWidget {
  Stockcheck({super.key});
  TextEditingController textEditingController = TextEditingController();
  TextStyle style = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  TextStyle style2 = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 7, 11, 255));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          MyButton1(
            tittle: "تقارير",
            onpress: () {
              context.gonext(context, Report1_stockCheck());
            },
          )
        ],
      ),
      body: Consumer2<final_prodcut_controller, StokCheck_Controller>(
        builder: (context, myType, sstockCheckcontroller, child) {
          Stockcheck_veiwModel vm = Stockcheck_veiwModel();
          List<FinalProdcutBalanceModel> f = vm.finalprodctBalance(
              myType.finalproducts.values
                  .where((test) =>
                      test.actions.if_action_exist(finalProdcutAction
                          .recive_Done_Form_FinalProdcutStock.getactionTitle) ==
                      true)
                  .toList(),
              context);

          return Column(
            children: [
              errmsg(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      items: f.map((e) => e.color).toSet().toList().map((item) {
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
                        return f.map((e) => e.color).toSet().toList().map(
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
                            color: const Color.fromARGB(255, 204, 225, 241)),
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
                          return item.value.toString().contains(searchValue);
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
                      items: f.map((e) => e.type).toSet().toList().map((item) {
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
                            color: const Color.fromARGB(255, 204, 225, 241)),
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
                          return item.value.toString().contains(searchValue);
                        },
                      )),
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
                          .map((e) => e.density.toString())
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
                        return f.map((e) => e.density).toSet().toList().map(
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
                            color: const Color.fromARGB(255, 204, 225, 241)),
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
                          return item.value.toString().contains(searchValue);
                        },
                      )),
                ],
              ),
              //header
              Center(
                child: IntrinsicHeight(
                    child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .35,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey, border: Border.all()),
                      child: Center(
                        child: Text(
                          "الصنف",
                          style: style,
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .20,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey, border: Border.all()),
                      child: Center(
                        child: Text("الرصيد", style: style),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .4,
                      decoration: BoxDecoration(
                          color: Colors.blueGrey, border: Border.all()),
                      child: Center(
                        child: Text("اخر جرد", style: style),
                      ),
                    ),
                  ].reversed.toList(),
                )),
              ),
              //table
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: f.map((e) {
                      List<StockCheckModel> a = sstockCheckcontroller
                          .stockChecks.values
                          .toList()
                          .getIdentCalOf(e);
                      return Center(
                        child: IntrinsicHeight(
                            child: Row(
                          children: [
                            //البيان
                            Container(
                              width: MediaQuery.of(context).size.width * .35,
                              decoration: BoxDecoration(border: Border.all()),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "${e.H.removeTrailingZeros}*${e.W.removeTrailingZeros}*${e.L.removeTrailingZeros}",
                                      style: style2,
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      "${e.color} ${e.type} ك${e.density.removeTrailingZeros}",
                                      style: style,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            //الكميه
                            Container(
                              width: MediaQuery.of(context).size.width * .20,
                              decoration: BoxDecoration(border: Border.all()),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(e.quantity.toString(),
                                        style: style),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        diaog_amountIN_StockCheck(context, e);
                                      },
                                      icon: const Icon(
                                          color: Colors.red, Icons.add)),
                                ],
                              ),
                            ),
                            //اخر جرد
                            Container(
                              width: MediaQuery.of(context).size.width * .4,
                              decoration: BoxDecoration(border: Border.all()),
                              child: Center(
                                child: Column(
                                  children: [
                                    a.isEmpty
                                        ? const SizedBox()
                                        : Column(
                                            children: [
                                              Text(a.last.actions.get_Who_Of(
                                                  StockCheckAction
                                                      .creat_new_StockCheck
                                                      .getTitle)),
                                              Text(a.last.actions
                                                  .get_Date_of_action(
                                                      StockCheckAction
                                                          .creat_new_StockCheck
                                                          .getTitle)
                                                  .formatt2()),
                                              Text(
                                                  "الرصيد الدفترى: ${a.last.item.quantity}"),
                                              Text(
                                                  "الرصيد الفعلى: ${a.last.realamont}"),
                                              if (a.last.item.quantity -
                                                      a.last.realamont <
                                                  0)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(' : فرق '),
                                                    Text(
                                                      '${(a.last.item.quantity - a.last.realamont)}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.red),
                                                    ),
                                                  ].reversed.toList(),
                                                )
                                              else if (a.last.item.quantity -
                                                      a.last.realamont >
                                                  0)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const Text(' : زياده '),
                                                    Text(
                                                      '+${(a.last.item.quantity - a.last.realamont)}',
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
                          ].reversed.toList(),
                        )),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

diaog_amountIN_StockCheck(BuildContext context, FinalProdcutBalanceModel e) {
  Stockcheck_veiwModel vm = Stockcheck_veiwModel();
  return showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: const Text("جرد جديد"),
            scrollable: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            content: SizedBox(
              height: 160,
              child: SingleChildScrollView(
                child: Form(
                  key: vm.formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                          validator: Validation.validateIFimpty,
                          hint: "الكميه الفعليه",
                          width: 120,
                          controller: vm.amountcontroller),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        WidgetStateProperty.all(Colors.red)),
                                onPressed: () {
                                  if (vm.validate()) {
                                    Navigator.pop(context);
                                    context
                                        .read<StokCheck_Controller>()
                                        .addNewStockCheck(StockCheckModel(
                                            stockCheck_ID: DateTime.now()
                                                .microsecondsSinceEpoch,
                                            item: e,
                                            realamont: vm.amountcontroller.text
                                                .to_int(),
                                            actions: [
                                              StockCheckAction
                                                  .creat_new_StockCheck.add
                                            ]));
                                    vm.amountcontroller.clear();
                                  }
                                },
                                child: const Text('تم')),
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
