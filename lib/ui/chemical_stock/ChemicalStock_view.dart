// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/controllers/dropDowen_controller.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/chemical_stock/componants/IN.dart';
import 'package:janssenfoam/ui/chemical_stock/componants/Out.dart';
import 'package:janssenfoam/ui/chemical_stock/componants/boxOfReport.dart';
import 'package:janssenfoam/ui/chemical_stock/componants/componants.dart';
import 'package:janssenfoam/ui/chemical_stock/componants/reports.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';

import 'package:provider/provider.dart';

class Chemical_view extends StatelessWidget {
  const Chemical_view({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                context.gonext(context, CreateChemicalCategory());
              },
              child: const Text(
                "تكويد اصناف",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              )).permition(context, UserPermition.show_Chemical_category),
          TextButton(
              onPressed: () {
                context.gonext(context, Suplying());
              },
              child: const Text(
                "توريد",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              )),
          TextButton(
              onPressed: () {
                context.gonext(context, Outing());
              },
              child: const Text(
                "صرف",
                style: TextStyle(color: Color.fromARGB(255, 156, 0, 0)),
              ))
        ],
      ),
      body: Consumer<dropDowenContoller>(
        builder: (context, myType, child) {
          return Column(
            children: [
              errmsg(context),
              BoxOFReport(),
              if (myType.selectedreport == 'تقرير الكمية المتوفره فقط')
                R_FOR_onlyAvilableQuantity(),
              if (myType.selectedreport == 'تقرير حركة المخزون')
                const R_FOR_stock_actions()
            ],
          );
        },
      ),
    );
  }
}
