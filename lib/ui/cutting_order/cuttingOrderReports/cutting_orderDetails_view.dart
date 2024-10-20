// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, unused_element, unused_local_variable

import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/cutting_order/Order_controller.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/services/file_handle_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';

import 'package:syncfusion_flutter_xlsio/xlsio.dart';
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
  File('${appDocDirectory!.path}/${formatwitTime2.format(DateTime.now())}تفاصيل التام.xlsx')
      .writeAsBytes(bytes, flush: true)
      .then((value) => FileHandleApi.openFile(value));
}

class CuttingOrderDetailsReports extends StatelessWidget {
  CuttingOrderDetailsReports();

  var columns = <GridColumn>[
    GridColumn(
        visible: false,
        allowFiltering: true,
        columnName: 'id',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'id',
              style: textstyle11,
            ))),
    GridColumn(
        visible: false,
        allowFiltering: true,
        columnName: 'id2',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'id2',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'serial',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'رقم',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'len',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'طول',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'wed',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'عرض',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'hight',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'ارتفاع',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'den',
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
            alignment: Alignment.center,
            child: Text(
              'نوع',
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
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'amount',
        label: Container(
            alignment: Alignment.center,
            child: Text(
              'كميه',
              style: textstyle11,
            ))),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfDataGridState> kkkkk = GlobalKey<SfDataGridState>();

    return Consumer<OrderController>(builder: (context, mytype, child) {
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
                  allowSwiping: true,
                  swipeMaxOffset: 100.0,
                  endSwipeActionsBuilder:
                      (BuildContext context, DataGridRow row, int rowIndex) {
                    return GestureDetector(
                        onTap: () {
                          // print(row.getCells().first.value);
                          // mytype.deletefinalProudut(mytype.finalproducts
                          //     .where((element) =>
                          //         element.id == row.getCells().first.value)
                          //     .first);
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
                  allowEditing: permitionss(context,
                      UserPermition.allow_edit_in_details_finalProdcut),
                  selectionMode: SelectionMode.multiple,
                  navigationMode: GridNavigationMode.cell,
                  isScrollbarAlwaysShown: true,
                  key: kkkkk,
                  allowSorting: true,
                  allowMultiColumnSorting: true,
                  allowTriStateSorting: true,
                  allowFiltering: true,
                  source: EmployeeDataSource223344(context,
                      coumingData: mytype.cuttingOrders.values.toList()),
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: columns,
                ),
              ),
            ),
          ));
    });
  }
}

class EmployeeDataSource223344 extends DataGridSource {
//DataGridRowهنا تحويل البيانات الى قائمه من

  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();

  EmployeeDataSource223344(
    this.context, {
    required List<cutingOrder> coumingData,
  }) {
    data = coumingData
        .expand<DataGridRow>((e) => e.items.map((a) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.cuttingOrder_ID),
              DataGridCell<int>(columnName: 'id2', value: a.id),
              DataGridCell<int>(columnName: 'serial', value: e.serial),
              DataGridCell<double>(columnName: 'len', value: a.lenth),
              DataGridCell<double>(columnName: 'wed', value: a.widti),
              DataGridCell<double>(columnName: 'hight', value: a.hight),
              DataGridCell<double>(columnName: 'den', value: a.density),
              DataGridCell<String>(columnName: 'type', value: a.type),
              DataGridCell<String>(columnName: 'color', value: a.color),
              DataGridCell<int>(columnName: 'amount', value: a.Qantity),
            ])))
        .toList();
    data2 = coumingData;
  }
  final BuildContext context;
  List<DataGridRow> data = [];
  List<cutingOrder> data2 = [];
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
    // final cutingOrder u = data2.elementAt(dataRowIndex);

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
        onSubmitted: (String value) {},
      ),
    );
  }
}

/////////////////////////////////////////////////////////////////////////////////////////////

