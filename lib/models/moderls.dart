// ignore_for_file: public_member_api_docs, sort_constructors_first, non_constant_identifier_names, camel_case_types

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:janssenfoam/ui/stockCheck/stockchek_veiwModel.dart';

//=========================================
class Itme {
  double L;
  double W;
  double H;
  double density;
  double volume;
  double wight;
  String color;
  String type;
  double price;
  Itme({
    required this.L,
    required this.W,
    required this.H,
    required this.density,
    required this.volume,
    required this.wight,
    required this.color,
    required this.type,
    required this.price,
  });

  Itme copyWith({
    double? L,
    double? W,
    double? H,
    double? density,
    double? volume,
    double? wight,
    String? color,
    String? type,
    double? price,
  }) {
    return Itme(
      L: L ?? this.L,
      W: W ?? this.W,
      H: H ?? this.H,
      density: density ?? this.density,
      volume: volume ?? this.volume,
      wight: wight ?? this.wight,
      color: color ?? this.color,
      type: type ?? this.type,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'L': L,
      'W': W,
      'H': H,
      'density': density,
      'volume': volume,
      'wight': wight,
      'color': color,
      'type': type,
      'price': price,
    };
  }

  factory Itme.fromMap(Map<String, dynamic> map) {
    return Itme(
      L: map['L'] as double,
      W: map['W'] as double,
      H: map['H'] as double,
      density: map['density'] as double,
      volume: map['volume'] as double,
      wight: map['wight'] as double,
      color: map['color'] as String,
      type: map['type'] as String,
      price: map['price'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Itme.fromJson(String source) =>
      Itme.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Itme(L: $L, W: $W, H: $H, density: $density, volume: $volume, wight: $wight, color: $color, type: $type, price: $price)';
  }

  @override
  bool operator ==(covariant Itme other) {
    if (identical(this, other)) return true;

    return other.L == L &&
        other.W == W &&
        other.H == H &&
        other.density == density &&
        other.volume == volume &&
        other.wight == wight &&
        other.color == color &&
        other.type == type &&
        other.price == price;
  }

  @override
  int get hashCode {
    return L.hashCode ^
        W.hashCode ^
        H.hashCode ^
        density.hashCode ^
        volume.hashCode ^
        wight.hashCode ^
        color.hashCode ^
        type.hashCode ^
        price.hashCode;
  }
}

class BlockWetOutput {
  double L;
  double W;
  double H;
  double density;
  double volume;
  double wight;
  BlockWetOutput({
    required this.L,
    required this.W,
    required this.H,
    required this.density,
    required this.volume,
    required this.wight,
  });

  BlockWetOutput copyWith({
    double? L,
    double? W,
    double? H,
    double? density,
    double? volume,
    double? wight,
  }) {
    return BlockWetOutput(
      L: L ?? this.L,
      W: W ?? this.W,
      H: H ?? this.H,
      density: density ?? this.density,
      volume: volume ?? this.volume,
      wight: wight ?? this.wight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'L': L,
      'W': W,
      'H': H,
      'density': density,
      'volume': volume,
      'wight': wight,
    };
  }

  factory BlockWetOutput.fromMap(Map<String, dynamic> map) {
    return BlockWetOutput(
      L: map['L'] as double,
      W: map['W'] as double,
      H: map['H'] as double,
      density: map['density'] as double,
      volume: map['volume'] as double,
      wight: map['wight'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockWetOutput.fromJson(String source) =>
      BlockWetOutput.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BlockWetOutput(L: $L, W: $W, H: $H, density: $density, volume: $volume, wight: $wight)';
  }

  @override
  bool operator ==(covariant BlockWetOutput other) {
    if (identical(this, other)) return true;

    return other.L == L &&
        other.W == W &&
        other.H == H &&
        other.density == density &&
        other.volume == volume &&
        other.wight == wight;
  }

  @override
  int get hashCode {
    return L.hashCode ^
        W.hashCode ^
        H.hashCode ^
        density.hashCode ^
        volume.hashCode ^
        wight.hashCode;
  }
}

class NotFinal {
  int notFinal_ID;
  String sapa_ID;
  int block_ID;
  int fraction_ID;
  int StockRequisetionOrder_ID;

  int stage;
  double wight;
  String type;
  int scissor;
  List<ActionModel> actions;
  NotFinal({
    required this.notFinal_ID,
    required this.sapa_ID,
    required this.block_ID,
    required this.fraction_ID,
    required this.StockRequisetionOrder_ID,
    required this.stage,
    required this.wight,
    required this.type,
    required this.scissor,
    required this.actions,
  });

  NotFinal copyWith({
    int? notFinal_ID,
    String? sapa_ID,
    int? block_ID,
    int? fraction_ID,
    int? StockRequisetionOrder_ID,
    int? stage,
    double? wight,
    String? type,
    int? scissor,
    List<ActionModel>? actions,
  }) {
    return NotFinal(
      notFinal_ID: notFinal_ID ?? this.notFinal_ID,
      sapa_ID: sapa_ID ?? this.sapa_ID,
      block_ID: block_ID ?? this.block_ID,
      fraction_ID: fraction_ID ?? this.fraction_ID,
      StockRequisetionOrder_ID:
          StockRequisetionOrder_ID ?? this.StockRequisetionOrder_ID,
      stage: stage ?? this.stage,
      wight: wight ?? this.wight,
      type: type ?? this.type,
      scissor: scissor ?? this.scissor,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'notFinal_ID': notFinal_ID,
      'sapa_ID': sapa_ID,
      'block_ID': block_ID,
      'fraction_ID': fraction_ID,
      'StockRequisetionOrder_ID': StockRequisetionOrder_ID,
      'stage': stage,
      'wight': wight,
      'type': type,
      'scissor': scissor,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory NotFinal.fromMap(Map<String, dynamic> map) {
    return NotFinal(
      notFinal_ID: map['notFinal_ID'] as int,
      sapa_ID: map['sapa_ID'] as String,
      block_ID: map['block_ID'] as int,
      fraction_ID: map['fraction_ID'] as int,
      StockRequisetionOrder_ID: map['StockRequisetionOrder_ID'] as int,
      stage: map['stage'] as int,
      wight: map['wight'] as double,
      type: map['type'] as String,
      scissor: map['scissor'] as int,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory NotFinal.fromJson(String source) =>
      NotFinal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotFinal(notFinal_ID: $notFinal_ID, sapa_ID: $sapa_ID, block_ID: $block_ID, fraction_ID: $fraction_ID, StockRequisetionOrder_ID: $StockRequisetionOrder_ID, stage: $stage, wight: $wight, type: $type, scissor: $scissor, actions: $actions)';
  }

  @override
  bool operator ==(covariant NotFinal other) {
    if (identical(this, other)) return true;

    return other.notFinal_ID == notFinal_ID &&
        other.sapa_ID == sapa_ID &&
        other.block_ID == block_ID &&
        other.fraction_ID == fraction_ID &&
        other.StockRequisetionOrder_ID == StockRequisetionOrder_ID &&
        other.stage == stage &&
        other.wight == wight &&
        other.type == type &&
        other.scissor == scissor &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return notFinal_ID.hashCode ^
        sapa_ID.hashCode ^
        block_ID.hashCode ^
        fraction_ID.hashCode ^
        StockRequisetionOrder_ID.hashCode ^
        stage.hashCode ^
        wight.hashCode ^
        type.hashCode ^
        scissor.hashCode ^
        actions.hashCode;
  }
}

class BlockModel {
  int Block_Id;
  int number;
  String serial;
  int Rcissor;
  int Hscissor;
  String cumingFrom;
  String OutTo;
  String notes;
  String discreption;
  Itme item;
  BlockWetOutput wetOutPut;
  List<FractionModel> fractions;
  List<ActionModel> actions;
  List<NotFinal> notFinals;
  int updatedat;
  BlockModel({
    required this.Block_Id,
    required this.number,
    required this.serial,
    required this.Rcissor,
    required this.Hscissor,
    required this.cumingFrom,
    required this.OutTo,
    required this.notes,
    required this.discreption,
    required this.item,
    required this.wetOutPut,
    required this.fractions,
    required this.actions,
    required this.notFinals,
    required this.updatedat,
  });

  BlockModel copyWith({
    int? Block_Id,
    int? number,
    String? serial,
    int? Rcissor,
    int? Hscissor,
    String? cumingFrom,
    String? OutTo,
    String? notes,
    String? discreption,
    Itme? item,
    BlockWetOutput? wetOutPut,
    List<FractionModel>? fractions,
    List<ActionModel>? actions,
    List<NotFinal>? notFinals,
    int? updatedat,
  }) {
    return BlockModel(
      Block_Id: Block_Id ?? this.Block_Id,
      number: number ?? this.number,
      serial: serial ?? this.serial,
      Rcissor: Rcissor ?? this.Rcissor,
      Hscissor: Hscissor ?? this.Hscissor,
      cumingFrom: cumingFrom ?? this.cumingFrom,
      OutTo: OutTo ?? this.OutTo,
      notes: notes ?? this.notes,
      discreption: discreption ?? this.discreption,
      item: item ?? this.item,
      wetOutPut: wetOutPut ?? this.wetOutPut,
      fractions: fractions ?? this.fractions,
      actions: actions ?? this.actions,
      notFinals: notFinals ?? this.notFinals,
      updatedat: updatedat ?? this.updatedat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Block_Id': Block_Id,
      'number': number,
      'serial': serial,
      'Rcissor': Rcissor,
      'Hscissor': Hscissor,
      'cumingFrom': cumingFrom,
      'OutTo': OutTo,
      'notes': notes,
      'discreption': discreption,
      'item': item.toMap(),
      'wetOutPut': wetOutPut.toMap(),
      'fractions': fractions.map((x) => x.toMap()).toList(),
      'actions': actions.map((x) => x.toMap()).toList(),
      'notFinals': notFinals.map((x) => x.toMap()).toList(),
      'updatedat': updatedat,
    };
  }

  factory BlockModel.fromMap(Map<String, dynamic> map) {
    return BlockModel(
      Block_Id: map['Block_Id'] as int,
      number: map['number'] as int,
      serial: map['serial'] as String,
      Rcissor: map['Rcissor'] as int,
      Hscissor: map['Hscissor'] as int,
      cumingFrom: map['cumingFrom'] as String,
      OutTo: map['OutTo'] as String,
      notes: map['notes'] as String,
      discreption: map['discreption'] as String,
      item: Itme.fromMap(map['item'] as Map<String, dynamic>),
      wetOutPut:
          BlockWetOutput.fromMap(map['wetOutPut'] as Map<String, dynamic>),
      fractions: List<FractionModel>.from(
        (map['fractions'] as List<dynamic>).map<FractionModel>(
          (x) => FractionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      notFinals: List<NotFinal>.from(
        (map['notFinals'] as List<dynamic>).map<NotFinal>(
          (x) => NotFinal.fromMap(x as Map<String, dynamic>),
        ),
      ),
      updatedat: map['updatedat'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockModel.fromJson(String source) =>
      BlockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BlockModel(Block_Id: $Block_Id, number: $number, serial: $serial, Rcissor: $Rcissor, Hscissor: $Hscissor, cumingFrom: $cumingFrom, OutTo: $OutTo, notes: $notes, discreption: $discreption, item: $item, wetOutPut: $wetOutPut, fractions: $fractions, actions: $actions, notFinals: $notFinals, updatedat: $updatedat)';
  }

  @override
  bool operator ==(covariant BlockModel other) {
    if (identical(this, other)) return true;

    return other.Block_Id == Block_Id &&
        other.number == number &&
        other.serial == serial &&
        other.Rcissor == Rcissor &&
        other.Hscissor == Hscissor &&
        other.cumingFrom == cumingFrom &&
        other.OutTo == OutTo &&
        other.notes == notes &&
        other.discreption == discreption &&
        other.item == item &&
        other.wetOutPut == wetOutPut &&
        listEquals(other.fractions, fractions) &&
        listEquals(other.actions, actions) &&
        listEquals(other.notFinals, notFinals) &&
        other.updatedat == updatedat;
  }

  @override
  int get hashCode {
    return Block_Id.hashCode ^
        number.hashCode ^
        serial.hashCode ^
        Rcissor.hashCode ^
        Hscissor.hashCode ^
        cumingFrom.hashCode ^
        OutTo.hashCode ^
        notes.hashCode ^
        discreption.hashCode ^
        item.hashCode ^
        wetOutPut.hashCode ^
        fractions.hashCode ^
        actions.hashCode ^
        notFinals.hashCode ^
        updatedat.hashCode;
  }
}

class FractionModel {
  int fraction_ID;
  String sapa_ID;
  String sapa_desc;
  int block_ID;
  Itme item;
  bool underOperation;
  String note;

  int Hscissor;
  int Rscissor;
  int Ascissor;
  int stagenum;
  int quality;

  final List<NotFinal> notfinals;
  final List<SubFraction> SubFractions;
  final List<ActionModel> actions;
  FractionModel({
    required this.fraction_ID,
    required this.sapa_ID,
    required this.sapa_desc,
    required this.block_ID,
    required this.item,
    required this.underOperation,
    required this.note,
    required this.Hscissor,
    required this.Rscissor,
    required this.Ascissor,
    required this.stagenum,
    required this.quality,
    required this.notfinals,
    required this.SubFractions,
    required this.actions,
  });

  FractionModel copyWith({
    int? fraction_ID,
    String? sapa_ID,
    String? sapa_desc,
    int? block_ID,
    Itme? item,
    bool? underOperation,
    String? note,
    int? Hscissor,
    int? Rscissor,
    int? Ascissor,
    int? stagenum,
    int? quality,
    List<NotFinal>? notfinals,
    List<SubFraction>? SubFractions,
    List<ActionModel>? actions,
  }) {
    return FractionModel(
      fraction_ID: fraction_ID ?? this.fraction_ID,
      sapa_ID: sapa_ID ?? this.sapa_ID,
      sapa_desc: sapa_desc ?? this.sapa_desc,
      block_ID: block_ID ?? this.block_ID,
      item: item ?? this.item,
      underOperation: underOperation ?? this.underOperation,
      note: note ?? this.note,
      Hscissor: Hscissor ?? this.Hscissor,
      Rscissor: Rscissor ?? this.Rscissor,
      Ascissor: Ascissor ?? this.Ascissor,
      stagenum: stagenum ?? this.stagenum,
      quality: quality ?? this.quality,
      notfinals: notfinals ?? this.notfinals,
      SubFractions: SubFractions ?? this.SubFractions,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fraction_ID': fraction_ID,
      'sapa_ID': sapa_ID,
      'sapa_desc': sapa_desc,
      'block_ID': block_ID,
      'item': item.toMap(),
      'underOperation': underOperation,
      'note': note,
      'Hscissor': Hscissor,
      'Rscissor': Rscissor,
      'Ascissor': Ascissor,
      'stagenum': stagenum,
      'quality': quality,
      'notfinals': notfinals.map((x) => x.toMap()).toList(),
      'SubFractions': SubFractions.map((x) => x.toMap()).toList(),
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory FractionModel.fromMap(Map<String, dynamic> map) {
    return FractionModel(
      fraction_ID: map['fraction_ID'] as int,
      sapa_ID: map['sapa_ID'] as String,
      sapa_desc: map['sapa_desc'] as String,
      block_ID: map['block_ID'] as int,
      item: Itme.fromMap(map['item'] as Map<String, dynamic>),
      underOperation: map['underOperation'] as bool,
      note: map['note'] as String,
      Hscissor: map['Hscissor'] as int,
      Rscissor: map['Rscissor'] as int,
      Ascissor: map['Ascissor'] as int,
      stagenum: map['stagenum'] as int,
      quality: map['quality'] as int,
      notfinals: List<NotFinal>.from(
        (map['notfinals'] as List<dynamic>).map<NotFinal>(
          (x) => NotFinal.fromMap(x as Map<String, dynamic>),
        ),
      ),
      SubFractions: List<SubFraction>.from(
        (map['SubFractions'] as List<dynamic>).map<SubFraction>(
          (x) => SubFraction.fromMap(x as Map<String, dynamic>),
        ),
      ),
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory FractionModel.fromJson(String source) =>
      FractionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FractionModel(fraction_ID: $fraction_ID, sapa_ID: $sapa_ID, sapa_desc: $sapa_desc, block_ID: $block_ID, item: $item, underOperation: $underOperation, note: $note, Hscissor: $Hscissor, Rscissor: $Rscissor, Ascissor: $Ascissor, stagenum: $stagenum, quality: $quality, notfinals: $notfinals, SubFractions: $SubFractions, actions: $actions)';
  }

  @override
  bool operator ==(covariant FractionModel other) {
    if (identical(this, other)) return true;

    return other.fraction_ID == fraction_ID &&
        other.sapa_ID == sapa_ID &&
        other.sapa_desc == sapa_desc &&
        other.block_ID == block_ID &&
        other.item == item &&
        other.underOperation == underOperation &&
        other.note == note &&
        other.Hscissor == Hscissor &&
        other.Rscissor == Rscissor &&
        other.Ascissor == Ascissor &&
        other.stagenum == stagenum &&
        other.quality == quality &&
        listEquals(other.notfinals, notfinals) &&
        listEquals(other.SubFractions, SubFractions) &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return fraction_ID.hashCode ^
        sapa_ID.hashCode ^
        sapa_desc.hashCode ^
        block_ID.hashCode ^
        item.hashCode ^
        underOperation.hashCode ^
        note.hashCode ^
        Hscissor.hashCode ^
        Rscissor.hashCode ^
        Ascissor.hashCode ^
        stagenum.hashCode ^
        quality.hashCode ^
        notfinals.hashCode ^
        SubFractions.hashCode ^
        actions.hashCode;
  }
}

class SubFraction {
  int subfraction_ID;
  int fraction_ID;
  String sapa_ID;
  String sapa_desc;
  int block_ID;
  Itme item;
  bool underOperation;
  String note;

  int Hscissor;
  int Rscissor;
  int Ascissor;
  int Rstagenum;
  int Astagenum;
  int Hstagenum;
  int quality;
  final List<NotFinal> notfinals;
  final List<ActionModel> actions;
  SubFraction({
    required this.subfraction_ID,
    required this.fraction_ID,
    required this.sapa_ID,
    required this.sapa_desc,
    required this.block_ID,
    required this.item,
    required this.underOperation,
    required this.note,
    required this.Hscissor,
    required this.Rscissor,
    required this.Ascissor,
    required this.Rstagenum,
    required this.Astagenum,
    required this.Hstagenum,
    required this.quality,
    required this.notfinals,
    required this.actions,
  });

  SubFraction copyWith({
    int? subfraction_ID,
    int? fraction_ID,
    String? sapa_ID,
    String? sapa_desc,
    int? block_ID,
    Itme? item,
    bool? underOperation,
    String? note,
    int? Hscissor,
    int? Rscissor,
    int? Ascissor,
    int? Rstagenum,
    int? Astagenum,
    int? Hstagenum,
    int? quality,
    List<NotFinal>? notfinals,
    List<ActionModel>? actions,
  }) {
    return SubFraction(
      subfraction_ID: subfraction_ID ?? this.subfraction_ID,
      fraction_ID: fraction_ID ?? this.fraction_ID,
      sapa_ID: sapa_ID ?? this.sapa_ID,
      sapa_desc: sapa_desc ?? this.sapa_desc,
      block_ID: block_ID ?? this.block_ID,
      item: item ?? this.item,
      underOperation: underOperation ?? this.underOperation,
      note: note ?? this.note,
      Hscissor: Hscissor ?? this.Hscissor,
      Rscissor: Rscissor ?? this.Rscissor,
      Ascissor: Ascissor ?? this.Ascissor,
      Rstagenum: Rstagenum ?? this.Rstagenum,
      Astagenum: Astagenum ?? this.Astagenum,
      Hstagenum: Hstagenum ?? this.Hstagenum,
      quality: quality ?? this.quality,
      notfinals: notfinals ?? this.notfinals,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'subfraction_ID': subfraction_ID,
      'fraction_ID': fraction_ID,
      'sapa_ID': sapa_ID,
      'sapa_desc': sapa_desc,
      'block_ID': block_ID,
      'item': item.toMap(),
      'underOperation': underOperation,
      'note': note,
      'Hscissor': Hscissor,
      'Rscissor': Rscissor,
      'Ascissor': Ascissor,
      'Rstagenum': Rstagenum,
      'Astagenum': Astagenum,
      'Hstagenum': Hstagenum,
      'quality': quality,
      'notfinals': notfinals.map((x) => x.toMap()).toList(),
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory SubFraction.fromMap(Map<String, dynamic> map) {
    return SubFraction(
      subfraction_ID: map['subfraction_ID'] as int,
      fraction_ID: map['fraction_ID'] as int,
      sapa_ID: map['sapa_ID'] as String,
      sapa_desc: map['sapa_desc'] as String,
      block_ID: map['block_ID'] as int,
      item: Itme.fromMap(map['item'] as Map<String, dynamic>),
      underOperation: map['underOperation'] as bool,
      note: map['note'] as String,
      Hscissor: map['Hscissor'] as int,
      Rscissor: map['Rscissor'] as int,
      Ascissor: map['Ascissor'] as int,
      Rstagenum: map['Rstagenum'] as int,
      Astagenum: map['Astagenum'] as int,
      Hstagenum: map['Hstagenum'] as int,
      quality: map['quality'] as int,
      notfinals: List<NotFinal>.from(
        (map['notfinals'] as List<dynamic>).map<NotFinal>(
          (x) => NotFinal.fromMap(x as Map<String, dynamic>),
        ),
      ),
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubFraction.fromJson(String source) =>
      SubFraction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubFraction(subfraction_ID: $subfraction_ID, fraction_ID: $fraction_ID, sapa_ID: $sapa_ID, sapa_desc: $sapa_desc, block_ID: $block_ID, item: $item, underOperation: $underOperation, note: $note, Hscissor: $Hscissor, Rscissor: $Rscissor, Ascissor: $Ascissor, Rstagenum: $Rstagenum, Astagenum: $Astagenum, Hstagenum: $Hstagenum, quality: $quality, notfinals: $notfinals, actions: $actions)';
  }

  @override
  bool operator ==(covariant SubFraction other) {
    if (identical(this, other)) return true;

    return other.subfraction_ID == subfraction_ID &&
        other.fraction_ID == fraction_ID &&
        other.sapa_ID == sapa_ID &&
        other.sapa_desc == sapa_desc &&
        other.block_ID == block_ID &&
        other.item == item &&
        other.underOperation == underOperation &&
        other.note == note &&
        other.Hscissor == Hscissor &&
        other.Rscissor == Rscissor &&
        other.Ascissor == Ascissor &&
        other.Rstagenum == Rstagenum &&
        other.Astagenum == Astagenum &&
        other.Hstagenum == Hstagenum &&
        other.quality == quality &&
        listEquals(other.notfinals, notfinals) &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return subfraction_ID.hashCode ^
        fraction_ID.hashCode ^
        sapa_ID.hashCode ^
        sapa_desc.hashCode ^
        block_ID.hashCode ^
        item.hashCode ^
        underOperation.hashCode ^
        note.hashCode ^
        Hscissor.hashCode ^
        Rscissor.hashCode ^
        Ascissor.hashCode ^
        Rstagenum.hashCode ^
        Astagenum.hashCode ^
        Hstagenum.hashCode ^
        quality.hashCode ^
        notfinals.hashCode ^
        actions.hashCode;
  }
}

//===================================
class FinalProdcutItme {
  double L;
  double W;
  double H;
  double density;
  double volume;
  double theowight;
  double realowight;
  String color;
  String type;
  int amount;
  double priceforamount;
  FinalProdcutItme({
    required this.L,
    required this.W,
    required this.H,
    required this.density,
    required this.volume,
    required this.theowight,
    required this.realowight,
    required this.color,
    required this.type,
    required this.amount,
    required this.priceforamount,
  });

  FinalProdcutItme copyWith({
    double? L,
    double? W,
    double? H,
    double? density,
    double? volume,
    double? theowight,
    double? realowight,
    String? color,
    String? type,
    int? amount,
    double? priceforamount,
  }) {
    return FinalProdcutItme(
      L: L ?? this.L,
      W: W ?? this.W,
      H: H ?? this.H,
      density: density ?? this.density,
      volume: volume ?? this.volume,
      theowight: theowight ?? this.theowight,
      realowight: realowight ?? this.realowight,
      color: color ?? this.color,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      priceforamount: priceforamount ?? this.priceforamount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'L': L,
      'W': W,
      'H': H,
      'density': density,
      'volume': volume,
      'theowight': theowight,
      'realowight': realowight,
      'color': color,
      'type': type,
      'amount': amount,
      'priceforamount': priceforamount,
    };
  }

  factory FinalProdcutItme.fromMap(Map<String, dynamic> map) {
    return FinalProdcutItme(
      L: map['L'] as double,
      W: map['W'] as double,
      H: map['H'] as double,
      density: map['density'] as double,
      volume: map['volume'] as double,
      theowight: map['theowight'] as double,
      realowight: map['realowight'] as double,
      color: map['color'] as String,
      type: map['type'] as String,
      amount: map['amount'] as int,
      priceforamount: map['priceforamount'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinalProdcutItme.fromJson(String source) =>
      FinalProdcutItme.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinalProdcutItme(L: $L, W: $W, H: $H, density: $density, volume: $volume, theowight: $theowight, realowight: $realowight, color: $color, type: $type, amount: $amount, priceforamount: $priceforamount)';
  }

  @override
  bool operator ==(covariant FinalProdcutItme other) {
    if (identical(this, other)) return true;

    return other.L == L &&
        other.W == W &&
        other.H == H &&
        other.density == density &&
        other.volume == volume &&
        other.theowight == theowight &&
        other.realowight == realowight &&
        other.color == color &&
        other.type == type &&
        other.amount == amount &&
        other.priceforamount == priceforamount;
  }

  @override
  int get hashCode {
    return L.hashCode ^
        W.hashCode ^
        H.hashCode ^
        density.hashCode ^
        volume.hashCode ^
        theowight.hashCode ^
        realowight.hashCode ^
        color.hashCode ^
        type.hashCode ^
        amount.hashCode ^
        priceforamount.hashCode;
  }
}

class FinalProductModel {
  int finalProdcut_ID;
  int block_ID;
  int fraction_ID;
  int subfraction_ID;
  String sapa_ID;
  String sapa_desc;

  FinalProdcutItme item;

  int scissor;
  int stage;
  String worker;

  String customer;
  String notes;

  int invoiceNum;
  int cuting_order_number;
  List<ActionModel> actions;

  int updatedat;
  FinalProductModel({
    required this.finalProdcut_ID,
    required this.block_ID,
    required this.fraction_ID,
    required this.subfraction_ID,
    required this.sapa_ID,
    required this.sapa_desc,
    required this.item,
    required this.scissor,
    required this.stage,
    required this.worker,
    required this.customer,
    required this.notes,
    required this.invoiceNum,
    required this.cuting_order_number,
    required this.actions,
    required this.updatedat,
  });

  FinalProductModel copyWith({
    int? finalProdcut_ID,
    int? block_ID,
    int? fraction_ID,
    int? subfraction_ID,
    String? sapa_ID,
    String? sapa_desc,
    FinalProdcutItme? item,
    int? scissor,
    int? stage,
    String? worker,
    String? customer,
    String? notes,
    int? invoiceNum,
    int? cuting_order_number,
    List<ActionModel>? actions,
    int? updatedat,
  }) {
    return FinalProductModel(
      finalProdcut_ID: finalProdcut_ID ?? this.finalProdcut_ID,
      block_ID: block_ID ?? this.block_ID,
      fraction_ID: fraction_ID ?? this.fraction_ID,
      subfraction_ID: subfraction_ID ?? this.subfraction_ID,
      sapa_ID: sapa_ID ?? this.sapa_ID,
      sapa_desc: sapa_desc ?? this.sapa_desc,
      item: item ?? this.item,
      scissor: scissor ?? this.scissor,
      stage: stage ?? this.stage,
      worker: worker ?? this.worker,
      customer: customer ?? this.customer,
      notes: notes ?? this.notes,
      invoiceNum: invoiceNum ?? this.invoiceNum,
      cuting_order_number: cuting_order_number ?? this.cuting_order_number,
      actions: actions ?? this.actions,
      updatedat: updatedat ?? this.updatedat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'finalProdcut_ID': finalProdcut_ID,
      'block_ID': block_ID,
      'fraction_ID': fraction_ID,
      'subfraction_ID': subfraction_ID,
      'sapa_ID': sapa_ID,
      'sapa_desc': sapa_desc,
      'item': item.toMap(),
      'scissor': scissor,
      'stage': stage,
      'worker': worker,
      'customer': customer,
      'notes': notes,
      'invoiceNum': invoiceNum,
      'cuting_order_number': cuting_order_number,
      'actions': actions.map((x) => x.toMap()).toList(),
      'updatedat': updatedat,
    };
  }

  factory FinalProductModel.fromMap(Map<String, dynamic> map) {
    return FinalProductModel(
      finalProdcut_ID: map['finalProdcut_ID'] as int,
      block_ID: map['block_ID'] as int,
      fraction_ID: map['fraction_ID'] as int,
      subfraction_ID: map['subfraction_ID'] as int,
      sapa_ID: map['sapa_ID'] as String,
      sapa_desc: map['sapa_desc'] as String,
      item: FinalProdcutItme.fromMap(map['item'] as Map<String, dynamic>),
      scissor: map['scissor'] as int,
      stage: map['stage'] as int,
      worker: map['worker'] as String,
      customer: map['customer'] as String,
      notes: map['notes'] as String,
      invoiceNum: map['invoiceNum'] as int,
      cuting_order_number: map['cuting_order_number'] as int,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      updatedat: map['updatedat'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory FinalProductModel.fromJson(String source) =>
      FinalProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'FinalProductModel(finalProdcut_ID: $finalProdcut_ID, block_ID: $block_ID, fraction_ID: $fraction_ID, subfraction_ID: $subfraction_ID, sapa_ID: $sapa_ID, sapa_desc: $sapa_desc, item: $item, scissor: $scissor, stage: $stage, worker: $worker, customer: $customer, notes: $notes, invoiceNum: $invoiceNum, cuting_order_number: $cuting_order_number, actions: $actions, updatedat: $updatedat)';
  }

  @override
  bool operator ==(covariant FinalProductModel other) {
    if (identical(this, other)) return true;

    return other.finalProdcut_ID == finalProdcut_ID &&
        other.block_ID == block_ID &&
        other.fraction_ID == fraction_ID &&
        other.subfraction_ID == subfraction_ID &&
        other.sapa_ID == sapa_ID &&
        other.sapa_desc == sapa_desc &&
        other.item == item &&
        other.scissor == scissor &&
        other.stage == stage &&
        other.worker == worker &&
        other.customer == customer &&
        other.notes == notes &&
        other.invoiceNum == invoiceNum &&
        other.cuting_order_number == cuting_order_number &&
        listEquals(other.actions, actions) &&
        other.updatedat == updatedat;
  }

  @override
  int get hashCode {
    return finalProdcut_ID.hashCode ^
        block_ID.hashCode ^
        fraction_ID.hashCode ^
        subfraction_ID.hashCode ^
        sapa_ID.hashCode ^
        sapa_desc.hashCode ^
        item.hashCode ^
        scissor.hashCode ^
        stage.hashCode ^
        worker.hashCode ^
        customer.hashCode ^
        notes.hashCode ^
        invoiceNum.hashCode ^
        cuting_order_number.hashCode ^
        actions.hashCode ^
        updatedat.hashCode;
  }
}

class ChipBlockModel {
  int id;
  final String title;
  final String color;
  final double density;
  final String type;
  final String serial;
  final double number;
  final double width;
  final double lenth;
  final double scissor;
  final double hight;
  final double wight;
  final String notes;
  final String description;
  ChipBlockModel({
    this.id = 0,
    required this.title,
    required this.color,
    required this.density,
    required this.type,
    required this.serial,
    required this.number,
    required this.width,
    required this.lenth,
    required this.scissor,
    required this.hight,
    required this.wight,
    required this.notes,
    required this.description,
  });

  ChipBlockModel copyWith({
    int? id,
    String? title,
    String? color,
    double? density,
    String? type,
    String? serial,
    double? number,
    double? width,
    double? lenth,
    double? scissor,
    double? hight,
    double? wight,
    String? notes,
    String? description,
  }) {
    return ChipBlockModel(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      density: density ?? this.density,
      type: type ?? this.type,
      serial: serial ?? this.serial,
      number: number ?? this.number,
      width: width ?? this.width,
      lenth: lenth ?? this.lenth,
      scissor: scissor ?? this.scissor,
      hight: hight ?? this.hight,
      wight: wight ?? this.wight,
      notes: notes ?? this.notes,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'color': color,
      'density': density,
      'type': type,
      'serial': serial,
      'number': number,
      'width': width,
      'lenth': lenth,
      'scissor': scissor,
      'hight': hight,
      'wight': wight,
      'notes': notes,
      'description': description,
    };
  }

  factory ChipBlockModel.fromMap(Map<String, dynamic> map) {
    return ChipBlockModel(
      id: map['id'] as int,
      title: map['title'] as String,
      color: map['color'] as String,
      density: map['density'] as double,
      type: map['type'] as String,
      serial: map['serial'] as String,
      number: map['number'] as double,
      width: map['width'] as double,
      lenth: map['lenth'] as double,
      scissor: map['scissor'] as double,
      hight: map['hight'] as double,
      wight: map['wight'] as double,
      notes: map['notes'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChipBlockModel.fromJson(String source) =>
      ChipBlockModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChipBlockModel(id: $id, title: $title, color: $color, density: $density, type: $type, serial: $serial, number: $number, width: $width, lenth: $lenth, scissor: $scissor, hight: $hight, wight: $wight, notes: $notes, description: $description)';
  }

  @override
  bool operator ==(covariant ChipBlockModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.color == color &&
        other.density == density &&
        other.type == type &&
        other.serial == serial &&
        other.number == number &&
        other.width == width &&
        other.lenth == lenth &&
        other.scissor == scissor &&
        other.hight == hight &&
        other.wight == wight &&
        other.notes == notes &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        color.hashCode ^
        density.hashCode ^
        type.hashCode ^
        serial.hashCode ^
        number.hashCode ^
        width.hashCode ^
        lenth.hashCode ^
        scissor.hashCode ^
        hight.hashCode ^
        wight.hashCode ^
        notes.hashCode ^
        description.hashCode;
  }
}

class ChipFraction {
  int id;
  final double width;
  final double lenth;
  final double hight;

  ChipFraction(
      {this.id = 0,
      required this.width,
      required this.lenth,
      required this.hight});
}

class ActionModel {
  String action;
  String who;
  DateTime when;
  ActionModel({
    required this.action,
    required this.who,
    required this.when,
  });

  ActionModel copyWith({
    String? action,
    String? who,
    DateTime? when,
  }) {
    return ActionModel(
      action: action ?? this.action,
      who: who ?? this.who,
      when: when ?? this.when,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'action': action,
      'who': who,
      'when': when.millisecondsSinceEpoch,
    };
  }

  factory ActionModel.fromMap(Map<String, dynamic> map) {
    return ActionModel(
      action: map['action'] as String,
      who: map['who'] as String,
      when: DateTime.fromMillisecondsSinceEpoch(map['when'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionModel.fromJson(String source) =>
      ActionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ActionModel(action: $action, who: $who, when: $when)';

  @override
  bool operator ==(covariant ActionModel other) {
    if (identical(this, other)) return true;

    return other.action == action && other.who == who && other.when == when;
  }

  @override
  int get hashCode => action.hashCode ^ who.hashCode ^ when.hashCode;
}

class Invoice {
  final int invoice_ID;
  final int serial;
  final String driverName;
  final int carNumber;
  final String dispatcher;
  final String notes;
  final List<ActionModel> actions;
  final List<InvoiceItem> items;
  int updatedat;
  Invoice({
    required this.invoice_ID,
    required this.serial,
    required this.driverName,
    required this.carNumber,
    required this.dispatcher,
    required this.notes,
    required this.actions,
    required this.items,
    required this.updatedat,
  });

  Invoice copyWith({
    int? invoice_ID,
    int? serial,
    String? driverName,
    int? carNumber,
    String? dispatcher,
    String? notes,
    List<ActionModel>? actions,
    List<InvoiceItem>? items,
    int? updatedat,
  }) {
    return Invoice(
      invoice_ID: invoice_ID ?? this.invoice_ID,
      serial: serial ?? this.serial,
      driverName: driverName ?? this.driverName,
      carNumber: carNumber ?? this.carNumber,
      dispatcher: dispatcher ?? this.dispatcher,
      notes: notes ?? this.notes,
      actions: actions ?? this.actions,
      items: items ?? this.items,
      updatedat: updatedat ?? this.updatedat,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'invoice_ID': invoice_ID,
      'serial': serial,
      'driverName': driverName,
      'carNumber': carNumber,
      'dispatcher': dispatcher,
      'notes': notes,
      'actions': actions.map((x) => x.toMap()).toList(),
      'items': items.map((x) => x.toMap()).toList(),
      'updatedat': updatedat,
    };
  }

  factory Invoice.fromMap(Map<String, dynamic> map) {
    return Invoice(
      invoice_ID: map['invoice_ID'] as int,
      serial: map['serial'] as int,
      driverName: map['driverName'] as String,
      carNumber: map['carNumber'] as int,
      dispatcher: map['dispatcher'] as String,
      notes: map['notes'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      items: List<InvoiceItem>.from(
        (map['items'] as List<dynamic>).map<InvoiceItem>(
          (x) => InvoiceItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      updatedat: map['updatedat'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invoice.fromJson(String source) =>
      Invoice.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Invoice(invoice_ID: $invoice_ID, serial: $serial, driverName: $driverName, carNumber: $carNumber, dispatcher: $dispatcher, notes: $notes, actions: $actions, items: $items, updatedat: $updatedat)';
  }

  @override
  bool operator ==(covariant Invoice other) {
    if (identical(this, other)) return true;

    return other.invoice_ID == invoice_ID &&
        other.serial == serial &&
        other.driverName == driverName &&
        other.carNumber == carNumber &&
        other.dispatcher == dispatcher &&
        other.notes == notes &&
        listEquals(other.actions, actions) &&
        listEquals(other.items, items) &&
        other.updatedat == updatedat;
  }

  @override
  int get hashCode {
    return invoice_ID.hashCode ^
        serial.hashCode ^
        driverName.hashCode ^
        carNumber.hashCode ^
        dispatcher.hashCode ^
        notes.hashCode ^
        actions.hashCode ^
        items.hashCode ^
        updatedat.hashCode;
  }
}

class InvoiceItem {
  int invoiceItem_ID;
  int finalprodcut_ID;
  double lenth;
  double width;
  double hight;
  String color;
  double density;
  String type;
  double price;
  String customer;
  int quantity;
  double theoriticalWight;
  double reallWight;
  InvoiceItem({
    required this.invoiceItem_ID,
    required this.finalprodcut_ID,
    required this.lenth,
    required this.width,
    required this.hight,
    required this.color,
    required this.density,
    required this.type,
    required this.price,
    required this.customer,
    required this.quantity,
    required this.theoriticalWight,
    required this.reallWight,
  });

  InvoiceItem copyWith({
    int? invoiceItem_ID,
    int? finalprodcut_ID,
    double? lenth,
    double? width,
    double? hight,
    String? color,
    double? density,
    String? type,
    double? price,
    String? customer,
    int? quantity,
    double? theoriticalWight,
    double? reallWight,
  }) {
    return InvoiceItem(
      invoiceItem_ID: invoiceItem_ID ?? this.invoiceItem_ID,
      finalprodcut_ID: finalprodcut_ID ?? this.finalprodcut_ID,
      lenth: lenth ?? this.lenth,
      width: width ?? this.width,
      hight: hight ?? this.hight,
      color: color ?? this.color,
      density: density ?? this.density,
      type: type ?? this.type,
      price: price ?? this.price,
      customer: customer ?? this.customer,
      quantity: quantity ?? this.quantity,
      theoriticalWight: theoriticalWight ?? this.theoriticalWight,
      reallWight: reallWight ?? this.reallWight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'invoiceItem_ID': invoiceItem_ID,
      'finalprodcut_ID': finalprodcut_ID,
      'lenth': lenth,
      'width': width,
      'hight': hight,
      'color': color,
      'density': density,
      'type': type,
      'price': price,
      'customer': customer,
      'quantity': quantity,
      'theoriticalWight': theoriticalWight,
      'reallWight': reallWight,
    };
  }

  factory InvoiceItem.fromMap(Map<String, dynamic> map) {
    return InvoiceItem(
      invoiceItem_ID: map['invoiceItem_ID'] as int,
      finalprodcut_ID: map['finalprodcut_ID'] as int,
      lenth: map['lenth'] as double,
      width: map['width'] as double,
      hight: map['hight'] as double,
      color: map['color'] as String,
      density: map['density'] as double,
      type: map['type'] as String,
      price: map['price'] as double,
      customer: map['customer'] as String,
      quantity: map['quantity'] as int,
      theoriticalWight: map['theoriticalWight'] as double,
      reallWight: map['reallWight'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceItem.fromJson(String source) =>
      InvoiceItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceItem(invoiceItem_ID: $invoiceItem_ID, finalprodcut_ID: $finalprodcut_ID, lenth: $lenth, width: $width, hight: $hight, color: $color, density: $density, type: $type, price: $price, customer: $customer, quantity: $quantity, theoriticalWight: $theoriticalWight, reallWight: $reallWight)';
  }

  @override
  bool operator ==(covariant InvoiceItem other) {
    if (identical(this, other)) return true;

    return other.invoiceItem_ID == invoiceItem_ID &&
        other.finalprodcut_ID == finalprodcut_ID &&
        other.lenth == lenth &&
        other.width == width &&
        other.hight == hight &&
        other.color == color &&
        other.density == density &&
        other.type == type &&
        other.price == price &&
        other.customer == customer &&
        other.quantity == quantity &&
        other.theoriticalWight == theoriticalWight &&
        other.reallWight == reallWight;
  }

  @override
  int get hashCode {
    return invoiceItem_ID.hashCode ^
        finalprodcut_ID.hashCode ^
        lenth.hashCode ^
        width.hashCode ^
        hight.hashCode ^
        color.hashCode ^
        density.hashCode ^
        type.hashCode ^
        price.hashCode ^
        customer.hashCode ^
        quantity.hashCode ^
        theoriticalWight.hashCode ^
        reallWight.hashCode;
  }
}

class CustomerModel {
  int customer_id;
  int serial;
  String name;
  int updatedat;
  List<ActionModel> actions;
  CustomerModel({
    required this.customer_id,
    required this.serial,
    required this.name,
    required this.updatedat,
    required this.actions,
  });

  CustomerModel copyWith({
    int? customer_id,
    int? serial,
    String? name,
    int? updatedat,
    List<ActionModel>? actions,
  }) {
    return CustomerModel(
      customer_id: customer_id ?? this.customer_id,
      serial: serial ?? this.serial,
      name: name ?? this.name,
      updatedat: updatedat ?? this.updatedat,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'customer_id': customer_id,
      'serial': serial,
      'name': name,
      'updatedat': updatedat,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      customer_id: map['customer_id'] as int,
      serial: map['serial'] as int,
      name: map['name'] as String,
      updatedat: map['updatedat'] as int,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CustomerModel(customer_id: $customer_id, serial: $serial, name: $name, updatedat: $updatedat, actions: $actions)';
  }

  @override
  bool operator ==(covariant CustomerModel other) {
    if (identical(this, other)) return true;

    return other.customer_id == customer_id &&
        other.serial == serial &&
        other.name == name &&
        other.updatedat == updatedat &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return customer_id.hashCode ^
        serial.hashCode ^
        name.hashCode ^
        updatedat.hashCode ^
        actions.hashCode;
  }
}

class cutingOrder {
  int cuttingOrder_ID;
  int serial;
  DateTime dateTOOrder;
  String customer;
  List<ActionModel> actions;
  List<OperationOrederItems> items;
  int updatedat;
  List<String> notes;
  cutingOrder({
    required this.cuttingOrder_ID,
    required this.serial,
    required this.dateTOOrder,
    required this.customer,
    required this.actions,
    required this.items,
    required this.updatedat,
    required this.notes,
  });

  cutingOrder copyWith({
    int? cuttingOrder_ID,
    int? serial,
    DateTime? dateTOOrder,
    String? customer,
    List<ActionModel>? actions,
    List<OperationOrederItems>? items,
    int? updatedat,
    List<String>? notes,
  }) {
    return cutingOrder(
      cuttingOrder_ID: cuttingOrder_ID ?? this.cuttingOrder_ID,
      serial: serial ?? this.serial,
      dateTOOrder: dateTOOrder ?? this.dateTOOrder,
      customer: customer ?? this.customer,
      actions: actions ?? this.actions,
      items: items ?? this.items,
      updatedat: updatedat ?? this.updatedat,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cuttingOrder_ID': cuttingOrder_ID,
      'serial': serial,
      'dateTOOrder': dateTOOrder.millisecondsSinceEpoch,
      'customer': customer,
      'actions': actions.map((x) => x.toMap()).toList(),
      'items': items.map((x) => x.toMap()).toList(),
      'updatedat': updatedat,
      'notes': notes,
    };
  }

  factory cutingOrder.fromMap(Map<String, dynamic> map) {
    return cutingOrder(
      cuttingOrder_ID: map['cuttingOrder_ID'] as int,
      serial: map['serial'] as int,
      dateTOOrder:
          DateTime.fromMillisecondsSinceEpoch(map['dateTOOrder'] as int),
      customer: map['customer'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      items: List<OperationOrederItems>.from(
        (map['items'] as List<dynamic>).map<OperationOrederItems>(
          (x) => OperationOrederItems.fromMap(x as Map<String, dynamic>),
        ),
      ),
      updatedat: map['updatedat'] as int,
      notes: List<String>.from((map['notes'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory cutingOrder.fromJson(String source) =>
      cutingOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'cutingOrder(cuttingOrder_ID: $cuttingOrder_ID, serial: $serial, dateTOOrder: $dateTOOrder, customer: $customer, actions: $actions, items: $items, updatedat: $updatedat, notes: $notes)';
  }

  @override
  bool operator ==(covariant cutingOrder other) {
    if (identical(this, other)) return true;

    return other.cuttingOrder_ID == cuttingOrder_ID &&
        other.serial == serial &&
        other.dateTOOrder == dateTOOrder &&
        other.customer == customer &&
        listEquals(other.actions, actions) &&
        listEquals(other.items, items) &&
        other.updatedat == updatedat &&
        listEquals(other.notes, notes);
  }

  @override
  int get hashCode {
    return cuttingOrder_ID.hashCode ^
        serial.hashCode ^
        dateTOOrder.hashCode ^
        customer.hashCode ^
        actions.hashCode ^
        items.hashCode ^
        updatedat.hashCode ^
        notes.hashCode;
  }
}

class OperationOrederItems {
  int id;
  String color;
  String type;
  double density;
  double lenth;
  double widti;
  double hight;
  int Qantity;
  OperationOrederItems({
    required this.id,
    required this.color,
    required this.type,
    required this.density,
    required this.lenth,
    required this.widti,
    required this.hight,
    required this.Qantity,
  });

  OperationOrederItems copyWith({
    int? id,
    String? color,
    String? type,
    double? density,
    double? lenth,
    double? widti,
    double? hight,
    int? Qantity,
  }) {
    return OperationOrederItems(
      id: id ?? this.id,
      color: color ?? this.color,
      type: type ?? this.type,
      density: density ?? this.density,
      lenth: lenth ?? this.lenth,
      widti: widti ?? this.widti,
      hight: hight ?? this.hight,
      Qantity: Qantity ?? this.Qantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'color': color,
      'type': type,
      'density': density,
      'lenth': lenth,
      'widti': widti,
      'hight': hight,
      'Qantity': Qantity,
    };
  }

  factory OperationOrederItems.fromMap(Map<String, dynamic> map) {
    return OperationOrederItems(
      id: map['id'] as int,
      color: map['color'] as String,
      type: map['type'] as String,
      density: map['density'] as double,
      lenth: map['lenth'] as double,
      widti: map['widti'] as double,
      hight: map['hight'] as double,
      Qantity: map['Qantity'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory OperationOrederItems.fromJson(String source) =>
      OperationOrederItems.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OperationOrederItems(id: $id, color: $color, type: $type, density: $density, lenth: $lenth, widti: $widti, hight: $hight, Qantity: $Qantity)';
  }

  @override
  bool operator ==(covariant OperationOrederItems other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.color == color &&
        other.type == type &&
        other.density == density &&
        other.lenth == lenth &&
        other.widti == widti &&
        other.hight == hight &&
        other.Qantity == Qantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        color.hashCode ^
        type.hashCode ^
        density.hashCode ^
        lenth.hashCode ^
        widti.hashCode ^
        hight.hashCode ^
        Qantity.hashCode;
  }
}

class UserModel {
  int user_Id;
  String name;

  String email;
  String password;

  String uid;
  List<String> permitions;
  int updatedat;
  List<ActionModel> actions;
  UserModel({
    required this.user_Id,
    required this.name,
    required this.email,
    required this.password,
    required this.uid,
    required this.permitions,
    required this.updatedat,
    required this.actions,
  });

  UserModel copyWith({
    int? user_Id,
    String? name,
    String? email,
    String? password,
    String? uid,
    List<String>? permitions,
    int? updatedat,
    List<ActionModel>? actions,
  }) {
    return UserModel(
      user_Id: user_Id ?? this.user_Id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      uid: uid ?? this.uid,
      permitions: permitions ?? this.permitions,
      updatedat: updatedat ?? this.updatedat,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user_Id': user_Id,
      'name': name,
      'email': email,
      'password': password,
      'uid': uid,
      'permitions': permitions,
      'updatedat': updatedat,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      user_Id: map['user_Id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      uid: map['uid'] as String,
      permitions: List<String>.from((map['permitions'] as List<dynamic>)),
      updatedat: map['updatedat'] as int,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(user_Id: $user_Id, name: $name, email: $email, password: $password, uid: $uid, permitions: $permitions, updatedat: $updatedat, actions: $actions)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.user_Id == user_Id &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.uid == uid &&
        listEquals(other.permitions, permitions) &&
        other.updatedat == updatedat &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return user_Id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        uid.hashCode ^
        permitions.hashCode ^
        updatedat.hashCode ^
        actions.hashCode;
  }
}

class UserpermitionTittle {
  String tittle;
  UserpermitionTittle({
    required this.tittle,
  });

  UserpermitionTittle copyWith({
    String? tittle,
  }) {
    return UserpermitionTittle(
      tittle: tittle ?? this.tittle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tittle': tittle,
    };
  }

  factory UserpermitionTittle.fromMap(Map<String, dynamic> map) {
    return UserpermitionTittle(
      tittle: map['tittle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserpermitionTittle.fromJson(String source) =>
      UserpermitionTittle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserpermitionTittle(tittle: $tittle)';

  @override
  bool operator ==(covariant UserpermitionTittle other) {
    if (identical(this, other)) return true;

    return other.tittle == tittle;
  }

  @override
  int get hashCode => tittle.hashCode;
}

class BlockCategory {
  int blockCategory_ID;
  int updatedat;
  String description;
  String type;
  String density;
  String color;
  List<ActionModel> actions;
  BlockCategory({
    required this.blockCategory_ID,
    required this.updatedat,
    required this.description,
    required this.type,
    required this.density,
    required this.color,
    required this.actions,
  });

  BlockCategory copyWith({
    int? blockCategory_ID,
    int? updatedat,
    String? description,
    String? type,
    String? density,
    String? color,
    List<ActionModel>? actions,
  }) {
    return BlockCategory(
      blockCategory_ID: blockCategory_ID ?? this.blockCategory_ID,
      updatedat: updatedat ?? this.updatedat,
      description: description ?? this.description,
      type: type ?? this.type,
      density: density ?? this.density,
      color: color ?? this.color,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'blockCategory_ID': blockCategory_ID,
      'updatedat': updatedat,
      'description': description,
      'type': type,
      'density': density,
      'color': color,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory BlockCategory.fromMap(Map<String, dynamic> map) {
    return BlockCategory(
      blockCategory_ID: map['blockCategory_ID'] as int,
      updatedat: map['updatedat'] as int,
      description: map['description'] as String,
      type: map['type'] as String,
      density: map['density'] as String,
      color: map['color'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory BlockCategory.fromJson(String source) =>
      BlockCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BlockCategory(blockCategory_ID: $blockCategory_ID, updatedat: $updatedat, description: $description, type: $type, density: $density, color: $color, actions: $actions)';
  }

  @override
  bool operator ==(covariant BlockCategory other) {
    if (identical(this, other)) return true;

    return other.blockCategory_ID == blockCategory_ID &&
        other.updatedat == updatedat &&
        other.description == description &&
        other.type == type &&
        other.density == density &&
        other.color == color &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return blockCategory_ID.hashCode ^
        updatedat.hashCode ^
        description.hashCode ^
        type.hashCode ^
        density.hashCode ^
        color.hashCode ^
        actions.hashCode;
  }
}

class PurcheItem {
  int item_Id;
  int purcheOrder_Id;
  double quantity;
  String Unit;
  String item;
  String note;
  String receiver;
  double lastPrice;

  final List<ActionModel> actions;
  final List<PurcheItemOffers> offers;
  PurcheItem({
    required this.item_Id,
    required this.purcheOrder_Id,
    required this.quantity,
    required this.Unit,
    required this.item,
    required this.note,
    required this.receiver,
    required this.lastPrice,
    required this.actions,
    required this.offers,
  });

  PurcheItem copyWith({
    int? item_Id,
    int? purcheOrder_Id,
    double? quantity,
    String? Unit,
    String? item,
    String? note,
    String? receiver,
    double? lastPrice,
    List<ActionModel>? actions,
    List<PurcheItemOffers>? offers,
  }) {
    return PurcheItem(
      item_Id: item_Id ?? this.item_Id,
      purcheOrder_Id: purcheOrder_Id ?? this.purcheOrder_Id,
      quantity: quantity ?? this.quantity,
      Unit: Unit ?? this.Unit,
      item: item ?? this.item,
      note: note ?? this.note,
      receiver: receiver ?? this.receiver,
      lastPrice: lastPrice ?? this.lastPrice,
      actions: actions ?? this.actions,
      offers: offers ?? this.offers,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'item_Id': item_Id,
      'purcheOrder_Id': purcheOrder_Id,
      'quantity': quantity,
      'Unit': Unit,
      'item': item,
      'note': note,
      'receiver': receiver,
      'lastPrice': lastPrice,
      'actions': actions.map((x) => x.toMap()).toList(),
      'offers': offers.map((x) => x.toMap()).toList(),
    };
  }

  factory PurcheItem.fromMap(Map<String, dynamic> map) {
    return PurcheItem(
      item_Id: map['item_Id'] as int,
      purcheOrder_Id: map['purcheOrder_Id'] as int,
      quantity: map['quantity'] as double,
      Unit: map['Unit'] as String,
      item: map['item'] as String,
      note: map['note'] as String,
      receiver: map['receiver'] as String,
      lastPrice: map['lastPrice'] as double,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      offers: List<PurcheItemOffers>.from(
        (map['offers'] as List<dynamic>).map<PurcheItemOffers>(
          (x) => PurcheItemOffers.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PurcheItem.fromJson(String source) =>
      PurcheItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurcheItem(item_Id: $item_Id, purcheOrder_Id: $purcheOrder_Id, quantity: $quantity, Unit: $Unit, item: $item, note: $note, receiver: $receiver, lastPrice: $lastPrice, actions: $actions, offers: $offers)';
  }

  @override
  bool operator ==(covariant PurcheItem other) {
    if (identical(this, other)) return true;

    return other.item_Id == item_Id &&
        other.purcheOrder_Id == purcheOrder_Id &&
        other.quantity == quantity &&
        other.Unit == Unit &&
        other.item == item &&
        other.note == note &&
        other.receiver == receiver &&
        other.lastPrice == lastPrice &&
        listEquals(other.actions, actions) &&
        listEquals(other.offers, offers);
  }

  @override
  int get hashCode {
    return item_Id.hashCode ^
        purcheOrder_Id.hashCode ^
        quantity.hashCode ^
        Unit.hashCode ^
        item.hashCode ^
        note.hashCode ^
        receiver.hashCode ^
        lastPrice.hashCode ^
        actions.hashCode ^
        offers.hashCode;
  }
}

class PurcheItemOffers {
  int PurcheItemOffers_Id;
  int item_Id;
  int purcheOrder_Id;
  String syplyer;
  double price;
  final List<ActionModel> actions;
  PurcheItemOffers({
    required this.PurcheItemOffers_Id,
    required this.item_Id,
    required this.purcheOrder_Id,
    required this.syplyer,
    required this.price,
    required this.actions,
  });

  PurcheItemOffers copyWith({
    int? PurcheItemOffers_Id,
    int? item_Id,
    int? purcheOrder_Id,
    String? syplyer,
    double? price,
    List<ActionModel>? actions,
  }) {
    return PurcheItemOffers(
      PurcheItemOffers_Id: PurcheItemOffers_Id ?? this.PurcheItemOffers_Id,
      item_Id: item_Id ?? this.item_Id,
      purcheOrder_Id: purcheOrder_Id ?? this.purcheOrder_Id,
      syplyer: syplyer ?? this.syplyer,
      price: price ?? this.price,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'PurcheItemOffers_Id': PurcheItemOffers_Id,
      'item_Id': item_Id,
      'purcheOrder_Id': purcheOrder_Id,
      'syplyer': syplyer,
      'price': price,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory PurcheItemOffers.fromMap(Map<String, dynamic> map) {
    return PurcheItemOffers(
      PurcheItemOffers_Id: map['PurcheItemOffers_Id'] as int,
      item_Id: map['item_Id'] as int,
      purcheOrder_Id: map['purcheOrder_Id'] as int,
      syplyer: map['syplyer'] as String,
      price: map['price'] as double,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory PurcheItemOffers.fromJson(String source) =>
      PurcheItemOffers.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurcheItemOffers(PurcheItemOffers_Id: $PurcheItemOffers_Id, item_Id: $item_Id, purcheOrder_Id: $purcheOrder_Id, syplyer: $syplyer, price: $price, actions: $actions)';
  }

  @override
  bool operator ==(covariant PurcheItemOffers other) {
    if (identical(this, other)) return true;

    return other.PurcheItemOffers_Id == PurcheItemOffers_Id &&
        other.item_Id == item_Id &&
        other.purcheOrder_Id == purcheOrder_Id &&
        other.syplyer == syplyer &&
        other.price == price &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return PurcheItemOffers_Id.hashCode ^
        item_Id.hashCode ^
        purcheOrder_Id.hashCode ^
        syplyer.hashCode ^
        price.hashCode ^
        actions.hashCode;
  }
}

class PurcheOrder {
  final int Id;
  final int serial;
  final String Adminstrationrequested;
  final DateTime dueDate;
  final String fl;
  final List<dynamic> financeManagerSingiture;

  final String gl;
  final List<dynamic> generalManagerSigniture;
  final String requester;
  final List<ActionModel> actions;
  final List<PurcheItem> items;
  final String status;
  PurcheOrder({
    required this.Id,
    required this.serial,
    required this.Adminstrationrequested,
    required this.dueDate,
    required this.fl,
    required this.financeManagerSingiture,
    required this.gl,
    required this.generalManagerSigniture,
    required this.requester,
    required this.actions,
    required this.items,
    required this.status,
  });

  PurcheOrder copyWith({
    int? Id,
    int? serial,
    String? Adminstrationrequested,
    DateTime? dueDate,
    String? fl,
    List<dynamic>? financeManagerSingiture,
    String? gl,
    List<dynamic>? generalManagerSigniture,
    String? requester,
    List<ActionModel>? actions,
    List<PurcheItem>? items,
    String? status,
  }) {
    return PurcheOrder(
      Id: Id ?? this.Id,
      serial: serial ?? this.serial,
      Adminstrationrequested:
          Adminstrationrequested ?? this.Adminstrationrequested,
      dueDate: dueDate ?? this.dueDate,
      fl: fl ?? this.fl,
      financeManagerSingiture:
          financeManagerSingiture ?? this.financeManagerSingiture,
      gl: gl ?? this.gl,
      generalManagerSigniture:
          generalManagerSigniture ?? this.generalManagerSigniture,
      requester: requester ?? this.requester,
      actions: actions ?? this.actions,
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Id': Id,
      'serial': serial,
      'Adminstrationrequested': Adminstrationrequested,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'fl': fl,
      'financeManagerSingiture': financeManagerSingiture,
      'gl': gl,
      'generalManagerSigniture': generalManagerSigniture,
      'requester': requester,
      'actions': actions.map((x) => x.toMap()).toList(),
      'items': items.map((x) => x.toMap()).toList(),
      'status': status,
    };
  }

  factory PurcheOrder.fromMap(Map<String, dynamic> map) {
    return PurcheOrder(
      Id: map['Id'] as int,
      serial: map['serial'] as int,
      Adminstrationrequested: map['Adminstrationrequested'] as String,
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate'] as int),
      fl: map['fl'] as String,
      financeManagerSingiture:
          List<dynamic>.from((map['financeManagerSingiture'] as List<dynamic>)),
      gl: map['gl'] as String,
      generalManagerSigniture:
          List<dynamic>.from((map['generalManagerSigniture'] as List<dynamic>)),
      requester: map['requester'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      items: List<PurcheItem>.from(
        (map['items'] as List<dynamic>).map<PurcheItem>(
          (x) => PurcheItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PurcheOrder.fromJson(String source) =>
      PurcheOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PurcheOrder(Id: $Id, serial: $serial, Adminstrationrequested: $Adminstrationrequested, dueDate: $dueDate, fl: $fl, financeManagerSingiture: $financeManagerSingiture, gl: $gl, generalManagerSigniture: $generalManagerSigniture, requester: $requester, actions: $actions, items: $items, status: $status)';
  }

  @override
  bool operator ==(covariant PurcheOrder other) {
    if (identical(this, other)) return true;

    return other.Id == Id &&
        other.serial == serial &&
        other.Adminstrationrequested == Adminstrationrequested &&
        other.dueDate == dueDate &&
        other.fl == fl &&
        listEquals(other.financeManagerSingiture, financeManagerSingiture) &&
        other.gl == gl &&
        listEquals(other.generalManagerSigniture, generalManagerSigniture) &&
        other.requester == requester &&
        listEquals(other.actions, actions) &&
        listEquals(other.items, items) &&
        other.status == status;
  }

  @override
  int get hashCode {
    return Id.hashCode ^
        serial.hashCode ^
        Adminstrationrequested.hashCode ^
        dueDate.hashCode ^
        fl.hashCode ^
        financeManagerSingiture.hashCode ^
        gl.hashCode ^
        generalManagerSigniture.hashCode ^
        requester.hashCode ^
        actions.hashCode ^
        items.hashCode ^
        status.hashCode;
  }
}

class StockCheckModel {
  final int stockCheck_ID;
  FinalProdcutBalanceModel item;
  final int realamont;
  final List<ActionModel> actions;
  StockCheckModel({
    required this.stockCheck_ID,
    required this.item,
    required this.realamont,
    required this.actions,
  });

  StockCheckModel copyWith({
    int? stockCheck_ID,
    FinalProdcutBalanceModel? item,
    int? realamont,
    List<ActionModel>? actions,
  }) {
    return StockCheckModel(
      stockCheck_ID: stockCheck_ID ?? this.stockCheck_ID,
      item: item ?? this.item,
      realamont: realamont ?? this.realamont,
      actions: actions ?? this.actions,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'stockCheck_ID': stockCheck_ID,
      'item': item.toMap(),
      'realamont': realamont,
      'actions': actions.map((x) => x.toMap()).toList(),
    };
  }

  factory StockCheckModel.fromMap(Map<String, dynamic> map) {
    return StockCheckModel(
      stockCheck_ID: map['stockCheck_ID'] as int,
      item:
          FinalProdcutBalanceModel.fromMap(map['item'] as Map<String, dynamic>),
      realamont: map['realamont'] as int,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory StockCheckModel.fromJson(String source) =>
      StockCheckModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'StockCheckModel(stockCheck_ID: $stockCheck_ID, item: $item, realamont: $realamont, actions: $actions)';
  }

  @override
  bool operator ==(covariant StockCheckModel other) {
    if (identical(this, other)) return true;

    return other.stockCheck_ID == stockCheck_ID &&
        other.item == item &&
        other.realamont == realamont &&
        listEquals(other.actions, actions);
  }

  @override
  int get hashCode {
    return stockCheck_ID.hashCode ^
        item.hashCode ^
        realamont.hashCode ^
        actions.hashCode;
  }
}

class WieghtTecketMOdel {
  int wightTecket_ID;
  int wightTecket_serial;
  int stockRequsition_ID;
  int stockRequsition_serial;
  int carNum;
  String customerName;
  String driverName;
  String prodcutName;
  String notes;
  double firstShot;
  double secondShot;
  double totalWeight;
  List<int> firstShotpiccam1;
  List<int> firstShotpiccam2;
  List<int> secondShotpiccam1;
  List<int> secondShotpiccam2;
  String firstShotpiccam1Adress;
  String firstShotpiccam2Adress;
  String secondShotpiccam1Adress;
  String secondShotpiccam2Adress;
  List<ActionModel> actions;
  bool synced;
  int lastupdated;
  WieghtTecketMOdel({
    required this.wightTecket_ID,
    required this.wightTecket_serial,
    required this.stockRequsition_ID,
    required this.stockRequsition_serial,
    required this.carNum,
    required this.customerName,
    required this.driverName,
    required this.prodcutName,
    required this.notes,
    required this.firstShot,
    required this.secondShot,
    required this.totalWeight,
    required this.firstShotpiccam1,
    required this.firstShotpiccam2,
    required this.secondShotpiccam1,
    required this.secondShotpiccam2,
    required this.firstShotpiccam1Adress,
    required this.firstShotpiccam2Adress,
    required this.secondShotpiccam1Adress,
    required this.secondShotpiccam2Adress,
    required this.actions,
    required this.synced,
    required this.lastupdated,
  });

  WieghtTecketMOdel copyWith({
    int? wightTecket_ID,
    int? wightTecket_serial,
    int? stockRequsition_ID,
    int? stockRequsition_serial,
    int? carNum,
    String? customerName,
    String? driverName,
    String? prodcutName,
    String? notes,
    double? firstShot,
    double? secondShot,
    double? totalWeight,
    List<int>? firstShotpiccam1,
    List<int>? firstShotpiccam2,
    List<int>? secondShotpiccam1,
    List<int>? secondShotpiccam2,
    String? firstShotpiccam1Adress,
    String? firstShotpiccam2Adress,
    String? secondShotpiccam1Adress,
    String? secondShotpiccam2Adress,
    List<ActionModel>? actions,
    bool? synced,
    int? lastupdated,
  }) {
    return WieghtTecketMOdel(
      wightTecket_ID: wightTecket_ID ?? this.wightTecket_ID,
      wightTecket_serial: wightTecket_serial ?? this.wightTecket_serial,
      stockRequsition_ID: stockRequsition_ID ?? this.stockRequsition_ID,
      stockRequsition_serial:
          stockRequsition_serial ?? this.stockRequsition_serial,
      carNum: carNum ?? this.carNum,
      customerName: customerName ?? this.customerName,
      driverName: driverName ?? this.driverName,
      prodcutName: prodcutName ?? this.prodcutName,
      notes: notes ?? this.notes,
      firstShot: firstShot ?? this.firstShot,
      secondShot: secondShot ?? this.secondShot,
      totalWeight: totalWeight ?? this.totalWeight,
      firstShotpiccam1: firstShotpiccam1 ?? this.firstShotpiccam1,
      firstShotpiccam2: firstShotpiccam2 ?? this.firstShotpiccam2,
      secondShotpiccam1: secondShotpiccam1 ?? this.secondShotpiccam1,
      secondShotpiccam2: secondShotpiccam2 ?? this.secondShotpiccam2,
      firstShotpiccam1Adress:
          firstShotpiccam1Adress ?? this.firstShotpiccam1Adress,
      firstShotpiccam2Adress:
          firstShotpiccam2Adress ?? this.firstShotpiccam2Adress,
      secondShotpiccam1Adress:
          secondShotpiccam1Adress ?? this.secondShotpiccam1Adress,
      secondShotpiccam2Adress:
          secondShotpiccam2Adress ?? this.secondShotpiccam2Adress,
      actions: actions ?? this.actions,
      synced: synced ?? this.synced,
      lastupdated: lastupdated ?? this.lastupdated,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'wightTecket_ID': wightTecket_ID,
      'wightTecket_serial': wightTecket_serial,
      'stockRequsition_ID': stockRequsition_ID,
      'stockRequsition_serial': stockRequsition_serial,
      'carNum': carNum,
      'customerName': customerName,
      'driverName': driverName,
      'prodcutName': prodcutName,
      'notes': notes,
      'firstShot': firstShot,
      'secondShot': secondShot,
      'totalWeight': totalWeight,
      'firstShotpiccam1': firstShotpiccam1,
      'firstShotpiccam2': firstShotpiccam2,
      'secondShotpiccam1': secondShotpiccam1,
      'secondShotpiccam2': secondShotpiccam2,
      'firstShotpiccam1Adress': firstShotpiccam1Adress,
      'firstShotpiccam2Adress': firstShotpiccam2Adress,
      'secondShotpiccam1Adress': secondShotpiccam1Adress,
      'secondShotpiccam2Adress': secondShotpiccam2Adress,
      'actions': actions.map((x) => x.toMap()).toList(),
      'synced': synced,
      'lastupdated': lastupdated,
    };
  }

  factory WieghtTecketMOdel.fromMap(Map<String, dynamic> map) {
    return WieghtTecketMOdel(
      wightTecket_ID: map['wightTecket_ID'] as int,
      wightTecket_serial: map['wightTecket_serial'] as int,
      stockRequsition_ID: map['stockRequsition_ID'] as int,
      stockRequsition_serial: map['stockRequsition_serial'] as int,
      carNum: map['carNum'] as int,
      customerName: map['customerName'] as String,
      driverName: map['driverName'] as String,
      prodcutName: map['prodcutName'] as String,
      notes: map['notes'] as String,
      firstShot: map['firstShot'] as double,
      secondShot: map['secondShot'] as double,
      totalWeight: map['totalWeight'] as double,
      firstShotpiccam1:
          List<int>.from((map['firstShotpiccam1'] as List<dynamic>)),
      firstShotpiccam2:
          List<int>.from((map['firstShotpiccam2'] as List<dynamic>)),
      secondShotpiccam1:
          List<int>.from((map['secondShotpiccam1'] as List<dynamic>)),
      secondShotpiccam2:
          List<int>.from((map['secondShotpiccam2'] as List<dynamic>)),
      firstShotpiccam1Adress: map['firstShotpiccam1Adress'] as String,
      firstShotpiccam2Adress: map['firstShotpiccam2Adress'] as String,
      secondShotpiccam1Adress: map['secondShotpiccam1Adress'] as String,
      secondShotpiccam2Adress: map['secondShotpiccam2Adress'] as String,
      actions: List<ActionModel>.from(
        (map['actions'] as List<dynamic>).map<ActionModel>(
          (x) => ActionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      synced: map['synced'] as bool,
      lastupdated: map['lastupdated'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory WieghtTecketMOdel.fromJson(String source) =>
      WieghtTecketMOdel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WieghtTecketMOdel(wightTecket_ID: $wightTecket_ID, wightTecket_serial: $wightTecket_serial, stockRequsition_ID: $stockRequsition_ID, stockRequsition_serial: $stockRequsition_serial, carNum: $carNum, customerName: $customerName, driverName: $driverName, prodcutName: $prodcutName, notes: $notes, firstShot: $firstShot, secondShot: $secondShot, totalWeight: $totalWeight, firstShotpiccam1: $firstShotpiccam1, firstShotpiccam2: $firstShotpiccam2, secondShotpiccam1: $secondShotpiccam1, secondShotpiccam2: $secondShotpiccam2, firstShotpiccam1Adress: $firstShotpiccam1Adress, firstShotpiccam2Adress: $firstShotpiccam2Adress, secondShotpiccam1Adress: $secondShotpiccam1Adress, secondShotpiccam2Adress: $secondShotpiccam2Adress, actions: $actions, synced: $synced, lastupdated: $lastupdated)';
  }

  @override
  bool operator ==(covariant WieghtTecketMOdel other) {
    if (identical(this, other)) return true;

    return other.wightTecket_ID == wightTecket_ID &&
        other.wightTecket_serial == wightTecket_serial &&
        other.stockRequsition_ID == stockRequsition_ID &&
        other.stockRequsition_serial == stockRequsition_serial &&
        other.carNum == carNum &&
        other.customerName == customerName &&
        other.driverName == driverName &&
        other.prodcutName == prodcutName &&
        other.notes == notes &&
        other.firstShot == firstShot &&
        other.secondShot == secondShot &&
        other.totalWeight == totalWeight &&
        listEquals(other.firstShotpiccam1, firstShotpiccam1) &&
        listEquals(other.firstShotpiccam2, firstShotpiccam2) &&
        listEquals(other.secondShotpiccam1, secondShotpiccam1) &&
        listEquals(other.secondShotpiccam2, secondShotpiccam2) &&
        other.firstShotpiccam1Adress == firstShotpiccam1Adress &&
        other.firstShotpiccam2Adress == firstShotpiccam2Adress &&
        other.secondShotpiccam1Adress == secondShotpiccam1Adress &&
        other.secondShotpiccam2Adress == secondShotpiccam2Adress &&
        listEquals(other.actions, actions) &&
        other.synced == synced &&
        other.lastupdated == lastupdated;
  }

  @override
  int get hashCode {
    return wightTecket_ID.hashCode ^
        wightTecket_serial.hashCode ^
        stockRequsition_ID.hashCode ^
        stockRequsition_serial.hashCode ^
        carNum.hashCode ^
        customerName.hashCode ^
        driverName.hashCode ^
        prodcutName.hashCode ^
        notes.hashCode ^
        firstShot.hashCode ^
        secondShot.hashCode ^
        totalWeight.hashCode ^
        firstShotpiccam1.hashCode ^
        firstShotpiccam2.hashCode ^
        secondShotpiccam1.hashCode ^
        secondShotpiccam2.hashCode ^
        firstShotpiccam1Adress.hashCode ^
        firstShotpiccam2Adress.hashCode ^
        secondShotpiccam1Adress.hashCode ^
        secondShotpiccam2Adress.hashCode ^
        actions.hashCode ^
        synced.hashCode ^
        lastupdated.hashCode;
  }
}

//=============================================

class IndusterialSecurityModel {
  int ID;
  DateTime date;
  String who;
  String place;
  int ImageId;
  List<int> image;
  String note;
  IndusterialSecurityModel({
    required this.ID,
    required this.date,
    required this.who,
    required this.place,
    required this.ImageId,
    required this.image,
    required this.note,
  });

  IndusterialSecurityModel copyWith({
    int? ID,
    DateTime? date,
    String? who,
    String? place,
    int? ImageId,
    List<int>? image,
    String? note,
  }) {
    return IndusterialSecurityModel(
      ID: ID ?? this.ID,
      date: date ?? this.date,
      who: who ?? this.who,
      place: place ?? this.place,
      ImageId: ImageId ?? this.ImageId,
      image: image ?? this.image,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'ID': ID,
      'date': date.millisecondsSinceEpoch,
      'who': who,
      'place': place,
      'ImageId': ImageId,
      'image': image,
      'note': note,
    };
  }

  factory IndusterialSecurityModel.fromMap(Map<String, dynamic> map) {
    return IndusterialSecurityModel(
      ID: map['ID'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      who: map['who'] as String,
      place: map['place'] as String,
      ImageId: map['ImageId'] as int,
      image: List<int>.from((map['image'] as List<dynamic>)),
      note: map['note'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IndusterialSecurityModel.fromJson(String source) =>
      IndusterialSecurityModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'IndusterialSecurityModel(ID: $ID, date: $date, who: $who, place: $place, ImageId: $ImageId, image: $image, note: $note)';
  }

  @override
  bool operator ==(covariant IndusterialSecurityModel other) {
    if (identical(this, other)) return true;

    return other.ID == ID &&
        other.date == date &&
        other.who == who &&
        other.place == place &&
        other.ImageId == ImageId &&
        listEquals(other.image, image) &&
        other.note == note;
  }

  @override
  int get hashCode {
    return ID.hashCode ^
        date.hashCode ^
        who.hashCode ^
        place.hashCode ^
        ImageId.hashCode ^
        image.hashCode ^
        note.hashCode;
  }
}

class SensorModel {
  int id;
  int val;
  DateTime date;
  SensorModel({
    required this.id,
    required this.val,
    required this.date,
  });

  SensorModel copyWith({
    int? id,
    int? val,
    DateTime? date,
  }) {
    return SensorModel(
      id: id ?? this.id,
      val: val ?? this.val,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'val': val,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory SensorModel.fromMap(Map<String, dynamic> map) {
    return SensorModel(
      id: map['id'] as int,
      val: map['val'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory SensorModel.fromJson(String source) =>
      SensorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SensorModel(id: $id, val: $val, date: $date)';

  @override
  bool operator ==(covariant SensorModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.val == val && other.date == date;
  }

  @override
  int get hashCode => id.hashCode ^ val.hashCode ^ date.hashCode;
}
