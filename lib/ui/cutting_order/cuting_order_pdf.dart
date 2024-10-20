import 'package:flutter/services.dart';
import '../../app/extentions.dart';
import '../../models/moderls.dart';
import 'cutting_ordera_viewModer.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class Cuting_order_pdf {
  CuttingOrderViewModel vm = CuttingOrderViewModel();
  Future<Document> generate(c, cutingOrder order) async {
    var data = await rootBundle.load("assets/fonts/HacenTunisia.ttf");
    final iconImage =
        (await rootBundle.load('assets/icon.png')).buffer.asUint8List();
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
            Padding(
                padding: const EdgeInsets.all(45),
                child: Column(children: [
                  Row(children: [
                    Image(
                      MemoryImage(iconImage),
                      height: 80,
                      width: 250,
                    ),
                    SizedBox(width: 30),
                    Column(children: [
                      Container(
                          color: PdfColors.grey,
                          child: Text(" تاريخ امر الشغل :  ")),
                      SizedBox(height: 20),
                      Container(
                          color: PdfColors.grey,
                          child: Text(
                              " تاريخ  التسليم : ${vm.date(order.dateTOOrder)}  ")),
                      SizedBox(height: 9),
                    ])
                  ]),
                  Column(children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text("امر تشغيل منتج تام",
                          style: const TextStyle(fontSize: 15)),
                    ),
                    Text("مسلسل: ${order.serial} ")
                  ]),
                  SizedBox(height: .3 * PdfPageFormat.mm),
                  Divider(),
                  SizedBox(height: 1 * PdfPageFormat.mm),
                  headerOfTitleOfItems2(),
                  Items2(order.items),
                  // total(invoices)
                ]))
          ];
        },
      ),
    );
    return pdf;
  }
}

headerOfTitleOfItems2() {
  TextStyle style = const TextStyle(fontSize: 18);
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 30,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: PdfColors.grey400,
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  child: Center(
                child: Text("الكميه", style: style),
              )),
              SizedBox(
                  child: Center(
                child: Text("كثافه", style: style),
              )),
              SizedBox(
                  child: Center(
                child: Text(" النوع ", style: style),
              )),
              SizedBox(
                  child: Center(
                child: Text("      لون ", style: style),
              )),
              SizedBox(
                  child: Center(
                child: Text("        مقاس        ", style: style),
              )),
            ].reversed.toList()),
      ));
}

Items2(List<OperationOrederItems> items) {
  TextStyle style = const TextStyle(fontSize: 19);
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
          children: items
              .map((e) => Container(
                    height: 40,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: PdfColors.grey100,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              child: Center(
                            child: Text("${e.Qantity}", style: style),
                          )),
                          SizedBox(
                              child: Center(
                            child: Text(e.density.toString(), style: style),
                          )),
                          SizedBox(
                              child: Center(
                            child: Text(e.type.toString(), style: style),
                          )),
                          SizedBox(
                              child: Center(
                            child: Text(e.color.toString(), style: style),
                          )),
                          SizedBox(
                              child: Center(
                            child: Text(
                                "${e.lenth.removeTrailingZeros}"
                                "*"
                                "${e.widti.removeTrailingZeros}"
                                "*"
                                "${e.hight.removeTrailingZeros}",
                                style: style),
                          )),
                        ].reversed.toList()),
                  ))
              .toList()));
}
