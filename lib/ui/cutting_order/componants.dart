// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/strings_manager.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/customers/Customer_controller.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/ui/cutting_order/Order_controller.dart';
import 'package:janssenfoam/controllers/dropDowen_controller.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/controllers/setting_controller.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/services/pdfprevei.dart';
import 'package:janssenfoam/ui/cutting_order/cuting_order_pdf.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:janssenfoam/app/validation.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:janssenfoam/ui/cutting_order/cutting_ordera_viewModer.dart';

class Fields001 extends StatelessWidget {
  const Fields001({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Form(
        key: vm.formKey,
        child: SizedBox(
          height: 450,
          child: Column(
            children: [
              DropForCustomers(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropDdowenForDensity(),
                  DropDdowenForcolor(),
                  DropDdowenFortype(),
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomTextFormField(
                        onsubmitted: (v) {
                          dropDowenContoller g =
                              context.read<dropDowenContoller>();
                          vm.validate();
                          if (vm.formKey.currentState!.validate() &&
                              g.initialcolor != null &&
                              g.initialdensity != null &&
                              g.initialtype != null) {
                            vm.addItem(
                                context, context.read<dropDowenContoller>());
                          }

                          context.read<ObjectBoxController>().get();
                          FocusScope.of(context).nextFocus();
                          FocusScope.of(context).nextFocus();
                          FocusScope.of(context).nextFocus();
                          return null;
                        },
                        width: MediaQuery.of(context).size.width * .19,
                        hint: "ارتفاع",
                        controller: vm.hightncontroller,
                        validator: Validation.validateothers,
                      ),
                      CustomTextFormField(
                        onsubmitted: (v) {
                          FocusScope.of(context).previousFocus();
                          return null;
                        },
                        width: MediaQuery.of(context).size.width * .19,
                        hint: "عرض",
                        controller: vm.widthcontroller,
                        validator: Validation.validateothers,
                      ),
                      CustomTextFormField(
                        onsubmitted: (v) {
                          FocusScope.of(context).previousFocus();
                          return null;
                        },
                        width: MediaQuery.of(context).size.width * .19,
                        hint: "طول",
                        controller: vm.lenthcontroller,
                        validator: Validation.validateothers,
                      ),
                      CustomTextFormField(
                        onsubmitted: (v) {
                          FocusScope.of(context).previousFocus();
                          return null;
                        },
                        width: MediaQuery.of(context).size.width * .19,
                        hint: "كميه",
                        controller: vm.amountcontroller,
                        validator: Validation.validateothers,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .19,
                        child: TextFormField(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101));

                              if (pickedDate != null) {
                                String formattedDate = pickedDate
                                    .millisecondsSinceEpoch
                                    .toString();

                                vm.datecontroller.text = formattedDate;
                              } else {}
                            },
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).previousFocus();
                            },
                            readOnly: true,
                            controller: vm.datecontroller,
                            validator: Validation.validateothers,
                            decoration: const InputDecoration(
                                hintText: "التسليم",
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2, color: Colors.teal)),
                                border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always,
                                fillColor: Color.fromARGB(31, 184, 161, 161),
                                filled: true)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    keybordtupe: TextInputType.name,
                    width: MediaQuery.of(context).size.width * .5,
                    hint: "ملحوظه",
                    controller: vm.notes,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Buttoms001 extends StatelessWidget {
  const Buttoms001({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (context.read<Customer_controller>().initialForRaido != null) {
          vm.addOrder(context);
          vm.notes.clear();
        }
      },
      child: const SizedBox(
        width: 90,
        height: 45,
        child: Center(
          child: Text(
            "اضافة",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class Buttoms003 extends StatelessWidget {
  const Buttoms003({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, myType, child) {
        return ElevatedButton(
          onPressed: () {
            dropDowenContoller g = context.read<dropDowenContoller>();
            vm.validate();
            if (vm.formKey.currentState!.validate() &&
                g.initialcolor != null &&
                g.initialdensity != null &&
                g.initialtype != null) {
              vm.addItem(context, context.read<dropDowenContoller>());
            }

            context.read<ObjectBoxController>().get();
          },
          child: SizedBox(
            width: 90,
            height: 45,
            child: Center(
              child: Text(
                " ${vm.temp.length + 1}مقاس",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Buttoms002 extends StatelessWidget {
  const Buttoms002({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        vm.clearfields();
        context.read<dropDowenContoller>().initialcolor = null;
        context.read<dropDowenContoller>().initialdensity = null;
        context.read<dropDowenContoller>().initialtype = null;
        context.read<Customer_controller>().initialForRaido = null;
        context.read<Customer_controller>().Refrsh_ui();
        context.read<dropDowenContoller>().Refrsh_ui();
        context.read<ObjectBoxController>().get();
      },
      child: const SizedBox(
        width: 90,
        height: 45,
        child: Center(
          child: Text(
            "clear",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class TheTable001 extends StatelessWidget {
  TheTable001({
    super.key,
    required this.vm,
  });
  final CuttingOrderViewModel vm;
  int x = 0;
  @override
  Widget build(BuildContext context) {
    return Consumer2<OrderController, final_prodcut_controller>(
      builder: (context, orders, finalprodcutcontroller, child) {
        return Expanded(
          flex: 4,
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 1450,
              child: ListView(
                children: [
                  const HeaderOftable001(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1),
                      2: FlexColumnWidth(1),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(3),
                      5: FlexColumnWidth(3),
                      6: FlexColumnWidth(3),
                      7: FlexColumnWidth(2),
                      8: FlexColumnWidth(1.5),
                      9: FlexColumnWidth(1.5),
                      10: FlexColumnWidth(1),
                      11: FlexColumnWidth(1.3),
                      12: FlexColumnWidth(1.5),
                      13: FlexColumnWidth(5),
                      14: FlexColumnWidth(1),
                      15: FlexColumnWidth(1.2),
                    },
                    children: orders.cuttingOrders.values
                        .where((element) =>
                            element.actions.if_action_exist(
                                OrderAction.order_colosed.getTitle) ==
                            false)
                        .sortedBy<num>((element) => element.serial)
                        .map((order) {
                          x++;

                          return TableRow(
                              decoration: BoxDecoration(
                                color: order.actions.if_action_exist(OrderAction
                                                .order_aproved_from_control
                                                .getTitle) ==
                                            false ||
                                        order.actions.if_action_exist(OrderAction
                                                .order_aproved_from_calculation
                                                .getTitle) ==
                                            false
                                    ? permitionssForOne(
                                                context,
                                                UserPermition
                                                    .full_Red_of_cuttingOrder) ==
                                            true
                                        ? Colors.black
                                        : Colors.red
                                    : x % 2 == 0
                                        ? Colors.blue[50]
                                        : Colors.amber[50],
                              ),
                              children: [
                                //طباعة امر الشغل
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          showmyAlertDialogfor_EDIT(
                                              context, order);
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color:
                                              Color.fromARGB(255, 108, 207, 83),
                                        ))).permition(context,
                                    UserPermition.can_edit_in_cutting_order),
                                //طباعة امر الشغل
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          permission().then((value) async {
                                            Cuting_order_pdf()
                                                .generate(context, order)
                                                .then((value) => context.gonext(
                                                    context,
                                                    PDfpreview(
                                                      v: value.save(),
                                                    )));
                                          });
                                        },
                                        child: const Icon(
                                          Icons.print,
                                          color:
                                              Color.fromARGB(255, 108, 207, 83),
                                        ))).permition(context,
                                    UserPermition.can_print_in_cutting_order),
                                //اغلاق امر الشغل
                                Container(
                                    padding: const EdgeInsets.all(4),
                                    child: GestureDetector(
                                        onTap: () {
                                          order.actions.add(
                                              OrderAction.order_colosed.add);
                                          showmyAlertDialog(context,
                                              "اغلاق امر الشغل", order);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ))).permition(context,
                                    UserPermition.can_close_in_cutting_order),
                                Center(
                                  child: Column(
                                    children: order.notes
                                        .map((e) => Text(e))
                                        .toList(),
                                  ),
                                ),
                                //موافقة الكنترول
                                GestureDetector(
                                  onTap: () {
                                    if (order.actions.if_action_exist(
                                                OrderAction
                                                    .order_aproved_from_control
                                                    .getTitle) ==
                                            false &&
                                        permitionss(
                                            context,
                                            UserPermition
                                                .can_aprove_from_controll)) {
                                      order.actions.add(OrderAction
                                          .order_aproved_from_control.add);
                                      showmyAlertDialog(
                                          context, " موافقة الكنترول", order);
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(order.actions.if_action_exist(
                                                      OrderAction
                                                          .order_aproved_from_control
                                                          .getTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          order.actions.if_action_exist(OrderAction
                                                      .order_aproved_from_control
                                                      .getTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(order.actions
                                                      .get_Date_of_action(
                                                          OrderAction
                                                              .order_aproved_from_control
                                                              .getTitle))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
                                          order.actions.if_action_exist(OrderAction
                                                      .order_aproved_from_control
                                                      .getTitle) ==
                                                  true
                                              ? Text(order.actions
                                                  .get_order_Who_Of(OrderAction
                                                      .order_aproved_from_control))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                                //موافقة الحسابات
                                GestureDetector(
                                  onTap: () {
                                    if (order.actions.if_action_exist(OrderAction
                                                .order_aproved_from_calculation
                                                .getTitle) ==
                                            false &&
                                        permitionss(
                                            context,
                                            UserPermition
                                                .can_aprove_from_calculation)) {
                                      order.actions.add(OrderAction
                                          .order_aproved_from_calculation.add);
                                      showmyAlertDialog(
                                          context, "موافقة الحسابات", order);
                                    }
                                  },
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(order.actions.if_action_exist(
                                                      OrderAction
                                                          .order_aproved_from_calculation
                                                          .getTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          order.actions.if_action_exist(OrderAction
                                                      .order_aproved_from_calculation
                                                      .getTitle) ==
                                                  true
                                              ? Text(DateFormat(
                                                      'dd-MM-yy/hh:mm a')
                                                  .format(order.actions
                                                      .get_Date_of_action(
                                                          OrderAction
                                                              .order_aproved_from_calculation
                                                              .getTitle))
                                                  .toString()
                                                  .toString()
                                                  .toString())
                                              : const SizedBox(),
                                          order.actions.if_action_exist(OrderAction
                                                      .order_aproved_from_calculation
                                                      .getTitle) ==
                                                  true
                                              ? Text(order.actions
                                                  .get_order_Who_Of(OrderAction
                                                      .order_aproved_from_calculation))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                                //الانشاء
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      padding: const EdgeInsets.all(2),
                                      child: Column(
                                        children: [
                                          Icon(order.actions.if_action_exist(
                                                      OrderAction.create_order
                                                          .getTitle) ==
                                                  true
                                              ? Icons.check
                                              : Icons.close),
                                          order.actions.if_action_exist(
                                                      OrderAction.create_order
                                                          .getTitle) ==
                                                  true
                                              ? Text(
                                                  DateFormat('dd-MM-yy/hh:mm a')
                                                      .format(order.actions
                                                          .get_Date_of_action(
                                                              OrderAction
                                                                  .create_order
                                                                  .getTitle))
                                                      .toString()
                                                      .toString()
                                                      .toString())
                                              : const SizedBox(),
                                          order.actions.if_action_exist(
                                                      OrderAction.create_order
                                                          .getTitle) ==
                                                  true
                                              ? Text(order.actions
                                                  .get_order_Who_Of(
                                                      OrderAction.create_order))
                                              : const SizedBox(),
                                        ],
                                      )),
                                ),
                                //تاريخ التسليم
                                Center(
                                  child: Container(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        order.dateTOOrder.formatt(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                //العميل
                                Center(
                                  child: Container(
                                      padding: const EdgeInsets.only(bottom: 3),
                                      child: Text(
                                        permitionss(
                                                context,
                                                UserPermition
                                                    .show_cusotmer_name_in_cutting_order)
                                            ? context
                                                .read<Customer_controller>()
                                                .customers
                                                .values
                                                .where((element) =>
                                                    element.serial ==
                                                    order.customer.to_int())
                                                .first
                                                .name
                                            : order.customer.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                //الكميه
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .4)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              children: [
                                                Text(
                                                    ' ${[
                                                      item.Qantity *
                                                          item.lenth *
                                                          item.hight *
                                                          item.widti /
                                                          1000000
                                                    ].first.removeTrailingZeros}  m3 ',
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    )),
                                              ],
                                            )),
                                      )
                                      .toList(),
                                ),
                                // المتبقى
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .4)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  (item.Qantity -
                                                          vm.Total_done_of_cutting_order(
                                                              context,
                                                              order,
                                                              item))
                                                      .removeTrailingZeros,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )
                                      .toList(),
                                ),
                                //الانتاج
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .4)),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  vm.Total_done_of_cutting_order(
                                                          context, order, item)
                                                      .removeTrailingZeros,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      )
                                      .toList(),
                                ),
                                //النسبه المويه الانجاز
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: .4)),
                                          child: Stack(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4),
                                                child: LinearPercentIndicator(
                                                  width: 67.0,
                                                  lineHeight: 15.0,
                                                  percent:
                                                      vm.petcentage_of_cutingOrder(
                                                                      context,
                                                                      order,
                                                                      item) /
                                                                  100 >
                                                              1
                                                          ? 1
                                                          : vm.petcentage_of_cutingOrder(
                                                                  context,
                                                                  order,
                                                                  item) /
                                                              100,
                                                  progressColor:
                                                      vm.petcentage_of_cutingOrder(
                                                                  context,
                                                                  order,
                                                                  item) <
                                                              99
                                                          ? Colors.red
                                                          : Colors.green,
                                                ),
                                              ),
                                              Center(
                                                child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 4),
                                                    child: Text(
                                                      "${vm.petcentage_of_cutingOrder(context, order, item).removeTrailingZeros} %",
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),

                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(width: .4)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  " ${item.color}<<",
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  item.type.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  " <<${item.density.removeTrailingZeros}ك<< ",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  "${item.hight.removeTrailingZeros}*${item.widti.removeTrailingZeros}*${item.lenth.removeTrailingZeros}",
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                const Gap(5)
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                                //الكميه
                                Column(
                                  children: order.items
                                      .map(
                                        (item) => Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(width: .4)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 4),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    item.Qantity.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      )
                                      .toList(),
                                ),
                                //التسلسل
                                Center(
                                  child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      child: Text(
                                        order.serial.toString(),
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                              ]);
                        })
                        .toList()
                        .reversed
                        .toList(),
                    border: TableBorder.all(width: 1, color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HeaderOftable001 extends StatelessWidget {
  const HeaderOftable001({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(3),
        4: FlexColumnWidth(3),
        5: FlexColumnWidth(3),
        6: FlexColumnWidth(3),
        7: FlexColumnWidth(2),
        8: FlexColumnWidth(1.5),
        9: FlexColumnWidth(1.5),
        10: FlexColumnWidth(1),
        11: FlexColumnWidth(1.3),
        12: FlexColumnWidth(1.5),
        13: FlexColumnWidth(5),
        14: FlexColumnWidth(1),
        15: FlexColumnWidth(1.2),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 111, 191, 216),
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("تعديل")),
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("طباعه")),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5), child: const Text("غلق")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("ملاحظات")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("controll approval")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("finance approval")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("sales approval")),
              ),
              Container(
                  padding: const EdgeInsets.all(5),
                  child: const Text("تاريخ التسليم")),
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("عميل")),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("اجمالى م3")),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "المتبقى",
                      style: TextStyle(fontSize: 11),
                    )),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "انتاج",
                      style: TextStyle(fontSize: 11),
                    )),
              ),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text(" %الانجاز")),
              ),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(
                    child: Text('مقاس>>كثافه>>نوع',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  )),
              Container(
                  padding: const EdgeInsets.all(4),
                  child: const Center(child: Text('كميه'))),
              Container(
                  padding: const EdgeInsets.all(4), child: const Text('تسلسل')),
            ])
      ],
    );
  }
}

showmyAlertDialog(
    BuildContext context, String notificationTittle, cutingOrder item) {
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
                // style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  context.read<OrderController>().add_order(
                      item, notificationTittle, SringsManager.myemail);
                  Navigator.pop(context);
                },
                child: const Text(
                  'yes',
                )),
          ],
        );
      });
}

showmyAlertDialogfor_EDIT(BuildContext context, cutingOrder item) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('تعديل امر الشغل'),
          content: Consumer<SettingController>(
            builder: (context, myType, child) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...item.items.map(
                      (e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            var Q = TextEditingController();
                            Q.text = e.Qantity.toString();
                            var L = TextEditingController();
                            L.text = e.lenth.removeTrailingZeros;
                            var W = TextEditingController();
                            W.text = e.widti.removeTrailingZeros;
                            var H = TextEditingController();
                            H.text = e.hight.removeTrailingZeros;
                            var D = TextEditingController();
                            D.text = e.density.removeTrailingZeros;
                            var T = TextEditingController();
                            T.text = e.type;
                            var C = TextEditingController();
                            C.text = e.color;
                            var N = TextEditingController();
                            N.text = item.notes.isEmpty ? '' : item.notes.first;
                            showDialog(
                                context: context,
                                builder: (builder) => AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomTextFormField(
                                              hint: "كميه",
                                              width: 80,
                                              controller: Q),
                                          const Gap(8),
                                          Row(
                                            children: [
                                              CustomTextFormField(
                                                  hint: "طول",
                                                  width: 80,
                                                  controller: L),
                                              CustomTextFormField(
                                                  hint: "عرض",
                                                  width: 80,
                                                  controller: W),
                                              CustomTextFormField(
                                                  hint: "ارتفاع",
                                                  width: 80,
                                                  controller: H),
                                            ].reversed.toList(),
                                          ),
                                          const Gap(8),
                                          Row(
                                            children: [
                                              CustomTextFormField(
                                                  hint: "لون",
                                                  width: 80,
                                                  controller: C),
                                              CustomTextFormField(
                                                  hint: "نوع",
                                                  width: 80,
                                                  controller: T),
                                              CustomTextFormField(
                                                  hint: "كثافه",
                                                  width: 80,
                                                  controller: D),
                                            ].reversed.toList(),
                                          ),
                                          const Gap(6),
                                          CustomTextFormField(
                                              hint: "ملاحظات",
                                              width: 120,
                                              controller: N),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('No')),
                                        ElevatedButton(
                                            // style: ElevatedButton.styleFrom(primary: Colors.red),
                                            onPressed: () {
                                              e.Qantity = Q.text.to_int();
                                              e.lenth = L.text.to_double();
                                              e.widti = W.text.to_double();
                                              e.hight = H.text.to_double();
                                              e.density = D.text.to_double();
                                              e.color = C.text;
                                              e.type = T.text;
                                              item.notes
                                                ..clear()
                                                ..add(N.text);
                                              Navigator.pop(context);
                                              myType.Refresh_Ui();
                                            },
                                            child: const Text(
                                              'yes',
                                            )),
                                      ],
                                    ));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 225, 167, 167),
                                border: Border.all(width: .4)),
                            child: Center(
                              child: Text(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600),
                                  'عدد ${e.Qantity} ${e.color}>>${e.type}>>ك${e.density.removeTrailingZeros}>>${e.lenth.removeTrailingZeros}*${e.widti.removeTrailingZeros}*${e.hight.removeTrailingZeros}'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
            ElevatedButton(
                onPressed: () {
                  item.actions.add(OrderAction.order_edit.add);
                  context.read<OrderController>().add_order(
                      item, "تعديل امر الشغل", SringsManager.myemail);
                  Navigator.pop(context);
                },
                child: const Text(
                  'yes',
                )),
          ],
        );
      });
}

class DropForCustomers extends StatelessWidget {
  DropForCustomers({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Customer_controller>(
      builder: (context, myType, child) {
        String? selectedValue =
            context.read<Customer_controller>().initialForRaido;
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(
              selectedValue == null ? 'اختر العميل' : selectedValue.toString(),
              style: TextStyle(
                fontSize: 14,
                color: Theme.of(context).hintColor,
              ),
            ),
            items: myType.customers.values
                .sortedBy<num>((element) => element.serial)
                .map((item) => DropdownMenuItem(
                      value: item.name.toString(),
                      child: Text(
                        "${item.name}-${item.serial}",
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              context.read<Customer_controller>().initialForRaido = value;
              myType.Refrsh_ui();
            },
            buttonStyleData: const ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: 200,
            ),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 200,
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
                  expands: true,
                  maxLines: null,
                  controller: textEditingController,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: '  ... البحث عن عميل',
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

class DropDdowenFortype extends StatelessWidget {
  DropDdowenFortype({
    super.key,
  });
  CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        Mytype.getblocks(context, vm);
        return Column(
          children: [
            const Text("النوع"),
            DropdownButton(
                value: Mytype.initialtype,
                items: Mytype.filterType()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onTap: () {
                  Mytype.getblocks(context, vm);
                  Mytype.Refrsh_ui();
                },
                onChanged: (v) {
                  if (v != null) {
                    Mytype.initialtype = v;
                    Mytype.getblocks(context, vm);
                    vm.typecontroller.text = v.toString();
                    Mytype.getblocks(context, vm);
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenForcolor extends StatelessWidget {
  DropDdowenForcolor({
    super.key,
  });
  CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        Mytype.getblocks(context, vm);
        return Column(
          children: [
            const Text("اللون"),
            DropdownButton(
                value: Mytype.initialcolor,
                items: Mytype.filtercolor()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onTap: () {
                  Mytype.getblocks(context, vm);
                  Mytype.Refrsh_ui();
                },
                onChanged: (v) {
                  if (v != null) {
                    Mytype.getblocks(context, vm);

                    Mytype.initialcolor = v;
                    Mytype.getblocks(context, vm);
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}

class DropDdowenForDensity extends StatelessWidget {
  DropDdowenForDensity({
    super.key,
  });
  CuttingOrderViewModel vm = CuttingOrderViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<dropDowenContoller>(
      builder: (context, Mytype, child) {
        Mytype.getblocks(context, vm);
        return Column(
          children: [
            const Text("الكثافه"),
            DropdownButton(
                value: Mytype.initialdensity,
                items: Mytype.filterdensity()
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toString()),
                        ))
                    .toList(),
                onTap: () {
                  Mytype.getblocks(context, vm);
                  Mytype.Refrsh_ui();
                },
                onChanged: (v) {
                  if (v != null) {
                    vm.densitycontroller.text = v.toString();
                    Mytype.initialdensity = v;
                    Mytype.getblocks(context, vm);
                    Mytype.Refrsh_ui();
                  }
                }),
          ],
        );
      },
    );
  }
}
