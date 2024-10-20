import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/blocks/IN/blocksStock_view.dart';
import 'package:janssenfoam/ui/blocks/OUt/outOfStock_view.dart';
import 'package:janssenfoam/ui/blocks/addCategoreys/blockCategory.dart';

class blocksView extends StatelessWidget {
  blocksView({super.key});
  final CalcController? controller = CalcController();
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
                    context.gonext(context, BlockCategoryView());
                  },
                  child: const Text("تكويد"))
              .permition(context, UserPermition.show_add_new_category),
          const Gap(22),
          ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(Colors.redAccent)),
                  onPressed: () {
                    context.gonext(context, const OutOfStockView());
                  },
                  child: const Text("صرف"))
              .permition(context, UserPermition.blocks_OUT),
          const Gap(22),
          ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green)),
                  onPressed: () {
                    context.gonext(context, blocksStock());
                  },
                  child: const Text("اضافه"))
              .permition(context, UserPermition.blocks_OUT),
          const Gap(22),
        ],
      ),
      body: const SizedBox(
        width: 300,
        height: 400,
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
