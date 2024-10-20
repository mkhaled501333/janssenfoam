// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:pdf/widgets.dart';
import 'package:open_file/open_file.dart';
import 'package:intl/intl.dart' as d;

class FileHandleApi {
  static Future<File> saveDocument({required Document pdf}) async {
    String date = d.DateFormat('yyyy-MM-dd').format(DateTime.now());

    final bytes = await pdf.save();
    return Directory('/storage/emulated/0/A').create().then((value) {
      return File('${value.path}/${'$dateيومية المقصات.pdf'}')
          .writeAsBytes(bytes);
    });
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }
}
