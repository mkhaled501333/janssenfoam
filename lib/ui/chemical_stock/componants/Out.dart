//صفحة الصرف
// ignore_for_file: must_be_immutable, file_names

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/chemical_stock/chemecalsModels.dart';
import 'package:janssenfoam/ui/chemical_stock/ChemicalsController.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/ui/chemical_stock/ChemicalStock_viewModel.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:provider/provider.dart';

import '../../../core/recources/enums.dart';
import 'IN.dart';

class Outing extends StatelessWidget {
  Outing({super.key});
  ChemicalStockViewModel vm = ChemicalStockViewModel();

  @override
  Widget build(BuildContext context) {
    makenull();

    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        var d = myType.chemicalsCategorys;

        vm.OutingNum.text = myType.chiemicals.isNotEmpty
            ? (myType.chiemicals
                        .sortedBy<num>((element) => element.StockRequisitionNum)
                        .last
                        .StockRequisitionNum +
                    1)
                .toString()
            : 1.toString();
        // var chemicals = myType.ChemicalCategorys.filterfamily(
        //     myType.selectedValueForFamily);
        return Scaffold(
          appBar: AppBar(
            title: const Text("امر صرف مخزنى"),
          ),
          body: Column(
            children: [
              errmsg(context),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: SizedBox(
                          height: 67,
                          child: CustomTextFormField(
                              hint: "رقم الصرف",
                              width: MediaQuery.of(context).size.width * .45,
                              controller: vm.OutingNum),
                        ),
                      ),
                      const Gap(7),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .45,
                        child: DropForcustomer(
                            refrech: myType.Refresh_Ui,
                            items: myType.chemicalcusomers
                                .map((e) => e.name)
                                .toSet()
                                .toList(),
                            hint: "العميل"),
                      ),
                      const Gap(7),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .45,
                        child: DropForfamily(
                            refrech: myType.Refresh_Ui,
                            items: d.map((e) => e.family).toSet().toList(),
                            hint: 'العائله'),
                      ),
                      const Gap(7),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .45,
                        child: DropForItem(
                            refrech: myType.Refresh_Ui,
                            items: selectedfamily == null
                                ? []
                                : d
                                    .where((e) => e.family == selectedfamily)
                                    .map((e) => e.item)
                                    .toSet()
                                    .toList(),
                            hint: 'الصنف'),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .45,
                        child: DropForUnit(
                            refrech: myType.Refresh_Ui,
                            items: myType.units
                                .map((e) => e.name)
                                .toSet()
                                .toList(),
                            hint: 'الوحده'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomTextFormField(
                                hint: "العدد",
                                width: MediaQuery.of(context).size.width * .45,
                                controller: vm.quantity),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomTextFormField(
                            keybordtupe: TextInputType.name,
                            hint: "ملاحظات",
                            width: MediaQuery.of(context).size.width * .45,
                            controller: vm.notess),
                      ),
                      SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width * .45,
                        child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.green)),
                            onPressed: () {
                              vm.OutNewChemical(context);
                              makenull();
                              myType.Refresh_Ui();
                            },
                            child: const Text("صرف")),
                      ),
                    ],
                  ),
                ].reversed.toList(),
              ),
              ChemicaTableForSupplying(),
            ],
          ),
        );
      },
    );
  }
}

class ChemicaTableForSupplying extends StatelessWidget {
  ChemicaTableForSupplying({super.key});
  ChemicalStockViewModel vm = ChemicalStockViewModel();
  String chosenDate = format.format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        print(myType.chiemicals.length);
        List<ChemicalsModel> Chemicals = myType.chiemicals
            .sortedBy<num>((element) => element.supplyOrderNum)
            .reversed
            .toList()
            .where((element) =>
                element.StockRequisitionNum != 0 &&
                element.actions
                        .get_Date_of_action(ChemicalAction
                            .creat_Out_ChemicalAction_item.getTitle)
                        .formatt() ==
                    chosenDate &&
                element.actions.if_action_exist(
                        ChemicalAction.archive_ChemicalAction_item.getTitle) ==
                    false)
            .toList();
        return Expanded(
          child: SingleChildScrollView(
            reverse: true,
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: 800,
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              String formattedDate = format.format(pickedDate);
                              chosenDate = formattedDate;
                              myType.Refresh_Ui();
                            } else {}
                          },
                          child: Text(
                            chosenDate,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  const HeaderChemicaTableForSupplying(),
                  Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1.2),
                      2: FlexColumnWidth(1.2),
                      3: FlexColumnWidth(2),
                      4: FlexColumnWidth(4),
                      5: FlexColumnWidth(3),
                      6: FlexColumnWidth(3),
                      7: FlexColumnWidth(2),
                      8: FlexColumnWidth(1),
                    },
                    border: TableBorder.all(width: 1, color: Colors.black),
                    children: Chemicals.sortedBy<num>(
                            (element) => element.chemical_ID)
                        .map((e) => TableRow(
                            decoration: BoxDecoration(color: Colors.teal[50]
                                // : Colors.amber[50],
                                ),
                            children: [
                              Center(
                                  child:
                                      Text(e.StockRequisitionNum.toString())),
                              Center(child: Text(e.outTo.toString())),
                              Center(child: Text(e.family.toString())),
                              Center(child: Text(e.name.toString())),
                              Center(child: Text(e.unit.toString())),
                              Center(child: Text(e.quantity.toString())),
                              Center(child: Text(e.Totalquantity.toString())),
                              Center(child: Text(e.notes.toString())),
                              Center(
                                child: IconButton(
                                    onPressed: () {
                                      vm.DeleteChemical(context, e);
                                    },
                                    icon: const Icon(
                                        color: Colors.red, Icons.delete)),
                              )
                            ].reversed.toList()))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HeaderChemicaTableForSupplying extends StatelessWidget {
  const HeaderChemicaTableForSupplying({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(1.2),
        2: FlexColumnWidth(1.2),
        3: FlexColumnWidth(2),
        4: FlexColumnWidth(4),
        5: FlexColumnWidth(3),
        6: FlexColumnWidth(3),
        7: FlexColumnWidth(2),
        8: FlexColumnWidth(1),
      },
      border: TableBorder.all(width: 1, color: Colors.black),
      children: [
        TableRow(
            decoration: const BoxDecoration(
              color:
                  // Colors.teal[50]:
                  Color.fromARGB(122, 26, 163, 140),
            ),
            children: const [
              Center(child: Text("رقم الصرف")),
              Center(child: Text("العميل")),
              Center(child: Text("عائله")),
              Center(child: Text("صنف")),
              Center(child: Text("وحده")),
              Center(child: Text("عدد")),
              Center(child: Text("الكميه")),
              Center(child: Text("ملاحظات")),
              Center(child: Text("حذف")),
            ].reversed.toList())
      ],
    );
  }
}
