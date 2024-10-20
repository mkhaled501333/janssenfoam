// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, must_be_immutable, camel_case_types

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/ui/cutting_order/Order_controller.dart';
import 'package:janssenfoam/controllers/dropDowen_controller.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/cutting_order/cutting_ordera_viewModer.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_imported/finalProductStock_viewmodel.dart';

class HeaderOftable extends StatelessWidget {
  const HeaderOftable({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
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
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.amber[50],
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text("حذف"))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text(' التخزين'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text(' الجوده'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text('الاستلام'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text('ملاحظات'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text('دور'))),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Center(child: Text('مقص'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('عميل'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Center(child: Text('بيان')))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('عدد'))),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('م'))),
            ])
      ],
    );
  }
}

class FieldsINsertInFInalProdcut extends StatelessWidget {
  const FieldsINsertInFInalProdcut({
    super.key,
    required this.vm,
  });

  final FinalProductStockViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          SearchForSize(),
          // ignore: prefer_const_constructors
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DropDdowenFor_scissors(),
            ],
          ),

          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomTextFormField(
                keybordtupe: TextInputType.name,
                width: MediaQuery.of(context).size.width * .23,
                hint: "ملاحظات ",
                controller: vm.notes,
              ),
              Consumer<dropDowenContoller>(
                builder: (context, myType, child) {
                  return CustomTextFormField(
                    width: MediaQuery.of(context).size.width * .23,
                    hint: "رقم الدور ",
                    controller: myType.N,
                    validator: Validation.validateothers,
                  );
                },
              ),
              CustomTextFormField(
                width: MediaQuery.of(context).size.width * .23,
                hint: "العدد ",
                controller: vm.amountcontroller,
                validator: Validation.validateothers,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DropDdowenFor_scissors extends StatelessWidget {
  DropDdowenFor_scissors({super.key});

  CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        return Column(
          children: [
            const Text("المقص"),
            DropdownButton(
                value: Mytype.initioalFor_Scissors,
                items: Mytype.scissors
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Mytype.get_label(e),
                        ))
                    .toList(),
                onChanged: (v) {
                  if (v != null) {
                    Mytype.initioalFor_Scissors = v;
                    List<int> x = context
                        .read<final_prodcut_controller>()
                        .all
                        .values
                        .where((element) =>
                            element.actions.if_action_exist(finalProdcutAction
                                    .archive_final_prodcut.getactionTitle) ==
                                false &&
                            element.actions
                                    .get_Date_of_action(finalProdcutAction
                                        .incert_finalProduct_from_cutingUnit
                                        .getactionTitle)
                                    .formatt() ==
                                DateTime.now().formatt() &&
                            element.scissor == Mytype.initioalFor_Scissors)
                        .map((e) => e.stage)
                        .toSet()
                        .toList()
                        .sortedBy<num>((element) => element);
                    Mytype.N.text = x.isEmpty ? "1" : (x.last + 1).toString();
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class Buttoms extends StatelessWidget {
  const Buttoms({
    super.key,
    required this.vm,
  });
  final FinalProductStockViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        ElevatedButton(
            onPressed: () {
              vm.incert_finalProduct_from_cutingUnit(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "اضافة",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )),
      ],
    );
  }
}

//مقاسات شاذه خارخ الاوردر
class AddUnregular extends StatelessWidget {
  AddUnregular({super.key});

  FinalProductStockViewModel vm = FinalProductStockViewModel();

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
                                    'مقاسات شاذه خارخ الاوردر',
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
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      DropDdowenForcolor(),
                                      DropDdowenFordensity(),
                                      DropDdowenFortype(),
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
                                      CustomTextFormField(
                                        validator: Validation.validateothers,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .18,
                                        keybordtupe: TextInputType.number,
                                        hint: "مقص",
                                        controller: vm.scissorcontroller,
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
                                  CustomTextFormField(
                                    width:
                                        MediaQuery.of(context).size.width * .22,
                                    hint: "رقم الدور",
                                    controller: vm.N,
                                    validator: Validation.validateothers,
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
                                          vm.validate();
                                          if (context
                                                      .read<
                                                          BlockFirebasecontroller>()
                                                      .selectedDensity !=
                                                  null &&
                                              context
                                                      .read<
                                                          BlockFirebasecontroller>()
                                                      .selectedcolor !=
                                                  null &&
                                              context
                                                      .read<
                                                          BlockFirebasecontroller>()
                                                      .selectedtype !=
                                                  null) {
                                            vm.add_unregular(context, true);
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
                                  Expanded(
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    Colors.blue)),
                                        onPressed: () {
                                          context
                                              .read<BlockFirebasecontroller>()
                                              .selectedDensity = null;
                                          context
                                              .read<BlockFirebasecontroller>()
                                              .selectedcolor = null;
                                          context
                                              .read<BlockFirebasecontroller>()
                                              .selectedtype = null;
                                          Navigator.pop(context);
                                        },
                                        child: const Text('clear')),
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
        icon: const Icon(
            color: Color.fromARGB(255, 239, 214, 28), Icons.add_box_sharp));
  }
}

class SearchForSize extends StatelessWidget {
  SearchForSize({super.key});
  FinalProductStockViewModel vm = FinalProductStockViewModel();
  final TextEditingController textEditingController = TextEditingController();
  CuttingOrderViewModel vm2 = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, myType, child) {
        OrderController my = context.read<OrderController>();
        List<cutingOrder> orders = myType.cuttingOrders.values
            .where((v) =>
                v.actions.if_action_exist(OrderAction.order_colosed.getTitle) ==
                    false &&
                v.actions.if_action_exist(
                        OrderAction.order_aproved_from_calculation.getTitle) ==
                    true &&
                v.actions.if_action_exist(
                        OrderAction.order_aproved_from_control.getTitle) ==
                    true)
            .toList()
            .sortedBy<num>((element) => element.serial)
            .reversed
            .toList();
        return DropdownButtonHideUnderline(
          child: DropdownButton2<OperationOrederItems>(
            isExpanded: true,
            hint: Text(
              'اختر المقاس',
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: orders
                .expand((x) => x.items)
                .map((item) => DropdownMenuItem(
                      value: item,
                      child: Row(
                        children: [
                          Text(
                            " (${vm.find(orders, item).serial})>>${item.lenth.removeTrailingZeros}*${item.widti.removeTrailingZeros}*${item.hight.removeTrailingZeros} ${item.type} ${item.color}D ${item.density.removeTrailingZeros}  ",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          pp(vm: vm2, order: vm.find(orders, item), item: item)
                        ],
                      ),
                    ))
                .toList(),
            value: my.item,
            onChanged: (value) {
              my.item = value;
              my.order = vm.find(orders, value!);

              myType.Refrsh_ui();
            },
            buttonStyleData: ButtonStyleData(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: MediaQuery.of(context).size.width,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: MediaQuery.of(context).size.width,
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
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
                  keyboardType: TextInputType.number,
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: ' .....ابحث عن مقاس',
                    hintStyle: const TextStyle(fontSize: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return item.value
                    .toString()
                    .toLowerCase()
                    .contains(searchValue.toLowerCase());
              },
            ),
            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                textEditingController.clear();
              }
            },
          ),
        );
      },
    );
  }
}

class pp extends StatelessWidget {
  const pp({
    super.key,
    required this.vm,
    required this.order,
    required this.item,
  });

  final CuttingOrderViewModel vm;
  final cutingOrder order;
  final OperationOrederItems item;

  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, myType, child) {
        double x = vm.petcentage_of_cutingOrder(context, order, item);
        return Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1),
                      child: LinearPercentIndicator(
                        width: 73.0,
                        lineHeight: 15.0,
                        percent: x / 100 > 1 ? 1 : x / 100,
                        progressColor: x < 90 ? Colors.red : Colors.green,
                      ),
                    ),
                    Center(
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 1),
                          child: Text(
                            "${x.toStringAsFixed(1)} %",
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          )),
                    ),
                  ],
                ),
              ],
            ),
            Text(
                "left: ${vm.Total_Notdone_of_cutting_order(context, order, item).toStringAsFixed(0)}")
          ],
        );
      },
    );
  }
}

class DropDdowenFortype extends StatelessWidget {
  const DropDdowenFortype({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, Mytype, child) {
        final data = Mytype.blocks.values
            .toList()
            .filter_filter_type_and_density_color()
            .filter_basedOn_Type(Mytype.selectedtype)
            .filter_basedOn_color(Mytype.selectedcolor)
            .filter_basedOn_density(Mytype.selectedDensity);
        return Column(
          children: [
            const Text("النوع"),
            DropdownButton(
                value: Mytype.selectedtype,
                items: data
                    .map((t) => t.item.type)
                    .toSet()
                    .toList()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onTap: () {},
                onChanged: (v) {
                  if (v != null) {
                    Mytype.selectedtype = v;
                    Mytype.Refresh_the_UI();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenForcolor extends StatelessWidget {
  const DropDdowenForcolor({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, Mytype, child) {
        final data = Mytype.blocks.values
            .toList()
            .filter_filter_type_and_density_color()
            .filter_basedOn_Type(Mytype.selectedtype)
            .filter_basedOn_color(Mytype.selectedcolor)
            .filter_basedOn_density(Mytype.selectedDensity);
        return Column(
          children: [
            const Text("اللون"),
            DropdownButton(
                value: Mytype.selectedcolor,
                items: data
                    .map((t) => t.item.color)
                    .toSet()
                    .toList()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onTap: () {},
                onChanged: (v) {
                  if (v != null) {
                    Mytype.selectedcolor = v;
                    Mytype.Refresh_the_UI();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenFordensity extends StatelessWidget {
  const DropDdowenFordensity({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, Mytype, child) {
        final data = Mytype.blocks.values
            .toList()
            .filter_filter_type_and_density_color()
            .filter_basedOn_Type(Mytype.selectedtype)
            .filter_basedOn_color(Mytype.selectedcolor)
            .filter_basedOn_density(Mytype.selectedDensity);
        return Column(
          children: [
            const Text("كثافه"),
            DropdownButton(
                value: Mytype.selectedDensity,
                items: data
                    .map((t) => t.item.density)
                    .toSet()
                    .toList()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onTap: () {},
                onChanged: (v) {
                  if (v != null) {
                    Mytype.selectedDensity = v;
                    Mytype.Refresh_the_UI();
                  }
                }),
          ],
        );
      },
    );
  }
}
