// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/ui/chemical_stock/chemecalsModels.dart';

import 'package:web_socket_channel/web_socket_channel.dart';

mixin ChemicalsServerApi {
  late WebSocketChannel channel;
  final Map<String, ChemicalsModel> chemicalss = {};
  List<ChemicalsModel> get chiemicals => chemicalss.values
      .toList()
      .where((test) =>
          test.actions.if_action_exist(
              ChemicalAction.archive_ChemicalAction_item.getTitle) ==
          false)
      .toList();

  getChemicalsDataFromServer(Function() refrech) async {
    // get for the firsttime
    Uri uri = Uri.http('$ip:8080', '/chemicals');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      chemicalss.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var chemical = ChemicalsModel.fromMap(element);
        if (chemical.actions.if_action_exist(
                ChemicalAction.archive_ChemicalAction_item.getTitle) ==
            false) {
          chemicalss.addAll({chemical.chemical_ID.toString(): chemical});
        }
      }
      refrech();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/chemicals/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel = WebSocketChannel.connect(uri2);
    channel.stream.forEach((u) {
      ChemicalsModel chemical = ChemicalsModel.fromJson(u);
      chemicalss.addAll({chemical.chemical_ID.toString(): chemical});
      refrech();
    });
  }

  //==============================================================================
  late WebSocketChannel unitchanel;
  final Map<String, Units> _units = {};
  List<Units> get units => _units.values
      .where((item) =>
          item.actions.if_action_exist(
              Chemical_Category.archive_Chemical_category.getTitle) ==
          false)
      .toList();

  getunits(Function() refrech) async {
    // get for the firsttime
    Uri uri = Uri.http('$ip:8080', '/chemecalUnits');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      _units.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var item = Units.fromMap(element);
        if (item.actions.if_action_exist(
                Chemical_Category.archive_Chemical_category.getTitle) ==
            false) {
          _units.addAll({item.id.toString(): item});
        }
      }
      refrech();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/chemecalUnits/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    unitchanel = WebSocketChannel.connect(uri2);
    unitchanel.stream.forEach((u) {
      Units chemical = Units.fromJson(u);
      _units.addAll({chemical.id.toString(): chemical});
      // print("get chemcasl $chemical");
      refrech();
    });
  }

  //==============================================================================
  late WebSocketChannel syplyerchannel;
  final Map<String, ChemicalsSyplyers> _chemicalsuplyers = {};
  List<ChemicalsSyplyers> get chemicalsuplyers => _chemicalsuplyers.values
      .where((item) =>
          item.actions.if_action_exist(
              Chemical_Category.archive_Chemical_category.getTitle) ==
          false)
      .toList();

  getsyplyers(Function() refrech) async {
    // get for the firsttime
    Uri uri = Uri.http('$ip:8080', '/chemicalSuplyers');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      _chemicalsuplyers.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var item = ChemicalsSyplyers.fromMap(element);
        if (item.actions.if_action_exist(
                Chemical_Category.archive_Chemical_category.getTitle) ==
            false) {
          _chemicalsuplyers.addAll({item.id.toString(): item});
        }
      }
      refrech();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/chemicalSuplyers/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    syplyerchannel = WebSocketChannel.connect(uri2);
    syplyerchannel.stream.forEach((u) {
      ChemicalsSyplyers chemical = ChemicalsSyplyers.fromJson(u);
      _chemicalsuplyers.addAll({chemical.id.toString(): chemical});
      // print("get chemcasl $chemical");
      refrech();
    });
  }

  //==============================================================================
  late WebSocketChannel customerchanel;
  final Map<String, ChemicalsCustomers> _chemicalcusomers = {};
  List<ChemicalsCustomers> get chemicalcusomers => _chemicalcusomers.values
      .where((item) =>
          item.actions.if_action_exist(
              Chemical_Category.archive_Chemical_category.getTitle) ==
          false)
      .toList();

  getcustomers(Function() refrech) async {
    // get for the firsttime
    Uri uri = Uri.http('$ip:8080', '/chemicalCustomers');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      _chemicalcusomers.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var item = ChemicalsCustomers.fromMap(element);
        if (item.actions.if_action_exist(
                Chemical_Category.archive_Chemical_category.getTitle) ==
            false) {
          _chemicalcusomers.addAll({item.id.toString(): item});
        }
      }
      refrech();
    }
    //
    Uri uri2 = Uri.parse('ws://$ip:8080/chemicalCustomers/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    customerchanel = WebSocketChannel.connect(uri2);
    customerchanel.stream.forEach((u) {
      ChemicalsCustomers chemical = ChemicalsCustomers.fromJson(u);
      _chemicalcusomers.addAll({chemical.id.toString(): chemical});
      // print("get chemcasl $chemical");
      refrech();
    });
  }

  //==============================================================================
  late WebSocketChannel channel2;
  final Map<String, ChemicalCategory> _chemicalscategorys = {};
  List<ChemicalCategory> get chemicalsCategorys => _chemicalscategorys.values
      .where((item) =>
          item.actions.if_action_exist(
              Chemical_Category.archive_Chemical_category.getTitle) ==
          false)
      .toList();

  getChemicalsCategoryesDataFromServer(Function() refrech) async {
    // get for the firsttime
    Uri uri = Uri.http('$ip:8080', '/chemicalcategorys');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      _chemicalscategorys.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var item = ChemicalCategory.fromMap(element);
        if (item.actions.if_action_exist(
                Chemical_Category.archive_Chemical_category.getTitle) ==
            false) {
          _chemicalscategorys
              .addAll({item.chemicalcategory_ID.toString(): item});
        }
      }

      refrech();
    }

    //
    Uri uri2 = Uri.parse('ws://$ip:8080/chemicalcategorys/ws').replace(
        queryParameters: {
          'username': Sharedprfs.getemail(),
          'password': Sharedprfs.getpassword()
        });
    channel2 = WebSocketChannel.connect(uri2);
    channel2.stream.forEach((u) {
      ChemicalCategory chemical = ChemicalCategory.fromJson(u);
      _chemicalscategorys
          .addAll({chemical.chemicalcategory_ID.toString(): chemical});
      // print("get chemcasl $chemical");
      refrech();
    });
  }
}
