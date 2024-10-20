// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import 'package:janssenfoam/ui/finalProdcuts/finalProdcutExtentions.dart';
import 'package:provider/provider.dart';
import 'package:janssenfoam/ui/finalProdcuts/final_product_controller.dart';
import 'package:janssenfoam/models/moderls.dart';

class Stockcheck_veiwModel extends BaseViewModel {
  List<FinalProdcutBalanceModel> finalprodctBalance(
      List<FinalProductModel> finalproducts, BuildContext context) {
    var l = context.read<final_prodcut_controller>();
    return finalproducts
        .filter_density_typ_color_size()
        .where((e) => finalproducts.countOf(e) > 0)
        .toList()
        .filterItemsPasedOnDensites(context, l.selctedDensities)
        .filterItemsPasedOntypes(context, l.selctedtybes)
        .filterItemsPasedOncolors(context, l.selctedcolors)
        .map((g) => FinalProdcutBalanceModel(
            color: g.item.color,
            type: g.item.type,
            density: g.item.density,
            L: g.item.L,
            W: g.item.W,
            H: g.item.H,
            quantity: finalproducts.countOf(g)))
        .toList();
  }
}

class FinalProdcutBalanceModel {
  String color;
  String type;
  double density;
  double L;
  double W;
  double H;
  int quantity;
  FinalProdcutBalanceModel({
    required this.color,
    required this.type,
    required this.density,
    required this.L,
    required this.W,
    required this.H,
    required this.quantity,
  });

  FinalProdcutBalanceModel copyWith({
    String? color,
    String? type,
    double? density,
    double? L,
    double? W,
    double? H,
    int? quantity,
  }) {
    return FinalProdcutBalanceModel(
      color: color ?? this.color,
      type: type ?? this.type,
      density: density ?? this.density,
      L: L ?? this.L,
      W: W ?? this.W,
      H: H ?? this.H,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'color': color,
      'type': type,
      'density': density,
      'L': L,
      'W': W,
      'H': H,
      'quantity': quantity,
    };
  }

  factory FinalProdcutBalanceModel.fromMap(Map<String, dynamic> map) {
    return FinalProdcutBalanceModel(
      color: map['color'] as String,
      type: map['type'] as String,
      density: map['density'] as double,
      L: map['L'] as double,
      W: map['W'] as double,
      H: map['H'] as double,
      quantity: map['quantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinalProdcutBalanceModel.fromJson(String source) =>
      FinalProdcutBalanceModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinalProdcutBalanceModel(color: $color, type: $type, density: $density, L: $L, W: $W, H: $H, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant FinalProdcutBalanceModel other) {
    if (identical(this, other)) return true;

    return other.color == color &&
        other.type == type &&
        other.density == density &&
        other.L == L &&
        other.W == W &&
        other.H == H &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return color.hashCode ^
        type.hashCode ^
        density.hashCode ^
        L.hashCode ^
        W.hashCode ^
        H.hashCode ^
        quantity.hashCode;
  }
}
