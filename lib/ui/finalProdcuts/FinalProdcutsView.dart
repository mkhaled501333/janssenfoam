import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/finalProdcuts/OUT/view.dart';
import 'package:janssenfoam/ui/finalProdcuts/Reports/view.dart';
import 'package:janssenfoam/ui/finalProdcuts/IN/Stock_of_finalProduct_View.dart';
import 'package:janssenfoam/ui/finalProdcuts/invoices/invoices_view.dart';

class FinalProdcutsModule extends StatelessWidget {
  const FinalProdcutsModule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const Gap(22),
          ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                  onPressed: () {
                    context.gonext(context, InvicesView());
                  },
                  child: const Text("الازونات"))
              .permition(context, UserPermition.show_finalprodcut_invoice),
          const Gap(22),
          ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.redAccent)),
                  onPressed: () {
                    context.gonext(context, const outOfStockOrder());
                  },
                  child: const Text("صرف"))
              .permition(
                  context, UserPermition.show_finalprodcut_invoicemaking),
          const Gap(22),
          ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  onPressed: () {
                    context.gonext(context, const FinalProductStockView());
                  },
                  child: const Text("اضافه"))
              .permition(context, UserPermition.show_finalProdcut_stock),
          const Gap(22),
        ],
      ),
      body: const FinalprodcutsReportsView()
          .permition(context, UserPermition.show_Reports_finalprodcut),
    );
  }
}
