import 'dart:io';

import 'package:file_picker/file_picker.dart';

import '../../../../app/extentions.dart';
import '../../../../models/moderls.dart';
import '../../../../services/file_handle_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xcel;

Future<void> generateAndSaveExcel(List<BlockModel> blocks) async {
  final xcel.Workbook workbook = xcel.Workbook(); // create a new excel workbook
  final xcel.Worksheet sheet = workbook
      .worksheets[0]; // the sheet we will be populating (only the first sheet)

  sheet.getRangeByIndex(1, 1).setText('number');
  sheet.getRangeByIndex(1, 2).setText('code');
  sheet.getRangeByIndex(1, 3).setText('lenth');
  sheet.getRangeByIndex(1, 4).setText('whidth');
  sheet.getRangeByIndex(1, 5).setText('hight');
  sheet.getRangeByIndex(1, 6).setText('density');
  sheet.getRangeByIndex(1, 7).setText('color');
  sheet.getRangeByIndex(1, 8).setText('description');

  // loop through the results to set the data in the excel sheet cells
  for (var i in blocks) {
    sheet
        .getRangeByIndex(blocks.indexOf(i) + 2, 1)
        .setText(i.number.toString());
    sheet.getRangeByIndex(blocks.indexOf(i) + 2, 2).setText(i.serial);
    sheet
        .getRangeByIndex(blocks.indexOf(i) + 2, 3)
        .setText(i.item.L.removeTrailingZeros);
    sheet
        .getRangeByIndex(blocks.indexOf(i) + 2, 4)
        .setText(i.item.W.removeTrailingZeros);
    sheet
        .getRangeByIndex(blocks.indexOf(i) + 2, 5)
        .setText(i.item.H.removeTrailingZeros);
    sheet
        .getRangeByIndex(blocks.indexOf(i) + 2, 6)
        .setText(i.item.density.removeTrailingZeros);
    sheet.getRangeByIndex(blocks.indexOf(i) + 2, 7).setText(i.item.color);
    sheet.getRangeByIndex(blocks.indexOf(i) + 2, 8).setText(i.discreption);
  }

  // save the document in the downloads file
  final List<int> bytes = workbook.saveAsStream();

  if (Platform.isAndroid) {
    Directory? appDocDirectory = await getExternalStorageDirectory();

    File('${appDocDirectory!.path}/${blocks.first.serial} صبه.xlsx')
        .writeAsBytes(bytes)
        .then((value) => FileHandleApi.openFile(value));
  } else {
    String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Your File to desired location',
        fileName: ' ${blocks.first.serial} صبه');
    File('$outputFile .xlsx').writeAsBytes(bytes);
  }
}
