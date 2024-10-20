import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/customers/Customer_controller.dart';
import 'package:janssenfoam/ui/cutting_order/Order_controller.dart';
import 'package:janssenfoam/ui/cutting_order/cutting_order_view.dart';

import 'package:janssenfoam/ui/cutting_order/cutting_ordera_viewModer.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class StatisticsCuttingOrders extends StatelessWidget {
  StatisticsCuttingOrders({
    super.key,
  });

  final CuttingOrderViewModel vm = CuttingOrderViewModel();
  final yourScrollController = ScrollController();
  final yourScrollController2 = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Consumer2<final_prodcut_controller, OrderController>(
      builder: (context, finalprodcutcontroller, ordercontroller, child) {
        return Stack(
          children: [
            Card(
              color: const Color.fromARGB(255, 229, 206, 128),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 500,
                  width: MediaQuery.of(context).size.width * .45,
                  child: Scrollbar(
                    thumbVisibility: true,
                    controller: yourScrollController,
                    child: SingleChildScrollView(
                      reverse: true,
                      controller: yourScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Scrollbar(
                        controller: yourScrollController2,
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          controller: yourScrollController2,
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: ordercontroller.opendOrders
                                .map(
                                  (order) => Padding(
                                    padding: const EdgeInsets.only(bottom: 7),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(),
                                          color: order.actions.if_action_exist(
                                                          OrderAction
                                                              .order_aproved_from_control
                                                              .getTitle) ==
                                                      false ||
                                                  order.actions.if_action_exist(
                                                          OrderAction
                                                              .order_aproved_from_calculation
                                                              .getTitle) ==
                                                      false
                                              ? Colors.red
                                              : ordercontroller.opendOrders.indexOf(order) %
                                                          2 ==
                                                      0
                                                  ? const Color.fromARGB(
                                                      255, 240, 205, 241)
                                                  : const Color.fromARGB(
                                                      255, 161, 197, 231)),
                                      child: IntrinsicHeight(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            cell(
                                              order.serial.toString(),
                                              70,
                                            ),
                                            cell2(order, 450, context),
                                            cell(
                                                permitionss(
                                                        context,
                                                        UserPermition
                                                            .show_cusotmer_name_in_cutting_order)
                                                    ? context
                                                        .read<
                                                            Customer_controller>()
                                                        .customers
                                                        .values
                                                        .where((element) =>
                                                            element.serial ==
                                                            order.customer
                                                                .to_int())
                                                        .first
                                                        .name
                                                    : order.customer.toString(),
                                                100),
                                            cell5(
                                              order,
                                              100,
                                            ),
                                            cell7(
                                              order,
                                              100,
                                            ),
                                          ].reversed.toList(),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                color: const Color.fromARGB(255, 7, 32, 255),
                onPressed: () {
                  context.gonext(context, const CuttingOrderView());
                },
                icon: const Icon(Icons.open_in_browser_sharp))
          ],
        );
      },
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
                            color: Color.fromARGB(255, 2, 61, 170),
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
