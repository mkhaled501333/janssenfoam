// ignore_for_file: must_be_immutable, file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/ui/finalProdcuts/OUT/wid.dart';
import 'package:provider/provider.dart';

class outOfStockOrder extends StatelessWidget {
  const outOfStockOrder({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<final_prodcut_controller>(
      builder: (context, finalproducts, child) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 50,
            title: const BUtton(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                errmsg(context),
                OUT(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BUtton extends StatelessWidget {
  const BUtton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        children: [
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.amber)),
              onPressed: () {
                context.read<final_prodcut_controller>().indexOfRadioButon = 0;
                context.read<final_prodcut_controller>().Refresh_Ui();
              },
              child: const Text(
                "من الوزنات",
                style: TextStyle(color: Colors.black),
              )),
          // ignore: prefer_const_constructors
          Gap(5),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 255, 7, 214))),
              onPressed: () {
                context.read<final_prodcut_controller>().indexOfRadioButon = 1;
                context.read<final_prodcut_controller>().Refresh_Ui();
              },
              child: const Text(
                "صرف",
                style: TextStyle(color: Colors.black),
              )),
          const Gap(5),
          ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll(Color.fromARGB(255, 65, 255, 7))),
              onPressed: () {
                context.read<final_prodcut_controller>().indexOfRadioButon = 2;
                context.read<final_prodcut_controller>().Refresh_Ui();
              },
              child: const Text(
                "من اومر الشغل",
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
    );
  }
}
