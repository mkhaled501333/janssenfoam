import 'package:flutter/services.dart';
import '../../../../app/extentions.dart';

import '../../../../models/moderls.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfBlockReport2 {
  static Future<Document> generate(c, List<BlockModel> blocks) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");

    var arabicFont = Font.ttf(data);
    final pdf = Document();
    const double inch = 72.0;
    const double cm = inch / 2.54;
    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData(
            tableCell: TextStyle(font: arabicFont, fontSize: 16),
            defaultTextStyle: TextStyle(font: arabicFont, fontSize: 12)),
        pageFormat: const PdfPageFormat(21.0 * cm, 29.7 * cm, marginAll: 3),
        orientation: PageOrientation.natural,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        build: (context) {
          return [
            Text(""),
            headerer(),
            dataa(blocks),
          ];
        },
      ),
    );
    return pdf;
  }
}

Widget headerer() {
  return Container(
    decoration: const BoxDecoration(color: PdfColors.blueGrey200),
    height: 30,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 40,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("م")),
        ),
        Container(
          width: 40,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("رقم")),
        ),
        Container(
          width: 95,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("كود")),
        ),
        Container(
          width: 40,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("كثافه")),
        ),
        Container(
          width: 40,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("لون")),
        ),
        Container(
          width: 40,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("طول")),
        ),
        Container(
          width: 40,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("عرض")),
        ),
        Container(
          width: 40,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("ارتفاع")),
        ),
        Container(
          width: 115,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("بيان")),
        ),
        Container(
          width: 100,
          decoration: BoxDecoration(border: Border.all(width: 1)),
          child: Center(child: Text("ملاحظات")),
        ),
      ],
    ),
  );
}

Widget dataa(List<BlockModel> blocks) {
  return Column(
      children: blocks
          .map((e) => Container(
                decoration: const BoxDecoration(color: PdfColors.white),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 40,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(child: Text("${blocks.indexOf(e) + 1}")),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(child: Text(e.number.toString())),
                    ),
                    Container(
                      width: 95,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(child: Text(e.serial)),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(child: Text(e.item.density.toString())),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(child: Text(e.item.color)),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(
                          child: Text(e.item.L.removeTrailingZeros.toString())),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(
                          child: Text(e.item.W.removeTrailingZeros.toString())),
                    ),
                    Container(
                      width: 40,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(
                          child: Text(e.item.H.removeTrailingZeros.toString())),
                    ),
                    Container(
                      width: 115,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(child: Text(e.discreption)),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      child: Center(child: Text(e.notes)),
                    ),
                  ],
                ),
              ))
          .toList());
}
