//صفحة التوريد
// ignore_for_file: must_be_immutable

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/chemical_stock/ChemicalsController.dart';
import 'package:janssenfoam/main.dart';
import 'package:janssenfoam/ui/chemical_stock/chemecalsModels.dart';
import 'package:janssenfoam/ui/chemical_stock/ChemicalStock_viewModel.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/core/commen/textformfield.dart';
import 'package:provider/provider.dart';

class Suplying extends StatelessWidget {
  Suplying({super.key});
  ChemicalStockViewModel vm = ChemicalStockViewModel();

  @override
  Widget build(BuildContext context) {
    makenull();
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        var d = myType.chemicalsCategorys;
        print("object");
        vm.supplyingNum.text = myType.chiemicals.isNotEmpty
            ? (myType.chiemicals
                        .sortedBy<num>((element) => element.supplyOrderNum)
                        .last
                        .supplyOrderNum +
                    1)
                .toString()
            : 1.toString();

        return Scaffold(
          appBar: AppBar(
            title: const Text("امر توريد مخزنى"),
          ),
          body: Column(
            children: [
              errmsg(context),
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: SizedBox(
                          child: CustomTextFormField(
                              hint: "رقم التوريد",
                              width: MediaQuery.of(context).size.width * .45,
                              controller: vm.supplyingNum),
                        ),
                      ),
                      const Gap(7),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .45,
                        child: DropForSypler(
                            refrech: myType.Refresh_Ui,
                            items: myType.chemicalsuplyers
                                .map((e) => e.name)
                                .toSet()
                                .toList(),
                            hint: "المورد"),
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
                              vm.addNewChemical(context);
                              makenull();

                              myType.Refresh_Ui();
                            },
                            child: const Text(
                              "توريد",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                ].reversed.toList(),
              ),
              const ChemicaTableForSupplying(),
            ],
          ),
        );
      },
    );
  }
}

makenull() {
  selectedIntem = null;
  selectedSypler = null;
  selectedUnit = null;
  selectedcustomer = null;
  selectedfamily = null;
}
// hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh

//جدول عرض فى الموردين
class ChemicaTableForSupplying extends StatefulWidget {
  const ChemicaTableForSupplying({super.key});

  @override
  State<ChemicaTableForSupplying> createState() =>
      _ChemicaTableForSupplyingState();
}

class _ChemicaTableForSupplyingState extends State<ChemicaTableForSupplying> {
  ChemicalStockViewModel vm = ChemicalStockViewModel();
  String chosenDate = format.format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    List<ChemicalsModel> Chemicals = context
        .read<Chemicals_controller>()
        .chiemicals
        .sortedBy<num>((element) => element.supplyOrderNum)
        .reversed
        .toList()
        .where((element) =>
            element.Totalquantity > 0 &&
            element.supplyOrderNum != 0 &&
            element.actions
                    .get_Date_of_action(
                        ChemicalAction.creat_new_ChemicalAction_item.getTitle)
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
                          setState(() {
                            String formattedDate = format.format(pickedDate);
                            chosenDate = formattedDate;
                          });
                        } else {}
                      },
                      child: Text(
                        chosenDate,
                        style: const TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
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
                children: Chemicals.map((e) => TableRow(
                    decoration: BoxDecoration(color: Colors.teal[50]
                        // : Colors.amber[50],
                        ),
                    children: [
                      Center(child: Text(e.supplyOrderNum.toString())),
                      Center(child: Text(e.cumingFrom.toString())),
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
                            icon: const Icon(color: Colors.red, Icons.delete)),
                      )
                    ].reversed.toList())).toList(),
              ),
            ],
          ),
        ),
      ),
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
              Center(child: Text("رقم التوريد")),
              Center(child: Text("المورد")),
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

class MydropDowen extends StatelessWidget {
  MydropDowen({
    super.key,
    required this.refrech,
    required this.items,
    required this.selecteditems,
    required this.tittle,
  });
  final String tittle;
  final Function refrech;
  final List<String> items;
  final List<String> selecteditems;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
        isExpanded: true,
        hint: Center(
          child: Text(
            tittle,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        items: items.toSet().map((item) {
          return DropdownMenuItem(
            value: item,
            //disable default onTap to avoid closing menu when selecting an item
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = selecteditems.contains(item);
                return InkWell(
                  onTap: () {
                    isSelected
                        ? selecteditems.remove(item)
                        : selecteditems.add(item);

                    //This rebuilds the StatefulWidget to update the button's text
                    refrech();
                    //This rebuilds the dropdownMenu Widget to update the check mark
                    menuSetState(() {});
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        if (isSelected)
                          const Icon(Icons.check_box_outlined)
                        else
                          const Icon(Icons.check_box_outline_blank),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
        //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
        value: selecteditems.isEmpty ? null : selecteditems.last,
        onChanged: (value) {},
        selectedItemBuilder: (context) {
          return items.map(
            (item) {
              return Container(
                alignment: AlignmentDirectional.center,
                child: Text(
                  selecteditems.join(', '),
                  style: const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              );
            },
          ).toList();
        },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: const Color.fromARGB(255, 204, 225, 241)),
          padding: const EdgeInsets.only(left: 17, right: 8),
          height: 50,
          width: MediaQuery.of(context).size.width * .3,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.zero,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ));
  }
}

String? selectedSypler;

class DropForSypler extends StatelessWidget {
  DropForSypler({
    super.key,
    required this.refrech,
    required this.items,
    required this.hint,
  });
  final Function refrech;
  final String hint;
  final List<String> items;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          hint,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedSypler,
        onChanged: (value) {
          selectedSypler = value;
          refrech();
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: const Color.fromARGB(255, 201, 233, 226),
          ),
          elevation: 2,
        ),

        dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: const Color.fromARGB(255, 201, 233, 226),
            )),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),

        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value
                .toString()
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

String? selectedcustomer;

class DropForcustomer extends StatelessWidget {
  DropForcustomer({
    super.key,
    required this.refrech,
    required this.items,
    required this.hint,
  });
  final Function refrech;
  final String hint;
  final List<String> items;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          hint,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedcustomer,
        onChanged: (value) {
          selectedcustomer = value;
          refrech();
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: const Color.fromARGB(255, 201, 233, 226),
          ),
          elevation: 2,
        ),

        dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: const Color.fromARGB(255, 201, 233, 226),
            )),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),

        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value
                .toString()
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

String? selectedfamily;

class DropForfamily extends StatelessWidget {
  DropForfamily({
    super.key,
    required this.refrech,
    required this.items,
    required this.hint,
  });
  final Function refrech;
  final String hint;
  final List<String> items;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          hint,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedfamily,
        onChanged: (value) {
          selectedfamily = value;
          refrech();
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: const Color.fromARGB(255, 201, 233, 226),
          ),
          elevation: 2,
        ),

        dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: const Color.fromARGB(255, 201, 233, 226),
            )),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),

        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value
                .toString()
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

String? selectedIntem;

class DropForItem extends StatelessWidget {
  DropForItem({
    super.key,
    required this.refrech,
    required this.items,
    required this.hint,
  });
  final Function refrech;
  final String hint;
  final List<String> items;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          hint,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedIntem,
        onChanged: (value) {
          selectedIntem = value;
          refrech();
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: const Color.fromARGB(255, 201, 233, 226),
          ),
          elevation: 2,
        ),

        dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: const Color.fromARGB(255, 201, 233, 226),
            )),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),

        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value
                .toString()
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}

String? selectedUnit;

class DropForUnit extends StatelessWidget {
  DropForUnit({
    super.key,
    required this.refrech,
    required this.items,
    required this.hint,
  });
  final Function refrech;
  final String hint;
  final List<String> items;

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Text(
          hint,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: selectedUnit,
        onChanged: (value) {
          selectedUnit = value;
          refrech();
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: 160,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: const Color.fromARGB(255, 201, 233, 226),
          ),
          elevation: 2,
        ),

        dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: Colors.black26,
              ),
              color: const Color.fromARGB(255, 201, 233, 226),
            )),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
        ),

        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value
                .toString()
                .toLowerCase()
                .contains(searchValue.toLowerCase());
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            textEditingController.clear();
          }
        },
      ),
    );
  }
}
