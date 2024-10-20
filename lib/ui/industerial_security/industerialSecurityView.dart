import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/strings_manager.dart';
import 'package:janssenfoam/ui/industerial_security/industerialSecurityController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/ui/industerial_security/report2.dart';
import 'package:janssenfoam/ui/industerial_security/reports.dart';
import 'package:janssenfoam/ui/industerial_security/senor.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class InsusterialSecurityView extends StatelessWidget {
  InsusterialSecurityView({super.key});
  final MobileScannerController controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.yellow.shade400),
              child: TextButton(
                  onPressed: () {
                    context.gonext(context, const IndusterialSecutityReport2());
                  },
                  child: const Text(
                    "2تقرير",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.yellow.shade400),
              child: TextButton(
                  onPressed: () {
                    context.gonext(context, const IndusterialSecurityReport());
                  },
                  child: const Text(
                    "تقرير",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.yellow.shade400),
              child: TextButton(
                  onPressed: () {
                    context.gonext(context, const Sensor());
                  },
                  child: const Text(
                    "مستوى الخزان",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 0, 0),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
            ),
          ),
          const Gap(15),
        ],
      ),
      body: Consumer<IndusterialSecuritycontroller>(
        builder: (context, myType, child) {
          return Column(
            children: [
              errmsg(context),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 270,
                child: MobileScanner(
                  controller: controller,
                  onDetect: (a) async {
                    postrecord(myType, a.barcodes.first.rawValue!);
                    controller.stop();
                  },
                ),
              ),
              buttoms(controller: controller),
              const Header(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: myType.all.values
                        .where((test) =>
                            test.date.formatt_yMd() ==
                            DateTime.now().formatt_yMd())
                        .map((e) => DataRow(
                            record: e,
                            index: myType.all.values.toList().indexOf(e)))
                        .toList(),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void postrecord(IndusterialSecuritycontroller myType, String point) {
    if (point.to_int() == 1) {
      post(myType, point, 122, 1901);
    } else if (point.to_int() == 2) {
      post(myType, point, 122, 701);
    } else if (point.to_int() == 3) {
      post(myType, point, 122, 401);
    } else if (point.to_int() == 4) {
      post(myType, point, 4, 2501);
    } else if (point.to_int() == 5) {
      post(myType, point, 21, 1501);
    } else if (point.to_int() == 6) {
      post(myType, point, 21, 801);
    } else if (point.to_int() == 7) {
      post(myType, point, 21, 1701);
    } else if (point.to_int() == 8) {
      post(myType, point, 4, 2701);
    } else if (point.to_int() == 9) {
      post(myType, point, 62, 101);
    } else if (point.to_int() == 10) {
      post(myType, point, 90, 2201);
    } else if (point.to_int() == 11) {
      post(myType, point, 90, 101);
    } else if (point.to_int() == 12) {
      post(myType, point, 4, 1401);
    } else {}
  }

  post(IndusterialSecuritycontroller myType, String point, int ip, int cam) {
    myType.getImageFromCamera(ip, cam).then((e) {
      var record = IndusterialSecurityModel(
          ID: DateTime.now().microsecondsSinceEpoch,
          date: DateTime.now(),
          who: SringsManager.myemail,
          place: point,
          ImageId: DateTime.now().millisecondsSinceEpoch,
          image: e,
          note: 'لا يوجد');
      myType.postRecord(record);
    });
  }
}

class buttoms extends StatelessWidget {
  const buttoms({
    super.key,
    required this.controller,
  });

  final MobileScannerController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
            onPressed: () {
              controller.toggleTorch();
            },
            icon: const Icon(Icons.flashlight_off)),
        ElevatedButton(
            onPressed: () {
              controller.start();
            },
            child: const Text('ابدء')),
        ElevatedButton(
            onPressed: () {
              controller.stop();
            },
            child: const Text('اغلق')),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key});
  final color = const Color.fromARGB(255, 111, 191, 216);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            color: color,
            borderRadius: BorderRadius.circular(11)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            cell('النقطه', 70),
            cell('', 70),
            cell('ملاحظات', 70),
          ].reversed.toList(),
        ),
      ),
    );
  }

  SizedBox cell(String tittle, double width) => SizedBox(
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Center(
            child: Text(
              tittle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );
}

class DataRow extends StatelessWidget {
  const DataRow({
    super.key,
    required this.record,
    required this.index,
  });
  final IndusterialSecurityModel record;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(),
            color: index % 2 == 0
                ? const Color.fromARGB(255, 205, 226, 241)
                : const Color.fromARGB(255, 243, 220, 143)),
        child: IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    record.place,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    record.who,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    record.date.formatt2(),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Text(
                record.note,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ].reversed.toList(),
          ),
        ),
      ),
    );
  }
}
