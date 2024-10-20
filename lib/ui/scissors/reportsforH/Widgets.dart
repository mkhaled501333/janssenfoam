// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:janssenfoam/ui/blocks/blockExtentions.dart';
import 'package:janssenfoam/controllers/bFractionsController.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/blocks/blockFirebaseController.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/scissors/reportsforH/h_reports_viewModel.dart';

//جدول المنصرف من الخزن
class blockstockInventoryForH extends StatelessWidget {
  const blockstockInventoryForH({super.key, required this.scissor});
  final int scissor;

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
      GridColumn(
          columnName: 'serial',
          label: Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: const Text(
                'كود',
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
            source: EmployeeDataSourcee(
                coumingData: blocks.blocks.values.toList(), scissor: scissor),
            columnWidthMode: ColumnWidthMode.fill,
            columns: columns,
          ),
        );
      },
    );
  }
}

class EmployeeDataSourcee extends DataGridSource {
  HReportsViewModel vm = HReportsViewModel();
//DataGridRowهنا تحويل البيانات الى قائمه من
  EmployeeDataSourcee(
      {required List<BlockModel> coumingData, required int scissor}) {
    data = coumingData
        .where((e) => e.Hscissor == scissor)
        .toList()
        .filter_filter_type_density_color_size_serial()
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(
                  columnName: 'amount',
                  value: vm.total_amount_for_single_siz__(
                      e, coumingData, scissor)),
              DataGridCell<String>(
                  columnName: 'size',
                  value:
                      "${e.item.H.removeTrailingZeros}*${e.item.W.removeTrailingZeros}*${e.item.L.removeTrailingZeros}"),
              DataGridCell<String>(columnName: 'color', value: e.item.color),
              DataGridCell<double>(columnName: 'denety', value: e.item.density),
              DataGridCell<String>(columnName: 'type', value: e.item.type),
              DataGridCell<String>(columnName: 'serial', value: e.serial),
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

//جدول النواتج
class Results extends StatelessWidget {
  const Results({
    super.key,
    required this.scissor,
    required this.blocks,
  });
  final int scissor;
  final List<BlockModel> blocks;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          const HeaderOftable22(),
          TheTable23(
            scissor: scissor,
            blocks: blocks,
          )
        ],
      ),
    );
  }
}

class HeaderOftable22 extends StatelessWidget {
  const HeaderOftable22({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(.4),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(.3),
        },
        border: TableBorder.all(width: 1, color: Colors.black),
        children: [
          TableRow(
              decoration: BoxDecoration(
                color: Colors.amber[50],
              ),
              children: [
                Container(
                    padding: const EdgeInsets.all(4),
                    child: const Text("ناتج")),
                Container(
                    padding: const EdgeInsets.all(4),
                    child: const Center(child: Text('تصنيع'))),
                Container(
                    padding: const EdgeInsets.all(4), child: const Text('م')),
              ])
        ],
      ),
    );
  }
}

class TheTable23 extends StatelessWidget {
  TheTable23({
    super.key,
    required this.scissor,
    required this.blocks,
  });
  final int scissor;
  final List<BlockModel> blocks;
  HReportsViewModel vm = HReportsViewModel();
  Fractions_Controller fractioncontroller = Fractions_Controller();

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return Expanded(
      flex: 4,
      child: SingleChildScrollView(
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(.4),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(.3),
          },
          children: fractioncontroller.fractions.filter_Fractios___().map((e) {
            x++;

            return TableRow(
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                ),
                children: [
                  Container(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        vm
                            .total_amount_for_single_siz__fractions(
                                e, fractioncontroller.fractions, scissor)
                            .toString(),
                      )),
                  Container(
                      padding: const EdgeInsets.all(4),
                      child: Text(
                        "${e..item.H.removeTrailingZeros}*${e..item.L.removeTrailingZeros}*${e.item.W.removeTrailingZeros}",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 221, 2, 75)),
                      )),
                  Container(
                      padding: const EdgeInsets.all(4), child: Text("$x")),
                ]);
          }).toList(),
          border: TableBorder.all(width: 1, color: Colors.black),
        ),
      ),
    );
  }
}
