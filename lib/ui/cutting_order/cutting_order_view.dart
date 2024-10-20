// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types
// ignore_for_file: must_be_immutable
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/cutting_order/2DTable.dart';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/ui/customers/Customer_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/controllers/ObjectBoxController.dart';
import 'package:janssenfoam/ui/cutting_order/Order_controller.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/services/pdfprevei.dart';
import 'package:janssenfoam/ui/cutting_order/componants.dart';
import 'package:janssenfoam/ui/cutting_order/cuting_order_pdf.dart';
import 'package:janssenfoam/ui/cutting_order/cutting_ordera_viewModer.dart';

class CuttingOrderView extends StatelessWidget {
  const CuttingOrderView({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    CuttingOrderViewModel vm = CuttingOrderViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('اوامر التشغيل'),
        actions: [
          TextButton(
              onPressed: () {
                context.gonext(context, AddNewCuttingOrder());
              },
              child: Container(
                width: 66,
                decoration: const BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.all(Radius.circular(11))),
                child: const Center(
                    child: Text(
                  "جديد",
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold),
                )),
              )).permition(context, UserPermition.incert_in_cutting_order),
          IconButton(
              onPressed: () {
                context.gonext(context, HistoryPage());
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
          errmsg(context),
          Towdirectonscroll001(),
          // TheTable001(
          //   vm: vm,
          // )
        ],
      ),
    );
  }
}

class RowScroll extends StatelessWidget {
  const RowScroll({
    super.key,
    required this.vm,
  });

  final CuttingOrderViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Consumer<ObjectBoxController>(
      builder: (context, myType, child) {
        return Row(children: [
          Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  children: vm.temp
                      .map((e) => Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(14)),
                            child: Row(
                              children: [
                                Text(
                                  "${e.lenth.removeTrailingZeros}*${e.widti.removeTrailingZeros}*${e.hight.removeTrailingZeros}=>>>",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "${e.Qantity}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 226, 2, 133)),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                )),
          ),
        ]);
      },
    );
  }
}

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});
  CuttingOrderViewModel vm = CuttingOrderViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تاريخ اوامر التشغيل"),
      ),
      body: Column(
        children: [
          errmsg(context),
          const SizedBox(
            height: 20,
          ),
          HistoryForOrders(vm: vm),
        ],
      ),
    );
  }
}

class HistoryForOrders extends StatelessWidget {
  const HistoryForOrders({
    super.key,
    required this.vm,
  });
  final CuttingOrderViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderController>(
      builder: (context, orders, child) {
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
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(3),
                      5: FlexColumnWidth(3),
                      6: FlexColumnWidth(2),
                      7: FlexColumnWidth(1.5),
                      8: FlexColumnWidth(1.5),
                      9: FlexColumnWidth(1),
                      10: FlexColumnWidth(1.3),
                      11: FlexColumnWidth(1.5),
                      12: FlexColumnWidth(5),
                      13: FlexColumnWidth(1),
                      14: FlexColumnWidth(1.2),
                    },
                    children: orders.cuttingOrders.values
                        .where((element) =>
                            element.actions.if_action_exist(
                                OrderAction.order_colosed.getTitle) ==
                            true)
                        .sortedBy<num>((element) => element.serial)
                        .map((order) {
                          return TableRow(
                              decoration: BoxDecoration(
                                border: Border.all(),
                                color: order.serial % 2 == 0
                                    ? Colors.blue[50]
                                    : Colors.amber[50],
                              ),
                              children: [
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
                                              " اغلاق امر الشغل", order);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                                  onTap: () {},
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
                                  onTap: () {},
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
                                            padding:
                                                const EdgeInsets.only(right: 8),
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

class percentage extends StatelessWidget {
  const percentage({
    super.key,
    required this.vm,
    required this.order,
  });

  final CuttingOrderViewModel vm;
  final cutingOrder order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: order.items
          .map(
            (item) => Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: LinearPercentIndicator(
                    width: 68.0,
                    lineHeight: 15.0,
                    percent: vm.petcentage_of_cutingOrder(
                                    context, order, item) /
                                100 >
                            1
                        ? 1
                        : vm.petcentage_of_cutingOrder(context, order, item) /
                            100,
                    progressColor:
                        vm.petcentage_of_cutingOrder(context, order, item) < 50
                            ? Colors.red
                            : Colors.green,
                  ),
                ),
                Center(
                  child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "${vm.petcentage_of_cutingOrder(context, order, item)..toStringAsFixed(1)} %",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:
                              // order.items.indexOf(item) %
                              //             2 ==
                              //         0
                              //     ? Colors.cyan
                              //     :
                              Colors.black,
                        ),
                      )),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}

class HeaderOftable00122 extends StatelessWidget {
  const HeaderOftable00122({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(3),
        4: FlexColumnWidth(3),
        5: FlexColumnWidth(3),
        6: FlexColumnWidth(2),
        7: FlexColumnWidth(1),
        8: FlexColumnWidth(1.5),
        9: FlexColumnWidth(1.5),
        10: FlexColumnWidth(4),
        11: FlexColumnWidth(1),
        12: FlexColumnWidth(1.2),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 111, 191, 216),
            ),
            children: [
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("طباعه")),
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("")),
              Container(
                  padding: const EdgeInsets.all(5),
                  child: const Text("الملاحظات")),
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
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("اجمالى م3")),
              ),
              Container(
                  padding: const EdgeInsets.all(5), child: const Text("عميل")),
              Center(
                child: Container(
                    padding: const EdgeInsets.all(5),
                    child: const Text("اجمالى عدد")),
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

class AddNewCuttingOrder extends StatelessWidget {
  AddNewCuttingOrder({super.key});
  CuttingOrderViewModel vm = CuttingOrderViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            errmsg(context),
            const SizedBox(
              height: 20,
            ),
            Fields001(vm: vm),
            RowScroll(vm: vm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Buttoms001(
                  vm: vm,
                ),
                Buttoms003(vm: vm),
                Buttoms002(vm: vm),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
            )
          ],
        ),
      ),
    );
  }
}
