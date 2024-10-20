// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, unused_element

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/services/file_handle_api.dart';

import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

TextStyle textstyle11 =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
Future<void> createAndopenEXL(
  GlobalKey<SfDataGridState> mkey,
) async {
  permission();
  Directory? appDocDirectory = await getExternalStorageDirectory();

  final Workbook workbook = Workbook();
  final Worksheet worksheet = workbook.worksheets[0];
  mkey.currentState!.exportToExcelWorksheet(worksheet);
  final List<int> bytes = workbook.saveAsStream();
  File('${appDocDirectory!.path}/${formatwitTime2.format(DateTime.now())}تفاصيل البلوكات.xlsx')
      .writeAsBytes(bytes, flush: true)
      .then((value) => FileHandleApi.openFile(value));
}

class Block_detaild_view extends StatelessWidget {
  Block_detaild_view();

  var columns = <GridColumn>[
    GridColumn(
        visible: false,
        allowFiltering: true,
        columnName: 'id',
        label: Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              'ID',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'size',
        label: Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              'المقاس',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'color',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'لون',
              style: textstyle11,
              overflow: TextOverflow.ellipsis,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'density',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'كثافه',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'type',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'نوع',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'serial',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'كود',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'description',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'وصف',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'wight',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'وزن',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'num',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'رقم',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'date',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'تاريخ الصرف',
              style: textstyle11,
            ))),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfDataGridState> kkkkk = GlobalKey<SfDataGridState>();

    return Consumer<BlockFirebasecontroller>(builder: (context, blocks, child) {
      return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.date_range)),
              IconButton(
                onPressed: () async {
                  createAndopenEXL(kkkkk);
                },
                icon: const Icon(Icons.explicit_outlined),
              ),
            ],
          ),
          body: ScrollConfiguration(
            behavior: const ScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: 1000,
                child: SfDataGrid(
                  tableSummaryRows: [
                    GridTableSummaryRow(
                        showSummaryInRow: true,
                        title: 'Total  Count: {Count}',
                        titleColumnSpan: 3,
                        columns: [
                          const GridSummaryColumn(
                              name: 'Count',
                              columnName: 'num',
                              summaryType: GridSummaryType.count),
                        ],
                        position: GridTableSummaryRowPosition.top),
                  ],
                  allowSwiping: true,
                  swipeMaxOffset: 100.0,
                  endSwipeActionsBuilder:
                      (BuildContext context, DataGridRow row, int rowIndex) {
                    return GestureDetector(
                        onTap: () {
                          var b = blocks.blocks.values
                              .toList()
                              .where((element) =>
                                  element.Block_Id ==
                                  row.getCells().first.value)
                              .first;
                          b.actions.add(BlockAction.archive_block.add);
                          blocks.updateBlock(b);
                        },
                        child: Container(
                            color: Colors.redAccent,
                            child: const Center(
                              child: Icon(Icons.delete),
                            ))).permition(
                        context, UserPermition.delete_in_finalprodcut_details);
                  },
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                  allowEditing: permitionss(
                      context, UserPermition.allow_edit_in_details_blocks),
                  selectionMode: SelectionMode.multiple,
                  navigationMode: GridNavigationMode.cell,
                  isScrollbarAlwaysShown: true,
                  key: kkkkk,
                  allowSorting: true,
                  allowMultiColumnSorting: true,
                  allowTriStateSorting: true,
                  allowFiltering: true,
                  source: EmployeeDataSource22(context,
                      coumingData: blocks.blocks.values.toList()),
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: columns,
                ),
              ),
            ),
          ));
    });
  }
}

dynamic newCellValue;
TextEditingController editingController = TextEditingController();

class EmployeeDataSource22 extends DataGridSource {
//DataGridRowهنا تحويل البيانات الى قائمه من
  EmployeeDataSource22(
    this.context, {
    required List<BlockModel> coumingData,
  }) {
    data = coumingData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.Block_Id),
              DataGridCell<String>(
                  columnName: 'size',
                  value:
                      "${e.item.H.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}"),
              DataGridCell<String>(columnName: 'color', value: e.item.color),
              DataGridCell<double>(
                  columnName: 'density', value: e.item.density),
              DataGridCell<String>(columnName: 'type', value: e.item.type),
              DataGridCell<String>(columnName: 'serial', value: e.serial),
              DataGridCell<String>(
                  columnName: 'description', value: e.discreption),
              DataGridCell<double>(columnName: 'wight', value: e.item.wight),
              DataGridCell<int>(columnName: 'num', value: e.number),
              DataGridCell<String>(
                  columnName: 'date',
                  value: e.actions.if_action_exist(
                          BlockAction.consume_block.getactionTitle)
                      ? DateFormat('yyyy/MM/dd').format(e.actions
                          .get_Date_of_action(
                              BlockAction.consume_block.getactionTitle))
                      : '0 غير مصروف '),
            ]))
        .toList();
    data2 = coumingData;
  }
  final BuildContext context;

  List<DataGridRow> data = [];
  List<BlockModel> data2 = [];

  @override
  List<DataGridRow> get rows => data;
  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(summaryValue),
    );
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value
            ?.toString() ??
        '';
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhereOrNull((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            ?.value ??
        '';

    final int dataRowIndex = data.indexOf(dataGridRow);
    final BlockModel u = data2.elementAt(dataRowIndex);

    newCellValue = "";

    final bool isNumericType =
        column.columnName == 'id' || column.columnName == 'amount';

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = int.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          if (column.columnName == "size") {
            String i = value;
            List<String> b = i.replaceAll("*", " ").split(" ");
            context
                .read<BlockFirebasecontroller>()
                .edit_cell_size(oldValue, u.Block_Id, column.columnName, b);
          } else {
            context
                .read<BlockFirebasecontroller>()
                .edit_cell(u.Block_Id, column.columnName, value);
            submitCell();
          }
          submitCell();
        },
      ),
    );
  }

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      //انشاء ستايل ل بيانات الخلايا
      TextStyle? getTextStyle() {
        if (e.columnName == 'amount') {
          return const TextStyle(color: Colors.pinkAccent);
        } else {
          return null;
        }
      }

      //هنا الخلايا
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4.0),
        child: Text(
          e.value.toString(),
          style: getTextStyle(),
        ),
      );
    }).toList());
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////

