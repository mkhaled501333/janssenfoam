import 'dart:convert';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle, Uint8List;
import 'package:csv/csv.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';

import 'package:provider/provider.dart';

class bulkUploadForblocks extends StatefulWidget {
  const bulkUploadForblocks({super.key});

  @override
  State<bulkUploadForblocks> createState() => _bulkUploadState();
}

class _bulkUploadState extends State<bulkUploadForblocks> {
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
              'assets/1234.png',
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
                int x = 0;
                if (_data.isNotEmpty) {
                  for (var e in _data) {
                    print('val $e');
                    BlockWetOutput wetOutPut = BlockWetOutput(
                        L: 0, W: 0, H: 0, density: 0, volume: 0, wight: 0);
                    context.read<BlockFirebasecontroller>().addblock(BlockModel(
                        Block_Id: DateTime.now().microsecondsSinceEpoch + x++,
                        number: e[0].toString().to_int(),
                        serial: e[1],
                        Rcissor: 0,
                        Hscissor: 0,
                        cumingFrom: "الصبه",
                        OutTo: "",
                        notes: e[11],
                        discreption: e[10],
                        item: Itme(
                            L: e[2].toString().to_double(),
                            W: e[3].toString().to_double(),
                            H: e[4].toString().to_double(),
                            density: e[5].toString().to_double(),
                            volume: e[9].toString().to_double(),
                            wight: e[8].toString().to_double(),
                            color: e[6],
                            type: e[7],
                            price: 0),
                        wetOutPut: wetOutPut,
                        fractions: [],
                        actions: [BlockAction.create_block.add],
                        notFinals: [],
                        updatedat: DateTime.now().microsecondsSinceEpoch));
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
