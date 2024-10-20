// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/controllers/biscol.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/finalProdcuts/invoices/invoice_controller.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/services/inviceForFinalProdct.dart';
import 'package:janssenfoam/services/pdfprevei.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';

import 'package:provider/provider.dart';

class InvicesView extends StatefulWidget {
  InvicesView({super.key});
  int index = 0;
  @override
  State<InvicesView> createState() => _InvicesViewState();
}

class _InvicesViewState extends State<InvicesView> {
  String chosenDate = format.format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.amber)),
                  onPressed: () {
                    setState(() {
                      widget.index = 0;
                    });
                  },
                  child: const Text(
                    "حموله و وزن",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              const Gap(9),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 255, 7, 77))),
                  onPressed: () {
                    setState(() {
                      widget.index = 1;
                    });
                  },
                  child: const Text(
                    "حمول فقط",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )),
              const Gap(9),
              TextButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      setState(() {
                        String formattedDate = format.format(pickedDate);
                        chosenDate = formattedDate;
                      });
                    } else {}
                  },
                  child: Text(
                    chosenDate,
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  )).permition(context, UserPermition.show_date_in_invoices),
            ],
          )
        ],
        // title: const Text("اذونات اليوم"),
      ),
      body: Consumer2<Invoice_controller, Hivecontroller>(
        builder: (context, myType, hivecontroller, child) {
          var allTickets = hivecontroller.allrecords.values.where((test) =>
              test.actions
                  .if_action_exist(WhigtTecketAction.archive_tecket.getTitle) ==
              false);
          List<Invoice> t = myType.invoices
              .where((element) =>
                  format.format(element.actions.get_Date_of_action(
                      InvoiceAction.creat_invoice.getTitle)) ==
                  chosenDate)
              .sortedBy<num>((element) => element.serial)
              .reversed
              .toList();
          return SingleChildScrollView(
            child: Column(
              children: [
                errmsg(context),
                if (widget.index == 0)
                  ...t.map((i) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpansionTile(
                          collapsedBackgroundColor:
                              const Color.fromARGB(255, 153, 211, 218),
                          backgroundColor:
                              const Color.fromARGB(255, 238, 118, 150),
                          title: title(t, i),
                          children: [
                            if (allTickets
                                .where((test) =>
                                    test.stockRequsition_serial == i.serial)
                                .isNotEmpty)
                              Visibility(
                                visible: allTickets
                                        .where((test) =>
                                            test.stockRequsition_serial ==
                                            i.serial)
                                        .isNotEmpty &&
                                    allTickets
                                        .where((test) =>
                                            test.stockRequsition_serial ==
                                            i.serial)
                                        .first
                                        .secondShotpiccam2Adress
                                        .isNotEmpty,
                                child: Image.network(
                                  'http://192.168.1.225:8080/i?imageid=${allTickets.where((test) => test.stockRequsition_serial == i.serial).first.secondShotpiccam2Adress}',
                                  width: 400,
                                  height: 400,
                                  fit: BoxFit.fill,
                                ),
                              ),
                          ],
                        ),
                      )),
                if (widget.index == 1)
                  ...t.map(
                    (e) => GestureDetector(
                      onTap: () {
                        permission().then((value) async {
                          finalProductInvoice
                              .generate(context, e)
                              .then((value) => context.gonext(
                                  context,
                                  PDfpreview(
                                    v: value.save(),
                                  )));
                        });
                      },
                      child: Card(
                        color: Colors.blue[100],
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                            child:
                                Text("${t.reversed.toList().indexOf(e) + 1}"),
                          ),
                          title: Column(
                            children: [
                              Text(
                                  'الوقت: ${formatwitTime3.format(e.actions.get_Date_of_action(InvoiceAction.creat_invoice.getTitle)).replaceAll(RegExp(r'PM'), 'م').replaceAll(RegExp(r'AM'), 'ص')}'),
                              Text(
                                  'عميل: ${e.items.isEmpty ? 0 : e.items.first.customer}'),
                              Text('تسلسل: ${e.serial}'),
                              Text('السائق : ${e.driverName}'),
                              Text('رقم العربه : ${e.carNumber}'),
                            ],
                          ),
                          subtitle: const Text('    '),
                          trailing: const Icon(Icons.print),
                        ),
                      ),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  Row title(List<Invoice> t, Invoice i) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          child: Text("${t.reversed.toList().indexOf(i) + 1}"),
        ),
        Text(i.driverName.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(i.carNumber.toString(),
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
