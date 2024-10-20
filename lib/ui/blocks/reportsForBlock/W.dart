// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names
// ignore_for_file: must_be_immutable, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/blocks/reportsForBlock/Bolck_reports_viewModel.dart';

class HeaderOftable4 extends StatelessWidget {
  const HeaderOftable4({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {},
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: BoxDecoration(
              color: Colors.amber[50],
            ),
            children: [
              // Container(
              //     padding: const EdgeInsets.all(0),
              //     child: const Text("m3اجمالى المنصرف")),
              // Container(
              //     padding: const EdgeInsets.all(0),
              //     child: const Text("m3رصيد اخر المده")),
              Container(
                  padding: const EdgeInsets.all(0),
                  child: const Text('m3  رصيد  ب ')),

              Container(
                  padding: const EdgeInsets.all(0), child: const Text('اللون')),
              Container(
                  padding: const EdgeInsets.all(0), child: const Text('كثافه')),
              Container(
                  padding: const EdgeInsets.all(0), child: const Text('النوع')),
            ])
      ],
    );
  }
}

//جدول الاجماليات
class TheTable2 extends StatelessWidget {
  TheTable2({
    super.key,
  });
  BlockReportsViewModel vm = BlockReportsViewModel();
  @override
  Widget build(BuildContext context) {
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        return SizedBox(
          child: Table(
            columnWidths: const {},
            children: blocks.blocks.values
                .toList()

                // .filter_date(context)
                .filter_filter_type_and_density()
                .sortedBy<num>((element) => element.item.density)
                .map((e) {
              String x = (vm.Last_period_balance(
                          context, blocks.blocks.values.toList(), e) +
                      vm.total_spend(
                          context,
                          blocks.blocks.values
                              .toList()
                              .filter_date_consumed(context),
                          e))
                  .toStringAsFixed(1);
              return TableRow(
                  decoration: BoxDecoration(
                    color: 2 % 2 == 0 ? Colors.teal[50] : Colors.amber[50],
                  ),
                  children: [
                    //اجمالى المنصرف
                    // Container(
                    //     padding: const EdgeInsets.all(2),
                    //     child: Text(vm
                    //         .total_spend(
                    //             context,
                    //             blocks.blocks.filter_date_consumed(context),
                    //             e)
                    //         .toStringAsFixed(1))),
                    // //رصيد اخر المده
                    // Container(
                    //     padding: const EdgeInsets.all(2),
                    //     child: Text(
                    //         vm.Last_period_balance(context, blocks.blocks, e)
                    //             .toStringAsFixed(1))),
                    //رصيد اول المده
                    x.to_double() != 0
                        ? Container(
                            padding: const EdgeInsets.all(5),
                            child: Text("${x.to_double()}"))
                        : const SizedBox(),

                    x.to_double() != 0
                        ? Container(
                            padding: const EdgeInsets.all(0),
                            child: Text(e.item.color.toString()))
                        : const SizedBox(),
                    x.to_double() != 0
                        ? Container(
                            padding: const EdgeInsets.all(0),
                            child: Text(e.item.density.toString()))
                        : const SizedBox(),
                    x.to_double() != 0
                        ? Container(
                            padding: const EdgeInsets.all(0),
                            child: Text(e.item.type))
                        : const SizedBox(),
                  ]);
            }).toList(),
            border: TableBorder.all(width: 1, color: Colors.black),
          ),
        );
      },
    );
  }
}

class blockstockInventory extends StatelessWidget {
  const blockstockInventory({super.key});

  @override
  Widget build(BuildContext context) {
    const textstyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
    var columns = <GridColumn>[
      GridColumn(
          columnName: 'amount',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'عدد',
                style: textstyle,
              ))),
      GridColumn(
          minimumWidth: 110,
          columnName: 'size',
          label: Container(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.center,
              child: const Text(
                'المقاس',
                style: textstyle,
              ))),
      GridColumn(
          columnName: 'color',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'لون',
                style: textstyle,
                overflow: TextOverflow.ellipsis,
              ))),
      GridColumn(
          columnName: 'denety',
          label: Container(
              alignment: Alignment.center,
              child: const Text(
                'كثافه',
                style: textstyle,
              ))),
      GridColumn(
          columnName: 'type',
          label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: const Text(
                'نوع',
                style: textstyle,
              ))),
    ];
    return Consumer<BlockFirebasecontroller>(
      builder: (context, blocks, child) {
        return SfDataGridTheme(
          data: const SfDataGridThemeData(
              headerColor: Color.fromARGB(255, 189, 233, 228)),
          child: SfDataGrid(
            allowSorting: true,
            allowMultiColumnSorting: true,
            allowTriStateSorting: true,
            source: EmployeeDataSource(
                coumingData: blocks.blocks.values
                    .toList()
                    .where((element) =>
                        element.actions.if_action_exist(
                            BlockAction.consume_block.getactionTitle) ==
                        false)
                    .toList()
                // .filter_date(context)
                ),
            columnWidthMode: ColumnWidthMode.fill,
            columns: columns,
          ),
        );
      },
    );
  }
}

class EmployeeDataSource extends DataGridSource {
  BlockReportsViewModel vm = BlockReportsViewModel();
//DataGridRowهنا تحويل البيانات الى قائمه من
  EmployeeDataSource({
    required List<BlockModel> coumingData,
  }) {
    data = coumingData
        .filter_filter_type_density_color_size()
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'amount',
                  value: vm.total_amount_for_single_siz__(e, coumingData)),
              DataGridCell<String>(
                  columnName: 'size',
                  value:
                      "${e.item.H.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}"),
              DataGridCell<String>(columnName: 'color', value: e.item.color),
              DataGridCell<double>(columnName: 'denety', value: e.item.density),
              DataGridCell<String>(columnName: 'type', value: e.item.type),
            ]))
        .toList();
  }

  List<DataGridRow> data = [];

  @override
  List<DataGridRow> get rows => data;

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

  void loadMoreRows() {}
}

class EmployeeDataSource22 extends DataGridSource {
  BlockReportsViewModel vm = BlockReportsViewModel();
//DataGridRowهنا تحويل البيانات الى قائمه من
  EmployeeDataSource({
    required List<BlockModel> coumingData,
  }) async {
    data = coumingData
        .filter_filter_type_density_color_size()
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'amount',
                  value: vm.total_amount_for_single_siz__(e, coumingData)),
              DataGridCell<String>(
                  columnName: 'size',
                  value:
                      "${e.item.H.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}"),
              DataGridCell<String>(columnName: 'color', value: e.item.color),
              DataGridCell<double>(columnName: 'denety', value: e.item.density),
              DataGridCell<String>(columnName: 'type', value: e.item.type),
            ]))
        .toList();
  }

  List<DataGridRow> data = [];

  @override
  List<DataGridRow> get rows => data;

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
