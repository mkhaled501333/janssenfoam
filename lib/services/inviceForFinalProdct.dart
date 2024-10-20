// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as d;
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class finalProductInvoice {
  static Future<Document> generate(c, Invoice invoices) async {
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
        footer: foter(invoices),
        build: (context) {
          return [
            Padding(
                padding: const EdgeInsets.all(45),
                child: Column(children: [
                  Row(children: [
                    Image(
                      MemoryImage(iconImage),
                      height: 60,
                      width: 210,
                    ),
                  ]),
                  Column(children: [
                    Text("stock requisition order",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                    Text("serial: ${invoices.serial}",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold)),
                  ]),
                  SizedBox(height: .3 * PdfPageFormat.mm),
                  Divider(),
                  SizedBox(height: 1 * PdfPageFormat.mm),
                  headerOfTitleOfItems(),
                  Items(invoices.items),
                  total(invoices)
                ]))
          ];
        },
      ),
    );
    return pdf;
  }
}

headerOfTitleOfItems() {
  TextStyle style = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 40,
        margin: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(
          color: PdfColors.grey400,
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          SizedBox(
              child: Center(
            child: Text("Quantity", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text("wight ", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text(" density ", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text("  color ", style: style),
          )),
          SizedBox(
              child: Center(
            child: Text("        size      ", style: style),
          )),
        ]),
      ));
}

Items(List<InvoiceItem> items) {
  TextStyle style = const TextStyle(fontSize: 19);
  return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
          children: items
              .map((e) => Container(
                    height: 30,
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      color: PdfColors.grey100,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                              child: Center(
                            child: Text("${e.quantity * -1}", style: style),
                          )),
                          SizedBox(
                              child: Center(
                            child: Text(e.theoriticalWight.toString(),
                                style: style),
                          )),
                          SizedBox(
                              child: Center(
                            child: Text(e.density.toString(), style: style),
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
                                "${e.width.removeTrailingZeros}"
                                "*"
                                "${e.hight.removeTrailingZeros}",
                                style: style),
                          )),
                        ]),
                  ))
              .toList()));
}

total(Invoice invoice) {
  double totalWightAmount = double.parse(invoice.items
      .map((e) => e.theoriticalWight)
      .reduce((a, b) => a + b)
      .removeTrailingZeros);
  return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(children: [
        Divider(),
        Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Spacer(flex: 6),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Total wight  ',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Text(
                          '$totalWightAmount',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2 * PdfPageFormat.mm),
                    Container(height: 1, color: PdfColors.grey400),
                    SizedBox(height: 0.5 * PdfPageFormat.mm),
                    Container(height: 1, color: PdfColors.grey400),
                  ],
                ),
              ),
            ],
          ),
        ),
      ]));
}

foter(Invoice invoice) {
  return (context) => Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Column(children: [
              SizedBox(height: 2 * PdfPageFormat.mm),
              Text(
                'Billed To : ${invoice.items.first.customer} ',
              ),
              SizedBox(height: 1 * PdfPageFormat.mm),
              Text(
                'Date : ${d.DateFormat('dd-MM-yy/hh:mm a').format(invoice.actions.get_Date_of_action(InvoiceAction.creat_invoice.getTitle))}',
              ),
              SizedBox(height: 1 * PdfPageFormat.mm),
            ]),
            SizedBox(width: 30),
            Column(children: [
              SizedBox(height: 2 * PdfPageFormat.mm),
              Text(
                'driver name : ${invoice.driverName} ',
              ),
              SizedBox(height: 1 * PdfPageFormat.mm),
              Text(
                'dispatcher : ${invoice.dispatcher}',
              ),
              SizedBox(height: 1 * PdfPageFormat.mm),
            ]),
            SizedBox(width: 30),
            Column(children: [
              SizedBox(height: 2 * PdfPageFormat.mm),
              Text(
                'car number : ${invoice.carNumber} ',
              ),
              SizedBox(height: 1 * PdfPageFormat.mm),
            ]),
          ]),
        ],
      ));
}
