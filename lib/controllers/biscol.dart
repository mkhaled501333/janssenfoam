import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/core/functions.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

class Hivecontroller extends ChangeNotifier {
  Map<String, WieghtTecketMOdel> allrecords = {};
  static late WebSocketChannel channel;
  WieghtTecketMOdel? temprecord;
  String v = '';
  bool canedit1 = true;
  bool canedit2 = true;
  TextEditingController carnumcontroller = TextEditingController();
  TextEditingController drivernamecontroller = TextEditingController();
  TextEditingController customercontroller = TextEditingController();
  TextEditingController itemcontroller = TextEditingController();
  TextEditingController notescontroller = TextEditingController();
  bool channelConectioninitionlized = false;
  bool getupdatesinitionlized = false;
  bool sendPendigTicketsinitionlized = false;

  clearfields() {
    v = '';
    carnumcontroller.clear();
    drivernamecontroller.clear();
    customercontroller.clear();
    itemcontroller.clear();
    notescontroller.clear();
    notifyListeners();
  }

  channelConection() async {
    await getAll();

    connectChannel();
    // while (true) {
    //   await Future.delayed(const Duration(seconds: 1));
    //   if (channel.closeCode != null) {
    //     channelConectioninitionlized = false;
    //     connectChannel();
    //   }
    // }
  }

  void connectChannel() {
    if (isserveronline == true) {
      channelConectioninitionlized = true;
      Uri uri2 = Uri.parse('ws://$ip:8080/biscol/ws')
          .replace(queryParameters: {'username': 'biscolpc'});
      channel = WebSocketChannel.connect(uri2);
      channel.stream.forEach((u) {
        print(u);
        WieghtTecketMOdel item = WieghtTecketMOdel.fromJson(u);
        allrecords.addAll({item.wightTecket_ID.toString(): item});
        notifyListeners();
      });
    }
  }

  getdata() {
    if (internet == true) {
    } else {
      channelConection();
    }
  }

  Future<void> getAll() async {
    Uri uri = Uri.http('$ip:8080', '/biscol');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      allrecords.clear();
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var block = WieghtTecketMOdel.fromMap(element);
        allrecords.addAll({block.wightTecket_ID.toString(): block});
      }
      notifyListeners();
    }
  }

  Uint8List? cam1;
  Uint8List? cam2;

  FillRecord(WieghtTecketMOdel r) {
    temprecord = r;
    carnumcontroller.text = r.carNum.toString();
    drivernamecontroller.text = r.driverName;
    customercontroller.text = r.customerName;
    itemcontroller.text = r.prodcutName;
    notescontroller.text = r.notes;

    notifyListeners();
  }

  updateRecord(WieghtTecketMOdel record, int serial) {
    record.lastupdated = DateTime.now().microsecondsSinceEpoch;
    record.stockRequsition_serial = serial;
    channel.sink.add(record.toJson());
  }

  Refrech_UI() {
    notifyListeners();
  }

  List<String> selectedCarNum = [];
  List<String> selectedDrivers = [];
  List<String> selectedcustomerName = [];
  List<String> selectedProdcutName = [];
  String selectedReport = '';
  DateTime? pickedDateFrom;
  DateTime? pickedDateTO;
  String archived = 'غير محزوف';

  List<DateTime> AllDatesOfOfData() {
    return allrecords.values
        .expand((e) => e.actions)
        .map((d) => d.when)
        .toList();
  }

  WieghtTecketMOdel? ini;
}
