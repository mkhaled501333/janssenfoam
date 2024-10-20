import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/Statistics/utiles/utilies.dart';

import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RoundedSessorStatistics extends StatelessWidget {
  const RoundedSessorStatistics({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.mainTextColor2,
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
            final totoal =
                prodcutionofday.isEmpty ? 0 : prodcutionofday.totalVolume();
            final R1 =
                prodcutionofday.where((e) => e.scissor == 4).totalVolume();
            final R2 =
                prodcutionofday.where((e) => e.scissor == 5).totalVolume();
            final R3 =
                prodcutionofday.where((e) => e.scissor == 6).totalVolume();
            return SfCircularChart(
                title: ChartTitle(
                    text: 'الانتاج للدائرى : ${totoal.toStringAsFixed(1)} م3'),
                legend: const Legend(isVisible: true),
                series: <CircularSeries>[
                  PieSeries<ChartData, String>(
                      dataSource: [
                        ChartData(
                            "الدائرى الاول",
                            ((R1 / totoal) * 100)
                                .toStringAsFixed(1)
                                .to_double()),
                        ChartData(
                            "الدائرى الثانى",
                            ((R2 / totoal) * 100)
                                .toStringAsFixed(1)
                                .to_double()),
                        ChartData(
                            "الدائرى الثالث",
                            ((R3 / totoal) * 100)
                                .toStringAsFixed(1)
                                .to_double()),
                      ],
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

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}

extension DF on Iterable<FinalProductModel> {
  double totalVolume() {
    return isEmpty
        ? 0.0
        : map((e) => e.item.H * e.item.L * e.item.W * e.item.amount / 1000000)
            .reduce((a, b) => a + b);
  }
}
