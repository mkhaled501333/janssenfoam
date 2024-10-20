// ignore_for_file: non_constant_identifier_names, empty_catches, file_names, unused_element
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/core/functions.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/core/recources/strings_manager.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:http/http.dart' as http;

import 'package:web_socket_channel/web_socket_channel.dart';

class IndusterialSecuritycontroller extends ChangeNotifier {
  Map<String, IndusterialSecurityModel> all = {};
  DateTime? pickedDateFrom;
  DateTime? pickedDateTO;
  List<String> selectedPoints = [];
  List<String> selectedPersons = [];
  List<String> selectedhous = [];
  SensorModel? sensotdata;
  List<DateTime> AllDatesOfOfData() {
    return all.values.map((d) => d.date).toList();
  }

  getdata() async {
    if (internet == true) {
      industerialsecurity_From_firebase();
    } else {
      connecAndListenTochannel();
      connecAndListenTochannelSensor();
    }
  }

  industerialsecurity_From_firebase() {
    if (Platform.isAndroid) {
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("industerialsecurity");
      ref.get().then((onValue) {
        if (onValue.value != null) {
          for (var e in onValue.children) {
            final record =
                IndusterialSecurityModel.fromJson(e.value.toString());
            all.addAll({record.ID.toString(): record});
          }
          print("get orders data");
          Refresh_the_UI();
        }
      });
      ref.onChildChanged.listen((onData) {
        if (onData.snapshot.value != null) {
          final record = IndusterialSecurityModel.fromJson(
              onData.snapshot.value.toString());
          all.addAll({record.ID.toString(): record});
          print("get orders data");
          Refresh_the_UI();
        }
      });
    }
  }

  late WebSocketChannel channel;

  connecAndListenTochannel() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/industerialsecurity');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var a = json.decode(response.body) as List;
      for (var element in a) {
        var i = IndusterialSecurityModel.fromMap(element);
        all.addAll({i.ID.toString(): i});
      }
      notifyListeners();
    }
    //connect channel
    Uri url = Uri.parse('ws://$ip:8080/industerialsecurity/ws')
        .replace(queryParameters: {'username': SringsManager.myemail});
    channel = WebSocketChannel.connect(url);
    channel.stream.forEach((u) {
      IndusterialSecurityModel item = IndusterialSecurityModel.fromJson(u);
      all.addAll({item.ID.toString(): item});
      notifyListeners();
    });
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      if (channel.closeCode != null && isserveronline == true) {
        channel = WebSocketChannel.connect(url);
        channel.stream.forEach((u) {
          IndusterialSecurityModel item = IndusterialSecurityModel.fromJson(u);
          all.addAll({item.ID.toString(): item});
          notifyListeners();
        });
      }
    }
  }

  connecAndListenTochannelSensor() async {
    // get for the first time
    Uri uri = Uri.http('$ip:8080', '/sensor');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var a = json.decode(response.body);
      sensotdata = SensorModel.fromMap(a);

      notifyListeners();
    }
    //connect channel
    Uri url = Uri.parse('ws://$ip:8080/sensor/ws')
        .replace(queryParameters: {'username': SringsManager.myemail});
    channel = WebSocketChannel.connect(url);
    channel.stream.forEach((u) {
      sensotdata = SensorModel.fromJson(u);
      notifyListeners();
    });
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      if (channel.closeCode != null && isserveronline == true) {
        channel = WebSocketChannel.connect(url);
        channel.stream.forEach((u) {
          final item = SensorModel.fromJson(u);
          print(item);
          notifyListeners();
        });
      }
    }
  }

  Future<bool> postRecord(IndusterialSecurityModel record) async {
    Uri uri = Uri.http('$ip:8080', '/industerialsecurity');
    var response = await http.post(uri, body: record.toJson());
    return response.statusCode == 200 ? true : false;
  }

  Refresh_the_UI() {
    notifyListeners();
  }

  Future<Uint8List> getImageFromCamera(int ip, int cam) async {
    final url = Uri.parse(
        'http://admin:Admin%40123@192.168.1.$ip/ISAPI/Streaming/channels/$cam/picture'); //Repclace Your Endpoint
    final headers = {
      'Accept': '*/*',
      'Cache-Control': 'no-cache',
      'Accept-Encoding': 'gzip, deflate, br',
      'Content-Type': 'image/jpeg',
      'Authorization': 'Basic YWRtaW46QWRtaW5AMTIz'
    };

    final response = await http.get(
      url,
      headers: headers,
    );
    await Future.delayed(const Duration(milliseconds: 300));
    return response.bodyBytes;
  }
}
