import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/controllers/bSubfractions.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import '../../app/extentions.dart';
import '../customers/Customer_controller.dart';
import '../cutting_order/Order_controller.dart';
import '../../controllers/bFractionsController.dart';
import '../blocks/blockFirebaseController.dart';
import '../finalProdcuts/final_product_controller.dart';
import '../finalProdcuts/invoices/invoice_controller.dart';
import '../not_final/non_final_controller.dart';
import '../../main.dart';
import '../../models/moderls.dart';
import 'package:provider/provider.dart';

class UsersActions extends StatefulWidget {
  const UsersActions({super.key});

  @override
  State<UsersActions> createState() => _UsersActionsState();
}

class _UsersActionsState extends State<UsersActions> {
  String chosenDate = format.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  setState(() {
                    String formattedDate = format.format(pickedDate);
                    chosenDate = formattedDate;
                  });
                } else {}
              },
              child: Text(
                chosenDate,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: ListView(
        children: [
          errmsg(context),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: returnAllactions(context)
                  .filter_date(context, chosenDate)
                  .sortedBy<DateTime>((element) => element.when)
                  .reversed
                  .map((e) => Text(
                      "${formatwitTime.format(e.when)} >> ${e.who} >> ${e.action}"))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

List<ActionModel> returnAllactions(BuildContext context) {
  List<ActionModel> a = context
      .read<BlockFirebasecontroller>()
      .all
      .values
      .map((e) => e.actions)
      .toList()
      .expand((element) => element)
      .toList();
  List<ActionModel> b = context
      .read<Fractions_Controller>()
      .fractions
      .map((e) => e.actions)
      .expand((element) => element)
      .toList();
  List<ActionModel> e = context
      .read<Customer_controller>()
      .initalData
      .values
      .map((e) => e.actions)
      .toList()
      .expand((element) => element)
      .toList();
  List<ActionModel> f = context
      .read<final_prodcut_controller>()
      .finalproducts
      .values
      .map((e) => e.actions)
      .toList()
      .expand((element) => element)
      .toList();
  List<ActionModel> g = context
      .read<Invoice_controller>()
      .invoices
      .map((e) => e.actions)
      .toList()
      .expand((element) => element)
      .toList();
  List<ActionModel> h = context
      .read<OrderController>()
      .cuttingOrders
      .values
      .map((e) => e.actions)
      .toList()
      .expand((element) => element)
      .toList();
  List<ActionModel> j = context
      .read<NonFinalController>()
      .not_finals
      .map((e) => e.actions)
      .toList()
      .expand((element) => element)
      .toList();
  List<ActionModel> r = context
      .read<SubFractions_Controller>()
      .subfractions
      .map((e) => e.actions)
      .toList()
      .expand((element) => element)
      .toList();
  return a + b + f + e + g + h + j + r;
}
