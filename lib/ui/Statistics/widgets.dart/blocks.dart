import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/ui/blocks/blocksView.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsBlocks extends StatelessWidget {
  const StatisticsBlocks({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(179, 252, 232, 232),
      child: SizedBox(
        height: 200,
        child: Consumer<BlockFirebasecontroller>(
          builder: (c, myType, child) {
            final prodcutionofday = myType.blocks.values.where((test) =>
                test.actions
                    .get_Date_of_action(
                        BlockAction.consume_block.getactionTitle)
                    .formatt_yMd() ==
                DateTime.now().formatt_yMd());
            final alldensites =
                prodcutionofday.map((e) => e.item.density).toSet().toList();
            final totoal = prodcutionofday.isEmpty ? 0 : prodcutionofday.length;
            final data = alldensites.map((t) {
              final x = prodcutionofday
                  .where((test) => test.item.density == t)
                  .length;
              return ChartData(
                'D$t =>${prodcutionofday.where((test) => test.item.density == t).length}',
                ((x / totoal) * 100).toDouble(),
              );
            }).toList();

            return Stack(
              children: [
                SfCircularChart(
                    title: ChartTitle(
                        text: 'صرف البلوكات  عدد ${prodcutionofday.length}'),
                    legend: const Legend(isVisible: true),
                    series: <CircularSeries>[
                      PieSeries<ChartData, String>(
                          dataSource: data,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          name: 'Data')
                    ]),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          context.gonext(context, blocksView());
                        },
                        icon: const Icon(Icons.open_in_browser_outlined))
                  ],
                ),
              ],
            );
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
