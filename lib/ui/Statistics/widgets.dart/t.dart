import 'package:flutter/material.dart';
import 'package:flutter_echart/flutter_echart.dart';

List<EChartPieBean> dataList = [
  EChartPieBean(title: "1", number: 200, color: Colors.lightBlueAccent),
  EChartPieBean(title: "2", number: 200, color: Colors.deepOrangeAccent),
  EChartPieBean(title: "3", number: 400, color: Colors.green),
  EChartPieBean(title: "4", number: 300, color: Colors.amber),
  EChartPieBean(title: "5", number: 200, color: Colors.orange),
];

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 215,
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: PieChatWidget(
          initSelect: 0,
          dataList: dataList,
          isLog: true,
          isBackground: true,
          isLineText: true,
          bgColor: Colors.white,
          isFrontgText: false,
          openType: OpenType.ANI,
          loopType: LoopType.NON,
        ),
      ),
    );
  }
}
