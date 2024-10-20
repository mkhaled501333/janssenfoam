// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, use_key_in_widget_constructors, unused_element, unused_local_variable

import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/app/functions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/userpermitions.dart';
import 'package:janssenfoam/ui/customers/Customer_controller.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
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

class details_of_finalProdcut extends StatelessWidget {
  details_of_finalProdcut();

  var columns = <GridColumn>[
    GridColumn(
        visible: false,
        allowFiltering: true,
        columnName: 'id',
        label: Container(
            padding: const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              'id',
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
        columnName: 'amount',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'الكميه',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'customer',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'عميل',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'scisorrs',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'مقص',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'invoiceNumber',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'invoiceNum',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'orderNumber',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'orderNum',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'ading',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'الاضافه',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'outorder',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'الصرف',
              style: textstyle11,
            ))),
    GridColumn(
        allowFiltering: true,
        columnName: 'scissor',
        label: Container(
            padding: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              'استلام المقصات',
              style: textstyle11,
            ))),
  ];

  @override
  Widget build(BuildContext context) {
    final GlobalKey<SfDataGridState> kkkkk = GlobalKey<SfDataGridState>();

    return Consumer<final_prodcut_controller>(
        builder: (context, mytype, child) {
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
                          var f = mytype.finalproducts.values
                              .where((element) =>
                                  element.finalProdcut_ID ==
                                  row.getCells().first.value)
                              .first;
                          f.actions.add(
                              finalProdcutAction.archive_final_prodcut.add);
                          mytype.updateFinalProdcut(f);
                        },
                        child: Container(
                            color: Colors.redAccent,
                            child: const Center(
                              child: Icon(Icons.delete),
                            ))).permition(
                        context, UserPermition.delete_in_finalprodcut_details);
                  },
                  tableSummaryRows: [
                    GridTableSummaryRow(
                        showSummaryInRow: true,
                        title: 'Total  Quantity: {Count}',
                        titleColumnSpan: 3,
                        columns: [
                          const GridSummaryColumn(
                              name: 'Count',
                              columnName: 'amount',
                              summaryType: GridSummaryType.sum),
                        ],
                        position: GridTableSummaryRowPosition.top),
                  ],
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
                  source: EmployeeDataSource2233(context,
                      coumingData: mytype.finalproducts.values.toList()),
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: columns,
                ),
              ),
            ),
          ));
    });
  }
}

class EmployeeDataSource2233 extends DataGridSource {
//DataGridRowهنا تحويل البيانات الى قائمه من

  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();

  EmployeeDataSource2233(
    this.context, {
    required List<FinalProductModel> coumingData,
  }) {
    data = coumingData
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.finalProdcut_ID),
              DataGridCell<String>(
                  columnName: 'size',
                  value:
                      "${e.item.H.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}"),
              DataGridCell<String>(columnName: 'color', value: e.item.color),
              DataGridCell<double>(
                  columnName: 'density', value: e.item.density),
              DataGridCell<String>(columnName: 'type', value: e.item.type),
              DataGridCell<int>(columnName: 'amount', value: e.item.amount),
              DataGridCell<String>(
                  columnName: 'customer',
                  value: context
                      .read<Customer_controller>()
                      .customers
                      .values
                      .where((element) => element.serial == e.customer.to_int())
                      .first
                      .name),
              DataGridCell<int>(columnName: 'scisorrs', value: e.scissor),
              DataGridCell<int>(
                  columnName: 'invoiceNumber', value: e.invoiceNum),
              DataGridCell<int>(
                  columnName: 'orderNumber', value: e.cuting_order_number),
              DataGridCell<String>(
                  columnName: 'ading',
                  value: e.actions.if_action_exist(finalProdcutAction
                          .recive_Done_Form_FinalProdcutStock.getactionTitle)
                      ? format.format(e.actions.get_Date_of_action(
                          finalProdcutAction.recive_Done_Form_FinalProdcutStock
                              .getactionTitle))
                      : "--"),
              DataGridCell<String>(
                  columnName: 'outorder',
                  value: e.actions.if_action_exist(
                          finalProdcutAction.out_order.getactionTitle)
                      ? format.format(e.actions.get_Date_of_action(
                          finalProdcutAction.out_order.getactionTitle))
                      : "--"),
              DataGridCell<String>(
                  columnName: 'scissor',
                  value: e.actions.if_action_exist(finalProdcutAction
                          .incert_finalProduct_from_cutingUnit.getactionTitle)
                      ? format.format(e.actions.get_Date_of_action(
                          finalProdcutAction.incert_finalProduct_from_cutingUnit
                              .getactionTitle))
                      : "--"),
            ]))
        .toList();
    data2 = coumingData;
  }
  final BuildContext context;
  List<DataGridRow> data = [];
  List<FinalProductModel> data2 = [];
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

  // @override
  // Future<void> onCellSubmit(DataGridRow dataGridRow,
  //     RowColumnIndex rowColumnIndex, GridColumn column) {
  //   final dynamic oldValue = dataGridRow
  //           .getCells()
  //           .firstWhereOrNull((DataGridCell dataGridCell) =>
  //               dataGridCell.columnName == column.columnName)
  //           ?.value ??
  //       '';

  //   final int dataRowIndex = data.indexOf(dataGridRow);

  //   if (newCellValue == null || oldValue == newCellValue) {
  //     return;
  //   }

  //   if (column.columnName == 'id') {
  //     data[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
  //         DataGridCell<int>(columnName: 'id', value: newCellValue);
  //     data[dataRowIndex] = newCellValue;
  //   } else if (column.columnName == 'name') {
  //     data[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
  //         DataGridCell<String>(columnName: 'name', value: newCellValue);
  //     data[dataRowIndex] = newCellValue;
  //   } else if (column.columnName == 'designation') {
  //     data[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
  //         DataGridCell<String>(columnName: 'designation', value: newCellValue);
  //     data[dataRowIndex] = newCellValue;
  //   } else {
  //     data[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
  //         DataGridCell<int>(columnName: 'salary', value: newCellValue);
  //     data[dataRowIndex] = newCellValue;
  //   }
  // }

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
    final FinalProductModel u = data2.elementAt(dataRowIndex);

    // if (column.columnName == 'id') {
    //   data[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<int>(columnName: 'id', value: newCellValue);
    //   data[dataRowIndex] = newCellValue;
    // }
    //  else if (column.columnName == 'name') {
    //   data[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<String>(columnName: 'name', value: newCellValue);
    //   data[dataRowIndex] = newCellValue;
    // } else if (column.columnName == 'designation') {
    //   data[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<String>(columnName: 'designation', value: newCellValue);
    //   data[dataRowIndex] = newCellValue;
    // } else {
    //   data[dataRowIndex].getCells()[rowColumnIndex.columnIndex] =
    //       DataGridCell<int>(columnName: 'salary', value: newCellValue);
    //   data[dataRowIndex] = newCellValue;
    // }
    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
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
          // print(u);
          if (column.columnName == "size") {
            String i = value;
            List<String> b = i.replaceAll("*", " ").split(" ");
            context
                .read<final_prodcut_controller>()
                .edit_cell_size(u.finalProdcut_ID, column.columnName, b);
          } else {
            context
                .read<final_prodcut_controller>()
                .edit_cell(u.finalProdcut_ID, column.columnName, value);
            submitCell();
          }
        },
      ),
    );
  }
}
