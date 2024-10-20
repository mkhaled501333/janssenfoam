import 'package:collection/collection.dart';
import 'package:flutter/services.dart';
import 'package:janssenfoam/ui/reports/All_reports_veiwModel.dart';
import '../../../../app/extentions.dart';
import '../../../../models/moderls.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class Pdf2ForR {
  static Future<Document> generate(
      c,
      List<int> allStages1,
      List<int> allStages2,
      List<int> allStages3,
      AllReportsViewModel vm,
      List<FractionModel> fractions1,
      List<FractionModel> fractions2,
      List<FractionModel> fractions3,
      List<FinalProductModel> finalProdcuts1,
      List<FinalProductModel> finalProdcuts2,
      List<FinalProductModel> finalProdcuts3,
      chosenDate) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");
    var arabicFont = Font.ttf(data);
    final pdf = Document();
    const double inch = 72.0;
    const double cm = inch / 2.54;
    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData(
            tableCell: TextStyle(font: arabicFont, fontSize: 13),
            defaultTextStyle: TextStyle(font: arabicFont, fontSize: 10)),
        pageFormat: const PdfPageFormat(21.0 * cm, 29.7 * cm, marginAll: 3),
        orientation: PageOrientation.natural,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        build: (context) {
          return [
            SizedBox(height: 10),
            newMethod(
                c, allStages1, vm, 1, fractions1, finalProdcuts1, chosenDate),
            newMethod(
                c, allStages2, vm, 2, fractions2, finalProdcuts2, chosenDate),
            newMethod(
                c, allStages3, vm, 3, fractions3, finalProdcuts3, chosenDate),
          ];
        },
      ),
    );
    return pdf;
  }
}

newMethod(
    context,
    List<int> allStages,
    AllReportsViewModel vm,
    int scissor,
    List<FractionModel> fractions,
    List<FinalProductModel> finalProdcuts,
    String chosenDate) {
  return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        children: [
          Container(
              child: Column(children: [
            Center(
                child: Container(
                    decoration: const BoxDecoration(color: PdfColors.grey500),
                    child: Text("يومية المقصات  الدائرى ($scissor)$chosenDate",
                        style: const TextStyle(fontSize: 14)))),
            Center(
                child: Container(
                    decoration: const BoxDecoration(color: PdfColors.grey500),
                    child: Text("تفصيلى كل دور دائرى($scissor)",
                        style: const TextStyle(fontSize: 14)))),
            Table(
              border: TableBorder.all(width: 1, color: PdfColors.black),
              columnWidths: const {
                0: FlexColumnWidth(2.4),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(.4),
              },
              children: [
                TableRow(
                    decoration: const BoxDecoration(color: PdfColors.amber),
                    children: [
                      Center(child: Text("دون التام")),
                      Center(child: Text("الناتج")),
                      Center(child: Text("الوارد")),
                      Center(child: Text("دور")),
                    ])
              ],
            ),
            Table(
              border: TableBorder.all(width: 1, color: PdfColors.black),
              columnWidths: const {
                0: FlexColumnWidth(2.4),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(.4),
              },
              children: allStages
                  .toSet()
                  .toList()
                  .sortedBy<num>((element) => element)
                  .map((k) => TableRow(
                        children: [
                          Center(child: Text("$k")),
                          //الوارد
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: vm
                                .getIncomingOnScissor(
                                    context,
                                    scissor,
                                    fractions
                                        .where(
                                            (element) => element.stagenum == k)
                                        .toList())
                                .map((e) => Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: PdfColors.grey400,
                                          child: Text(
                                              "حجم${(e.total * e.voluem / 1000000).toStringAsFixed(1)}"),
                                        ),
                                        Text(e.descrioption),
                                        Text("من"),
                                        Text("${e.total}"),
                                      ].reversed.toList(),
                                    )))
                                .toList(),
                          ),
                          //التام
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: vm
                                .totalAndDescriptionOfFinal(
                                    context, finalProdcuts, k, scissor)
                                .map((e) => Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          color: PdfColors.grey400,
                                          child: Text(
                                              "حجم${(e.total * e.volume).toStringAsFixed(1)}"),
                                        ),
                                        Text(e.description),
                                        Text("من"),
                                        Text("${e.total}"),
                                      ].reversed.toList(),
                                    )))
                                .toList(),
                          ),
                          //دون التام
                          Row(
                            children: fractions
                                .where((element) => element.stagenum == k)
                                .toList()
                                .map((f) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: PdfColors.grey200,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              child: Text(
                                                ""
                                                // ${f.type} kg ${fractions.where((element) => element.stage == k).expand((s) => s.notfinals).where((element) => element.type == f.type).map((e) => e.wight).reduce((n, m) => n + m).removeTrailingZeros}
                                                ,
                                              ),
                                            ),
                                          ].reversed.toList(),
                                        ))))
                                .toList(),
                          )
                        ].reversed.toList(),
                      ))
                  .toList(),
            ),
            Center(
                child: Container(
                    decoration: const BoxDecoration(color: PdfColors.grey500),
                    child:
                        Text("اجمالى", style: const TextStyle(fontSize: 14)))),
            Table(
              border: TableBorder.all(width: 1, color: PdfColors.black),
              columnWidths: const {
                0: FlexColumnWidth(1.3),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(.3),
              },
              children: [
                TableRow(
                    decoration: const BoxDecoration(color: PdfColors.amber),
                    children: [
                      Center(child: Text("اجمالى دون التام")),
                      Center(child: Text("اجمالى الناتج")),
                      Center(child: Text("اجمالى الوارد")),
                    ])
              ],
            ),
            Table(
              border: TableBorder.all(width: 1, color: PdfColors.black),
              columnWidths: const {
                0: FlexColumnWidth(1.3),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(3),
                3: FlexColumnWidth(.3),
              },
              children: [
                TableRow(
                  children: [
                    //الوارد
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: vm
                          .getIncomingOnScissor(context, scissor, fractions)
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: PdfColors.grey400,
                                      child: Text(
                                          "حجم${(e.total * e.voluem / 1000000).toStringAsFixed(1)}"),
                                    ),
                                    Text(e.descrioption),
                                    Text("من"),
                                    Text("${e.total}"),
                                  ].reversed.toList(),
                                ),
                              ))
                          .toList(),
                    ),

                    // التام

                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: vm
                          .totalAndDescriptionOfFinalWithNoStage(
                              context, finalProdcuts, scissor)
                          .map((e) => Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color: PdfColors.grey400,
                                      child: Text(
                                          "حجم${(e.total * e.volume).toStringAsFixed(1)}"),
                                    ),
                                    Text(e.description),
                                    Text("من"),
                                    Text("${e.total}"),
                                  ].reversed.toList(),
                                ),
                              ))
                          .toList(),
                    ),
                    //دون التام
                    Column(
                      children: fractions
                          .toList()
                          .map((f) => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Text(
                                      ""
                                      // ${f.type} kg ${fractions.expand((s) => s.notfinals).where((element) => element.type == f.type).map((e) => e.wight).reduce((n, m) => n + m).removeTrailingZeros}
                                      ,
                                    ),
                                  ),
                                ].reversed.toList(),
                              ))
                          .toList(),
                    )
                  ].reversed.toList(),
                ),
                TableRow(
                    decoration: const BoxDecoration(color: PdfColors.grey),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                            "${vm.getIncomingOnScissor(context, scissor, fractions).map((e) => e.total * e.voluem / 1000000).isEmpty ? 0 : vm.getIncomingOnScissor(context, scissor, fractions).map((e) => e.total * e.voluem / 1000000).reduce((a, b) => a + b).removeTrailingZeros}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                              "${vm.totalAndDescriptionOfFinalWithNoStage(context, finalProdcuts, scissor).map((e) => e.volume * e.total).isEmpty ? 0 : vm.totalAndDescriptionOfFinalWithNoStage(context, finalProdcuts, scissor).map((e) => e.volume * e.total).reduce((a, b) => a + b).removeTrailingZeros}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Text(
                              " kg "
                              // ${fractions.expand((s) => s.notfinals).map((e) => e.wight).isEmpty ? "0" : fractions.expand((s) => s.notfinals).map((e) => e.wight).reduce((n, m) => n + m).removeTrailingZeros}
                              ,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17)),
                        ),
                      ),
                    ].reversed.toList())
              ],
            ),
          ])),
        ],
      ));
}
