// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/ui/chemical_stock/chemecalsModels.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/ui/chemical_stock/ChemicalsController.dart';

import 'componants/IN.dart';

class ChemicalStockViewModel extends BaseViewModel {
  @override
  TextEditingController unit = TextEditingController();
  TextEditingController quantityForUnit = TextEditingController();
  TextEditingController family = TextEditingController();
  @override
  TextEditingController item = TextEditingController();
  TextEditingController supplyer = TextEditingController();
  TextEditingController customer = TextEditingController();
  TextEditingController supplyingNum = TextEditingController();
  TextEditingController OutingNum = TextEditingController();
  @override
  TextEditingController quantity = TextEditingController();
  TextEditingController notess = TextEditingController();

  addNewChemical(BuildContext context) {
    Chemicals_controller mytype = context.read<Chemicals_controller>();

    if (selectedSypler != null &&
        selectedfamily != null &&
        selectedUnit != null &&
        selectedIntem != null &&
        quantity.text.isNotEmpty) {
      var unit = context
          .read<Chemicals_controller>()
          .units
          .firstWhere((e) => e.name == selectedUnit);

      ChemicalsModel r = ChemicalsModel(
          updatedat: DateTime.now().microsecondsSinceEpoch,
          chemical_ID: DateTime.now().microsecondsSinceEpoch,
          family: selectedfamily!,
          name: selectedIntem!,
          unit: selectedUnit!,
          quantityForSingleUnit: unit.quantity,
          quantity: quantity.text.to_double(),
          Totalquantity: unit.quantity * quantity.text.to_double(),
          supplyOrderNum: supplyingNum.text.to_int(),
          StockRequisitionNum: 0,
          description: "",
          notes: notes.text,
          cumingFrom: selectedSypler!,
          outTo: "",
          actions: [ChemicalAction.creat_new_ChemicalAction_item.add]);

      mytype.addChemical(r);
      quantity.clear();
    }
  }

  OutNewChemical(BuildContext context) {
    Chemicals_controller mytype = context.read<Chemicals_controller>();
    print(1);
    if (selectedcustomer != null &&
        selectedfamily != null &&
        selectedUnit != null &&
        selectedIntem != null &&
        quantity.text.isNotEmpty) {
      print(2);

      var unit = context
          .read<Chemicals_controller>()
          .units
          .firstWhere((e) => e.name == selectedUnit);

      ChemicalsModel r = ChemicalsModel(
          updatedat: DateTime.now().microsecondsSinceEpoch,
          chemical_ID: DateTime.now().microsecondsSinceEpoch,
          family: selectedfamily!,
          name: selectedIntem!,
          unit: selectedUnit!,
          quantityForSingleUnit: unit.quantity,
          quantity: quantity.text.to_double(),
          Totalquantity: -unit.quantity * quantity.text.to_double(),
          supplyOrderNum: 0,
          StockRequisitionNum: OutingNum.text.to_int(),
          description: "",
          notes: notes.text,
          cumingFrom: '',
          outTo: selectedcustomer!,
          actions: [ChemicalAction.creat_Out_ChemicalAction_item.add]);

      mytype.addChemical(r);
      quantity.clear();
    }
    // Chemicals_controller mytype = context.read<Chemicals_controller>();

    // double quantityForUnit = mytype.ChemicalCategorys.where(
    //             (element) => element.unit == "${mytype.selectedValueForUnit}")
    //         .isEmpty
    //     ? 0
    //     : mytype.ChemicalCategorys.where(
    //             (element) => element.unit == "${mytype.selectedValueForUnit}")
    //         .first
    //         .quantityForUnit;

    // ChemicalsModel r = ChemicalsModel(
    //     updatedat: DateTime.now().microsecondsSinceEpoch,
    //     chemical_ID: DateTime.now().microsecondsSinceEpoch,
    //     family: mytype.selectedValueForFamily.toString(),
    //     name: mytype.selectedValueForItem.toString(),
    //     unit: mytype.selectedValueForUnit.toString(),
    //     quantityForSingleUnit: quantityForUnit,
    //     quantity: quantity.text.to_double(),
    //     Totalquantity: -quantityForUnit * quantity.text.to_double(),
    //     supplyOrderNum: 0,
    //     StockRequisitionNum: OutingNum.text.to_int(),
    //     description: "",
    //     notes: notes.text,
    //     cumingFrom: "",
    //     outTo: mytype.selectedValueForcustomer.toString(),
    //     actions: [ChemicalAction.creat_Out_ChemicalAction_item.add]);

    // if (mytype.selectedValueForFamily != null &&
    //     mytype.selectedValueForItem != null &&
    //     mytype.selectedValueForcustomer != null &&
    //     mytype.selectedValueForUnit != null &&
    //     quantity.text.isNotEmpty) {
    //   mytype.addChemical(r);
    //   quantity.clear();
    // }
  }

  DeleteChemical(BuildContext context, ChemicalsModel e) {
    Chemicals_controller mytype = context.read<Chemicals_controller>();
    e.actions.add(ChemicalAction.archive_ChemicalAction_item.add);

    mytype.addChemical(e);
  }

  addUnit(BuildContext context) {
    Units record = Units(
        id: DateTime.now().microsecondsSinceEpoch,
        name: unit.text,
        quantity: quantityForUnit.text.to_double(),
        actions: []);
    context.read<Chemicals_controller>().addunit(record);
    unit.clear();
    quantityForUnit.clear();
    Navigator.pop(context);
  }

  deleteUnit(BuildContext context, Units untit) {
    untit.actions.add(Chemical_Category.archive_Chemical_category.add);

    context.read<Chemicals_controller>().addunit(untit);
    unit.clear();
    quantityForUnit.clear();
  }

  delete(BuildContext context, ChemicalCategory e) {
    e.actions.add(Chemical_Category.archive_Chemical_category.add);
    context.read<Chemicals_controller>().addChemicalCategory(e);
  }

  addFamily(BuildContext context) {
    ChemicalCategory record = ChemicalCategory(
        chemicalcategory_ID: DateTime.now().microsecondsSinceEpoch,
        family: family.text,
        item: "",
        actions: [Chemical_Category.creat_new_Chemical_category.add],
        lastupdate: DateTime.now().microsecondsSinceEpoch);
    context.read<Chemicals_controller>().addChemicalCategory(record);
    family.clear();
    Navigator.of(context).pop();
  }

  deleteFamily(BuildContext context, String familyname) {
    context
        .read<Chemicals_controller>()
        .chemicalsCategorys
        .where((test) => test.family == familyname)
        .forEach((item) {
      item.actions.add(Chemical_Category.archive_Chemical_category.add);
      context.read<Chemicals_controller>().addChemicalCategory(item);
    });
  }

  addItme(BuildContext context, String familyy) {
    ChemicalCategory record = ChemicalCategory(
        chemicalcategory_ID: DateTime.now().microsecondsSinceEpoch,
        family: familyy,
        item: item.text,
        actions: [Chemical_Category.creat_new_Chemical_category.add],
        lastupdate: DateTime.now().microsecondsSinceEpoch);
    context.read<Chemicals_controller>().addChemicalCategory(record);
    item.clear();
    Navigator.of(context).pop();
  }

  deleteItem(BuildContext context, ChemicalCategory item) {
    item.actions.add(Chemical_Category.archive_Chemical_category.add);
    context.read<Chemicals_controller>().addChemicalCategory(item);
  }

  addSupplyer(BuildContext context) {
    ChemicalsSyplyers record = ChemicalsSyplyers(
        id: DateTime.now().microsecondsSinceEpoch,
        name: supplyer.text,
        actions: []);
    context.read<Chemicals_controller>().addsyplyers(record);
    item.clear();
    Navigator.of(context).pop();
  }

  deletesypler(BuildContext context, ChemicalsSyplyers item) {
    item.actions.add(Chemical_Category.archive_Chemical_category.add);
    context.read<Chemicals_controller>().addsyplyers(item);
  }

  addcustomer(BuildContext context) {
    ChemicalsCustomers record = ChemicalsCustomers(
        id: DateTime.now().microsecondsSinceEpoch,
        name: customer.text,
        actions: []);
    context.read<Chemicals_controller>().addcustomer(record);
    carnumber.clear();
    Navigator.of(context).pop();
  }

  deleteCustomer(BuildContext context, ChemicalsCustomers item) {
    item.actions.add(Chemical_Category.archive_Chemical_category.add);
    context.read<Chemicals_controller>().addcustomer(item);
  }

  double getTotal(List<ChemicalsModel> Chemicals, ChemicalsModel e) {
    Iterable<ChemicalsModel> a = Chemicals.where(
            (element) => element.family == e.family && element.name == e.name)
        .toList();
    return a.isEmpty
        ? 0.0
        : a.map((e) => e.Totalquantity).reduce((v, b) => v + b);
  }

  List<Report_1_Data> getDataForReport(
      BuildContext context,
      List<String> selctedNames,
      List<String> selctedFamilys,
      List<ChemicalsModel> Chemicals) {
    return Chemicals.filterFamilyOrName(selctedNames, selctedFamilys)
        .FilterChemicals()
        .filterItemsPasedONFamilys(context, selctedFamilys)
        .filterItemsPasedONnames(context, selctedNames)
        .map((e) => Report_1_Data(
              family: e.family,
              name: e.name,
              totalQuantity: getTotal(Chemicals, e),
            ))
        .toList();
  }
}

class Report_1_Data {
  String family;
  String name;
  double totalQuantity;
  Report_1_Data({
    required this.family,
    required this.name,
    required this.totalQuantity,
  });
}
