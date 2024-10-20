import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

Future<Document> generateForPurche(Uint8List iconImage) async {
  var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");
  final logo = (await rootBundle.load('assets/icon.png')).buffer.asUint8List();
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
      footer: foter(iconImage),
      build: (context) {
        return [
          Padding(
              padding: const EdgeInsets.all(45),
              child: Column(children: [
                Row(children: [
                  Container(
                      height: 200,
                      child: Image(
                        MemoryImage(logo),
                        height: 300,
                        width: 100,
                      )),
                  SizedBox(width: 99),
                  Text(" طلب شراء (1)", style: const TextStyle(fontSize: 14)),
                ]),
                SizedBox(height: .3 * PdfPageFormat.mm),
                Divider(),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("الادراه الطالبه :",
                            style: const TextStyle(fontSize: 14)),
                        Text("ادارة المشتريات ",
                            style: const TextStyle(fontSize: 14)),
                        Text("تحيه طيبه وبعد",
                            style: const TextStyle(fontSize: 14)),
                        Text("برجاء التفضل باننا بحاجه الى :-",
                            style: const TextStyle(fontSize: 14)),
                      ])
                ])
              ]))
        ];
      },
    ),
  );
  return pdf;
}

foter(Uint8List iconImage) {
  return (context) => Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(children: [
              Text("مدير المصنع", style: const TextStyle(fontSize: 14)),
              Image(
                MemoryImage(iconImage),
                height: 160,
                width: 120,
              )
            ]),
            Column(children: [
              Text(" المدير المالى", style: const TextStyle(fontSize: 14)),
              Image(
                MemoryImage(iconImage),
                height: 160,
                width: 120,
              )
            ]),
            Column(children: [
              Text(" اسم الطالب", style: const TextStyle(fontSize: 14)),
              Image(
                MemoryImage(iconImage),
                height: 160,
                width: 120,
              )
            ]),
          ].reversed.toList()));
}



