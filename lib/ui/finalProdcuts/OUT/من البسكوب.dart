// من البسكول
// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/controllers/biscol.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:provider/provider.dart';

class Out2 extends StatelessWidget {
  Out2({super.key});
  final TextEditingController t = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer2<final_prodcut_controller, Hivecontroller>(
      builder: (context, finals, biscols, child) {
        return const Column(
          children: [Center(child: DropDdowenFor_cars())],
        );
      },
    );
  }
}

class DropDdowenFor_cars extends StatelessWidget {
  const DropDdowenFor_cars({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Hivecontroller>(
      builder: (context, myType, child) {
        var a = myType.allrecords.values
            .where((e) =>
                e.actions.if_action_exist(
                        WhigtTecketAction.archive_tecket.getTitle) ==
                    false &&
                e.actions.if_action_exist(
                        WhigtTecketAction.create_secondWhigt.getTitle) ==
                    false)
            .map((e) => e)
            .toList()
            .toSet()
            .toList();
        if (a.isEmpty) {
          myType.ini = null;
        }
        return Column(
          children: [
            const Text(
              'الوزنات ',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            DropdownButton<WieghtTecketMOdel>(
                value: myType.ini,
                items: a
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                              '${e.driverName} ${e.carNum} ${e.customerName}'),
                        ))
                    .toList(),
                onChanged: (v) {
                  myType.ini = null;
                  if (v != null) {
                    myType.ini = v;

                    myType.Refrech_UI();
                  }
                }),
          ],
        );
      },
    );
  }
}
