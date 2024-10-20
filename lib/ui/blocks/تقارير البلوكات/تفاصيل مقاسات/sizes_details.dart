// ignore_for_file: must_be_immutable
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/services/pdfprevei.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/ui/blocks/%D8%AA%D9%82%D8%A7%D8%B1%D9%8A%D8%B1%20%D8%A7%D9%84%D8%A8%D9%84%D9%88%D9%83%D8%A7%D8%AA/%D8%AA%D9%81%D8%A7%D8%B5%D9%8A%D9%84%20%D9%85%D9%82%D8%A7%D8%B3%D8%A7%D8%AA/pdf2.dart';
import 'package:janssenfoam/ui/blocks/reportsForBlock/Bolck_reports_viewModel.dart';
import 'package:provider/provider.dart';

class blocksSizesDetials extends StatefulWidget {
  const blocksSizesDetials({super.key});

  @override
  State<blocksSizesDetials> createState() => _blocksSizesDetialsState();
}

class _blocksSizesDetialsState extends State<blocksSizesDetials> {
  BlockReportsViewModel vm = BlockReportsViewModel();

  String chosenDate = format.format(DateTime.now());

  bool? showVolume = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, myType, child) {
        List<BlockModel> blocks = myType.filterblocksBalanceBetweenTowDates2();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            errmsg(context),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(' setting ?'),
                              content: SizedBox(
                                height: 350,
                                child: Column(children: [
                                  const Divider(
                                    height: 30,
                                    thickness: 5,
                                    color: Colors.black,
                                  ),
                                  CheckboxListTile(
                                    title: const Text("عرض الحجم"),
                                    value: showVolume,
                                    onChanged: (newValue) {
                                      setState(() {
                                        showVolume = newValue;
                                        Navigator.pop(context);
                                      });
                                    },
                                    controlAffinity: ListTileControlAffinity
                                        .leading, //  <-- leading Checkbox
                                  )
                                ]),
                              ),
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('تم')),
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.settings)),
                TextButton(
                    onPressed: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      if (pickedDate != null) {
                        chosenDate = format.format(pickedDate);
                        myType.initialDateRange2 = pickedDate.formatToInt();
                        myType.filterblocksBalanceBetweenTowDates2();
                        myType.Refresh_the_UI();
                      } else {}
                    },
                    child: Text(
                      chosenDate,
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )),
                IconButton(
                    onPressed: () {
                      permission().then((value) async {
                        PdfBlockReport3.generate(context, blocks, showVolume)
                            .then((value) => context.gonext(
                                context,
                                PDfpreview(
                                  v: value.save(),
                                )));
                      });
                    },
                    icon: const Icon(Icons.picture_as_pdf)),
              ],
            ),
            const Text("تفاصيل مقاسات مخزن البلوكات"),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: blocks
                  .filter_filter_type_and_density_color()
                  .sortedBy<num>((element) => element.item.density)
                  .map((e) => Column(
                        children: [
                          //الجزء الاصفر
                          Container(
                              width: MediaQuery.of(context).size.width * .7,
                              decoration:
                                  const BoxDecoration(color: Colors.amber),
                              child: Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    showVolume == false
                                        ? const SizedBox()
                                        : Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Colors.black,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  "volume: ${vm.sizes(e, blocks).isEmpty ? 0 : vm.sizes(e, blocks).map((e) => e.item.L * e.item.W * e.item.H / 1000000).reduce((a, b) => a + b).toStringAsFixed(1)} ",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                    Text(
                                      vm.sizes(e, blocks).length.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "ك${e.item.density.removeTrailingZeros}  ${e.item.type}  ${e.item.color}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ))),

                          SizedBox(
                            width: MediaQuery.of(context).size.width * .7,
                            child: Table(
                              border: TableBorder.all(width: 2),
                              children: vm
                                  .sizes(e, blocks)
                                  .filter_filter_type_density_color_size()
                                  .sortedBy<num>((element) =>
                                      element.item.W *
                                      element.item.H *
                                      element.item.L)
                                  .map((r) => TableRow(children: [
                                        Center(
                                          child: Text(
                                            "${vm.total_amount_for_single_siz__(r, blocks)} ",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Center(
                                            child: Text(
                                              "${r.item.L.removeTrailingZeros}*${r.item.W.removeTrailingZeros}",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ]))
                                  .toList(),
                            ),
                          ),
                        ],
                      ))
                  .toList(),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "      grand total :  ${blocks.length} ",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            showVolume == false
                ? const SizedBox()
                : Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "grand volume : ${blocks.isEmpty ? 0 : blocks.map((e) => e.item.L * e.item.W * e.item.H / 1000000).reduce((a, b) => a + b).toStringAsFixed(1)} ",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 20,
            )
          ],
        );
      },
    );
  }
}
