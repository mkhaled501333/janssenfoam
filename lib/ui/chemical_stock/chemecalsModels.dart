// ignore_for_file: public_member_api_docs, sort_constructors_first

// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:janssenfoam/models/moderls.dart';

class ChemicalsModel {
  int chemical_ID;
  int updatedat;
  String family;
  String name;
  String unit;
  double quantityForSingleUnit;
  int supplyOrderNum;
  int StockRequisitionNum;
  double quantity;
  double Totalquantity;
  String description;
  String notes;
  String cumingFrom;
  String outTo;
  List<ActionModel> actions;
  ChemicalsModel({
    required this.chemical_ID,
    required this.updatedat,
    required this.family,
    required this.name,
    required this.unit,
    required this.quantityForSingleUnit,
    required this.supplyOrderNum,
    required this.StockRequisitionNum,
    required this.quantity,
    required this.Totalquantity,
    required this.description,
    required this.notes,
    required this.cumingFrom,
    required this.outTo,
    required this.actions,
  });

  ChemicalsModel copyWith({
    int? chemical_ID,
    int? updatedat,
    String? family,
    String? name,
    String? unit,
    double? quantityForSingleUnit,
    int? supplyOrderNum,
    int? StockRequisitionNum,
    double? quantity,
    double? Totalquantity,
    String? description,
    String? notes,
    String? cumingFrom,
    String? outTo,
    List<ActionModel>? actions,
  }) {
    return ChemicalsModel(
      chemical_ID: chemical_ID ?? this.chemical_ID,
      updatedat: updatedat ?? this.updatedat,
      family: family ?? this.family,
      name: name ?? this.name,
      unit: unit ?? this.unit,
      quantityForSingleUnit:
          quantityForSingleUnit ?? this.quantityForSingleUnit,
      supplyOrderNum: supplyOrderNum ?? this.supplyOrderNum,
      StockRequisitionNum: StockRequisitionNum ?? this.StockRequisitionNum,
      quantity: quantity ?? this.quantity,
      Totalquantity: Totalquantity ?? this.Totalquantity,
      description: description ?? this.description,
      notes: notes ?? this.notes,
      cumingFrom: cumingFrom ?? this.cumingFrom,
      outTo: outTo ?? this.outTo,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chemical_ID': chemical_ID,
      'updatedat': updatedat,
      'family': family,
      'name': name,
      'unit': unit,
      'quantityForSingleUnit': quantityForSingleUnit,
      'supplyOrderNum': supplyOrderNum,
      'StockRequisitionNum': StockRequisitionNum,
      'quantity': quantity,
      'Totalquantity': Totalquantity,
      'description': description,
      'notes': notes,
      'cumingFrom': cumingFrom,
      'outTo': outTo,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory ChemicalsModel.fromMap(Map<String, dynamic> map) {
    return ChemicalsModel(
      chemical_ID: map['chemical_ID'] as int,
      updatedat: map['updatedat'] as int,
      family: map['family'] as String,
      name: map['name'] as String,
      unit: map['unit'] as String,
      quantityForSingleUnit: map['quantityForSingleUnit'] as double,
      supplyOrderNum: map['supplyOrderNum'] as int,
      StockRequisitionNum: map['StockRequisitionNum'] as int,
      quantity: map['quantity'] as double,
      Totalquantity: map['Totalquantity'] as double,
      description: map['description'] as String,
      notes: map['notes'] as String,
      cumingFrom: map['cumingFrom'] as String,
      outTo: map['outTo'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChemicalsModel.fromJson(String source) =>
      ChemicalsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChemicalsModel(chemical_ID: $chemical_ID, updatedat: $updatedat, family: $family, name: $name, unit: $unit, quantityForSingleUnit: $quantityForSingleUnit, supplyOrderNum: $supplyOrderNum, StockRequisitionNum: $StockRequisitionNum, quantity: $quantity, Totalquantity: $Totalquantity, description: $description, notes: $notes, cumingFrom: $cumingFrom, outTo: $outTo, actions: $actions)';
  }

  @override
  bool operator ==(covariant ChemicalsModel other) {
    if (identical(this, other)) return true;

    return other.chemical_ID == chemical_ID &&
        other.updatedat == updatedat &&
        other.family == family &&
        other.name == name &&
        other.unit == unit &&
        other.quantityForSingleUnit == quantityForSingleUnit &&
        other.supplyOrderNum == supplyOrderNum &&
        other.StockRequisitionNum == StockRequisitionNum &&
        other.quantity == quantity &&
        other.Totalquantity == Totalquantity &&
        other.description == description &&
        other.notes == notes &&
        other.cumingFrom == cumingFrom &&
        other.outTo == outTo &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return chemical_ID.hashCode ^
        updatedat.hashCode ^
        family.hashCode ^
        name.hashCode ^
        unit.hashCode ^
        quantityForSingleUnit.hashCode ^
        supplyOrderNum.hashCode ^
        StockRequisitionNum.hashCode ^
        quantity.hashCode ^
        Totalquantity.hashCode ^
        description.hashCode ^
        notes.hashCode ^
        cumingFrom.hashCode ^
        outTo.hashCode ^
        actions.hashCode;
  }
}

class ChemicalCategory {
  int chemicalcategory_ID;
  String family;
  String item;
  List<ActionModel> actions;
  int lastupdate;
  ChemicalCategory({
    required this.chemicalcategory_ID,
    required this.family,
    required this.item,
    required this.actions,
    required this.lastupdate,
  });

  ChemicalCategory copyWith({
    int? chemicalcategory_ID,
    String? family,
    String? item,
    List<ActionModel>? actions,
    int? lastupdate,
  }) {
    return ChemicalCategory(
      chemicalcategory_ID: chemicalcategory_ID ?? this.chemicalcategory_ID,
      family: family ?? this.family,
      item: item ?? this.item,
      actions: actions ?? this.actions,
      lastupdate: lastupdate ?? this.lastupdate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chemicalcategory_ID': chemicalcategory_ID,
      'family': family,
      'item': item,
      'actions': actions.map((x) => x.toMap()).toList(),
      'lastupdate': lastupdate,
    };
  }

  factory ChemicalCategory.fromMap(Map<String, dynamic> map) {
    return ChemicalCategory(
      chemicalcategory_ID: map['chemicalcategory_ID'] as int,
      family: map['family'] as String,
      item: map['item'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      lastupdate: map['lastupdate'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChemicalCategory.fromJson(String source) =>
      ChemicalCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChemicalCategory(chemicalcategory_ID: $chemicalcategory_ID, family: $family, item: $item, actions: $actions, lastupdate: $lastupdate)';
  }

  @override
  bool operator ==(covariant ChemicalCategory other) {
    if (identical(this, other)) return true;

    return other.chemicalcategory_ID == chemicalcategory_ID &&
        other.family == family &&
        other.item == item &&
        listEquals(other.actions, actions) &&
        other.lastupdate == lastupdate;
  }

  @override
  int get hashCode {
    return chemicalcategory_ID.hashCode ^
        family.hashCode ^
        item.hashCode ^
        actions.hashCode ^
        lastupdate.hashCode;
  }
}

class ChemicalsSyplyers {
  int id;
  String name;
  List<ActionModel> actions;
  ChemicalsSyplyers({
    required this.id,
    required this.name,
    required this.actions,
  });

  ChemicalsSyplyers copyWith({
    int? id,
    String? name,
    List<ActionModel>? actions,
  }) {
    return ChemicalsSyplyers(
      id: id ?? this.id,
      name: name ?? this.name,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory ChemicalsSyplyers.fromMap(Map<String, dynamic> map) {
    return ChemicalsSyplyers(
      id: map['id'] as int,
      name: map['name'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChemicalsSyplyers.fromJson(String source) =>
      ChemicalsSyplyers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChemicalsSyplyers(id: $id, name: $name, actions: $actions)';

  @override
  bool operator ==(covariant ChemicalsSyplyers other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ actions.hashCode;
}

class ChemicalsCustomers {
  int id;
  String name;
  List<ActionModel> actions;
  ChemicalsCustomers({
    required this.id,
    required this.name,
    required this.actions,
  });

  ChemicalsCustomers copyWith({
    int? id,
    String? name,
    List<ActionModel>? actions,
  }) {
    return ChemicalsCustomers(
      id: id ?? this.id,
      name: name ?? this.name,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory ChemicalsCustomers.fromMap(Map<String, dynamic> map) {
    return ChemicalsCustomers(
      id: map['id'] as int,
      name: map['name'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChemicalsCustomers.fromJson(String source) =>
      ChemicalsCustomers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ChemicalsCustomers(id: $id, name: $name, actions: $actions)';

  @override
  bool operator ==(covariant ChemicalsCustomers other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ actions.hashCode;
}

class Units {
  int id;
  String name;
  double quantity;
  List<ActionModel> actions;
  Units({
    required this.id,
    required this.name,
    required this.quantity,
    required this.actions,
  });

  Units copyWith({
    int? id,
    String? name,
    double? quantity,
    List<ActionModel>? actions,
  }) {
    return Units(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'quantity': quantity,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory Units.fromMap(Map<String, dynamic> map) {
    return Units(
      id: map['id'] as int,
      name: map['name'] as String,
      quantity: map['quantity'] as double,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Units.fromJson(String source) =>
      Units.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Units(id: $id, name: $name, quantity: $quantity, actions: $actions)';
  }

  @override
  bool operator ==(covariant Units other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.quantity == quantity &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ quantity.hashCode ^ actions.hashCode;
  }
}
