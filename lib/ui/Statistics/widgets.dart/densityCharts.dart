import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DensitiesCharts extends StatelessWidget {
  const DensitiesCharts({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(179, 252, 232, 232),
      child: SizedBox(
        height: 200,
        child: Consumer<final_prodcut_controller>(
          builder: (context, myType, child) {
            final prodcutionofday = myType.finalproducts.values.where((test) =>
                test.actions
                    .get_Date_of_action(finalProdcutAction
                        .incert_finalProduct_from_cutingUnit.getactionTitle)
                    .formatt_yMd() ==
                DateTime.now().formatt_yMd());
            final alldensites =
                prodcutionofday.map((e) => e.item.density).toSet().toList();
            final totoal = prodcutionofday.isEmpty
                ? 0
                : prodcutionofday
                    .map((e) =>
                        e.item.H *
                        e.item.L *
                        e.item.W *
                        e.item.amount /
                        1000000)
                    .reduce((a, b) => a + b);
            final data = alldensites
                .map(
                  (t) => ChartData(
                      'D$t',
                      (prodcutionofday
                                  .where((test) => test.item.density == t)
                                  .map(
                                    (e) =>
                                        e.item.H *
                                        e.item.L *
                                        e.item.W *
                                        e.item.amount /
                                        1000000,
                                  )
                                  .reduce((a, b) => a + b) /
                              totoal *
                              100)
                          .toStringAsFixed(1)
                          .to_double()),
                )
                .toList();
            return SfCircularChart(
                title: ChartTitle(
                    text: 'الانتاج للكثافات  ${totoal.toStringAsFixed(1)} م3'),
                legend: const Legend(isVisible: true),
                series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                      dataSource: data,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      name: 'Data')
                ]);
          },
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final double y;
}

class data {
  data(this.volume, this.density);
  final double volume;
  final double density;
}
