// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/fromExcel.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';

import 'package:janssenfoam/ui/finalProdcuts/IN/widgets.dart';
import 'package:provider/provider.dart';

class FinalProductStockView extends StatelessWidget {
  const FinalProductStockView({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<Users_controller>().reconnect();

    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () async {
                    context.gonext(context, const bulkUpload());
                  },
                  icon: const Icon(Icons.explicit_outlined)),
              AddToStock().permition(
                  context, UserPermition.incert_in_final_prodcutStock),
              IconButton(
                  onPressed: () =>
                      context.gonext(context, HistoryOfAdingToStock()),
                  icon: const Icon(Icons.history)),
            ],
            title: const Center(child: Text("رصيد منتج تام الصنع")),
          ),
          body: const SizedBox(),
        );
      },
    );
  }
}
