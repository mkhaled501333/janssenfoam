// ignore_for_file: camel_case_types, file_names

import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, Uint8List;
import 'package:csv/csv.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'extentions.dart';
import '../ui/finalProdcuts/final_product_controller.dart';
import '../models/moderls.dart';
import 'package:provider/provider.dart';

class bulkUpload extends StatefulWidget {
  const bulkUpload({super.key});

  @override
  State<bulkUpload> createState() => _bulkUploadState();
}

class _bulkUploadState extends State<bulkUpload> {
  List<List<dynamic>> _data = [];
  String? filePath;
  // This function is triggered when the  button is pressed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.white,
            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          title: const Text("Bulk Upload",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              )),
        ),
        body: Column(
          children: [
            errmsg(context),
            const Text(
              "هام:يجب ان يكون شيت الاكسل كالتالى مع حذف اول صف عند التصدير",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/namozag.png',
            ),
            ElevatedButton(
              child: const Text("Upload FIle"),
              onPressed: () {
                pickFile();
              },
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.red)),
              child: const Text(" incert This Data"),
              onPressed: () {
                if (_data.isNotEmpty) {
                  for (var e in _data) {
                    print(e);
                    context
                        .read<final_prodcut_controller>()
                        .updateFinalProdcut(FinalProductModel(
                            updatedat: DateTime.now().microsecondsSinceEpoch,
                            block_ID: 0,
                            fraction_ID: 0,
                            sapa_ID: "",
                            sapa_desc: "",
                            subfraction_ID: 0,
                            finalProdcut_ID:
                                DateTime.now().microsecondsSinceEpoch +
                                    e[4].toString().to_int(),
                            item: FinalProdcutItme(
                                L: e[0].toString().to_double(),
                                W: e[1].toString().to_double(),
                                H: e[2].toString().to_double(),
                                density: e[3].toString().to_double(),
                                volume: e[4].toString().to_double() *
                                    e[1].toString().to_double() *
                                    e[0].toString().to_double() *
                                    e[2].toString().to_double() /
                                    1000000,
                                theowight: e[3].toString().to_double() *
                                    e[4].toString().to_double() *
                                    e[1].toString().to_double() *
                                    e[0].toString().to_double() *
                                    e[2].toString().to_double() /
                                    1000000,
                                realowight: 0.0,
                                color: e[6],
                                type: e[7].toString(),
                                amount: e[4].toString().to_int(),
                                priceforamount: 0.0),
                            scissor: 0,
                            stage: 0,
                            invoiceNum: 0,
                            customer: e[5],
                            worker: "",
                            notes: e[8],
                            cuting_order_number: 0,
                            actions: [
                              finalProdcutAction
                                  .incert_finalProduct_from_Others.add,
                              finalProdcutAction
                                  .recive_Done_Form_FinalProdcutStock.add,
                            ]));
                  }
                }
                setState(() {
                  _data.clear();
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Table(
                      border: TableBorder.all(),
                      children: _data
                          .map((e) => TableRow(
                              children: e
                                  .map((f) => Center(child: Text(f)))
                                  .toList()))
                          .toList(),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      List<List<dynamic>> rowdetail = [];

      Uint8List bytes = File(result.files.single.path!).readAsBytesSync();
      Excel excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          rowdetail.addAll([row.map((e) => e!.value.toString()).toList()]);
        }
      }

      print(rowdetail);
      setState(() {
        _data = rowdetail;
      });

      // return File(result.files.single.path!);
    } else {
      print("No file selected");
    }
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    print(result.files.first.name);
    filePath = result.files.single.path!;

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    print(fields);

    setState(() {
      _data = fields;
    });
  }
}
