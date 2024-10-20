import 'package:flutter/services.dart';

import '../../../../app/extentions.dart';

import '../../../../models/moderls.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class pdfinduserialSecurityr2 {
  static Future<Document> generate(
    Iterable<IndusterialSecurityModel> point1,
    Iterable<IndusterialSecurityModel> point2,
    Iterable<IndusterialSecurityModel> point3,
    Iterable<IndusterialSecurityModel> point4,
    Iterable<IndusterialSecurityModel> point5,
    Iterable<IndusterialSecurityModel> point6,
    Iterable<IndusterialSecurityModel> point7,
    Iterable<IndusterialSecurityModel> point8,
    Iterable<IndusterialSecurityModel> point9,
    Iterable<IndusterialSecurityModel> point10,
    Iterable<IndusterialSecurityModel> point11,
    Iterable<IndusterialSecurityModel> point12,
  ) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");

    var arabicFont = Font.ttf(data);
    final pdf = Document();
    const double inch = 72.0;
    const double cm = inch / 2.54;
    pdf.addPage(
      MultiPage(
        textDirection: TextDirection.rtl,
        theme: ThemeData(
            tableCell: TextStyle(font: arabicFont, fontSize: 10),
            defaultTextStyle: TextStyle(font: arabicFont, fontSize: 10)),
        pageFormat: const PdfPageFormat(21.0 * cm, 29.7 * cm, marginAll: 3),
        orientation: PageOrientation.landscape,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        maxPages: 60,
        margin: const EdgeInsets.symmetric(vertical: 8),
        build: (context) {
          return [
            SizedBox(height: 5),
            Center(
                child: Container(
              child: Text("التاريخ ${DateTime.now().formatt_yMd()}",
                  style: const TextStyle(
                    fontSize: 10,
                    decoration: TextDecoration.underline,
                  )),
            )),
            SizedBox(height: 5),
            Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  content(point1, "محطة مياه"),
                  content(point2, "غرفة محول"),
                  content(point3, "غرفة طلمبات"),
                  content(point4, "م الكيماويات"),
                  content(point5, "م التنكات"),
                  content(point6, "المعمل"),
                  content(point7, "الصبه"),
                  content(point8, "المنشر"),
                  content(point9, "م البلوكات"),
                  content(point10, "المقصات"),
                  content(point11, "البسكوب"),
                  content(point12, "ش خلفى"),
                ]))
          ];
        },
      ),
    );
    return pdf;
  }
}

content(Iterable<IndusterialSecurityModel> p, String tillte) => Padding(
      padding: const EdgeInsets.only(right: 3),
      child: Column(
        children: [
          Container(
            width: 60,
            decoration: BoxDecoration(
              color: PdfColors.grey,
              border: Border.all(width: .5),
            ),
            child: Center(
                child: Text(
              tillte,
              style: const TextStyle(fontSize: 7.5),
            )),
          ),
          Container(
            padding: const EdgeInsets.all(.7),
            width: 60,
            decoration: BoxDecoration(border: Border.all(width: .5)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ...p.map((e) {
                  return Container(
                      decoration: BoxDecoration(
                          color: p.toList().indexOf(e) != 0 &&
                                  (e.date.formatt_num().to_int() -
                                          p
                                              .elementAt(
                                                  p.toList().indexOf(e) - 1)
                                              .date
                                              .formatt_num()
                                              .to_int() >
                                      100)
                              ? PdfColors.grey400
                              : PdfColors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(e.who, style: const TextStyle(fontSize: 7.5)),
                          Text(
                            e.date.formatt_hm(),
                            style: const TextStyle(fontSize: 7.5),
                          ),
                        ],
                      ));
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 60,
                        decoration: const BoxDecoration(),
                        child: Center(
                            child: Text(
                          p.length.toString(),
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
