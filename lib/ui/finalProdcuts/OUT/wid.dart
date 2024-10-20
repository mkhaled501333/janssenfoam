// ignore_for_file: must_be_immutable, duplicate_ignore

import 'package:advanced_search/advanced_search.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/color_manager.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/finalProdcuts/OUT/%D9%85%D9%86%20%D8%A7%D9%84%D8%A8%D8%B3%D9%83%D9%88%D8%A8.dart';
import 'package:janssenfoam/ui/finalProdcuts/finalProdcutExtentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/ui/customers/Customer_controller.dart';
import 'package:janssenfoam/controllers/biscol.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/ui/finalProdcuts/invoices/invoice_controller.dart';
import 'package:janssenfoam/controllers/setting_controller.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';

import 'package:provider/provider.dart';

import 'VM.dart';

// ignore: must_be_immutable
// صفحة الصرف
class OUT extends StatelessWidget {
  OUT({
    super.key,
  });
  outOfStockOrderveiwModel vm = outOfStockOrderveiwModel();
  @override
  Widget build(BuildContext context) {
    return Consumer2<final_prodcut_controller, Hivecontroller>(
      builder: (c, finalproductscntroller, hivecontroller, child) {
        print("reffffff");
        if (hivecontroller.ini != null) {
          vm.carnumber.text = hivecontroller.ini!.carNum.toString();
          vm.driverName.text = hivecontroller.ini!.driverName.toString();
          vm.customerName.text = hivecontroller.ini!.customerName.toString();
        }

        List<FinalProductModel> sorce = finalproductscntroller
            .finalproducts.values
            .where((e) =>
                e.item.amount < 0 &&
                e.actions.if_action_exist(
                        finalProdcutAction.createInvoice.getactionTitle) ==
                    false &&
                e.actions.if_action_exist(finalProdcutAction
                        .incert_From_StockChekRefresh.getactionTitle) ==
                    false)
            .toList()
            .sortedBy<num>((element) => element.finalProdcut_ID)
            .toList();

        return Form(
          key: vm.formKey,
          child: Column(
            children: [
              // تم  الاعدادات
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        vm.addInvoice(context);
                      },
                      child: const Text("تم")),
                  const SizedBox(
                    width: 15,
                  ),
                  IconButton(
                          onPressed: () {
                            showmyAlertDialogforss(context);
                          },
                          icon: const Icon(Icons.settings))
                      .permition(
                          context, UserPermition.show_setting_in_out_order),
                ],
              ),

              const Gap(10),
              if (finalproductscntroller.indexOfRadioButon == 0) Out2(),
              // البحنث عن عميل
              if (finalproductscntroller.indexOfRadioButon == 1 ||
                  (hivecontroller.ini != null &&
                      hivecontroller.ini!.customerName.isEmpty))
                Row(
                  children: [
                    SizedBox(
                      width: 280,
                      child: AdvancedSearch(
                        searchItems: context
                            .read<Customer_controller>()
                            .customers
                            .values
                            .map((e) => e.name)
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
                        onSearchClear: () {
                          print("Cleared Search");
                        },
                        onSubmitted: (searchText, listOfResults) {
                          print("Submitted: $searchText");
                        },
                        onEditingProgress: (searchText, listOfResults) {
                          print("TextEdited: $searchText");
                          print("LENGTH: ${listOfResults.length}");
                        },
                      ),
                    ),
                  ],
                ),
              const Gap(10),
              // العميل و رقم العربه
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    if (finalproductscntroller.indexOfRadioButon == 1)
                      CustomTextFormField(
                          label: "العميل",
                          readOnly: true,
                          validator: Validation.validateothers,
                          hint: 'فارغ  ',
                          width: 120,
                          controller: vm.customerName),
                    const SizedBox(
                      width: 10,
                    ),
                    if (finalproductscntroller.indexOfRadioButon == 1)
                      CustomTextFormField(
                          validator: Validation.validateothers,
                          hint: 'رقم العربه',
                          width: 120,
                          controller: vm.carnumber),
                    const Gap(22),
                    context.read<SettingController>().switch1 == false
                        ? Consumer<Invoice_controller>(
                            builder: (context, myType, child) {
                              var x = const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold);
                              Iterable<int> invoices =
                                  myType.invoices.map((e) => e.serial);

                              return Column(
                                children: [
                                  Text('رقم', style: x),
                                  Text('الاذن', style: x),
                                  Text(
                                      '( ${invoices.isEmpty ? 1 : invoices.max + 1} )',
                                      style: x),
                                ],
                              );
                            },
                          )
                        : CustomTextFormField(
                            validator: Validation.validateothers,
                            hint: 'رقم الاذن',
                            width: 120,
                            controller: vm.invoiceNum),
                  ],
                ),
              ),
              // اسم السائق و القائم با التحميل
              SizedBox(
                height: 100,
                child: Row(
                  children: [
                    if ((finalproductscntroller.indexOfRadioButon == 0 &&
                            hivecontroller.ini != null &&
                            hivecontroller.ini!.driverName.isEmpty) ||
                        finalproductscntroller.indexOfRadioButon == 1)
                      CustomTextFormField(
                          validator: Validation.validateothers,
                          keybordtupe: TextInputType.name,
                          hint: 'اسم السائق ',
                          width: 120,
                          controller: vm.driverName),
                    const SizedBox(
                      width: 10,
                    ),
                    // CustomTextFormField(
                    //     validator: Validation.validateothers,
                    //     keybordtupe: TextInputType.name,
                    //     hint: 'القائم بالتحميل',
                    //     width: 120,
                    //     controller: vm.whoLoad),
                  ],
                ),
              ),
              const Gap(10),

              // البنود
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            itemsWihTotalAndButtomOut(context);
                          },
                          icon: const Icon(Icons.add_circle_outline,
                              size: 30,
                              color: Color.fromARGB(255, 255, 21, 4))),
                      const Gap(44),
                      const Icon(Icons.arrow_downward_sharp,
                          size: 33, color: Colors.blue),
                      const Text(
                        "البنود",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.blue),
                      ),
                    ],
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 20,
                      child: Table(
                        columnWidths: const {
                          1: FlexColumnWidth(2),
                          2: FlexColumnWidth(2),
                          0: FlexColumnWidth(.7),
                        },
                        children: sorce.map((user) {
                          return TableRow(
                              decoration: BoxDecoration(color: Colors.teal[50]),
                              children: [
                                //delete
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
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Text(
                                          user.notes,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )),
                                //data
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${user.item.H.removeTrailingZeros}*${user.item.W.removeTrailingZeros}*${user.item.L.removeTrailingZeros}",
                                          style: const TextStyle(
                                              fontSize: 16,
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
                                    )),

                                // quantity
                                Center(
                                  child: Container(
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        user.item.amount.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Color.fromARGB(
                                                255, 255, 0, 106)),
                                      )),
                                ),
                              ]);
                        }).toList(),
                        border: TableBorder.all(width: 1, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class OutButtom extends StatelessWidget {
  OutButtom({super.key, required this.item});
  outOfStockOrderveiwModel vm = outOfStockOrderveiwModel();
  final FinalProductModel item;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CalcController? controller = CalcController();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    scrollable: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 600,
                      child: SingleChildScrollView(
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              // Container(
                              //   color: Colors.blue[900],
                              //   height: 30,
                              //   child: const Center(
                              //     child: Text(
                              //       ' صرف منتج تام    ',
                              //       style: TextStyle(
                              //         fontWeight: FontWeight.w700,
                              //         color: Colors.white,
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              const Gap(5),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 500,
                                    child: SimpleCalculator(
                                      controller: controller,
                                      theme: const CalculatorThemeData(
                                        commandColor:
                                            Color.fromARGB(255, 187, 176, 142),
                                        displayColor: Colors.black,
                                        displayStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 80,
                                            color: Colors.red),
                                      ),
                                    ),
                                  ),

                                  // CustomTextFormField(
                                  //   onsubmitted: (r) {
                                  //     if (formKey.currentState!.validate()) {
                                  //       vm.add(context, item);
                                  //       Navigator.pop(context);
                                  //       FocusScope.of(context).nextFocus();
                                  //     }
                                  //     return null;
                                  //   },
                                  //   autofocus: true,
                                  //   autovalidate: true,
                                  //   validator: Validation.validateothe,
                                  //   width:
                                  //       MediaQuery.of(context).size.width * .18,
                                  //   keybordtupe: TextInputType.number,
                                  //   hint: "الكميه",
                                  //   controller: vm.amountcontroller,
                                  // ),

                                  const Gap(11),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStateProperty.all(
                                                        Colors.red)),
                                            onPressed: () {
                                              vm.add(context, item, controller);
                                            },
                                            child: const Text('أضافه')),
                                      ),
                                      const Gap(5),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ));
        },
        child: const Text("صرف"));
  }
}

//الكميات والبحث
itemsWihTotalAndButtomOut(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          contentPadding: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    autofocus: true,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        hintText: "بحث فى المخزن المنتج التام",
                        hintStyle: TextStyle(color: ColorManager.gray),
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: ColorManager.gray,
                        )),
                    onChanged: (value) {
                      context
                          .read<final_prodcut_controller>()
                          .searchin_OutOFStock = value;
                      context.read<final_prodcut_controller>().Refresh_Ui();
                    },
                  ),
                  Consumer<final_prodcut_controller>(
                    builder: (context, myType, child) {
                      List<FinalProductModel> instock =
                          myType.nowBbalanceInStock();
                      return Column(
                          children: instock
                              .search(myType.searchin_OutOFStock)
                              .map((i) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                              color: Colors.blue[50],
                              border: Border.all(width: .5)),
                          child: ListTile(
                            trailing: Text(
                              "${i.item.amount}",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.red),
                            ),
                            title: Row(
                              children: [
                                Text("${i.item.density.removeTrailingZeros}"
                                    "ك"),
                                const SizedBox(
                                  width: 9,
                                ),
                                Text(i.item.color),
                                const SizedBox(
                                  width: 9,
                                ),
                                Text(i.item.type.toString()),
                                const SizedBox(
                                  width: 9,
                                ),
                                Text("${i.item.L.removeTrailingZeros}"
                                    "*"
                                    "${i.item.W.removeTrailingZeros}"
                                    "*"
                                    " ${i.item.H.removeTrailingZeros}"),
                                const SizedBox(
                                  width: 9,
                                ),
                                OutButtom(item: i)
                              ],
                            ),
                          ),
                        );
                      }).toList());
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            const Row(
              children: [],
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {},
                child: const Text('ok')),
          ],
        );
      });
}

// االاعدادات
showmyAlertDialogforss(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 300,
          child: AlertDialog(
            title: const Text('settings'),
            content: Column(children: [
              Consumer<SettingController>(
                builder: (context, myType, child) {
                  return Row(
                    children: [
                      const Text("اضافة رقم الاذن يدوى"),
                      Switch(
                        value: myType.switch1,
                        onChanged: (val) {
                          myType.switch1 = val;
                          myType.Refresh_Ui();
                          context.read<final_prodcut_controller>().Refresh_Ui();
                        },
                      ),
                    ],
                  );
                },
              )
            ]),
            actions: [
              ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('ok')),
            ],
          ),
        );
      });
}
