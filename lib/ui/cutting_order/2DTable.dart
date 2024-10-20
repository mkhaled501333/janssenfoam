// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/customers/Customer_controller.dart';
import 'package:janssenfoam/services/pdfprevei.dart';
import 'package:janssenfoam/ui/cutting_order/componants.dart';
import 'package:janssenfoam/ui/cutting_order/cuting_order_pdf.dart';
import 'package:janssenfoam/ui/cutting_order/cutting_ordera_viewModer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/cutting_order/Order_controller.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';

class Towdirectonscroll001 extends StatelessWidget {
  Towdirectonscroll001({
    super.key,
  });

  final yourScrollController = ScrollController();
  final yourScrollController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<OrderController, final_prodcut_controller>(
      builder: (context, orderscontroller, finalProdcutsController, w) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Scrollbar(
            thumbVisibility: true,
            controller: yourScrollController,
            child: SingleChildScrollView(
              reverse: true,
              controller: yourScrollController,
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'عرض الموافقات',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Checkbox(
                              value: orderscontroller.showAproves,
                              onChanged: (v) {
                                v != v;
                                orderscontroller.showAproves = v!;
                                orderscontroller.Refrsh_ui();
                              }),
                        ],
                      ),
                      const Gap(33),
                      Row(
                        children: [
                          const Text(
                            'عرض الازرار',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          Checkbox(
                              value: orderscontroller.showButtoms,
                              onChanged: (v) {
                                v != v;
                                orderscontroller.showButtoms = v!;
                                orderscontroller.Refrsh_ui();
                              }),
                        ],
                      ),
                    ],
                  ),
                  const Header(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.vertical -
                        115,
                    child: Scrollbar(
                      controller: yourScrollController2,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: yourScrollController2,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: orderscontroller.opendOrders
                              .map((e) => DataRow(
                                    order: e,
                                    index:
                                        orderscontroller.opendOrders.indexOf(e),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});
  final color = const Color.fromARGB(255, 111, 191, 216);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            color: color,
            borderRadius: BorderRadius.circular(11)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            cell('تسلسل', 70),
            cell2('انجاز        عدد          مقاس       نوع>>لون>>كثافه    ',
                450),
            cell('عميل', 100),
            cell('التسليم', 90),
            cell('ملاحظات', 100),
            cell('م3', 100),
            if (context.read<OrderController>().showAproves)
              cell(
                  '  control                  finance                    sales    ',
                  420),
            if (context.read<OrderController>().showButtoms) cell('', 140),
          ].reversed.toList(),
        ),
      ),
    );
  }

  SizedBox cell(String tittle, double width) => SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Text(
              tittle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
  SizedBox cell2(String tittle, double width) => SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                tittle,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
}

class DataRow extends StatelessWidget {
  DataRow({
    super.key,
    required this.order,
    required this.index,
  });
  final cutingOrder order;
  final int index;
  final CuttingOrderViewModel vm = CuttingOrderViewModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(),
            color: order.actions.if_action_exist(
                            OrderAction.order_aproved_from_control.getTitle) ==
                        false ||
                    order.actions.if_action_exist(OrderAction
                            .order_aproved_from_calculation.getTitle) ==
                        false
                ? permitionssForOne(
                            context, UserPermition.full_Red_of_cuttingOrder) ==
                        true
                    ? Colors.black
                    : Colors.red
                : index % 2 == 0
                    ? const Color.fromARGB(255, 205, 226, 241)
                    : const Color.fromARGB(255, 243, 220, 143)),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              cell(
                order.serial.toString(),
                70,
              ),
              cell2(order, 450, context),
              cell(
                  permitionss(context,
                          UserPermition.show_cusotmer_name_in_cutting_order)
                      ? context
                          .read<Customer_controller>()
                          .customers
                          .values
                          .where((element) =>
                              element.serial == order.customer.to_int())
                          .first
                          .name
                      : order.customer.toString(),
                  100),
              cell3(
                order,
                90,
              ),
              cell5(
                order,
                100,
              ),
              cell7(
                order,
                100,
              ),
              if (context.read<OrderController>().showAproves)
                cell4(context, 420),
              if (context.read<OrderController>().showButtoms)
                cell6(context, order, 140)
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }

  SizedBox cell(String tittle, double width) => SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Text(
              tittle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
  SizedBox cell2(cutingOrder order, double width, BuildContext context) =>
      SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: order.items.map((item) {
            var r = (item.Qantity -
                vm.Total_done_of_cutting_order(context, order, item));
            return Padding(
              padding: const EdgeInsets.all(1.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (r > 0)
                    Text(
                      "${r.removeTrailingZeros} باقى",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  if (r < 0)
                    Text(
                      "${(-r).removeTrailingZeros} زياده",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  if (r == 0) const SizedBox(),
                  Row(
                    children: [
                      Text(
                        '${item.density.removeTrailingZeros}<<${item.type}>>${item.color}<<',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 3, 139, 21),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${item.hight.removeTrailingZeros}*${item.widti.removeTrailingZeros}*${item.lenth.removeTrailingZeros} من',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' ${item.Qantity} ',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 1, 52, 148),
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          LinearPercentIndicator(
                            backgroundColor:
                                const Color.fromARGB(255, 160, 160, 160),
                            barRadius: const Radius.circular(11),
                            width: 75.0,
                            lineHeight: 15.0,
                            percent: vm.petcentage_of_cutingOrder(
                                            context, order, item) /
                                        100 >
                                    1
                                ? 1
                                : vm.petcentage_of_cutingOrder(
                                        context, order, item) /
                                    100,
                            progressColor: vm.petcentage_of_cutingOrder(
                                        context, order, item) <
                                    99
                                ? Colors.red
                                : Colors.green,
                          ),
                          Center(
                            child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  "${vm.petcentage_of_cutingOrder(context, order, item).toStringAsFixed(0)} %",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );

  Center cell3(cutingOrder order, double width) => Center(
        child: Container(
            width: width,
            padding: const EdgeInsets.only(bottom: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('يسلم فى'),
                Text(
                  order.dateTOOrder.formatt(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
      );
  Center cell6(BuildContext context, cutingOrder order, double width) => Center(
        child: Container(
            width: width,
            padding: const EdgeInsets.only(bottom: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //طباعة امر الشغل
                Container(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                        onTap: () {
                          showmyAlertDialogfor_EDIT(context, order);
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 108, 207, 83),
                        ))).permition(
                    context, UserPermition.can_edit_in_cutting_order),
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
                          color: Color.fromARGB(255, 108, 207, 83),
                        ))).permition(
                    context, UserPermition.can_print_in_cutting_order),
                //اغلاق امر الشغل
                Container(
                    padding: const EdgeInsets.all(4),
                    child: GestureDetector(
                        onTap: () {
                          order.actions.add(OrderAction.order_colosed.add);
                          showmyAlertDialog(context, "اغلاق امر الشغل", order);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))).permition(
                    context, UserPermition.can_close_in_cutting_order),
              ],
            )),
      );

  SizedBox cell4(BuildContext context, double width) => SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    if (order.actions.if_action_exist(OrderAction
                                .order_aproved_from_control.getTitle) ==
                            false &&
                        permitionss(
                            context, UserPermition.can_aprove_from_controll)) {
                      order.actions
                          .add(OrderAction.order_aproved_from_control.add);
                      showmyAlertDialog(context, "موافقة الكنترول", order);
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        children: [
                          Icon(order.actions.if_action_exist(OrderAction
                                      .order_aproved_from_control.getTitle) ==
                                  true
                              ? Icons.check
                              : Icons.close),
                          order.actions.if_action_exist(OrderAction
                                      .order_aproved_from_control.getTitle) ==
                                  true
                              ? Text(DateFormat('dd-MM-yy/hh:mm a')
                                  .format(order.actions.get_Date_of_action(
                                      OrderAction
                                          .order_aproved_from_control.getTitle))
                                  .toString()
                                  .toString()
                                  .toString())
                              : const SizedBox(),
                          order.actions.if_action_exist(OrderAction
                                      .order_aproved_from_control.getTitle) ==
                                  true
                              ? Text(order.actions.get_order_Who_Of(
                                  OrderAction.order_aproved_from_control))
                              : const SizedBox(),
                        ],
                      )),
                ),
                //موافقة الحسابات
                GestureDetector(
                  onTap: () {
                    if (order.actions.if_action_exist(OrderAction
                                .order_aproved_from_calculation.getTitle) ==
                            false &&
                        permitionss(context,
                            UserPermition.can_aprove_from_calculation)) {
                      order.actions
                          .add(OrderAction.order_aproved_from_calculation.add);
                      showmyAlertDialog(context, "موافقة الحسابات", order);
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.all(2),
                      child: Column(
                        children: [
                          Icon(order.actions.if_action_exist(OrderAction
                                      .order_aproved_from_calculation
                                      .getTitle) ==
                                  true
                              ? Icons.check
                              : Icons.close),
                          order.actions.if_action_exist(OrderAction
                                      .order_aproved_from_calculation
                                      .getTitle) ==
                                  true
                              ? Text(DateFormat('dd-MM-yy/hh:mm a')
                                  .format(order.actions.get_Date_of_action(
                                      OrderAction.order_aproved_from_calculation
                                          .getTitle))
                                  .toString()
                                  .toString()
                                  .toString())
                              : const SizedBox(),
                          order.actions.if_action_exist(OrderAction
                                      .order_aproved_from_calculation
                                      .getTitle) ==
                                  true
                              ? Text(order.actions.get_order_Who_Of(
                                  OrderAction.order_aproved_from_calculation))
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
                                      OrderAction.create_order.getTitle) ==
                                  true
                              ? Icons.check
                              : Icons.close),
                          order.actions.if_action_exist(
                                      OrderAction.create_order.getTitle) ==
                                  true
                              ? Text(DateFormat('dd-MM-yy/hh:mm a')
                                  .format(order.actions.get_Date_of_action(
                                      OrderAction.create_order.getTitle))
                                  .toString()
                                  .toString()
                                  .toString())
                              : const SizedBox(),
                          order.actions.if_action_exist(
                                      OrderAction.create_order.getTitle) ==
                                  true
                              ? Text(order.actions
                                  .get_order_Who_Of(OrderAction.create_order))
                              : const SizedBox(),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      );

  Center cell5(cutingOrder order, double width) => Center(
        child: Container(
            width: width,
            padding: const EdgeInsets.only(bottom: 3),
            child: Center(
              child: Column(
                children: order.notes.map((e) => Text(e)).toList(),
              ),
            )),
      );

  Center cell7(cutingOrder order, double width) {
    return Center(
      child: Container(
          width: width,
          padding: const EdgeInsets.only(bottom: 3),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  color: Colors.grey,
                  child: Text(order.items.size()),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: order.items.map((e) => Text(e.size())).toList(),
                ),
              ],
            ),
          )),
    );
  }
}
