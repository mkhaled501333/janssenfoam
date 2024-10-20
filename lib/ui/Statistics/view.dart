import 'package:flutter/material.dart';
import 'package:janssenfoam/ui/Statistics/widgets.dart/blocks.dart';
import 'package:janssenfoam/ui/Statistics/widgets.dart/cars.dart';
import 'package:janssenfoam/ui/Statistics/widgets.dart/cuttingOrders.dart';
import 'package:janssenfoam/ui/Statistics/widgets.dart/densityCharts.dart';
import 'package:janssenfoam/ui/Statistics/widgets.dart/industerialSecurity.dart';
import 'package:janssenfoam/ui/Statistics/widgets.dart/roundedSissor.dart';
import 'package:janssenfoam/ui/Statistics/widgets.dart/t.dart';

class Statistics extends StatelessWidget {
  const Statistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StatisticsCuttingOrders(),
                const industerialSecurityreportwidgetStatistics()
              ],
            ),
            const Row(
              children: [
                CartsStatistics(),
                Column(
                  children: [
                    StatisticsBlocks(),
                    DensitiesCharts(),
                  ],
                ),
                Column(
                  children: [
                    RoundedSessorStatistics(),
                    MyWidget(),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
